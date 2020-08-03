FROM alpine:latest

MAINTAINER https://github.com/vdedios

COPY srcs/* ./

RUN apk add mysql mysql-client openrc\
	&& mv config_db.sql /tmp \
	#&& mv wordpress.sql /tmp \
	&& openrc reboot \
	&& /etc/init.d/mariadb setup \
	&& /etc/init.d/mariadb start \
	&& mysql < /tmp/config_db.sql
	#&& mysql wordpress < /tmp/wordpress.sql

CMD openrc reboot && /etc/init.d/mariadb start && ash

EXPOSE 3306
