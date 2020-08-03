FROM alpine:latest

MAINTAINER https://github.com/vdedios

COPY srcs/* ./

RUN apk add mysql openrc\
	&& mv config_db.sql /tmp \
	&& mv wordpress.sql /tmp \
	&& rc-service mysql start \
	&& mysql < /tmp/config_db.sql \
	&& mysql wordpress < /tmp/wordpress.sql \
	&& rc-service mysql stop

CMD openrc reboot && rc-service mysql start && ash
