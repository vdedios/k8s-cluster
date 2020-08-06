FROM alpine:latest

MAINTAINER https://github.com/vdedios

COPY srcs/* ./

RUN apk add phpmyadmin \
    && mv config.inc.php /etc/phpmyadmin

CMD php -S 0.0.0.0:5000 -t /usr/share/webapps/phpmyadmin

EXPOSE 5000
