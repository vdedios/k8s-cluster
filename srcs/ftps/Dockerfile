FROM alpine:latest

MAINTAINER https://github.com/vdedios

COPY ./srcs/* ./

RUN apk update && apk add vsftpd openssl \
	&& rm /etc/vsftpd/vsftpd.conf \
	&& mv vsftpd.conf /etc/vsftpd \
	&& openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42/CN=127.0.0.1" \
	-keyout /etc/ssl/private/vsftpd.key \
	-out /etc/ssl/certs/vsftpd.crt

CMD	openrc reboot && rc-service vsftpd start && ash

EXPOSE 21
