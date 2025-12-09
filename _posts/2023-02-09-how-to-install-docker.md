---
title: How to install Docker
lng_pair: how_to_install_docker
category: "technology"
tags: ["guides","docker"]
image: "/assets/images/stock/container_ship.jpg"
date: 2023-02-09 21:20:00 -0700
---

<!-- outline-start -->

If you're unfamiliar, Docker is an incredible tool that allows for quickly spinning up sandboxes to run virtualized servers and networked applications. It provides an incredibly fast and lightweight alternative to virtual machines, at the cost of less separation between the virtual environment and the host system.

This makes it easy to host services such as Minecraft, Plex, Web Servers, and others. While not quite as scalable as cloud-native code such as serverless, containers still allow for massive improvements in deployment speed, and ease of updates.

I'll be going over what works for the operating systems I'm most familiar with, but you can find other documentation online if you use Mac, Windows, or a different Linux distribution.

<!-- outline-end -->

## Installing on Ubuntu

Installing on Ubuntu is fairly straight-forward, as the installation script works out of the box:

[https://get.docker.com](https://get.docker.com)

To use this script, here are a few commands that should work in most cases:

```bash
cd /tmp
curl -fsSL https://get.docker.com -o install_docker.sh
sh install_docker.sh
sudo usermod -aG docker $USER
```

What this does is save the script to a file in your /tmp folder (which will be automatically deleted after reboot), runs the script, then adds your current account to the docker group allowing you to run docker commands without requiring sudo.

## Installing on Pop OS!

Unfortunately the process is not quite as straight forward with Pop OS!, despite being based on Debian/Ubuntu.

I used the following examples to get this working:

- [https://devimalplanet.com/how-to-install-docker-on-linux-pop-os](https://devimalplanet.com/how-to-install-docker-on-linux-pop-os)
- [https://www.youtube.com/watch?v=LrUDOVbI0N8](https://www.youtube.com/watch?v=LrUDOVbI0N8)

First, there are some dependencies we'll need to install:

```shell
sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
```

Then we pull down the gpg public keys from Docker.com to allow for signature checking:

```shell
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

With the keys added, we can now add Docker's apt repo as a new source:

```shell
echo \
"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

With the Docker apt repo added, we can now install the required docker components:

```shell
sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io
```

And finally, we can add the current user to the Docker group, allowing you to use docker commands without sudo.

```shell
sudo usermod -aG docker $USER
```

## Testing your installation

You can test that the docker installation succeeded by running either of these test commands:

```bash
docker run hello-world
docker run -it ubuntu bash
```

If they don't work, or you get an error about needing permission, reboot then try again.

The first command downloads a hello-world example from Docker Hub, while the second downloads an Ubuntu base image from Docker Hub, then takes you to an instance of bash within the container.

## What next?

With Docker installed, you can now setup multiple machines in a Docker swarm, allowing for dynamic load balancing and some more advanced setups.

See: [How to create a Docker Swarm](https://joshbuker.com/blog/how-to-create-a-docker-swarm)
