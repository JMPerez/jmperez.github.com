---
layout: post
title: SSL, HTTP/2, Service Worker, Offline Mode? This blog has all of them
date: 2017-02-07 8:30:00+01:00
description: Some background on the hidden features of this blog. Static site, progressive images, AMP, HTTP/2, SSL...
permalink: my-setup-for-this-blog
---

I usually see myself spending more time migrating from one setup to another one than writing valuable content. After all, I consider my blog a playground where I try some concepts.

It is still [not very over-engineered](http://jlongster.com/Presenting-The-Most-Over-Engineered-Blog-Ever) and [being open sourced and available on GitHub](https://github.com/JMPerez/jmperez.github.com) I thought someone could benefit from it.

<!-- more -->

## Static Site

The blog is a set of static pages. Before that it used to be a Wordpress site and eventually [I migrated to Jekyll and GitHub Pages](/migrating-wordpress-jekyll-github-pages). This worked really well because I could take advantage of GitHub's distributed storage to serve the assets, and there is nothing that can beat a static site in terms of performance, which I care about.

In October 2016 I migrated to [Hexo](https://hexo.io/). Hexo is fast, and the posts are written in the same Markdown format I like and I used with Jekyll, so moving to Hexo was really easy.

Migrating to Hexo was a bit of a trade-off. Now I need to generate the static site from my computer and then deploy the files, instead of just using the GitHub editor, which was handy to fix small typos. The advantage is that I can create plugins in Javascript (and understand and tweak existing ones) to customise the output, which is better overall.

## Progressive Images

The few JPG images on this site are progressive JPGs, [generated using Jpeg.io](/ssim-jpeg-io). Having a more custom technique to load images, like [Medium's approach](/medium-image-progressive-loading-placeholder), is overkill. Progressive JPGs start rendering soon, and as the browser downloads more of the file it shows a better version of the image. You can see an example on [this WebPageTest run](https://www.webpagetest.org/result/170207_N3_1794c7ee69d5a1a3eb92842504f01a7b/).

[![Filmstrip for jmperezperez.com](/assets/images/posts/jmperez-filmstrip.png)](/assets/images/posts/jmperez-filmstrip.png)

Something in my to-do list is to prevent [content jumping](https://css-tricks.com/content-jumping-avoid/) by using some [intrinsic ratio placeholders](http://blog.learningspaces.io/flexible-cover-images-using-intrinsic-ratio/) for the images, and lazy-load them.

## SSL and HTTP/2

This site is served on HTTPS. I already talked about [how and why I migrated to SSL](/github-pages-ssl-custom-domain). A good thing about using Cloudflare for SSL is that I also get HTTP/2 support, so I can start investigating it a bit more. I would like to give Server Push a try though, but for that I would need to run my own server. Maybe some time in the future.

Finally, Cloudflare also allows me to set the browser cache expiration, increasing the short one that GitHub Pages set by default.

## Accelerated Mobile Pages (aka AMP)

I'm not a big fan of [Google's AMP](https://www.ampproject.org/), [Facebook's Instant Articles](https://instantarticles.fb.com) and [Apple News](https://developer.apple.com/news-publisher/). I think developers can create experiences on the web with a good performance without having to resort to a subset of the language nor a specific markup for a proprietary crawler.

Still, I wanted to give AMP a try, so I now generate an AMP version of every post on build time. Does it have any impact in traffic? Well, not much yet. Only around 2% of the page views to this site are for AMP'd pages.

## Service Worker and Offline content

The last addition to the site is a Service Worker which caches the main sections of this blog (home, projects, about) plus an offline page linking to those three. Additionally, if you visit a page it will be available when offline. I think it is a good trade-off.

[The implementation](/sw.js) is based on [the cache and update strategy](https://serviceworke.rs/strategy-cache-and-update_service-worker_doc.html) with a small variation. In my case I check the network, then the cache, and finally serve the `offline` page if no hit.

If you are thinking of making your site available when offline, be a good citizen. I have seen Service Workers that download all the posts from a blog. To be honest, this doesn't do any good for your users. By doing so you might be killing their data plan or using precious space in their devices. If you still want to preload/prefetch/download content, do it wisely.

When browsing the App Store/Play Store, the user has an indication of the size of the app, so they might choose not to download it when they are using roaming or tethering. On the web we don't have something like this.

## Performance

I like talking about web performance so my own site has to be a good example of what I advocate for. I use [PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/?url=https%3A%2F%2Fjmperezperez.com) to check the performance and usability on mobile (score >=99/100 for most pages) and [Lighthouse](https://developers.google.com/web/tools/lighthouse/) (100/100).

[![Screenshot from Lighthouse for jmperezperez.com](/assets/images/posts/jmperezperez-lighthouse.png)](/assets/images/posts/jmperezperez-lighthouse.png)

I'm looking forward to more ideas that I can apply to this blog and then some real project at scale :)
