package com.zohararad.storm;

import backtype.storm.Config;
import backtype.storm.LocalCluster;
import backtype.storm.LocalDRPC;
import backtype.storm.drpc.DRPCSpout;
import backtype.storm.drpc.ReturnResults;
import backtype.storm.topology.TopologyBuilder;
import backtype.storm.tuple.Fields;
import backtype.storm.utils.Utils;

public class DRPCTopology {

  static final String REQUEST_STREAM_ID = WordCounterBolt.class.getName() + "/request-stream";

  public static void main(String[] args) throws InterruptedException {
    TopologyBuilder builder = new TopologyBuilder();
    // Use LocalDRPC in local mode
    LocalDRPC drpc = new LocalDRPC();

    // Create a DRPC spout
    DRPCSpout drpcSpout = new DRPCSpout("drpc-query", drpc);
    builder.setSpout("drpc-input", drpcSpout);

    // Set first bold in DRPC to emit tuples on a different stream
    builder.setBolt("drpc-stream", new StreamChangerBolt(REQUEST_STREAM_ID, "word", "return-info"), 1)
        .noneGrouping("drpc-input");

    builder.setSpout("spout", new RandomSentenceSpout(), 5);

    builder.setBolt("split", new WordSplitterBolt(), 8)
        .shuffleGrouping("spout");

    builder.setBolt("count", new DRPCWordCounterBolt(REQUEST_STREAM_ID), 12)
        .fieldsGrouping("split", new Fields("word"))
        .allGrouping("drpc-stream", REQUEST_STREAM_ID); //place after DRPC stream change bolt in DRPC stream

    // Add DRPC return bolt that receives tuples from count bolt and returns them to DRPC
    builder.setBolt("return", new ReturnResults(), 3)
        .noneGrouping("count", REQUEST_STREAM_ID);

    Config conf = new Config();
    conf.setDebug(false);
    conf.setMaxTaskParallelism(3);

    LocalCluster cluster = new LocalCluster();
    cluster.submitTopology("word-count", conf, builder.createTopology());

    int i = 0;
    while(i < 10){
      Utils.sleep(2000);
      System.out.println("+++++++++++++++++++++++++++++++++++++");
      System.out.println(drpc.execute("drpc-query", "cow"));
      i++;
    }
    cluster.shutdown();
  }
}
