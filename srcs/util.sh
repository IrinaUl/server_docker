#!/bin/bash
service mysql start
mysql -u root --skip-password -e "CREATE USER 'ftserver'@'localhost' IDENTIFIED BY 'ftserver';"
mysql -u root --skip-password -e "CREATE DATABASE wordpress;"
mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'ftserver'@'localhost' IDENTIFIED BY 'ftserver';"
mysql -u root --skip-password -e "FLUSH PRIVILEGES;"

service php7.3-fpm start
service nginx start
bash