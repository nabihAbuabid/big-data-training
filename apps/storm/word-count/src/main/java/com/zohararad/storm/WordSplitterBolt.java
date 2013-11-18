package com.zohararad.storm;

import backtype.storm.task.OutputCollector;
import backtype.storm.task.TopologyContext;
import backtype.storm.topology.OutputFieldsDeclarer;
import backtype.storm.topology.base.BaseRichBolt;
import backtype.storm.tuple.Fields;
import backtype.storm.tuple.Tuple;
import backtype.storm.tuple.Values;

import java.util.Map;

public class WordSplitterBolt extends BaseRichBolt {

  private OutputCollector collector;

  public WordSplitterBolt() {}

  @Override
  public void prepare(Map conf, TopologyContext context, OutputCollector _collector) {
    collector = _collector;
  }

  @Override
  public void execute(Tuple tuple) {
    String sentence = tuple.getString(0);
    String[] words = sentence.split(" ");
    for(String word : words){
      collector.emit(new Values(word));
    }
    collector.ack(tuple);
  }

  @Override
  public void declareOutputFields(OutputFieldsDeclarer declarer) {
    declarer.declare(new Fields("word"));
  }

}
