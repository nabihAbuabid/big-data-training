#!/bin/bash

\curl -L https://get.rvm.io | bash -s stable

source ~/.profile
echo "----------"
echo "## In your terminal window choose from top menu: \"Edit -> Profile Preferences\""
echo "## In \"Title and Command\" tab check \"Run command as login shell\""
echo "## Reopen a new shell tab (CTRL-SHIFT-T) and run the ruby installer"
echo "----------"
