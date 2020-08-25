FROM alpine:latest

MAINTAINER https://github.com/vdedios

COPY srcs/* ./

RUN apk update && apk add wget php7 php-fpm php-mbstring php7-json php7-mysqli\
	&& wget https://es.wordpress.org/latest-es_ES.tar.gz \
	&& tar xvf latest-es_ES.tar.gz \
	&& mkdir /var/www \
	&& mv wordpress/* /var/www \
	&& rm -rf latest-es_ES.tar.gz \
	&& mv wp-config.php /var/www

ENTRYPOINT php -S 0.0.0.0:5050 -t /var/www

EXPOSE 5050
