---
title: How to Setup a TrueNAS Scale Server
categories:
  - Guides
  - Homelab
tags:
  - TrueNAS
  - NFS
image: "/assets/images/stock/blue_data_center.jpg"
date: 2023-03-20 22:15:00 -0700
---

This blog post will get you started with the minimum you need to stand up a TrueNAS Scale Server and create NFS share(s) for docker persisted volumes.

See also, the TrueNAS Scale Official Documentation:
- [Adding and Managing Datasets](https://www.truenas.com/docs/scale/scaletutorials/storage/datasets/datasetsscale/)
- [Adding NFS Shares](https://www.truenas.com/docs/scale/scaletutorials/shares/nfs/addingnfsshares/)
- [Adding SMB Shares](https://www.truenas.com/docs/scale/scaletutorials/shares/smb/addsmbshares/)
- [Managing SMB Shares](https://www.truenas.com/docs/scale/scaletutorials/shares/smb/managesmbshares/)

## Quick Notes

- Use LZ4 compression unless you know what you're doing
- Use NFSv4 ACLs unless you know what you're doing

## Setup TrueNAS Scale

Stage your bare metal server using the [Latest TrueNAS Scale Image](https://www.truenas.com/download-truenas-scale/).[^1]

Next, go to Network, and set your hostname via Global Configuration.

![](/assets/images/posts/network_global_config.png)

Next, from your router, assign the server a static IP address outside of your DHCP pool range.

Then, from System Settings -> General, enable the HTTP to HTTPS redirect.

![](/assets/images/posts/truenas_scale_system_settings.png)

Reboot time!

Before we can start adding network shares, we'll need to add a local user.

First, create a new dataset for local user homes. I recommend this be root level, and named something simple like `homes`.

See the official documentation on [Adding and Managing Datasets](https://www.truenas.com/docs/scale/scaletutorials/storage/datasets/datasetsscale/) for further details on creating new datasets.

Now that there is a place for the user homes, go ahead and create a new local user.

A few notes:
- Use the default UID, and DO NOT OVERRIDE IT. Trust me, it'll cause immense headaches down the road if you modify this.
- Set the home directory to the new dataset for homes
- Enable sudo
- Add your authorized ssh keys
- Set shell to your preferred terminal

Now that you have a local user with SSH keys, you'll want to enable and start automatically the SSH service under System Settings -> Services. Don't enable the NFS and SMB services quite yet, we'll do that after creating the shares.

## Creating an NFS Share

Follow the official documentation on [Adding NFS Shares](https://www.truenas.com/docs/scale/scaletutorials/shares/nfs/addingnfsshares/).

A few notes:
- I am inexperienced with NFS, and couldn't figure out how to get files to write without setting `mapall user` and `mapall group` both to a user with permissions to the dataset. Apparently this is a no-no, and if you know the proper method, let me know at [@joshbuker@infosec.exchange](https://infosec.exchange/@joshbuker) and I'll update this post.
- Enable NFSv4 (and dont enable NFSv3 mode for NFSv4)

## Creating an SMB Share

Follow the documentation on [Adding SMB Shares](https://www.truenas.com/docs/scale/scaletutorials/shares/smb/addsmbshares/) and [Managing SMB Shares](https://www.truenas.com/docs/scale/scaletutorials/shares/smb/managesmbshares/).

## Done!

You should now be able to use this server as the hosting for your persistent volumes in Docker. I'll be following up with various blog posts using this, such as Plex and Modded Minecraft servers via docker swarm.

[^1]: Look in the bottom right for "No Thank you, I have already signed up." to skip their newsletter spam.
