---
layout: post
title: 'Moving from Wordpress to Jekyll + Github Pages'
date: 2014-01-27 21:03:00+01:00
description: I recently migrated my blog to Jekyll and Github Pages and it was worth it. Even though there are drawbacks, it is convenient and the website has know a very good performance.
tags:
  - jekyll
permalink: migrating-wordpress-jekyll-github-pages
---

A few weeks ago I migrated this blog to [Jekyll and GitHub Pages](https://help.github.com/articles/using-jekyll-with-pages), and the process has turned out to be quite easy. I have wanted to give [Octopress](http://octopress.org/) or [Jekyll](http://jekyllrb.com/) a try for a long time, but I never found the time.

WordPress is a powerful blogging platform. I have used it for a 3 years to serve the few posts I have written so far. But I felt I wasn't really using many of its features and I wanted to use a Markdown to compose and store my posts.

<!-- more -->
## Personal opinion
There are many posts out there about how to migrate from Wordpress to Jekyll, but I wanted to focus on my opinion **after** doing it.

### Easy to use
The experience with Jekyll and GitHub pages has been good so far. The process of adding a new post is as easy as committing and pushing a Markdown file, and I feel comfortable with the straightforward structure of the whole repository.

I just push from my personal laptop, and if I am working on a post and want to edit from multiple devices I simply create a Google Drive document and use it as a draft.

### GitHub Pages = Great Performance
The response time for GitHub pages is consistently good and way faster compared to my previous hosting, 1and1. Have a look at this chart:
![Time spent downloading a page for jmperezperez.com by GoogleBot](/assets/images/posts/webmaster-tools-time-download-jmperezperez.png)

It represents the time spent downloading a page (in milliseconds) reported by Googlebot, as seen on the Webmaster Tools site. I carried out the migration on January 7th, and since then the time dropped from around 1 second to values in the range of 25 to 94ms.

To be fair, I will say I probably wasn't using one of the best hosting services out there. My previous Wordpress blog was very light, and I made sure it followed the [performance tips](/techniques-optimize-web-sites/) that I always promote. For instance, I was using [W3 Total Cache](http://wordpress.org/plugins/w3-total-cache/) to try to serve cached versions of the posts. But [GitHub Pages CDN](https://github.com/blog/1715-faster-more-awesome-github-pages) makes a big difference.

### Features I gained, features I lost
Since I had close to zero comments in my posts, I don't miss the comments feature, and I can always include a widget from Disqus if I eventually need it. **Syntax highlighting comes built-in** and is performed when generating the static file for the post, so I don't need to include a plug-in that does syntax-highlighting using Javascript client-side. If you think of it, doing this for every request is a waste of time and processing.

There are drawbacks though. Not being able to run Jekyll plug-ins makes some thing worse. For instance, when adding a picture to a post you need to take care of creating different versions of the image, like a thumbnail and the full picture. Image alignment is done through raw HTML, since Markdown doesn’t provide a way to do this and you can't use plug-ins. And redirections can be defined creating fake posts with the previous URL, and redirecting using Javascript.

For an example, have a look at [this fake post](https://raw.github.com/JMPerez/jmperez.github.io/jekyll/2009/06/jpegoptim-optimize-jpg-page-speed/index.md) which will redirect from `/2009/06/jpegoptim-optimize-jpg-page-speed` to `/jpegoptim-optimize-jpg-page-speed`. Notice that uses the [`redirection` layout](https://github.com/JMPerez/jmperez.github.io/blob/jekyll/_layouts/redirection.html), which redirects by using both `<meta http-equiv="refresh"` and `<link rel="canonical" href=` [as explained on StackOverflow](http://stackoverflow.com/questions/10178304/github-jekyll-old-pages-redirection-best-approach).

There is a way to circumvent this by generating the static files yourself and pushing them. To you GitHub repository. But then you need to have the necessary tools installed in the computer from which you want to push the new content. This is something I may consider doing.

For good or for bad you will have a short expiration time for your static files, set to 10 minutes at the moment. The good thing is that you don't need to version the static files, and 10 minutes can save a few requests during someone's normal browsing session of your site. The bad thing is that you won't reach a Page Speed of 100.

### A final note
One thing that bit me was that I couldn't access my projects GitHub Pages websites after creating my user pages and set a custom domain, as I would read later on [User, Organization and Project Pages](https://help.github.com/articles/user-organization-and-project-pages). That means that URLs like `jmperez.github.io/karaoke` are now sent to `jmperezperez.com/karaoke`. Now, instead of adding a `gh-pages` branch in my repositories, I add those files to a `projects` folder I created [in the repository for my user pages](https://github.com/JMPerez/jmperez.github.io).
