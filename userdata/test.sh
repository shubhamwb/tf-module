#!/bin/bash
apt-get update
apt-get install nginx -y
echo "welcome to Test Env" >/var/www/html/index.nginx-debian.html