---
title: How to Dev Containerify a Project
lng_pair: how_to_dev_containerify_a_project
categories:
  - Guides
tags:
  - Docker
image: "/assets/images/stock/code.jpg"
date: 2023-03-16 00:35:00 -0700
---

<!-- outline-start -->

Quick and dirty guide for adding `.devcontainer` support to a new project. See also [joshbuker/dev-containers](https://github.com/joshbuker/dev-containers) for example configurations.

<!-- outline-end -->

> NOTE:
> If opening a project with an existing devcontainer config, click the green button in the bottom left, and reopen in container.

1. [Install Docker](https://joshbuker.com/blog/how-to-install-docker/)
2. Install Visual Studio Code
3. Install Dev Containers Extension
4. Open Project Folder `Ctrl+K` + `Ctrl+O`
5. Open Command Palette `Ctrl+Shift+P` (if it's stubborn, run it a couple times until it shows the commands)
	1. `Dev Containers: Add Dev Container Configuration Files`
	2. Allows you to choose from a menu of templates provided by Microsoft
	3. Show All Definitions, choose appropriate template for the project[^1] [^2]
6. Reopen in Container, either from pop up or from command palette
7. If you modify the dev container config, rebuild the container for the changes to take effect[^3]
8. You may need to update the `forwardPorts` and `postCreateCommand` depending on the project. See [joshbuker/dev-containers](https://github.com/joshbuker/dev-containers) for examples.
9. Bang presto, you're good to go

---

[^1]: For Quasar and other Vue derivatives, there's a Vue template that works. Similarly, for other projects you may need the higher level template and customize as needed.
[^2]: After choosing the Vue template, add the Quasar CLI (via npm) additional feature
[^3]: It is important to wait for the dev container to fully start. Demons will invade your computer if you don't. If it takes too long, double check your RAM usage.
