#!/bin/bash -v
apt-get update -y
apt-get install -y nginx > /tmp/nginx.log
service nginx start

#SysDig
apt-get -y install linux-headers-$(uname -r)
curl -s https://s3.amazonaws.com/download.draios.com/stable/install-agent | sudo bash -s -- --access_key c31a5039-a5eb-4e17-918f-a4e45b788f16 --collector ingest.us-south.monitoring.cloud.ibm.com --collector_port 6443 --secure true --tags node:nginx

#LogDNA
echo "deb https://repo.logdna.com stable main" | sudo tee /etc/apt/sources.list.d/logdna.list 
wget -O- https://repo.logdna.com/logdna.gpg | sudo apt-key add - 
sudo apt-get update
sudo apt-get install logdna-agent < "/dev/null"
sudo logdna-agent -k 3d3422826300b1cb09ee094e22af518b
sudo logdna-agent -s LOGDNA_APIHOST=api.us-south.logging.cloud.ibm.com
sudo logdna-agent -s LOGDNA_LOGHOST=logs.us-south.logging.cloud.ibm.com
sudo logdna-agent -d /var/log/nginx
