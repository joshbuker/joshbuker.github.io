---
title: How to create a Docker Swarm
category: "technology"
tags: ["guides","docker"]
img: "/assets/images/stock/container_ship_swarm.jpg"
date: 2023-02-10 09:40:00 -0700
---

![Container Ship Swarm](/assets/images/stock/container_ship_swarm.jpg)

# How to create a Docker Swarm

<!-- outline-start -->

Docker Swarm is an easy way to turn a pile of old computers at home into a home lab environment. It can automatically load balance the various services you spin up, and you can use free tools like Portainer to help manage your swarm.

Before you create a Docker Swarm, you'll want to [install Docker](https://joshbuker.com/blog/how-to-install-docker) on all of the nodes (computers) you'll be using in the swarm. You can do this with as few as one manager node, and one worker node.

<!-- outline-end -->

Official Docker documentation: https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/

## Set Static IPs for all nodes

You'll want to assign a static IP for all of your manager and worker nodes, so that things don't implode when a node reboots.

For pfSense, you can do this by:

1. Going to [Status -> DHCP Leases](https://192.168.7.1/status_dhcp_leases.php)
2. Find the lease for the machine you want set static
3. Click the + button for setting static IP

For other network setups, look up "how to set a static ip with \<device\>".

## Initialize Docker Swarm on a Manager Node

Manager nodes are the machines that will act as the control center for the swarm, managing things like the distribution of services, and communication between nodes. Manager nodes will also act as workers, so deciding which machine acts as a manager primarily depends on how likely you think it is to stay online 24/7.

To initialize a new swarm, use the swarm init command:

```shell
docker swarm init --advertise-addr <MANAGER-IP>
```

e.g.

```shell
docker swarm init --advertise-addr 192.168.1.200
```

This should give you some output with the `docker swarm join --token <token> <ip>:<port>` command to use on followers, as well as how to create a token for managers.

You can test that this worked, by running:

```shell
docker info
```

Which should give some info about the swarm.

You can also run from a manager node:

```shell
docker node ls
```

To view the current nodes in the swarm.

## Join workers to the swarm

Run the join command on each follower. If you lost the original output, you can generate a new join token from a manager node using:

```shell
docker swarm join-token worker
```

Which will give you the command to run from a worker to join it to the swarm.

## What next?

Your Docker Swarm is ready! Now that it's initialized, you'll probably want to start spinning up some services to try things out. Personally, I recommend Portainer for managing a Docker Swarm. It provides a friendly and intuitive GUI, while automatically picking up anything you run via CLI.

Best of all, it's free to use, and is itself a container that runs as a swarm service.

See: [How to install Portainer](https://joshbuker.com/blog/how-to-install-portainer)
