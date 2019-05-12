---
layout: post
title: Developing modern sites with good performance
date: 2019-02-01 08:15:00+01:00
description: Performance affects user engagement but also can leave many users out. Fast sites are key to democratize the web and let everyone enjoy our products and services.
image:
  url: /assets/images/posts/android-apps-heand-15092.jpg
  width: 1024
  height: 683
permalink: modern-sites-good-performance
tags:
  - performance
---

Poor performance leads to exclusion. When we create heavy sites we limit what users can access our content. Those with more powerful devices and better network will get sites loaded faster. Those with older devices and slower network will need to wait more.

<div style="position:relative;padding-bottom:66.6666%;margin-bottom:1rem">
<img
    style="max-width:100%; border: 0;position:absolute;top:0;left:0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1549005393/android-apps-hand-15092_zj2jkp.jpg 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1549005393/android-apps-hand-15092_zj2jkp.jpg 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1549005393/android-apps-hand-15092_zj2jkp.jpg 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1549005393/android-apps-hand-15092_zj2jkp.jpg 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1549005393/android-apps-hand-15092_zj2jkp.jpg"
    alt="" />
</div>
<!-- more -->

## Why performance is important
[Study after study](https://wpostats.com/) shows how slowing sites down results in less engagement, less time on the site and a general decrease in key business metrics. Still, in our development teams we continue to prioritize more highly shipping features over addressing web performance.

Don't get me wrong, features are important. Serving an empty site is fast, but not very useful. It's important to deliver a core set of features, and do it in such a way that many users can enjoy it. Just keep in mind that if they user can't use the product we will lose them, no matter how much we have worked on the feature set.

## Our role promoting performance
Developers play a key role in prioritizing performance. They can steer what tasks the development team works on, and they can prove with results the impact of the changes.

While some performance improvements might be costly in time, there are usually lots of low-hanging fruits that can drive to big improvements. And we are more prepared than ever to do a good job.

We have a better understanding of how the browser and network works, and how to serve content to the user without incurring in delays. We also use tools to build our sites that help us defining dependencies and delivering a small payload, tailored to the current session.

## Taking advantage of modern tools
Single Page Applications and the trend of moving most of the logic to the client comes with performance implications. There is now more work to do in the browser, like data-fetching, templating or routing, which makes sites slower out-of-the-box. If we don't stop there and explore the beauty of component-based sites we will see that [code-splitting and lazy-loading](/high-performance-lazy-loading/) fit perfectly in the picture and they allow us, for the first time, to be smart on how we ship code while keeping complexity at a minimum.

While it can be difficult to keep track of every new tool and browser API, it's important to be aware of them. It wouldn't be smart to jump immediately on them and rewrite constantly our product on the latest and trendiest stack, but we can learn something from them.

I get inspired by tools like [Gatsby](https://www.gatsbyjs.org/) or [Next.js](https://nextjs.org/). They let us build sites that have a high performance out of the box. What they do is not black magic, but making a good job serving what is needed for the current page, and deferred the loading of the rest of the content. Nothing prevents us from adopting some of those techniques to our projects to give them a boost.

## The web that is coming
The future looks bright. We are decoupling UI and data. We are creating sites that can be run on a laptop, phone, TV or [smartwatch](https://developer.apple.com/videos/play/wwdc2018/239/). We are building offline experiences and sites that synchronize in the background and handle push notifications. We are moving desktop applications to the web, seamlessly running [assembly code](https://developer.mozilla.org/docs/WebAssembly) in the browser.
