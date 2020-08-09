FROM alpine:latest

MAINTAINER https://github.com/vdedios

RUN apk update && apk add libc6-compat \
	&& wget https://dl.grafana.com/oss/release/grafana-6.7.2.linux-amd64.tar.gz \
	&& tar -zxvf grafana-6.7.2.linux-amd64.tar.gz

CMD cd ./grafana-6.7.2/bin/ && ./grafana-server

EXPOSE 3000
