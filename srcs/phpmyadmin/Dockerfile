FROM alpine:latest

MAINTAINER https://github.com/vdedios

COPY srcs/* ./

RUN apk update && apk add wget nginx php-fpm php-mbstring openrc\
	&& rm /etc/nginx/nginx.conf && mv nginx.conf /etc/nginx \
	&& mkdir /etc/nginx/sites-available \
	&& mkdir /etc/nginx/sites-enabled \
	&& mkdir /var/www/html \
	&& mv default /etc/nginx/sites-available/ \
	&& ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default \
	&& wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& tar xvf phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& mv phpMyAdmin-5.0.2-all-languages /var/www/html/phpmyadmin \
	&& rm -rf phpMyAdmin-5.0.2-all-languages.tar.gz \

CMD	openrc reboot && rc-service php-fpm7 start && rc-service nginx start && ash

EXPOSE 5000
