---
layout: post
title: PerformanceObserver and Paint Timing API
date: 2017-06-17 11:15:00+02:00
description: A quick look at the Paint Timing API to get metrics about render events on our pages.
image:
  url: /assets/images/posts/paint-timing-filmstrip.png
  width: 15000
  height: 1388
tags:
  - performance
permalink: paint-timing-api
---

In [a recent post about Chrome 60 Beta](https://blog.chromium.org/2017/06/chrome-60-beta-paint-timing-api-css.html), Google announced the support of the Paint Timing API to get metrics on when your page starts rendering and when the user gets content that can be consumed (more info on the definition of the events below). Here I'm going to describe this new API a bit and show you how to use it.

<!-- more -->

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto,c_scale/v1510494808/paint-timing-example_byc6z2.png"
    sizes="(max-width: 768px) 100vw, 684px" alt="Example of Paint Timing API entries"/>
<small class="caption">Image taken from the [Chrome 60 blog post](https://blog.chromium.org/2017/06/chrome-60-beta-paint-timing-api-css.html), which first appeared in ["Web Performance: Leveraging the Metrics that Most Affect User Experience"](https://youtu.be/6Ljq-Jn-EgU) at Google I/O 2017</small>

Up until now we have been measuring performance through other metrics, mostly using the [Navigation Timing API](https://developer.mozilla.org/docs/Web/API/Navigation_timing_API), which is also what Google Analytics uses for their [Site Speed report](http://www.ericmobley.net/measuring-performance-google-analytics/). Yet those metrics don’t tell us the whole picture about the rendering experience.

The [Paint Timing API](https://github.com/WICG/paint-timing) aims to improve this by exposing metrics on paint events that are grouped in two types of entries. By [its definition](https://github.com/WICG/paint-timing#definition):

*   `"first-paint"` entries contain a `DOMHighResTimeStamp` reporting the time when the browser first rendered after navigation. This excludes the default background paint, but includes non-default background paint. This is the first key moment developers care about in page load – when the browser has started to render the page.
*   `"first-contentful-paint"` contain a `DOMHighResTimestamp` reporting the time when the browser first rendered any text, image (including background images), non-white canvas or SVG. This includes text with pending webfonts. This is the first time users could start consuming page content.

A picture is worth a thousand words, so let’s see how these entries would be reported by some real web sites:

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto,c_scale/v1510476598/paint-timing-filmstrip_anq3pv.png"
    sizes="(max-width: 768px) 100vw, 684px" alt="Filmstrip from several sites showing when Paint Timing API entries are triggered"/>
<small class="caption">Image taken from the [Paint timing API repo on WICG](https://github.com/WICG/paint-timing#examples).</small>

#### Hacking on it

As a hack project I decided to give it a try and implement it on a web site. You have a basic example [on the Paint timing page](https://github.com/WICG/paint-timing#usage):

```js
var observer = new PerformanceObserver(function(list) {
  var perfEntries = list.getEntries();
  for (var i = 0; i < perfEntries.length; i++) {
     // Process entries
     // report back for analytics and monitoring
     // ...
  }
});

// register observer for long task notifications
observer.observe({entryTypes: ["paint"]});
```

In practice you will probably want to report the information somewhere you can track it. If you are using Google Analytics, you can use [this snippet from Google’s Developer site](https://developers.google.com/web/updates/2017/06/user-centric-performance-metrics#tracking_fpfcp) (ES6):

```js
const observer = new PerformanceObserver((list) => {
  for (const entry of list.getEntries()) {
    // `name` will be either 'first-paint' or 'first-contentful-paint'.
    const metricName = entry.name;
    const time = Math.round(entry.startTime + entry.duration);

    ga('send', 'event', {
      eventCategory: 'Performance Metrics',
      eventAction: metricName,
      eventValue: time,
      nonInteraction: true,
    });
  }
});

// Start observing paint entries.
observer.observe({entryTypes: ['paint']});
```

#### Word of Caution

The API is still experimental and [in “Editor’s Draft” state](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceObserver). Also, the fact that a browser supports PerformanceObserver doesn’t mean that it supports the Paint events.

In the quick test I run, the above snippet would throw an exception:

```
Uncaught TypeError: Failed to execute ‘observe’ on
‘PerformanceObserver’: A Performance Observer MUST
have at least one valid entryType in its entryTypes
attribute.
```

It turns out that if you only observe the `paint` entryType and this is not supported in the browser, **it will throw an exception**. According to [the specification](https://w3c.github.io/performance-timeline/#dom-performanceobserverinit-entrytypes):

> `entryTypes`: A list of entry names to be observed. The list must not be empty and types not recognized by the user agent must be ignored.

In short, if you are giving this API a try, make sure you `try...catch` the `observer.observe()` call.

#### Conclusions

This is a bit in early stages but I’m looking forward to see how the API evolves and we can use it to track Web Performance even better. This will also be a great addition to [LightHouse](https://developers.google.com/web/tools/lighthouse/), [WebPageTest](http://www.webpagetest.org), [Calibre](https://calibreapp.com) and the rest of tools we use to monitor metrics on our sites.
