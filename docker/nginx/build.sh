#!/bin/bash

docker build -t my-nginx .
docker run -d -p 8080:80 -v /home/rajan/projects/docker/nginx/data:/usr/share/nginx/html my-nginx
