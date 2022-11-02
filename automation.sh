#! /bin/bash

name="Samarth"
s3_bucket="upgrad-samarth"

sudo apt update -y
sudo apt install apache2
sudo systemctl start apache2
sudo systemctl status apache2
sudo tar -c -v -f Samarth-httpd-logs-31102022-132441.tar /var/log/apache2/
aws s3 cp /tmp/Samarth-httpd-logs-31102022-132411.tar s3://$s3_bucket/
