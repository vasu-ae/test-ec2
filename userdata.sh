#!/bin/bash
yum update -y	
yum install httpd -y
service httpd start
echo "<h1>HELLO WORLD<h1>" > /var/www/html/index.html