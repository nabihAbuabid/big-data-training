# Big Data Training Materials

## Session 1 - Document Databases

Please open a terminal and run the following commands

```
$ cd ~
$ mkdir -p workspace/training && cd workspace/training
$ git clone git@github.com:zohararad/big-data-training.git big-data
$ cd materials
$ mongodb/install-mongo.sh
$ elasticsearch/install-elasticsearch.sh
$ cd rails
$ ./install-rvm.sh
$ ./install-ruby.sh
```

The above will

1. Clone this repository to `~/workspace/training/big-data`
2. Install MongoDB
3. Install Elastic Search
4. Install Ruby 2.0 using RVM
5. Install example project dependencies
6. Populate example data into MongoDB and Elastic Search