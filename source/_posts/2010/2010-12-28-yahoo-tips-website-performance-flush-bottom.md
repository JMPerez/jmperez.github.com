---
layout: post
title: 'The not so good web performance tips'
date: 2010-12-28 19:46:41+00:00
tags:
  - flush
  - performance
  - yahoo
permalink: yahoo-tips-website-performance-flush-bottom
---

Yesterday I was reading [Zakas' Performance on the Yahoo! Homepage slideshare presentation](http://www.slideshare.net/nzakas/performance-yahoohomepage), and I got very surprised when I saw that Yahoo had realised that two of the wide accepted tips for improving website performance had not work so well for them.
![Yahoo's Home page](/assets/images/posts/yahoo-homepage.jpg)

<!-- more -->
**1) Put scripts at the bottom** (slide 37)
Or at least that is [what Yahoo recommends](http://developer.yahoo.com/performance/rules.html#js_bottom), and it contributes as one of the indicators to calculate YSlow score. But they found out that page would stay frozen while fetching, executing and parsing Javascript and this was worse over slow connections.

The solution was loading Javascript using dynamic `script` tags. This solution is better applied when using progressive enhancement because users can try to perform actions that are provided by this non-blocking javascript.

**2) Flush after head** (slide 51)
This is another [recommended practice by Yahoo](http://developer.yahoo.com/performance/rules.html#flush). They found out that the best solution was to flush at different points, especially when a block of a considerable size had been output. They also recommend to avoid having a big external `div` containing the different sections, and place directly the sections as `body` children.

In conclusion, the best you can do is test the different alternatives, especially when trying to find the one the provides the best user's perceived page load time.
