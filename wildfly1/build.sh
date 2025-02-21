#!/bin/bash

docker build -t wildfly-adb2 .

docker run -p 8080:8080 -p 9990:9990 wildfly-adb2
