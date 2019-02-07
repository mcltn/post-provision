#!/bin/bash -v
apt-get update -y
apt-get install -y nginx > /tmp/nginx.log
service nginx start

apt-get -y install linux-headers-$(uname -r)

curl -s https://s3.amazonaws.com/download.draios.com/stable/install-agent | sudo bash -s -- --access_key c31a5039-a5eb-4e17-918f-a4e45b788f16 --collector ingest.us-south.monitoring.cloud.ibm.com --collector_port 6443 --secure true --tags node:nginx
