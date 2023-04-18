---
title: Running Plex with Docker and NFS
category: "technology"
tags: ["guides","plex","docker","nfs"]
img: "/assets/images/stock/popcorn.jpg"
date: 2023-04-18 15:00:00 -0700
---

![](/assets/images/stock/popcorn.jpg)

# Running Plex with Docker and NFS

<!-- outline start -->

If you've been following along with some of my previous posts on [Docker](https://joshbuker.com/blog/how-to-install-docker/) and [NFS](https://joshbuker.com/blog/how-to-setup-a-truenas-scale-server/), you may want something you can directly use with your new home network setup.

Plex is a popular self-hosted streaming solution, with client apps for all major platforms. See [plex.tv](https://plex.tv) for more details. Think of it like Netflix, but it uses files on your computer for what you can watch.

<!-- outline-end -->

## Quick Notes

This guide assumes that you have a functional NFS share for your Plex library data, and know how to operate within Docker Swarm.

Also, while it sounds like a good idea to have the config volume be NFS so that you can deploy to any node, unfortunately Plex suffers from massive performance issues when doing so. Luckily though, labels make it easy to pin the Plex server to a specific node, and the anonymous volume works well enough.

## Setup

First, you'll want to create an NFS share to host the Library data. This will be what your Plex server uses to stream videos.

Make a note of the IP address and mount point of the NFS Share, as you will need this later.

Next, you'll want to create a stack using [Portainer](https://joshbuker.com/blog/how-to-install-portainer/). You can either do this with the web editor, or you can [use a Git repository to allow for continuous deployment](https://joshbuker.com/blog/using-portainer-and-github-for-continuous-deployment/).

### How to use the Stack file

The following is the stack file I created, with some tweaks from [the official documentation](https://github.com/plexinc/pms-docker) to make it easier to configure:

```yaml
version: '3'

services:
  plex:
    image: plexinc/pms-docker
    restart: unless-stopped
    ports:
      - ${PLEX_PORT:-32400}:32400/tcp
      - 3005:3005/tcp
      - 8324:8324/tcp
      - 32469:32469/tcp
      - 1900:1900/udp
      - 32410:32410/udp
      - 32412:32412/udp
      - 32413:32413/udp
      - 32414:32414/udp
    environment:
      ADVERTISE_IP: 'http://${PLEX_ADVERTISE_IP:?Please configure PLEX_ADVERTISE_IP to connect to Plex}:${PLEX_PORT:-32400}/'
      # https://www.plex.tv/claim/
      PLEX_CLAIM: '${PLEX_CLAIM_TOKEN:?Please configure PLEX_CLAIM_TOKEN via env variables}'
      # https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List
      TZ: '${TZ:-America/Los_Angeles}'
    volumes:
      - plex_config:/config
      - plex_transcode:/transcode
      - plex_data:/data
    deploy:
      placement:
        constraints:
          # You'll need to label at least one node for plex deployment
          - node.labels.deployment.target.plex == true

volumes:
  plex_data:
    driver_opts:
      type: "nfs"
      o: "addr=${PLEX_NAS_ADDRESS:?Please configure PLEX_NAS_ADDRESS},rw,noatime,rsize=8192,wsize=8192,tcp,timeo=14,nfsvers=4"
      device: ":${PLEX_NAS_DEVICE:?Please configure PLEX_NAS_DEVICE}"
  plex_config: {}
  plex_transcode: {}
```

#### Environment Variables

There are four environment variables that you will need to configure:

- `PLEX_CLAIM_TOKEN`
- `PLEX_ADVERTISE_IP`
- `PLEX_NAS_ADDRESS`
- `PLEX_NAS_DEVICE`

##### PLEX_CLAIM_TOKEN

This is the randomly generated token used to sync your Plex server with your Plex account.

You can obtain this token by going to: [plex.tv/claim](https://www.plex.tv/claim/)

However, be aware that this token only lasts for 4 minutes, so you will likely need to generate it around the time of deployment to prevent it expiring early.

This token is only needed on the first run, or whenever the configuration data is wiped and needs regenerated (e.g. migrating to a new node).

##### PLEX_ADVERTISE_IP

The IP address that your Plex server will use as its canonical IP.

After testing, it appears that this does not automatically redirect clients, e.g. when connecting to other nodes within a Docker Swarm. If you know more about what this does, please let me know at [@joshbuker@infosec.exchange](https://infosec.exchange/@joshbuker).

##### PLEX_NAS_ADDRESS and PLEX_NAS_DEVICE

These control access to the NFS share used to host your Plex data.

`PLEX_NAS_ADDRESS` is the IP of your NFS host.
`PLEX_NAS_DEVICE` is the mount point of the Plex data/library share. e.g. `/mnt/pool/plex` (use whatever you set when creating the NFS share)

### Save and Deploy

Once you've configured the stack with the above environment variables, you'll need to set a node within your cluster with the label marking it as available for Plex.

With Portainer, you can do this by going to Swarm, then clicking on the node you want to use.

Under Node Details, add `deployment.target.plex` and set it to `true`.

![](/assets/images/posts/plex_node_details.png)

Plex should now automatically deploy to the node you configured, and you can complete setup from the Plex GUI.

### Finishing Setup from the Plex GUI

Visit `https://<node_ip>:32400`, and follow the configuration wizard. This process should be relatively straight-forward and self-explanatory.

There will be one last step after following the configuration wizard before Plex will be ready for you to begin using.

#### Configure LAN Networks

After booting up the service, and visiting the web interface, you'll want to configure the LAN Networks value under Settings -> Network.

LAN Networks controls which subnets are treated as LAN, and won't be throttled by any bandwidth restrictions placed in Settings -> Remote Access.
