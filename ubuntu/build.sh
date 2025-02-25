#!/bin/bash

. ./setenv.sh

docker rmi -f ${PROJECT_NAME}:${PROJECT_VERSION} 
docker build --progress=plain -t ${PROJECT_NAME}:${PROJECT_VERSION} .

echo "Stopping and removing previous ${PROJECT_NAME} containers"
OLD=$(sudo docker ps -a | grep "${PROJECT_NAME}" | awk '{print $1}' | paste -sd ' ' -)
if [ ! -z $OLD ]; then
	docker stop $OLD
	docker rm $OLD
fi

echo "Start ${PROJECT_NAME}"
sudo docker run -t  \
	--name ${PROJECT_NAME} \
	-v /data/certs:/etc/secrets \
	-p 8080:8080 \
	-p 9990:9990 \
	${PROJECT_NAME}:${PROJECT_VERSION}
