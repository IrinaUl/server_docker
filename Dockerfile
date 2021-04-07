FROM debian:buster

LABEL maintainer="mkacie@student.21-school.ru"
ENV TZ=Europe/Moscow

RUN apt-get update && apt-get -y upgrade && \
apt-get -y install openssl wget mariadb-server nginx php-fpm php-mysql php-bcmath php-ctype php-json php-mbstring php-pdo php-tokenizer php-xml php-curl php-soap php-cli

COPY srcs/service.conf /etc/nginx/conf.d/
RUN touch /var/www/index.php && echo "<?php phpinfo(); ?>" >> /var/www/index.php

RUN mkdir /etc/nginx/ssl && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out /etc/nginx/ssl/local.pem -keyout /etc/nginx/ssl/local.key -subj "/C=RU/ST=NSO/L=Moscow/O=21school/CN=mkacie/emailAddress=mkacie@student.21-school.ru"

RUN mkdir /var/www/phpMyAdmin && cd /var/www/phpMyAdmin &&\
	wget -c https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-english.tar.gz -O phpMyAdmin.tar.gz && \
	tar -xvf phpMyAdmin.tar.gz --strip-components 1 && \
	rm -rf phpMyAdmin.tar.gz 

RUN mkdir /var/www/wordpress && cd /var/www/wordpress && \
	wget -c https://wordpress.org/latest.tar.gz -O wordpress.tar.gz && \
	tar -xvf wordpress.tar.gz --strip-components 1 && \
	rm -rf wordpress.tar.gz && \
	chown -R www-data /var/www/* && chmod -R 755 /var/www/* && \
	apt-get -y clean all

EXPOSE 80 443
COPY ./srcs/*.sh /var/www/
RUN chmod 777 /var/www/*.sh
ENTRYPOINT bash /var/www/util.sh

