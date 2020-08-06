FROM alpine:latest

MAINTAINER https://github.com/vdedios

COPY srcs/* ./

RUN apk add mysql mysql-client openrc \
    && openrc reboot \
    && cp mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf \
    && /etc/init.d/mariadb setup \
    && /etc/init.d/mariadb start \
    && mariadb < config_db.sql

CMD openrc reboot && /etc/init.d/mariadb start && ash

EXPOSE 3306
