#!/bin/bash

if [ ! -d "$HOME/.rvm" ]; then
	echo "Please run the RVM installer first"
	exit 0
fi

echo "installing ruby"

rvm install 2.0.0 --disable-binary --verify-downloads 1

cwd=$(pwd)

echo "creating new project gemset"
rvm 2.0.0 do rvm gemset create big-data-training
rvm rvmrc warning ignore all.rvmrcs
cd "$cwd/../../apps/recruit-me"

echo "installing project dependencies"
rvm 2.0.0@big-data-training do bundle install
echo "seeding data"
rvm 2.0.0@big-data-training do rake db:seed
echo "indexing data"
rvm 2.0.0@big-data-training do rake environment tire:import:model CLASS='Position'
cd "$cwd"
