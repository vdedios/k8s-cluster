#! /bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;36m'
ORANGE='\033[0;33m'
RED='\033[1;31m'
NC='\033[0m'

# Welcome and start Minikube!
	cat srcs/hello.txt
	#minikube start
	eval $(minikube -p minikube docker-env)

printf "${ORANGE}------> DELETING PREVIOUS DEPLOYMENTS AND SERVICES\n${NC}"
	kubectl delete --all services
	kubectl delete --all deployments
# Configure Metallb Load Balancer
printf "${ORANGE}------> CONFIGURING LOAD BALANCER\n${NC}"

	# Apply the changes, returns nonzero returncode on errors only
	#kubectl get configmap kube-proxy -n kube-system -o yaml | \
	#sed -e "s/strictARP: false/strictARP: true/" | \
	#kubectl apply -f - -n kube-system

	#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
	#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
	## On first install only
	#kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

	## Apply config
	#kubectl apply -f srcs/deployments/metallb.yaml

# Build and deploy Wordpress
printf "${ORANGE}------> BUILDING AND DEPLOYING WORDPRESS\n${NC}"
	#docker build -t mywordpress srcs/wordpress
	kubectl apply -f srcs/deployments/wordpress.yaml
	kubectl expose deployment wordpress --type=LoadBalancer --port=5050

# Build and deploy MySQL and phpmyadmin
printf "${ORANGE}------> BUILDING AND DEPLOYING REST OF SERVICES\n${NC}"
	#Get wordpress external IP and set it into mysql database
	WORDPRESS_IP=$(kubectl get service/wordpress -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
	echo Wordpress public IP is $WORDPRESS_IP
	#Cambiar a OLD_IP
	sed -i '' "s+192.168.1.150+$WORDPRESS_IP+g" srcs/mysql/srcs/wordpress.sql

	#docker build -t mymysql srcs/mysql
	#docker build -t myphpmyadmin srcs/phpmyadmin
	#docker build -t mynginx srcs/nginx
	#docker build -t myftps srcs/ftps
	kubectl apply -f srcs/deployments/mysql.yaml
	kubectl apply -f srcs/deployments/phpmyadmin.yaml
	kubectl apply -f srcs/deployments/nginx.yaml
	kubectl apply -f srcs/deployments/ftps.yaml
	kubectl expose deployment phpmyadmin --type=LoadBalancer --port=5000
	kubectl expose deployment mysql --port=3306
	kubectl expose deployment nginx --type=LoadBalancer --port=80,443,22
	kubectl expose deployment ftps --type=LoadBalancer --port=21,31030,31031,31032,31033,31034,31035,31036,31037,31038,31039,31040
	PHPMYADMIN_IP=$(kubectl get service/phpmyadmin -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
	NGINX_IP=$(kubectl get service/nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
	FTPS_IP=$(kubectl get service/ftps -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

printf "\n${ORANGE}------> TRY ALL THE SERVICES!\n${NC}"
printf "${BLUE}	Wordpress:${NC}"
printf "${GREEN}  $WORDPRESS_IP:5050\n${NC}"
printf "${BLUE}	Phpmyadmin:${NC}"
printf "${GREEN}  $PHPMYADMIN_IP:5000\n${NC}"
printf "${BLUE}	Nginx:${NC}"
printf "${GREEN}  $NGINX_IP:80 and $NGINX_IP:22 for SSH\n${NC}"
printf "${BLUE}	Ftps:${NC}"
printf "${GREEN}  $FTPS_IP:21\n${NC}"
