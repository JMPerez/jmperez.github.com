---
layout: post
title: The (mobile) web is making a come-back
date: 2017-06-29 15:10:00+02:00
description: Some recent examples of large companies implementing Progressive Web Apps, changing their mobile strategy
permalink: web-is-back
image:
  url: /assets/images/posts/flipkart-pwa.png
  width: 924
  height: 521
tags:
  - web

---

The web ecosystem is maturing and every day we understand better how to architecture large and maintainable web applications. We also understand what makes our sites slower and are coming up with solutions to overcome this.

Building a complex site that can work on slow networks is a challenge. One that some companies have decided to accept without fear and share with the developer community.

<!-- more -->

## Western companies looking at users from developing countries

Instagram, Twitter, Uber, Tinder. They have in common that they are well known in the developed world, and also that they have embraced the web as the channel to reach users in emerging markets. Not as a basic site with a large modal to download the app, but with a full-feature experience. After all, web users shouldn't be considered second-class citizens.

Twitter has been great at talking about implementation details (see [Introducing Twitter Lite](https://blog.twitter.com/official/en_us/topics/product/2017/introducing-twitter-lite.html) and [Twitter Lite and High Performance React Progressive Web Apps at Scale](https://medium.com/@paularmstrong/twitter-lite-and-high-performance-react-progressive-web-apps-at-scale-d28a00e780a3)) which is really helpful for devs like me who face some of these challenges on a daily basis. And, because anyone can see the code you ship, it's easy to look [into the details](Twitter Lite and High Performance React Progressive Web Apps at Scale).

![Twitter Lite's saving options](/assets/images/posts/twitter-lite.png)

<small class="caption">Twitter Lite also offers an option to save data.</small>

The case of Instagram is notable too because of its scale. They recently [added photo upload](http://fortune.com/2017/05/09/instagram-mobile-website-upload-photos/) to their mobile site in a clear sign of their investment on the platform, but haven't shared details about how the tech behind the site. Tinder is a similar case, with [a newer website](http://blog.gotinder.com/introducing-tinder-online/).

And a couple of days ago it was Uber with [Building m.uber: Engineering a high-performance web app for the global market](https://eng.uber.com/m-uber/). They describe their JS stack, some interesting things they are doing to reduce the payload and also what they plan for the future.

[It's evident where the next Internet users are going to come from](https://building.calibreapp.com/beyond-the-bubble-real-world-performance-9c991dcd5342) and no big company wants to miss the opportunity.

## Emerging markets leading PWA

If you want to find the leading companies on web development stop looking in Silicon Valley and turn your head towards India and China. There is no talk from Google about PWA where a company from from these countries doesn't showcase their site. [Flipkart](http://flipkart.com), [Treebo](https://www.treebo.com), [Housing](https://housing.com), and [ele.me](https://www.ele.me) are some examples. Have a look at the recent [Production Progressive Web Apps With JavaScript Frameworks (Google I/O '17)](https://www.youtube.com/watch?v=aCMbSyngXB4).

![Flipkart's PWA seems to be improving important metrics](/assets/images/posts/flipkart-pwa.png)

<small class="caption">Some insights from Flipkart and the impact of their mobile site.</small>

Before anyone else they saw the benefits of building sites that can work offline and can work fine on a slow network without the hassle of app downloads and updates.

I believe this is good for users, but also for companies. Updating web content is almost instantaneous. This means deploying new features, but also fixing bugs. And believe me, when there is a big issue and you need to fix something right now, time is precious.

Developers can ship code without an expensive process of building whole apps and have them go through a submission/revision system. They also benefit from quicker feedback loops when coding and seeing their changes on the screen (to be fair, React Native is making this one way better in the native world).

## The mobile web in 2017

When I saw [this tweet](https://twitter.com/markdalgleish/status/879144162389393409) I laughed out loud.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">Updated: The mobile web in 2017, **now with web fonts!**<br><br>(Original: <a href="https://t.co/nLta2tqk42">https://t.co/nLta2tqk42</a>) <a href="https://t.co/c4ZgEdkbU8">pic.twitter.com/c4ZgEdkbU8</a></p>&mdash; Mark Dalgleish (@markdalgleish) <a href="https://twitter.com/markdalgleish/status/879144162389393409">26 June 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>


A moment later I got sad since this is quite true. It seems that everyone at every company assumes that apps are more engaging and retain users better than a web experience.

This is true when:
- a) you haven't made an effort in making your web better,
- b) you don't hesitate in adding 3rd party tracking code that worsens your site
- c) you fill the screen with banners and modals, hiding the actual content.

Have a look at [this tweet and its thread](https://twitter.com/sbholtrop/status/878611398527520768). You'll see screenshots that should probably remind some of your past experiences browsing the web on mobile.

## What does the future look like?

I don't know if the importance of the mobile apps will decrease, or whether those mobile web users will eventually use apps instead of the web. Will even network speed be a problem in the future?

It's very interesting to see these trends going back and forth. At a minimum, we should always build for our users and avoid assumptions. Not all of them use powerful MacBook Pros nor have the latest iPhone.

We are paid to face these challenges, to serve our users. Let's prioritise that instead of developer ergonomics and everyone will benefit.
