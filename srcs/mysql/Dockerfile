FROM alpine:latest

MAINTAINER https://github.com/vdedios

COPY srcs/* ./

RUN apk add mysql mysql-client openrc \
    && openrc reboot \
    && cp mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf \
    && openrc reboot \
    && /etc/init.d/mariadb setup \
    && /etc/init.d/mariadb start \
    && mariadb < create_tables.sql \
    && mariadb < config_db.sql \
    && mariadb < wordpress.sql \
    && mkdir -p /run/mariadb

CMD ["./run.sh"]

EXPOSE 3306
