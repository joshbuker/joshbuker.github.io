---
title: How to Create a Nix Package (Nixpkgs)
categories:
  - Guides
  - NixOS
tags:
  - NixOS
  - OSS
image: /assets/images/posts/nixos.png
---
A simple, to the point guide on how to add a new nix package to Nixpkgs.

## Prepare Git Repo

- Fork nixpkgs
- Clone your fork locally[^1]

[^1]: This will take a _long_ time to resolve the objects and deltas, especially if running on slow hardware. Be patient, and consider using whatever computer is your most powerful.

## Commits

- Add yourself to the maintainers list

