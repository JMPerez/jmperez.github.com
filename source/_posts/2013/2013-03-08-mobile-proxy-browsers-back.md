---
layout: post
title: 'Proxy mobile browsers are coming back'
date: 2013-03-08 09:08:24+00:00
tags:
  - mobile
  - optimization
  - proxy-browsers
permalink: mobile-proxy-browsers-back
---

Mobile proxy browsers are coming back. For a long time we had Opera Mini. And these days we have seen the release of Opera Beta for Android and an update to Chrome Beta for Android, both highlighting data compression features. And they are not the only ones. About a year ago Amazon introduced their Silk browser with a similar proxy solution to Google's.

On desktop, although this feature hasn't become that popular due to the higher bandwidth that is usually available, Opera also had presence with their [Opera Turbo](http://www.opera.com/turbo) feature.

<!-- more -->
## Opera's Off-Road Mode

[Opera Beta for Android](http://www.opera.com/mobile/android) is a webkit browser with an "Off-Road mode", which is not more than an Opera Mini embedded. In fact, it states it uses Presto in its User Agent. In practice, this means they use different browser engine for the compressed and not-compressed modes, resulting in different user experiences when browser the same site depending on this mode. You can check it accessing sites like Google or Facebook.

## Data Compression Proxy in Chrome Beta

Meanwhile, [Chrome Beta connects through SPDY](http://blog.chromium.org/2013/03/data-compression-in-chrome-beta-for.html) to a proxy server that carries out a myriad of optimizations, such as converting images to WebP, minifying HTML, Javascript and CSS and adding gzip compression (info about [how to enable it here](http://googlesystem.blogspot.ca/2013/03/try-chromes-data-compression-proxy.html)). In short, instead of waiting for developers to optimize their sites, Google is applying transparently some well-known techniques to improve website performance, similar to those they apply in their [mod_pagespeed Apache module](https://developers.google.com/speed/pagespeed/mod).

## What you, as developer, can do

It is tempting to just forget about [optimization techniques](/techniques-optimize-web-sites/), leaving
the hard work to these proxies. The truth is that we should be the ones that optimize by default our sites to provide the best experience regardless of user's browsers. These tools are showing us how important good performance is, especially when using mobile devices.
