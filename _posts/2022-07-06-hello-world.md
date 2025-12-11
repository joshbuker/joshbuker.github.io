---
title: Hello World!
categories:
  - Journaling
tags:
  - Blog
image: "/assets/images/stock/hello_world.jpg"
date: 2022-07-06 18:48:00 -0700
last_modified_at: 2025-12-10 20:26:00 -0800
---

Welcome to my first blog post.

As the first post, I feel like this should have some amazing content that folks will look back on and say, "yeah, it was clear from the beginning this would be great." Unfortunately, reality is not so ideal, and instead you get whatever this will end up being.

Perhaps through some stroke of luck, however, this will be engaging enough to be worth your time. Even if it isn't the next [SmarterEveryDay](https://www.smartereveryday.com/) or [~~Joey B Rocket Reviews~~ BPS Space](https://www.youtube.com/channel/UCILl8ozWuxnFYXIe2svjHhg).

## What even is this?

So, [joshbuker.com](https://joshbuker.com) (presumably the place you're reading this blog post) is my personal website, and will be a place to ~~dump all my bad ideas~~ blog about my projects, daily life, and maybe post some useful content once in a while.

When thinking about how I wanted to setup my website, and what tools to use for it, I started with some brainstorming.

---

First, was thinking about...

**What do I want to support:**
- An easy way to publish short essays and such from my notes, ideally with minimal duplication of content.
- Links to my socials and other websites.
	- [GitHub](https://github.com/joshbuker) and [LinkedIn](https://linkedin.com/in/joshbuker)
	- [Photography](https://photography.joshbuker.com)
	- Projects hosted elsewhere, e.g. [RoboRuckus](https://roboruckus.com)[^roboruckus] and [TDL App](https://tdl.app)
- Visually appealing[^design]
- An about me page
- Some way to demonstrate my ability to create a good portfolio / engineering notebook.

---

Then was considering my...

**Steps to move forward:**

1.  Delineate which location for each goal (e.g. GitHub for engineering stuff?)
2.  Find path of least resistance to getting an MVP live that fulfills all above goals

---

And finally, I thought about...

**What tools to consider:**

I don't need a dynamic website like Ruby on Rails for any of these goals. That said, I would really like a CI/CD pipeline that auto deploys new changes whenever I push up a new commit. Also, hosting all the content in git repos would allow me to avoid losing stuff or having to figure out data consolidation and sync.

Having a single source of truth would be ideal, but failing that, something easy to maintain and expand would be acceptable.

As for the tools themselves:
- [~~Ruby on Rails~~](https://rubyonrails.org/) - Overkill and requires some level of care and feeding.
- [~~Quasar~~](https://quasar.dev/) - Again, overkill, although it can compile down to a static site which reduces some complexity.
- [~~Obsidian Publish~~](https://obsidian.md/publish) - Convenient for turning notes more directly into website content, but a little too limited in function to satisfy my needs for a personal website. I might use this in conjunction with a subdomain for hosting misc content however.
- [~~S3 bucket with static site generation~~](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingBucket.html) - Using S3 is unnecessary when something like GitHub pages is available and free to use.
- [GitHub Pages](https://pages.github.com/) - 🎉 Winner! 🎉

And in particular:
- Photography: [ThumbsUp](https://thumbsup.github.io/)
- Personal website: ~~[Mr. Green](https://github.com/MrGreensWorkshop/MrGreen-JekyllTheme)~~ [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) (which is a theme for [GitHub Pages](https://pages.github.com/), and uses [Jekyll](https://jekyllrb.com/) under the hood)

---

And well, here we are now. I still have quite a bit of tweaking to do, and there's the other websites and projects that need their own pipelines created and some spring cleaning of the READMEs.

For now though, this I feel gets the first component (my personal website) to an acceptable minimum viable product.

Thanks for reading, and I hope to see you next time.

---

_Footnotes:_

[^roboruckus]: RoboRuckus is actually the brain-child of [Sam Groveman](https://github.com/ShVerni). That said, it's an amazing project that I've more recently joined him in, and would love to get more folks aware of the project. It serves as a great learning platform for people of all ages and skill-levels to get into Robotics, and more importantly it's just plain _fun to play_.
[^design]: Considering I'm what's lovingly referred to as _hilariously inept at UI design_, this means it needs to come with some sort of existing styling. In an ideal world, I wouldn't have to touch a single line of CSS. ![CSS Blinds GIF](/assets/images/posts/css.gif)
