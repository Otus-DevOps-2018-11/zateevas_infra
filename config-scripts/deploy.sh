#!/bin/bash

echo "Cloning reddit repo"
git clone -b monolith https://github.com/express42/reddit.git

echo "Install dependencies"
cd reddit && bundle install

echo "Starting puma"
puma -d

echo "Check puma"
ps aux | grep puma
