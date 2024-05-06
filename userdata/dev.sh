#!/bin/bash
apt-get update
apt-get install nginx -y
echo "<h1>welcome to Dev Environment</h1>" >/var/www/html/index.nginx-debian.html