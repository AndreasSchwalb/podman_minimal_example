#!/bin/bash

pod_name=minimal-server-pod

podman pod kill $pod_name
podman pod rm $pod_name

podman play kube \
--configmap ./config/env.yaml pod.yaml