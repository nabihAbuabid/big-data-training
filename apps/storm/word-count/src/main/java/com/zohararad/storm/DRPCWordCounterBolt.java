package com.zohararad.storm;

import backtype.storm.task.OutputCollector;
import backtype.storm.task.TopologyContext;
import backtype.storm.topology.BasicOutputCollector;
import backtype.storm.topology.OutputFieldsDeclarer;
import backtype.storm.topology.base.BaseBasicBolt;
import backtype.storm.topology.base.BaseRichBolt;
import backtype.storm.tuple.Fields;
import backtype.storm.tuple.Tuple;
import backtype.storm.tuple.Values;

import java.util.HashMap;
import java.util.Map;

public class DRPCWordCounterBolt extends BaseRichBolt {

  private Map<String, Integer> counts = new HashMap<String, Integer>();
  private String _targetStreamId;
  private OutputCollector collector;

  public DRPCWordCounterBolt(String targetStreamId) {
    _targetStreamId = targetStreamId;
  }

  @Override
  public void prepare(Map conf, TopologyContext context, OutputCollector _collector) {
    collector = _collector;
  }

  @Override
  public void execute(Tuple tuple) {
    if (tuple.getSourceStreamId().equals(_targetStreamId)){
      String word = tuple.getStringByField("word");
      Object retInfo = tuple.getValueByField("return-info");
      if(counts.containsKey(word)){
        collector.emit(_targetStreamId, new Values(counts.get(word).toString(), retInfo));
      }
    } else {
      String word = tuple.getString(0);
      Integer count = counts.get(word);
      if(count == null){
        count = 0;
      }
      count++;
      counts.put(word, count);
      collector.emit(new Values(word, count));
    }
    collector.ack(tuple);
  }

  @Override
  public void declareOutputFields(OutputFieldsDeclarer declarer) {
    // output fields on default stream
    declarer.declare(new Fields("word", "count"));
    // output fields on drpc stream
    declarer.declareStream(_targetStreamId, new Fields("count", "return-info"));
  }
}
