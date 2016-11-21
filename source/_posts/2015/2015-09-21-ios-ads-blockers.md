---
layout: post
title: iOS 9 and content blockers
date: 2015-09-21 19:33:00+02:00
description: Some opinions on ads and content blockers and how they affect web development.
tags:
  - progressive
permalink: ios-ads-blockers
---

Everyone is talking about ad-blockers these days after the release of iOS 9. But we should talk more about the "content blockers" feature in general, which can, by default, block scripts, fonts or images. What you can do as a web developer is what you should have been doing until now: don't take anything for granted and follow a progressive enhancement approach.

<!-- more -->
I have read lots of articles about why it is a good or bad idea to use these blockers, and I can understand both sides of the discussion. I get that it can make things difficult for businesses that rely on advertising and tracking scripts to finance themselves, and I also understand that as a user I want to see web content quickly. If that comes with savings in bandwidth, double win.

If I were to choose a post with which I agree, I would pick [Content Blocking Primer](http://meyerweb.com/eric/thoughts/2015/09/19/content-blocking-primer/). It doesn't say that this is the end of the world, and encourages web developers to do what they should have been doing all this time.

There have been browser extensions to block certain content for a long time. But it's now when it gets built-in and easily accessible for everyone, not necessarily tech-savvy ones.

## No scripts

Our content (at least the most important bit) should ideally be rendered server side. This improves load time and makes all bots index our content.

> "But Google Bot is able to run Javascript", you say.

Truth is that there are other bots out there that might not be that smart. Say someone shares a link to your site on Twitter. A Twitter bot goes and makes a request to that page and tries to use its metadata to show a nice Twitter Card. Facebook? Same story.

Relying on Javascript for our main content makes us also vulnerable to SPOF issues. Say the JS file has a typo, or maybe the CDN that contains a JS file you need is not accessible in that moment. If your content can be rendered server-side, the user will still be able to see it.

> "But I need Javascript for my site to work!" you claim.

You are probably right for this one, but more often than not you depend on Javascript because you didn't think of a scenario in which Javascript wasn't available. After all, who disables Javascript these days! _Note: I've done this and I continue doing it, so you can blame me too._

Say you use Javascript for a fancy lazy-loading component that makes your site faster by requesting images only when they are within the viewport. You don't want the browser to start making the requests as soon as it gets the markup, so you do something like:

```html
<div class="image" data-img="http://example.com/image.jpg"></div>
```

and use Javascriot to either replace the `<div/>` with an `<img/>` or set its `background` using CSS. Now imagine the browser is not running Javascript, in which case the image won't be shown.

Now have a look at this snippet:

```html
<div class="image" data-img="http://example.com/image.jpg"></div>
<noscript><img src="http://example.com/image.jpg"></noscript>
```

It adds a `<noscript>` tag that will make the browser render the content when it doesn't have Javascript.

> "But then you are downloading all the images" you say.

And you are right, but maybe that is better than not loading any image at all.

Tracking is something to think of too. A script like Google Analytics' wouldn't run, and the visit wouldn't be reported. This is a problem if you rely on these data, in which case you will need to make the request server-side using something like [Analytics Measurement Protocol](https://developers.google.com/analytics/devguides/collection/protocol/v1/devguide).

## Custom fonts

Are you really worried about custom fonts? You should already be providing a font stack with default system fonts that are used when the custom one fails to load (or after a certain timeout). In addition, you should be thinking of avoiding the "FOIT" (Flash of Invisible Text) if you want the user to be able to see the text quicker. I highly recommend you check [Font Loading Revisited with Font Events](https://www.filamentgroup.com/lab/font-events.html), and make a couple of tests using [WebPageTest](http://webpagetest.org) to see the impact of custom fonts in your site.

> "But I use custom fonts to show icons!" you shout.

[Inline SVG vs Icon Fonts](https://css-tricks.com/icon-fonts-vs-svg/) is a great post that compares SVG with icon fonts. tl;dr? you can use SVGs instead of Web Fonts.

# Is this whole blocking thing bad for the web?

Sometimes I believe we, as web developers, should do more in order to avoid third-party scripts from landing on the sites we build. The web has become a container where it is far too easy to drop things to, and it looks like one more script doesn't damage that much.

At the same time I wonder what the situation is in the native apps world. Everything seems so fast when you install an app. Make a quick test accessing your favourite newspaper from your phone, both on the web and through their app. If it's not [The Guardian](http://www.theguardian.com/), which have done a great job with their website, chances are that the web is much slower than their app. And then everyone nods when the read about [Facebook's Instant Articles](https://instantarticles.fb.com/) and blames the web for its slowness.

The web is deliberately slower not because the technology behind it, but because of the bloated set of non-sense third-party stuff we have been putting into.

I am really looking forward to seeing where this takes us.
