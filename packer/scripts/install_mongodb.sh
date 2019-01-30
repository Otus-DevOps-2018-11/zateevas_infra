#!/bin/bash

echo "Adding mongodb repo"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'


echo "Updating repo data"
apt update
echo "Installing mongodb"
apt install -y mongodb-org

rm /etc/mongod.conf
mv /tmp/mongod.conf /etc/mongod.conf

echo "Starting mongod"
systemctl enable mongod
systemctl start mongod
