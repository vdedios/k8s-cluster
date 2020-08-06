FROM alpine:latest

MAINTAINER https://github.com/vdedios

COPY srcs/* ./

RUN apk update && apk add wget nginx php-fpm php-mbstring openrc php7-json php7-mysqli\
	&& rm /etc/nginx/nginx.conf && mv nginx.conf /etc/nginx \
	&& mkdir /etc/nginx/sites-available \
	&& mkdir /etc/nginx/sites-enabled \
	&& mkdir /var/www/html \
	&& mv default /etc/nginx/sites-available/ \
	&& ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default \
	&& wget https://es.wordpress.org/latest-es_ES.tar.gz \
	&& tar xvf latest-es_ES.tar.gz \
	&& mv wordpress/* /var/www/html \
	&& rm -rf latest-es_ES.tar.gz \
	&& mv wp-config.php /var/www/html

CMD	openrc reboot && rc-service php-fpm7 start && rc-service nginx start && ash

EXPOSE 5050
