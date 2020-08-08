FROM alpine:latest

MAINTAINER https://github.com/vdedios

RUN apk update && apk add influxdb

CMD influxd run -config /etc/influxdb.conf

EXPOSE 8086
