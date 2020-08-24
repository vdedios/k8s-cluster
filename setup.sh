#! /bin/bash

# Environment IPs
WORDPRESS_IP=192.168.64.120
FTPS_IP=192.168.64.121

GREEN='\033[0;32m'
BLUE='\033[0;36m'
ORANGE='\033[0;33m'
RED='\033[1;31m'
NC='\033[0m'

# Welcome and start Minikube!
	cat srcs/hello.txt
	minikube start
	eval $(minikube -p minikube docker-env)

# Clean old deployments and svcs
printf "${ORANGE}------> DELETING PREVIOUS DEPLOYMENTS AND SERVICES\n${NC}"
	kubectl delete --all services
	kubectl delete --all deployments
	kubectl delete --all pvc
	kubectl delete --all pv

# Configure Metallb Load Balancer
printf "${ORANGE}------> CONFIGURING LOAD BALANCER\n${NC}"

	# Apply the changes, returns nonzero returncode on errors only
	kubectl get configmap kube-proxy -n kube-system -o yaml | \
	sed -e "s/strictARP: false/strictARP: true/" | \
	kubectl apply -f - -n kube-system

	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
	## On first install only
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

	## Apply config
	kubectl apply -f srcs/deployments/metallb.yaml

# Build and deploy all
printf "${ORANGE}------> BUILDING IMAGES\n${NC}"
	cp srcs/mysql/srcs/wordpress_base.sql srcs/mysql/srcs/wordpress.sql
	sed -i '' "s+OLD_IP+$WORDPRESS_IP+g" srcs/mysql/srcs/wordpress.sql
	cp srcs/ftps/srcs/vsftpd_base.conf srcs/ftps/srcs/vsftpd.conf
	sed -i '' "s+OLD_IP+$FTPS_IP+g" srcs/ftps/srcs/vsftpd.conf
	printf "${GREEN}	BUILDING WORDPRESS\n${NC}"
	#docker build -t mywordpress srcs/wordpress
	printf "${GREEN}	BUILDING MYSQL\n${NC}"
	#docker build -t mymysql srcs/mysql
	printf "${GREEN}	BUILDING PHPMYADMIN\n${NC}"
	#docker build -t myphpmyadmin srcs/phpmyadmin
	printf "${GREEN}	BUILDING NGINX\n${NC}"
	#docker build -t mynginx srcs/nginx
	printf "${GREEN}	BUILDING FTPS\n${NC}"
	#docker build -t myftps srcs/ftps
	printf "${GREEN}	BUILDING INFLUXDB\n${NC}"
	#docker build -t myinflux srcs/influx
	printf "${GREEN}	BUILDING GRAFANA\n${NC}"
	#docker build -t mygrafana srcs/grafana
	printf "${GREEN}	BUILDING TELEGRAF\n${NC}"
	#docker build -t mytelegraf srcs/telegraf
	rm srcs/ftps/srcs/vsftpd.conf
	rm srcs/mysql/srcs/wordpress.sql

printf "${ORANGE}------> DEPLOYING APPS AND CREATING SERVICES\n${NC}"
	cp srcs/deployments/ftps.yaml srcs/deployments/ftps_edit.yaml
	sed -i '' "s+FTPS_IP+$FTPS_IP+g" srcs/deployments/ftps_edit.yaml
	cp srcs/deployments/wordpress.yaml srcs/deployments/wordpress_edit.yaml
	sed -i '' "s+WORDPRESS_IP+$WORDPRESS_IP+g" srcs/deployments/wordpress_edit.yaml
	kubectl apply -f srcs/deployments/volumes.yaml
	kubectl apply -f srcs/deployments/wordpress_edit.yaml
	kubectl apply -f srcs/deployments/ftps_edit.yaml
	kubectl apply -f srcs/deployments/mysql.yaml
	kubectl apply -f srcs/deployments/phpmyadmin.yaml
	kubectl apply -f srcs/deployments/nginx.yaml
	kubectl apply -f srcs/deployments/influx.yaml
	kubectl apply -f srcs/deployments/grafana.yaml
	kubectl apply -f srcs/deployments/telegraf.yaml
	rm srcs/deployments/ftps_edit.yaml
	rm srcs/deployments/wordpress_edit.yaml

# Print IPs and ports
PHPMYADMIN_IP=$(kubectl get service/phpmyadmin -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
NGINX_IP=$(kubectl get service/nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
GRAFANA_IP=$(kubectl get service/grafana -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
printf "\n${ORANGE}------> TRY ALL THE SERVICES!\n${NC}"
printf "${BLUE}	Wordpress:${NC}"
printf "${GREEN}  $WORDPRESS_IP:5050\n${NC}"
printf "${BLUE}	Phpmyadmin:${NC}"
printf "${GREEN}  $PHPMYADMIN_IP:5000\n${NC}"
printf "${BLUE}	Nginx:${NC}"
printf "${GREEN}  $NGINX_IP:80 and $NGINX_IP:22 for SSH\n${NC}"
printf "${BLUE}	Ftps:${NC}"
printf "${GREEN}  $FTPS_IP:21\n${NC}"
printf "${BLUE}	grafana:${NC}"
printf "${GREEN}  $GRAFANA_IP:3000\n${NC}"
