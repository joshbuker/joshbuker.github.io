---
title: How to create a NixOS Server VM Inside NixOS
categories:
  - Guides
  - NixOS
tags:
  - NixOS
  - Virtualization
image: /assets/images/posts/nixos.png
---
I wanted to give NixOS a shot for replacing Ubuntu Server but have somewhat limited hardware at the moment, so using a Virtual Machine (VM) seemed like the easiest way to test things out before rolling it out on bare metal hardware.

## Installing the hypervisor on your host machine

Check this later: https://wiki.nixos.org/wiki/Virt-manager

```nix
{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.<myuser>.extraGroups = [ "libvirtd" ];
}
```
{: file="configuration.nix" }

```sh
sudo virsh net-autostart default
sudo virsh net-start default
```

## Creating the Virtual Machine

Download ISO, install

## Installing the guest utils

```nix
{
  services.qemuGuest.enable =true;
  services.spice-vdagentd.enable = true;
}
```
{: file="configuration.nix" }
