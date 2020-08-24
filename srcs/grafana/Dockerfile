FROM alpine:latest

MAINTAINER https://github.com/vdedios


RUN apk update && apk add libc6-compat \
	&& wget https://dl.grafana.com/oss/release/grafana-6.7.2.linux-amd64.tar.gz \
	&& tar -zxvf grafana-6.7.2.linux-amd64.tar.gz

COPY srcs/* ./

RUN mv dashboard.yaml grafana-6.7.2/conf/provisioning/dashboards/ \
	&& mv sources.yaml grafana-6.7.2/conf/provisioning/datasources/ \
	&& mkdir /var/lib/grafana-dashboards \
	&& mv dashboard.json /var/lib/grafana-dashboards \
	&& mv defaults.ini grafana-6.7.2/conf

CMD cd ./grafana-6.7.2/bin/ && ./grafana-server

EXPOSE 3000
