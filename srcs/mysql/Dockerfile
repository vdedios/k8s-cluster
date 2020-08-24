FROM alpine:latest

MAINTAINER https://github.com/vdedios

COPY srcs/* ./

RUN apk add mysql mysql-client openrc \
    && cp mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf \
    && mkdir -p /run/mariadb

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

CMD ["./run.sh"]
