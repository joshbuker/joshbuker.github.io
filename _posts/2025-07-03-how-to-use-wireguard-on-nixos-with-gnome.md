---
title: How to use Wireguard on NixOS with Gnome
lng_pair: how_to_use_wireguard_on_nixos_with_gnome
category: "technology"
tags: ["guides", "nixos", "wireguard", "gnome"]
image: "/assets/images/posts/nixos.png"
date: 2025-07-03 08:30:00 -0700
---

<!-- outline start -->

A quick and simple guide to getting Wireguard running on NixOS when using the Gnome desktop environment (and NetworkManager).

Last updated for NixOS 25.05.

<!-- outline end -->

## Requirements

- A functioning wireguard server that you are connecting to
- A NixOS device or virtual machine to act as the wireguard client

## Steps

- Install wireguard tools and allow wireguard through the firewall via nix config

```nix
{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.networkmanager
    pkgs.networkmanagerapplet # Adds nm-connection-editor
    pkgs.wireguard-tools # Allows using wg and wg-quick commands
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Allow wireguard connections through firewall
  networking.firewall.checkReversePath = "loose";
}
```

You can either create this as a separate `.nix` file and import it with:

```nix
{
  imports = [
    ./path/to/file.nix
  ];
}
```

Or simply embed the relevant lines into your existing configuration (e.g. within `configuration.nix`).

- Rebuild to install wg and wg-quick commands and reboot to apply firewall changes
- Generate a private and public key for wireguard

> NOTE:
> `umask` will invert the bits given for any new files, in this case it will make the privatekey and publickey files be marked with `700`, or read/write/execute for current user, and no access for group or global.

```sh
mkdir ~/wireguardtemp
cd ~/wireguardtemp
umask 077
wg genkey | tee privatekey | wg pubkey > publickey
```

- Create a wireguard config

You can name this whatever you like, for example: `home_network.conf`. `wg0` is also a commonly chosen name.

Remove all `<` and `>`, they are to indicate values you provide.

```sh
cd ~/wireguardtemp
nano ./home_network.conf
```

```conf
[Interface]
PrivateKey = <client private key>
Address = <client wireguard ip>/32
DNS = <internal dns address for wireguard network>

[Peer]
PublicKey = <server public key>
Endpoint = <server public ip>:13231
AllowedIPs = 0.0.0.0/0
```

> NOTE:
> You can replace `AllowedIPs = 0.0.0.0/0` with specific ranges to route only traffic destined for your internal network. For example `AllowedIPs = 192.168.0.0/16, 10.0.0.0/8`

- On your wireguard server, create a new peer using the client ***public*** key that you generated, ensuring that the allowed address on the server matches what's set in the `.conf` file
- Test the configuration with wg-quick to ensure it's working

```sh
cd ~/wireguardtemp
wg-quick up ./home_network.conf
```

If this doesn't work, try searching for solutions using wg-quick as a key term.

Assuming you've got it working, spin down the connection with:

```sh
cd ~/wireguardtemp
wg-quick down ./home_network.conf
```

- Import the configuration into NetworkManager

> NOTE:
> Using the GUI to import the file DOES NOT WORK at the time of writing. You MUST use nmcli to add the file.

```sh
cd ~/wireguardtemp
nmcli con import type wireguard file ./home_network.conf
nmcli connection modify home_network autoconnect no
nmcli connection down home_network
```

- (optional) Give the vpn network a pretty name

```sh
nmcli connection modify home_network con-name "Home Network"
```

- (optional) Save the private key and/or `.conf` file to your password manager of choice (e.g. [1Password](https://1password.com) or [VaultWarden](https://github.com/dani-garcia/vaultwarden))
- Remove the temp files (`privatekey`, `publickey`, and `home_network.conf`)

```sh
rm -rf ~/wireguardtemp
```

- Theoretically, you should be set! You can now enable or disable the wireguard connection through the vpn option in network manager (available in the system menu on the top right).
