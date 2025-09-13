---
title: How to use a GPG Smartcard for Git and SSH
category: technology
tags:
  - guides
  - smartcard
  - gpg
  - git
  - ssh
date:
---
<!--- outline start -->

A guide on using a GPG compatible SmartCard such as the NitroKey or YubiKey for Git and SSH.

This guide assumes that you are using a YubiKey and NixOS, but should largely be reusable for other SmartCards and Linux Operating Systems.

<!-- outline end -->

> NOTE:
> Due to current limitations, you cannot have multiple SmartCards that all work simultaneously using the same keys. You can however copy the backed up keys to a new SmartCard, and only need to change the configuration on your client device(s), not any servers. This is because GPG will look for the serial number of the SmartCard when completing operations, which will only ever point to one card at a time. At time of writing, there are no reasonable workarounds for this issue.

## References

- https://www.erraticbits.ca/post/2015/gpg-smartcard/
- https://opensource.com/article/19/4/gpg-subkeys-ssh
- https://gist.github.com/mcattarinussi/834fc4b641ff4572018d0c665e5a94d3
- https://gist.github.com/ageis/5b095b50b9ae6b0aa9bf

## Requirements

- A computer to perform the key generation and SmartCard setup
- A SmartCard that is GPG compatible
- A USB Storage Device to be used for backing up the GPG secret keys

## Steps
### Configure computer for setup process

Select a computer that you would like to use for generating the secret keys and uploading them to your SmartCard(s). This should be a secure computer that you trust and personally control.

> NOTE:
> Using a live boot operating system during this process may reduce the risk of your secret keys being cached on disk and later retrieved by an attacker, but is not necessary to follow this guide. Likewise, having a computer with hardware kill switches for networking, or removing the networking equipment during key generation and upload may also reduce the chances of the keys being stolen by an attacker. However, this is almost certainly overkill for the vast majority of people, and simply using a personal device and turning off the network connection via software should be sufficient in most cases.

On that computer, you will need to install GnuPG and enable SmartCard support.

#TODO: Add installation instructions for NixOS and Ubuntu

## Generating the GPG keys

Create a temp folder to work from and cd into it:

```sh
mkdir -p ~/temp
cd ~/temp
```

Generate a passphrase using your Password Manager, and copy it to the clipboard. You'll need it when generating the main key. You will need this beyond initial setup, so ensure it is saved in your password manager.

> NOTE:
> There are some concerns around ECC cryptography potentially having NSA backdoors and being susceptible to future quantum computer attacks. This guide recommends the use of RSA 4096 keys, but check for the currently recommended best practices on GPG keys as they may have changed since time of writing.

Generate the main key (used for signing the subkeys):
```sh
gpg --full-generate-key
```

Use the following settings:
- 4 - RSA (sign only)
- Keysize - 4096
- Expires - 0 (never)
- Y (confirm key expiration)
- Name - Your Name
- Email - gpg@example.com
- Comment (leave blank)
- Ensure you have your desired gpg passphrase copied to your keyboard
- O - Okay, continue
- Paste passphrase when prompted

This will output the results, and give you a long string after pub that is the ID of your gpg key. Copy that key for use in the following command. If you cleared the terminal before seeing it, you can also find the key id by running `gpg -k`.

Now edit the key you just generated, and add information for ssh and git commits:
```sh
gpg --edit-key <gpg-id>
```

- adduid
	- Your Name
	- Email - ssh@example.com
- adduid
	- Your Name
	- Email - git-commit@example.com
- uid 1
- primary
- save

Now generate the subkeys:
```sh
gpg --expert --edit-key <gpg-id>
```

- Copy your gpg passphrase again, it'll prompt you for it when adding subkeys
- addkey - Sign Only (e.g. sending and receiving encrypted email)
	- 4 - RSA (sign only)
	- Keysize - 4096
	- Expires - 0 (never)
	- Y (confirm key expiration)
	- Y (really create)
	- Paste gpg passphrase when prompted
- addkey - Encrypt Only (e.g. gpg git commit signing)
	- 6 - RSA (encrypt only)
	- Keysize - 4096
	- Expires - 0 (never)
	- Y
	- Y
	- Paste
- addkey - Authenticate Only (e.g. SSH)
	- 8 - RSA (custom)
	- S - Disable Signing
	- E - Disable Encrypt
	- A - Enable Authenticate
	- Q - Save
	- 4096
	- 0
	- y
	- y
	- paste
- save

```sh
gpg --gen-revoke <gpg-id> >> ./revoke.asc
```

- y
- 1
- leave blank
- y
- paste

```sh
gpg -a --export-secret-key <gpg-id> >> ./main.key
gpg -a --export-secret-subkeys <gpg-id> >> ./subkeys.key
```

## Configuring the SmartCard

Plug in your SmartCard now.

```sh
gpg --card-edit
```

- admin
- passwd
- 1 - change PIN (user pin)
	- Enter current user pin (usually defaults to `123456`)
	- Enter new user pin
	- Repeat newuser  pin
- 3 - change Admin PIN
	- Enter current admin pin (usually defaults to `12345678`)
	- Enter new admin pin
	- Repeat new admin pin
- 4 - change Unlock PIN (this may be tricky, as you cannot copy both pins at the same time)
	- Enter admin pin
	- Enter new unlock pin
	- Repeat new unlock pin
- q
- name - Your Name
- login - Your Username
- lang - en
- quit

```sh
gpg --edit-key <gpg-id>
```

- toggle
- key 1 - enable sign key
- keytocard
- 1 (signature key)
- key 1 - disable sign key
- key 2 - enable encrypt key
- keytocard
- 2 (encrypt key)
- key 2 - disable encrypt key
- key 3 - enable authenticate key
- keytocard
- 3 (authenticate key)
- save

If you don't have the stubs.asc file yet, create it using:
```sh
gpg -a --output stubs.asc --export-secret-keys <gpg-id>
```

## Configure SSH to use your SmartCard

```sh
gpg --with-keygrip -K
```

Grab the keygrip for your authenticate subkey.

save it as `~/.gnupg/sshcontrol`

Grab your ssh pubkey via:

```sh
ssh-add -L
```

should look like:
```
ssh-rsa <long string here> (none)
```

save this in your password manager, it will be used when adding to ssh servers

## Configure Git to use your SmartCard

```sh
gpg -K --keyid-format LONG
```

Grab the ID (removing the `rsa4096/` first) for your sign only subkey, add it to your .gitconfig:

```conf
[user]
  name = "Your Name"
  email = git-commit@example.com
  signingKey = <sign only subkey id in long format>
```

Grab your pubkey for uploading to GitHub or other Git servers:

```sh
gpg -a --export <gpg-id> > smartcard.pub
```

## Backup GPG

Open a terminal within your backup USB drive and run:

```sh
mkdir -p ./smartcard-backup
cd ./smartcard-backup
cp ~/temp/* ./
```

## Cleanup

```sh
cd ~/temp
shred -u -z ./*
cd ..
rm -r ~/temp
```

If you used a live boot USB for following this guide, it would now be wise to securely erase the drive to remove the possibility of recovering the secret keys from a cache that may have been missed.
