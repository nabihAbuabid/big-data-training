package com.zohararad.storm;

import backtype.storm.task.OutputCollector;
import backtype.storm.task.TopologyContext;
import backtype.storm.topology.OutputFieldsDeclarer;
import backtype.storm.topology.base.BaseRichBolt;
import backtype.storm.tuple.Fields;
import backtype.storm.tuple.Tuple;

import java.util.Map;

public class StreamChangerBolt extends BaseRichBolt {
  private String _targetStreamId;
  private Fields _fields;
  private OutputCollector collector;

  public StreamChangerBolt(String targetStreamId, String... fields) {
    _targetStreamId = targetStreamId;
    _fields = new Fields(fields);
  }

  @Override
  public void prepare(Map conf, TopologyContext context, OutputCollector _collector) {
    collector = _collector;
  }

  @Override
  public void execute(Tuple tuple) {
    collector.emit(_targetStreamId, tuple.getValues());
    collector.ack(tuple);
  }

  @Override
  public void declareOutputFields(OutputFieldsDeclarer declarer) {
    declarer.declareStream(_targetStreamId, _fields);
  }
}
