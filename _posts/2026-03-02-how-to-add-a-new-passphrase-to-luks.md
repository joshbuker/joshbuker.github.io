---
title: How to add a new passphrase to LUKS
categories:
  - Guides
tags:
  - LUKS
date: 2026-03-02 15:23:00 -0800
---
If you have an existing LUKS partition, and you would like to add a new passphrase without needing to reformat anything or replace the existing passphrase, luckily it's just a few commands.

First, identify the LUKS partition using lsblk:

```sh
lsblk
```

Which should give you something like the following:

```txt
NAME                                          MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
nvme0n1                                       259:0    0 465.8G  0 disk
├─nvme0n1p1                                   259:1    0     1G  0 part  /boot
├─nvme0n1p2                                   259:2    0 422.1G  0 part
│ └─luks-lfdh6awk-hx9p-plbt-nfvv-rzksdjdpy9sa 254:0    0 422.1G  0 crypt /nix/store
│                                                                        /
└─nvme0n1p3                                   259:3    0  42.6G  0 part
  └─luks-2a10928f-42g2-52gd-b7a0-42ci6cd84f17 254:1    0  42.6G  0 crypt [SWAP]
```

Grab the appropriate device, e.g.:

```sh
/dev/nvme0n1p2
```

Verify it's LUKS:

```sh
sudo cryptsetup luksDump /dev/nvme0n1p2
```

If the LUKS partition isn't already unlocked (e.g. mounting an external drive with a LUKS partition), you will need to unlock the partition before making edits. This step can be skipped if you're adding a passphrase for the current computer's partitions:

```sh
sudo cryptsetup luksOpen /dev/nvme0n1p2 temporary_mapped_name_here
```

Add new passphrase:
```sh
sudo cryptsetup luksAddKey /dev/nvme0n1p2
```

> Make sure to run the command for every partition (e.g. don't forget to run it on the main nix partition AND the swap partition) or you'll run into one unlocking but not the other.
{: .prompt-warning }

Done! You should now be able to unlock the drive either with the original passphrase, or the second newly added passphrase.
