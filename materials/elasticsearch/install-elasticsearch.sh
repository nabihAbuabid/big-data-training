#!/bin/bash

sudo apt-get install openjdk-7-jdk openjdk-7-jre-headless -y

wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.6.deb
sudo dpkg -i ./elasticsearch-0.90.6.deb
rm ./elasticsearch-0.90.6.deb
