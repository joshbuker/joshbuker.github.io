---
title: How to install Portainer
category: "technology"
tags: ["guides","docker"]
img: "/assets/images/stock/portainer.jpg"
date: 2023-02-15 09:00:00 -0700
---

![Portainer](/assets/images/stock/portainer.jpg)

# How to install Portainer

<!-- outline-start -->

Portainer is a useful GUI tool for interfacing with Docker. It runs as a container stack, and communicates directly with Docker itself.

Portainer particularly shines when managing a Docker Swarm.

<!-- outline-end -->

## Docker Swarm Mode

First, [Create a Docker Swarm](https://joshbuker.com/blog/how-to-create-a-docker-swarm/).

- [https://docs.portainer.io/start/install/server/swarm/linux](https://docs.portainer.io/start/install/server/swarm/linux)
- [https://stackoverflow.com/a/64234716](https://stackoverflow.com/a/64234716)

## Install and deploy Community Edition

First, download the latest stack file to somewhere on your manager node that will persist between reboots (i.e. DON'T use `/tmp`, as the file will be autoremoved).

For example:

```shell
mkdir -p ~/Projects/portainer
cd ~/Projects/portainer
curl -L https://downloads.portainer.io/ce2-16/portainer-agent-stack.yml -o portainer-agent-stack.yml
```

Update the stack file to use `latest` instead of whatever version is current (e.g. 2.16.2).

For example:

```yml
version: '3.2'

services:
  agent:
    image: portainer/agent:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /var/lib/docker/volumes:/var/lib/docker/volumes
    networks:
      - agent_network
    deploy:
      mode: global
      placement:
        constraints: [node.platform.os == linux]

  portainer:
    image: portainer/portainer-ce:latest
    command: -H tcp://tasks.agent:9001 --tlsskipverify
    ports:
      - "9443:9443"
      - "9000:9000"
      - "8000:8000"
    volumes:
      - portainer_data:/data
    networks:
      - agent_network
    deploy:
      mode: replicated
      replicas: 1
      placement:
        constraints: [node.role == manager]

networks:
  agent_network:
    driver: overlay
    attachable: true

volumes:
  portainer_data:
```

Once you have a stack file, deploy the stack to your swarm from a manager node using:

```shell
docker stack deploy -c portainer-agent-stack.yml portainer
```

You should now be able to visit any node in your docker swarm on port 9000 or 9443 (http and https respectively) to open portainer.

## What next?

[Using Portainer and GitHub for Continuous Deployment](https://joshbuker.com/blog/using-portainer-and-github-for-continuous-deployment)
