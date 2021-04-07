#!/bin/bash
if grep -q "autoindex on" /etc/nginx/conf.d/service.conf
then
	sed -i 's/autoindex on;/autoindex off;' /etc/nginx/conf.d/service.conf
	cat /etc/nginx/conf.d/service.conf
else 
	sed -i 's/autoindex off;/autoindex on;' /etc/nginx/conf.d/service.conf
	cat /etc/nginx/conf.d/service.conf
fi
service nginx reload