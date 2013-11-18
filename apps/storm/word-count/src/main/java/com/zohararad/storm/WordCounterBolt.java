package com.zohararad.storm;

import backtype.storm.task.OutputCollector;
import backtype.storm.task.TopologyContext;
import backtype.storm.topology.OutputFieldsDeclarer;
import backtype.storm.topology.base.BaseRichBolt;
import backtype.storm.tuple.Fields;
import backtype.storm.tuple.Tuple;
import backtype.storm.tuple.Values;

import java.util.HashMap;
import java.util.Map;

public class WordCounterBolt extends BaseRichBolt {

  Map<String, Integer> counts = new HashMap<String, Integer>();

  private OutputCollector collector;

  @Override
  public void prepare(Map conf, TopologyContext context, OutputCollector _collector) {
    collector = _collector;
  }

  @Override
  public void execute(Tuple tuple) {
    String word = tuple.getString(0);
    Integer count = counts.get(word);
    if (count == null)
      count = 0;
    count++;
    counts.put(word, count);
    System.out.println("========== " + word + " -> " + count);
    collector.emit(new Values(word, count));
    collector.ack(tuple);
  }

  @Override
  public void declareOutputFields(OutputFieldsDeclarer declarer) {
    declarer.declare(new Fields("word", "count"));
    declarer.declareStream("WORD_AGGREGATOR", new Fields("word", "count"));
    declarer.declareStream("PERSISTENCE", new Fields("word", "count", "timestamp"));
  }
}
