---
layout: post
title: Displaying Page Load Metrics on Your Site
date: 2018-03-30 09:00:00+02:00
description: Showing page load, First Paint, and First Contentful Paint Displaying on your site to prove you care about web performance.
image:
  url: /assets/images/posts/load-time/tim-kadlec-load-time.png
  width: 1200
  height: 728
permalink: page-load-footer
tags:
  - performance
---

I was browsing [Tim Kadlec's website](https://timkadlec.com) and I noticed he had added page load time metrics in the footer.

<img
    loading="lazy"
    style="max-width:100%; border: 0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1522388675/load-time/tim-kadlec-load-time.png 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1522388675/load-time/tim-kadlec-load-time.png 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1522388675/load-time/tim-kadlec-load-time.png 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1522388675/load-time/tim-kadlec-load-time.png 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1522388675/load-time/tim-kadlec-load-time.png"
    alt="Tim Kadlec's site shows how long the page took to load in the footer" />
<small class="caption">Tim Kadlec's site shows how long the page took to load in the footer.</small>

Stoyan Stefanov also realized and wrote ["This page loaded in X seconds"](http://www.phpied.com/this-page-loaded-in-x-seconds/), a blog post describing the code used for this. Stoyan also created a bookmark that shows an alert with the load time of the current page. The data is obtained from [`window.performance`](https://developer.mozilla.org/en-US/docs/Web/API/Window/performance).

I liked the idea and added a similar snippet that shows the page load time in the footer (you should see it if you scroll to the bottom). If your browser supports the [Paint Timing API](https://css-tricks.com/paint-timing-api/) you will see a couple of extra metrics: First Paint and First Contentful Paint.

<!-- more -->

## First Paint and First Contentful Paint

Page load time is a metric that tells us part of the story. Yet it might not reflect how fast the visible area loads. For instance, a page with lots of images will report a large page load time, since the `load` event will be triggered when all of them are fetched, even though the above-the-fold content might load way earlier. It is still a good idea, since it forces us to think about lazy-loading the resources when needed.

I have written before about [user perceived performance](https://www.smashingmagazine.com/2018/02/progressive-image-loading-user-perceived-performance/) and metrics that tell how long it takes to render something on the page. Using the [Paint Timing API](/paint-timing-api/) we can get the [First Paint and First Contentful Paint metrics](https://w3c.github.io/paint-timing/#sec-terminology).

My code snippet extends Tim's and Stoyan's to report these metrics, obtained running `performance.getEntriesByType('paint')`:

```js
window.addEventListener('load', () => {
  setTimeout(() => {
    const t = window.performance && performance.timing;
    const round2 = num => Math.round(num * 100) / 100;
    if (t) {
      const timingStats = document.querySelector('.timing-stats');
      const loadTime = (t.loadEventEnd - t.navigationStart) / 1000;
      let timingStatsHTML = `This page loaded in ${round2(loadTime)} seconds. `;
      const perfEntries = performance.getEntriesByType('paint');
      perfEntries.forEach((perfEntry, i, entries) => {
        timingStatsHTML += `${perfEntry.name} was ${round2(
          perfEntry.startTime / 1000
        )} seconds. `;
      });
      timingStats.innerHTML = timingStatsHTML;
    }
  }, 0);
});
```

In the future I would like to extend the reported metrics to include [First Meaningful Paint](https://developers.google.com/web/tools/lighthouse/audits/first-meaningful-paint) (whenever it is implemented, see [a description of the heuristics here](https://docs.google.com/document/d/1BR94tJdZLsin5poeet0XoTW60M0SjvOJQttKT-JK8HI/view)) and [Time to Interactive](https://developers.google.com/web/tools/lighthouse/audits/first-interactive) (using [GoogleChromeLabs/tti-polyfill](https://github.com/GoogleChromeLabs/tti-polyfill)).

<img
    loading="lazy"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto,c_scale/v1522388641/load-time/performance-metrics.jpg"
    sizes="(max-width: 768px) 100vw, 684px" />
<small class="caption">Slide from [Web Performance: Leveraging the Metrics that Most Affect User Experience from Google I/O '17](https://www.youtube.com/watch?v=6Ljq-Jn-EgU) showing different key moments during a page load.</small>

[Leonardo Zizzamia](https://twitter.com/Zizzamia) has been working on [Perfume.js](http://zizzamia.github.io/perfume/), a library to measure these metrics, annotate them to the dev tools timeline and optionally reporting them to Google Analytics. It also has a fallback for browsers that do not support the Paint Timing API.

You can read more about the library on his posts "[First (Contentful) Paint with a touch of Perfume(.js)](https://medium.com/@zizzamia/first-contentful-paint-with-a-touch-of-perfume-js-cd11dfd2e18f) and "[Time to Interactive with RUM](https://medium.com/@zizzamia/time-to-interactive-with-rum-862ba874392c)".

If you are into this topic, I also recommend you to watch the talk [Web Performance: Leveraging the Metrics that Most Affect User Experience from Google I/O '17](https://www.youtube.com/watch?v=6Ljq-Jn-EgU).

## How to Calculate the Transfer Size

The Resource Timing API allows to [know the transfer size of the assets fetched by the page](https://developer.mozilla.org/docs/Web/API/Resource_Timing_API/Using_the_Resource_Timing_API#Size_matters). For CORS requests is necessary to [include the `timing-allow-origin` header](https://developer.mozilla.org/docs/Web/API/Resource_Timing_API/Using_the_Resource_Timing_API#Coping_with_CORS) set up properly to return the transfer size. Otherwise they will report 0 as the transfer size.

Another caveat is that there doesn’t seem to be a way to know the transfer size of the page itself. One could calculate the length of the document’s innerHTML, but that won’t match the transfer size if the response was compressed (which hopefully was).

Let’s have a look at an example:

<img
    loading="lazy"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto,c_scale,dpr_auto/v1522831856/load-time/resource-timing-api-page-size.jpg"
    sizes="(max-width: 768px) 100vw, 684px"
    alt="Calculating the transferred size of the requests using Resource Timing API." />
<small class="caption">Calculating the transferred size of the request susing Resource Timing API.</small>

The page that I’m loading, served from jmperezperez.com, makes requests to fetch assets from res.cloudinary.com and www.google-analytics.com, which are external domains. Once loaded, I run this code to calculate the transferred size:

```js
const totalBytes = performance.getEntriesByType('resource').reduce((a, r) => {
  return a + r.transferSize;
}, 0);
console.log(`Page size is ${Math.round(totalBytes / 1024)} kB`);
```

The reported transferred size according to the dev tools is 113 kB, while the calculated using the code above (Resource Timing API) is 107 kB. Both res.cloudinary.com and www.google-analytics.com set the `timing-allow-origin: *` response header, which let us get the right `transferSize`.

You can read more about Cloudinary’s usage of Server Timing on their recent post “[Inside the Black Box with Server-Timing](https://cloudinary.com/blog/inside_the_black_box_with_server_timing)”.

Although we can’t get the exact page load size, using these APIs get us way closer.

## Reporting Metrics Inline and RUM

These new browser APIs allow us to access metrics from JavaScript, which previously could only be accessed manually using the developer tools. Access from the browser means we can show them to the user or report them to a Real User Monitoring solution to track and optimize user's experience.

Displaying these metrics on our sites is a way to communicate publicly that we are taking performance seriously.
