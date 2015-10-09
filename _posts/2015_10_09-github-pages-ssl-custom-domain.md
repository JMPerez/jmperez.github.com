---
layout: post
title: SSL all the things
date: 2015-10-09 11:35:00+02:00
description: Adding SSL to your site can be super easy. If you are using GitHub Pages with a custom domain, read this.
---
_... or why I have migrated my site to HTTPS_. I have been willing to use HTTPS on my site for some time, especially to be able to play with some new technologies like Service Workers. And, if GitHub implements it, [HTTP/2](https://en.wikipedia.org/wiki/HTTP/2#Encryption).

I'm using GitHub Pages with a custom domain. to power this blog and the pages for my GitHub projects. A simple search got me to [Set Up SSL on Github Pages With Custom Domains for Free](https://sheharyar.me/blog/free-ssl-for-github-pages-with-custom-domains/), where it's explained how to use Cloudfare to add SSL to your domain, and... it just works. I actually didn't even need to go through step 5 (switching to Flexible SSL) since I couldn't find the option, and it seems to still work.

You might wonder why this site, a static blog that doesn't deal with user's private information, needs SSL. I consider HTTPS to be a sign of a good network citizen. In addition, some of my projects use 3rd party APIs like Spotify's Web API, and the token retrieval and storage will be even more secure with HTTPS. And as I said, this will allow me to do some hacking with new browser APIs.

Migrating to HTTPS has also little effect in terms of performance. The site is quite fast at the moment, and keeping its requests to a minimum makes these decisions rather easy. Have a look at the [WebPageTest comparison between this site served on HTTP and HTTPS](http://www.webpagetest.org/video/compare.php?tests=151009_JQ_F73,151009_JT_F76) for more info.