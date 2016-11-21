---
layout: post
title: Web Performance talk in Stockholm - Internet Days
date: 2015-11-23 21:00:00+02:00
description: Faster than lightning was a set of talks around web performance during Internetdagarna 2015 in Stockholm, Sweden
image:
  url: /assets/images/posts/internetdagarna-logo.jpg
  width: 1060
  height: 550
tags:
  - conference
permalink: internetdagarna-2015
---
Today I have had the chance of attending the [Faster than lightning track](https://internetdagarna.se/arkiv/2015/internetdagarna.se/index.html%3Fp=17396.html) of [Internetdagarna 2015](https://internetdagarna.se/arkiv/2015/internetdagarna.se/index.html). There have been talks about web performance, and some broader topics like big data and UI, how data is important for large companies offering free services, and the need for public Governments to build compelling competitive services. [The videos are already online](https://www.youtube.com/watch?v=7G0Xz0JsiFg&index=1&list=PLtDs7N_g_eiZ5ag.e-xntFYydij0xSPL42).![The Heart logo @ Internetdagarna 2015](/assets/images/posts/internetdagarna-logo.jpg)

<!-- more -->
## Internetdagarna

A couple of weeks ago I attended [Monitoring web performance using Open Source tools and AMP](http://www.meetup.com/es/Stockholm-Web-Performance-Group/events/226316269/) by the [Stockholm Web Performance Group](http://www.meetup.com/es/Stockholm-Web-Performance-Group/). I was lucky and got a ticket at a raffle where they gave out a couple of tickets to Internetdagarna.

I have only attended the first of the two days of the conference. It has been very well organized, and the quality of the talks very high. Well, I pretty much every talk about web performance :) Also, I love their 8-bit theme and the [looping animations with the logo](https://www.youtube.com/watch?v=sQvgCPNtSGk#t=01h26m36s).
[![Main room at Internetdagarna 2015](/assets/images/posts/internetdagarna-hall.jpg)](/assets/images/posts/internetdagarna-hall.jpg)

## Talks

### High Performance Images, by Tobias Baldauf

Great talk! If you care about images, their size and format, please watch this. Instead of just explaining the typical tips about resizing and optimising images, Tobias focuses on formats and compression.

He goes through the history of formats, and the multiple formats that have tried to replace JPEG (WebP and JPEG-XR). Then, he goes back to JPEG demoing [mozjpeg](https://github.com/mozilla/mozjpeg) as an enhancement for encoding JPEGs. The question is "what quality to use?"

The answer is measuring image dissimilarity, to find out how much different is the compressed version compared to the original one. Good news: there is a tool for that, called [dssim](https://github.com/pornel/dssim). Then, one can run a script that compresses an image with different values until it reaches a certain dissimilarity threshold, like [Tobias' cjpeg-dssim](https://github.com/technopagan/cjpeg-dssim).

Tobias goes beyond this, and explains [his Adept script](https://github.com/technopagan/adept-jpg-compressor), based on the idea of using different compression levels for different areas of the image, aka adaptive JPEG compression. The script takes a long time, but it can be worth it for doing one-shot optimisations for important assets like a hero image.
[![Tobias Baldauf presenting in Internetdagarna 2015](/assets/images/posts/internetdagarna-tobias-baldauf.jpg)](/assets/images/posts/internetdagarna-tobias-baldauf.jpg)
_&uarr; Tobias Baldauf about to talk about mozjpeg_

[Video on Youtube](https://www.youtube.com/watch?v=j5sRzAOt4nE)

### Cheat Sheet To A Lean Website, by Barbara Bermes

Barbara talks about performance culture, and the need to feel empowered and encouraged to say "no" when implementing features or designs that affect performance.

This is something I have been hearing lately, especially around the ad-blocker and bloated sites topic. I wish all developers could feel free to discuss decisions that affect user's experience.

And when it comes to performance culture, it's almost impossible not to mention Etsy.

Barbara then goes through some good ideas, like having a performance budget, or defining mockups of the important areas that need to be rendered quickly, being aware of the critical rendering path, and the rest of Steve Souders's principles.
[![Barbara Bermes presenting in Internetdagarna 2015](/assets/images/posts/internetdagarna-barbara-bermes.jpg)](/assets/images/posts/internetdagarna-barbara-bermes.jpg)
_&uarr; Barbara Bermes talking about performance culture_

[Video on Youtube](https://www.youtube.com/watch?v=QQZigZiQ9Gg)

### The Case for HTTP/2, by Andy Davies

Andy explains the history of HTTP 1.1, its limitations and the workarounds we came up with to overcome its limitations. I find particularly interesting how inlining critical CSS in the HTML or inlining images in CSS using data URIs means that we are overriding browser's priorities, based on heuristics to determine what resources should be downloaded first. I had never thought about it from this perspective.

But Andy doesn't try to just sell HTTP/2. He explains HTTP/2 through some real examples applied to real sites. In some cases there is almost no improvement in loading time, and it is still difficult to implement a server push approach that takes into account whether the browser already has the filed being pushed. He also shows some issues in some server implementations that developers need to be aware of.
[![Andy Davies presenting in Internetdagarna 2015](/assets/images/posts/internetdagarna-andy-davies.jpg)](/assets/images/posts/internetdagarna-andy-davies.jpg)
_&uarr; Andy Davies showing how to debug HTTP/2 connections with Chrome tools_

[Video on Youtube](https://www.youtube.com/watch?v=m1b_VQk73SI)

### Working with performance, by Tobias J&#228;rlund

Tobias explains how Aftonbladet.se, the main news site in Sweden, approaches web performance, and what problems they have faced when trying to make everyone aware of the performance implications of the content (ads, large images...).
[![Tobias Järlund presenting in Internetdagarna 2015](/assets/images/posts/internetdagarna-tobias-jarlund.jpg)](/assets/images/posts/internetdagarna-tobias-jarlund.jpg)
_&uarr; Tobias Järlund talking about blocking 3rd party content. I personally don't like the quote depicted in that slide, since I think Aftonbladet's most important content should be, of course, news._

_No video available yet_

### Baking in Performance with Agile, by Meri Williams

Meri goes through some ideas to implement performance culture within teams. Also, she encourages everyone to similar devices and network connections to those from real users browsing our site. This can also help out when taking into account performance in other teams within the company.
[![Meri Williams presenting in Internetdagarna 2015](/assets/images/posts/internetdagarna-meri-williams.jpg)](/assets/images/posts/internetdagarna-meri-williams.jpg)
_&uarr; Meri Williams about unexpected events that can affect your traffic_

_No video available yet_
