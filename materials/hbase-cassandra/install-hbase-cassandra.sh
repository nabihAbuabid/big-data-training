#!/bin/bash

echo "deb [arch=amd64] http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh precise-cdh4 contrib"  | sudo tee -a /etc/apt/sources.list.d/cdh4.list

curl -s http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh/archive.key | sudo apt-key add -

echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -

sudo apt-get update
sudo apt-get install hbase-master dsc20

echo ""
echo "-----------------------------------"
echo "Edit /etc/hosts. Change 127.0.1.1 to 127.0.0.1"
echo "-----------------------------------"