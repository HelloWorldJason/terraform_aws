#!/bin/bash

apt-get update
apt-get install -y nginx
echo Created: ${time} | sudo tee /var/www/html/index.html
exit 0
