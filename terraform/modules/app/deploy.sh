#!/bin/bash
set -e

APP_DIR=$HOME

git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install

echo "DATABASE_URL=$1:27017" > $APP_DIR/reddit/env_variables
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
