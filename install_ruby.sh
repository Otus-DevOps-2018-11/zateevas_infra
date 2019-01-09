#!/bin/bash
echo "Updating repo data"
apt update
echo "Installing ruby packets"
apt install -y ruby-full ruby-bundler build-essential
echo "Installation Done! Current versions of ruby and bundler:"
ruby -v
bundler -v
