#!/bin/bash

echo "Cloning reddit repo"
mkdir -p /srv/reddit
git clone -b monolith https://github.com/express42/reddit.git /srv/reddit

echo "Install dependencies"
cd /srv/reddit && bundle install

echo "Enable and start systemd service"
cp /tmp/reddit.service /etc/systemd/system/
systemctl enable reddit.service
systemctl start reddit.service
