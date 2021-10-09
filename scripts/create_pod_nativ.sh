#!/bin/bash

pod_name=minimal-server-pod

podman pod kill $pod_name
podman pod rm $pod_name

podman pod create \
--name $pod_name \
-p 80:80

podman run -d --name test_server-1 --pod $pod_name minimal-server
