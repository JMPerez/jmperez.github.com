---
layout: post
title: SSL all the things
date: 2015-10-09 11:35:00+02:00
description: Adding SSL to your site can be super easy. If you are using GitHub Pages with a custom domain, read this.
tags:
  - ssl
permalink: github-pages-ssl-custom-domain
---
_... or why I have migrated my site to SSL_. I have been willing to use HTTPS on my site for some time, especially to be able to play with some new technologies like Service Workers. And, if GitHub implements it, [HTTP/2](https://en.wikipedia.org/wiki/HTTP/2#Encryption).

I'm using GitHub Pages with a custom domain to power this blog and the pages for my GitHub projects. While GitHub Pages can be served using HTTPS, if you define a custom domain you need to manage this.

<!-- more -->
## How to set up
A simple search got me to [Set Up SSL on Github Pages With Custom Domains for Free](https://sheharyar.me/blog/free-ssl-for-github-pages-with-custom-domains/), where it's explained how to use Cloudflare to add SSL to your domain. The steps are quite clear and I got it set up in a few minutes. And after some hours has propagated the server name configuration.

After making the change I went through some additional steps:

- Add a canonical link in your pages that points to the HTTPS URL.
- Add a basic protocol check to redirect to the secure version of the page if accessed using HTTP.
- Change the address for the site in the Google Analytics profile.
- Create a new profile on Google Webmaster Tools for the HTTPS version. I thought it would be possible to replace the address or add a new site to a certain profile, but it's not.

## Why switching to SSL
You might wonder why this site, a static blog that doesn't deal with user's private information, needs SSL. I consider HTTPS to be a sign of a good network citizen. In addition, some of my projects use 3rd party APIs like Spotify's Web API, and the token retrieval and storage will be even more secure with HTTPS. And as I said, this will allow me to do some hacking with new browser APIs.

**Update December 4th, 2015**: Cloudflare has just enabled HTTP/2 for the sites using their SSL, which means that if your browser supports it, you should be getting this page using HTTP/2.

## Performance implications
Migrating to HTTPS has a small effect in terms of performance. The requests will take longer to be fulfilled due to the negotiation phase of the protocol, and the decryption.

Fortunately, I try to keep the amount of requests to a minimum, and it payed off when applying SSL. If you are curious, I have prepared a [WebPageTest comparison between this site served on HTTP and HTTPS](http://www.webpagetest.org/video/compare.php?tests=151009_JQ_F73,151009_JT_F76).

There are some initiatives to make it easier to web owners to integrate SSL. [Let's Encrypt](https://letsencrypt.org/) is one of them, and it seems they will offer free certificates quite soon.
