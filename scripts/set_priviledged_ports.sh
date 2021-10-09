#!/bin/bash

echo "net.ipv4.ip_unprivileged_port_start=0" >> /etc/sysctl.conf 
sysctl --system