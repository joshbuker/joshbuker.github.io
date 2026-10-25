---
title: Stupid AI → Smart Documentation
categories:
  - Journaling
tags:
  - AI
  - Documentation
  - Markdown
  - Obsidian
date: 2026-10-24 19:11:00 -0800
---
If you've tried using AI, you've probably run into it making really stupid decisions that you'd expect a typical person to easily avoid. Even if you hate AI on principle and refuse to use it, the solution to making AI less dumb actually benefits humans just as much as machines. Long story short, it's writing good documentation.

Oftentimes when an AI Agent gives low quality results, part of the cause is due to it making incorrect assumptions about what you want it to do. It's the same issue you'd run into if giving a new hire the same task. They don't know what you want, how to determine which trade-offs to make, what does good quality mean, and what does done look like.

To solve these issues, the best method is to write documentation. Write procedure documentation on what steps should be taken. Write policy documents on what good quality work looks like, what the underlying goals are, and how to know when a task has been successfully completed.

Markdown is an amazing format for documentation. It's easily machine readable and writable, while also being easily human readable and writable. There are also many great tools that use markdown as the underlying format (e.g. [Obsidian](https://obsidian.md) and [Logseq](https://logseq.com/)). Giving a quick example of what process documentation written in markdown could look like:

````markdown
# Onboarding new users

This is the process for onboarding new users into our organization.

## Creating Accounts

New users will require access to X, Y, and Z.

### Creating an X account

1) Do step 1
2) Do step 2
3) etc...

### Creating a Y account

You can even include code verbatim:

```sh
account create --yes [username]
```

etc...

## Introductions

Introduce the user with an email to everyone in the organization. It should cover their hobbies, role within the org, and why NixOS is their favorite operating system.

**This is bold and important, for reasons.**

## Documentation

Show the user where they can find the relevant documentation. It's located somewhere, in markdown format. We recommend using Obsidian for viewing the documentation.
````

This instructions can function both for AI and the humans in your organization. They're all the Standard Operating Procedures (SOPs) and policies that you should have had in the first place, but likely got away without writing because humans are better at asking questions first.

Even if AI goes away (rising costs and enshittification comes for us all, in time), you'll be better off for having written the documentation that makes AI better at acting as desired. And if you're all aboard the AI train, this methodology will result in more consistent and higher quality work. A win-win regardless.

So, in short:

1) Write documentation
2) Use markdown for said documentation
3) ???
4) Profit
