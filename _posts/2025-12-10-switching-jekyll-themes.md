---
title: Switching Jekyll Themes
categories:
  - Journaling
tags:
  - Jekyll
  - Blog
date: 2025-12-11 00:28:00 -0800
last_modified_at: 2025-12-11 00:35:00 -0800
image:
  path: /assets/images/posts/mrgreen_blog_home_page.png
  alt: "The old look of my blog with MrGreen"
---
For a long time I've been using the [MrGreen](https://github.com/MrGreensWorkshop/MrGreen-JekyllTheme) [Jekyll](https://jekyllrb.com/) theme, which enticed me with its clean look and multi-lingual support. However, after being called a terrible programmer by the maintainer, I decided it was time to revisit what themes are out there and ended up finding quite a gem.

While it doesn't support multiple languages simultaneously, the [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) theme has many other features that I've been looking for that more than make up for the loss.

| Feature                                       | MrGreen                    | Chirpy                    |
| --------------------------------------------- | -------------------------- | ------------------------- |
| Clean Look                                    | ✅                          | ✅                         |
| Light / Dark Theme                            | ✅                          | ✅                         |
| [Giscus Comments](https://giscus.app/)        | ✅                          | ✅                         |
| Offline Support                               | ✅                          | ✅                         |
| Multi-Language Support                        | ✅[^multi-language-mrgreen] | ❌[^multi-language-chirpy] |
| Advanced Search                               | 🟡[^advanced-search]        | ✅                         |
| [Callouts](https://help.obsidian.md/callouts) | ❌                          | ✅                         |
| [Mermaid Diagrams](https://mermaid.js.org/)   | ❌                          | ✅                         |
| Dynamic Further Reading                       | ❌                          | ✅                         |
| RSS Feed                                      | ❌                          | ✅                         |
{: .w-100 }

[^multi-language-mrgreen]: MrGreen's multi-language support is impressively well implemented for a statically compiled website template.
[^multi-language-chirpy]: While Chirpy doesn't support multiple languages simultaneously, it does support setting a single locale, and potentially could be expanded to support multiple languages without too much effort.
[^advanced-search]: There is support for searching in MrGreen, but it is fairly limited and janky when compared to Chirpy's implementation.

The chirpy theme also had a fairly similar look and feel to what the old theme provided, with a few improvements and a few missing features. So, in a fit of Spite Driven Development (SDD), I set out to add the missing features and make it a fully functional replacement. After a three days of programming, and a bit of AI-assisted debugging, I'd say I did a fairly good job replicating what I had before.

![Chirpy Blog Home Page](/assets/images/posts/chirpy_blog_home_page.png)
_New look and feel with Chirpy_

A few of the things I had to adjust:
- [x] Moving the blog post listing from `/` to `/blog`
- [x] Recreating the look and feel of the plain pages, such as `/now` and `/about`
- [x] Pulling recent articles for the New Articles part of the homepage
- [x] Adding a few missing SEO tags such as `article:author` and `article:section`
- [x] Automatically hiding categories and tags from the sidebar when not open
- [x] Spending hours debugging why Jekyll pagination is finicky
- [x] Lots of minor metadata updates and other tweaks
- [x] Replicating the contact section of the sidebar and adding tooltips

But hey, a little bit of elbow grease goes a long way.

Anyway, with the improvements to my personal blog completed, it's time to get back into my current hyperfixation of choice - [NixOS](/tags/nixos/). Stay tuned for some more blog posts, and maybe even some tutorial videos!
