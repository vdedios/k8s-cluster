FROM alpine:latest

MAINTAINER https://github.com/vdedios

COPY ./srcs/* ./

RUN apk update && apk add nginx && apk add openrc openssl\
	&& mkdir /etc/nginx/sites-available \
	&& mkdir /etc/nginx/sites-enabled \
	&& mkdir /var/www/html \
	&& mv default /etc/nginx/sites-available/ \
	&& ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default \
	&& mv index.html /var/www/html \
	&& rm /etc/nginx/nginx.conf && mv nginx.conf /etc/nginx \
	&& rm /etc/nginx/conf.d/default.conf \
	&& openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42/CN=127.0.0.1" \
	-keyout /etc/ssl/private/server.key \
	-out /etc/ssl/certs/server.crt

CMD	openrc reboot && rc-service nginx start && ash

EXPOSE 80 443
