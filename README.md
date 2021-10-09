# Podman server example
## Priveleded ports for rootless container

```sudo sysctl net.ipv4.ip_unprivileged_port_start=0```

## Docker Compose rootless
export DOCKER_HOST="unix:$XDG_RUNTIME_DIR/podman/podman.sock"