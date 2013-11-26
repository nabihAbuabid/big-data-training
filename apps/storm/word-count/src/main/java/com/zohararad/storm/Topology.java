package com.zohararad.storm;

import backtype.storm.Config;
import backtype.storm.LocalCluster;
import backtype.storm.topology.TopologyBuilder;
import backtype.storm.tuple.Fields;

public class Topology {

  public static void main(String[] args) throws Exception {

    TopologyBuilder builder = new TopologyBuilder();

    builder.setSpout("spout", new RandomSentenceSpout(), 5);

    builder.setBolt("split", new WordSplitterBolt(), 8).shuffleGrouping("spout");
    builder.setBolt("count", new WordCounterBolt(), 12)
        .fieldsGrouping("split", new Fields("word"));

    Config conf = new Config();
    conf.setDebug(true);
    conf.setMaxTaskParallelism(3);

    LocalCluster cluster = new LocalCluster();
    cluster.submitTopology("word-count", conf, builder.createTopology());

    Thread.sleep(10000);

    cluster.shutdown();
  }

}
