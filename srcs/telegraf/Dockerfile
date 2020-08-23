FROM alpine:latest

MAINTAINER https://github.com/vdedios

RUN apk update && apk add libc6-compat wget\
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.15.2_linux_amd64.tar.gz \
	&& tar -zxvf telegraf-1.15.2_linux_amd64.tar.gz \
	&& mv telegraf-1.15.2 /etc \
	&& rm -rf telegraf-1.15.2_linux_amd64.tar.gz \
	&& mkdir /etc/telegraf

COPY ./srcs /etc/telegraf

CMD /etc/telegraf-1.15.2/usr/bin/telegraf
