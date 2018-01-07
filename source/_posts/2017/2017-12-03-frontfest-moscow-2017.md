---
layout: post
title: Speaking at FrontFest 2017 in Moscow, Russia
date: 2017-12-03 18:00:00+01:00
description: I attended FrontFest 2017 conference and talked about image performance, lazy-loading, placeholders and creative SVGs.
image:
  url: /assets/images/posts/frontfest.jpg
  width: 1024
  height: 683
tags:
  - images
  - talks
permalink: frontfest-moscow-2017
---

A couple of weeks ago I attended [FrontFest 2017](https://2017.frontfest.ru/) in Moscow. There were around 200 attendees at Digital October, an impressive venue. I had a lot of fun and met many local developers.

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto,c_scale/v1512318752/frontfest/frontfest-01.jpg"
    sizes="(max-width: 768px) 100vw, 684px" alt="Jose M. Perez speaking at Frontfest Moscow 2017" />

<!-- more -->

FrontFest is one of the several JS conferences that take place in Moscow, which has a healthy web community with several meetups that host up to 500 people.

This single-day event was comprised of 5 tracks filled with talks and workshops. Most of the talks and workshops were in Russian, though there was always one talk or workshop in English at a given time.

I especially liked [Blaine Cook's talk](https://2017.frontfest.ru/lecture/3/) about UX and developer responsibility managing user authentication. I also enjoyed Mathieu's [live-coding](https://2017.frontfest.ru/lecture/15/) and following workshop, where we coded [a simple yet very fun game](https://github.com/p01/twinStickShooter).

## My talk about "Progressive Image Rendering"

<div class="videoWrapper">
  <iframe width="720" height="405" src="https://www.youtube.com/embed/rmq1iEKsmBc" frameborder="0" allowfullscreen></iframe>
</div>

I had been playing with SVG techniques during the weeks before the event, which I had documented on [Using SVG as placeholders — More Image Loading Techniques](/svg-placeholders/). Thus, it was a great opportunity to include them in the talk.

I also mentioned the [Image Decode API](https://www.chromestatus.com/feature/5637156160667648). I first knew about it through [Mathieu 'p01' Henri](https://twitter.com/p01/), who told me there were early discussions to implement it when we met at [RenderConf Oxford](/render-conf-oxford-2017). Even though it's not widely supported I thought it was a good opportunity to talk about it.

This API prevents the browser from blocking the UI when decoding an image, and can be handy when doing lazy-load. Check also [this post](https://medium.com/dailyjs/image-loading-with-image-decode-b03652e7d2d2) for an example on how to use it.



### Slides
The slides are available on [slides.com/jmperez/pir-frontfest](https://slides.com/jmperez/pir-frontfest) and you can also see them right here embedded:

<div class="videoWrapper">
<iframe src="//slides.com/jmperez/pir-frontfest/embed" width="576" height="420" scrolling="no" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
</div>
