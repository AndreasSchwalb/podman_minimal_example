#!/bin/bash

pod_name=minimal-server-pod

podman pod kill $pod_name
podman pod rm $pod_name

podman_34 play kube \
--configmap ./config/env.yaml \
--build \
pod_custom.yaml