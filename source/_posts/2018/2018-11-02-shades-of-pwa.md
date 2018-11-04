---
layout: post
title: The different shades of Progressive Web Apps
date: 2018-11-02 15:44:00+02:00
description: Taking advantage of PWA functionality on your site is easy. You don't need to go all-in using all the features. Just take what is needed for your use case.
image:
  url: /assets/images/posts/shades-of-pwa/header.jpg
  width: 1024
  height: 683
permalink: shades-of-pwa
tags:
  - pwa
---

Implementing a PWA or adapting an existing site to “become a PWA” can be daunting. There are many new technologies to learn about, but you don’t need to use all of them to improve your website performance and user experience greatly.

<div style="position:relative;padding-bottom:66.6666%;margin-bottom:1rem">
<img
    style="max-width:100%; border: 0;position:absolute;top:0;left:0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1541172389/shades-of-pwa/header.jpg 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1541172389/shades-of-pwa/header.jpg 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1541172389/shades-of-pwa/header.jpg 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1541172389/shades-of-pwa/header.jpg 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1541172389/shades-of-pwa/header.jpg"
    alt="" />
</div>

On this post I will describe several use cases where Progressive Web Apps (PWA) can be useful to make your website achieve better performance and be more reliable.

<!-- more -->

## What are Progressive Web Apps

If you are a web developer you have probably heard about Progressive Web Apps (PWA). Web sites that load quick, are reliable, feel smooth and take advantage of modern APIs.

There is a lot of buzz about them, partly because Google coined the term and has been leading the implementation of the bits and pieces that composed it.

Implementing a PWA or adapting an existing site to “become a PWA” looks like a big endeavor. The same powerful marketing that has made PWA known in the developer community can be a blessing and a curse. Developers might get the wrong idea that either they use everything and make installable offline-capable push notifications-enabled websites, or they bail out. After all, **PWA is just a way to coin a set of recent browser APIs and techniques, not all or nothing**.

Every website’s use case is different and that is alright. If installing your website as an app is not something a user would do for your site, you don’t need to build that capability. **You can still take advantage of some of the technologies powering PWAs**. The main requirement is that your site runs on HTTPS and, in most cases, creating a ServiceWorker, which is not more than a Javascript file.

I want to describe some of the typical scenarios where you can applied elements from PWAs.

## Common Use Cases to Apply Service Workers and other PWA-related functionality

### Offline mode and pre-caching

To get your site to load without a connection, the user needs to visit it and the site needs to run a Service Worker (SW)that will make content available offline. The SW can follow different strategies (eg serving cache first, making a network request first, etc). You can find strategies on [Jake Archibald’s Offline Cookbook](https://jakearchibald.com/2014/offline-cookbook/) and [serviceworke.rs](https://serviceworke.rs/).

<div style="position:relative;padding-bottom:49%;margin-bottom:1rem">
<img
    style="max-width:100%; border: 0; position: absolute; top: 0; left: 0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1541172749/shades-of-pwa/stale-while-revalidate-sw.png 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1541172749/shades-of-pwa/stale-while-revalidate-sw.png 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1541172749/shades-of-pwa/stale-while-revalidate-sw.png 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1541172749/shades-of-pwa/stale-while-revalidate-sw.png 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1541172749/shades-of-pwa/stale-while-revalidate-sw.png"
    alt="Stale-while-revalidate” strategy, of the many explained on Jake Archibald’s Offline Cookbook" />
</div>

<small class="caption">“Stale-while-revalidate” strategy, of the many explained on [Jake Archibald’s Offline Cookbook](https://jakearchibald.com/2014/offline-cookbook/). If there’s a cached version available, use it, but fetch an update for next time.</small>

The strategies that check the cache first can be used to fetch and pre-cache top-level navigation routes and other critical resources. Thus, the user gets a faster loading and rendering experience as they click around the PWA.

Offline support is something that can be added pretty much to any site, big or small. I run [a simple SW](https://jmperezperez.com/sw.js) [on my blog](https://jmperezperez.com) to download the main sections and the posts that the user reads.

```js
// the cache version gets updated every time there is a new deployment
const CACHE_VERSION = 10;
const CURRENT_CACHE = `main-${CACHE_VERSION}`;

// these are the routes we are going to cache for offline support
const cacheFiles = ['/', '/about-me/', '/projects/', '/offline/'];

// on activation we clean up the previously registered service workers
self.addEventListener('activate', evt =>
  evt.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== CURRENT_CACHE) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  )
);

// on install we download the routes we want to cache for offline
self.addEventListener('install', evt =>
  evt.waitUntil(
    caches.open(CURRENT_CACHE).then(cache => {
      return cache.addAll(cacheFiles);
    })
  )
);

// fetch the resource from the network
const fromNetwork = (request, timeout) =>
  new Promise((fulfill, reject) => {
    const timeoutId = setTimeout(reject, timeout);
    fetch(request).then(response => {
      clearTimeout(timeoutId);
      fulfill(response);
      update(request);
    }, reject);
  });

// fetch the resource from the browser cache
const fromCache = request =>
  caches
    .open(CURRENT_CACHE)
    .then(cache =>
      cache
        .match(request)
        .then(matching => matching || cache.match('/offline/'))
    );

// cache the current page to make it available for offline
const update = request =>
  caches
    .open(CURRENT_CACHE)
    .then(cache =>
      fetch(request).then(response => cache.put(request, response))
    );

// general strategy when making a request (eg if online try to fetch it
// from the network with a timeout, if something fails serve from cache)
self.addEventListener('fetch', evt => {
  evt.respondWith(
    fromNetwork(evt.request, 10000).catch(() => fromCache(evt.request))
  );
  evt.waitUntil(update(evt.request));
});
```

With great power comes great responsibility. Do not use SWs to abuse the user’s data connection, downloading content they will never need, just in case.

### Service Workers for Multi-page Applications

In a multi-page app (MPA), every route that a user navigates to triggers a full request of the page, along with associated scripts and styles needed, to the server.

A good example is [ele.me](https://ele.me), the biggest food ordering and delivery company in mainland China. They used a SW to precache the main routes from their site, and implemented skeleton screens that are immediately shown while loading routes that aren’t cached.

<div>
<img
src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:350,f_auto,c_scale,w_600/v1541171672/shades-of-pwa/ele-me-skeleton-page.png"
sizes="(max-width: 768px) 50vw, 350px" alt="Processing a picture through Primitive using 10 shapes" style="width:48%;float:left;margin-right:2%;padding-bottom:10px" />
<img
src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:350,f_auto,c_scale,w_600/v1541171587/shades-of-pwa/ele-me-full-load.png"
sizes="(max-width: 768px) 50vw, 350px" alt="Processing a picturethrough Primitive using 100 shapes" style="width:48%;float:left;margin-right:2%;padding-bottom:10px" />
</div>

You can read more about their approach on [Google Developers site](https://developers.google.com/web/showcase/2017/eleme) and [this in-depth post](https://medium.com/elemefe/upgrading-ele-me-to-progressive-web-app-2a446832e509).

### Bridging the gap between SPAs and server-side rendered sites

Web development has gone through different stages

1.  Old sites used to be server-side rendered. Only minor interactions used Javascript in the client. Every page navigation meant a full page load.
2.  Then we started creating more complex web experiences and moved all the logic (and templates) to client-side land. Everything was amazing as long as you waited a bit while staring at a blank page whose main purpose was to load a large JS bundle.
3.  We realized that maybe we needed a hybrid solution. First request server-side rendered, then the rest happening client-side.

**Reaching the third step involves doing server-side rendering.** If you don’t want to duplicate templates and logic, the usual solution is to use NodeJS on the server. This is fun for web developers because we get to use the same language both on server and browser. In medium and large web projects it means rewriting existing working code from python/java/PHP/others to Javascript, and the typical nuances of adopting something different from the existing solution.

Server-side rendered sites have also a largely underestimated drawback. **Putting content early on the screen is one thing. Making the content interactive is another.** A page that renders quickly but then doesn’t respond to click/touch for seconds, while loads and executes the JS behemoth, results in frustration.

In web dev terms we are improving the [First Meaningful Paint](https://developers.google.com/web/tools/lighthouse/audits/first-meaningful-paint) (‘FMP’), but we aren’t making any improvement in the [Time to Interactive](https://developers.google.com/web/tools/lighthouse/audits/time-to-interactive) (‘TTI’).

This short version of Addy Osmani’s “The cost of JavaScript“ explains it very well:

<div class="videoWrapper">
    <iframe width="1764" height="1080" src="https://www.youtube.com/embed/qUFA1pAMfj4" frameborder="0" allowfullscreen></iframe>
</div>

<small class="caption">“<a href="https://www.youtube.com/watch?v=qUFA1pAMfj4">The cost of JavaScript</a>” by Addy Osmani. If you like it, there is also <a href="https://www.youtube.com/watch?v=63I-mEuSvGA">a longer version of the talk.</small>

Paul Lewis also described the situation in his post “[When everything is important nothing is](https://aerotwist.com/blog/when-everything-is-important-nothing-is/)”, and describes it as the _Uncanny Valley._

<img
    style="max-width:100%; border: 0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1541171412/shades-of-pwa/uncanny-valley.jpg 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1541171412/shades-of-pwa/uncanny-valley.jpg 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1541171412/shades-of-pwa/uncanny-valley.jpg 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1541171412/shades-of-pwa/uncanny-valley.jpg 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1541171412/shades-of-pwa/uncanny-valley.jpg"
    alt="Spotify web player shows an offline page when there is no internet connection" />
<small class="caption">Rendering your app server-side. An image from “[When everything is important nothing is](https://aerotwist.com/blog/when-everything-is-important-nothing-is/)”.</small>

I have seen many cases when server-side rendering was proposed as the first step to improve the performance in a SPA. This left off the table ideas like bundle-splitting, which would have likely reduced both FMP and TTI.

> […] **you should avoid SSR if you don’t need it.** Most modern web apps require sophisticated interaction with the UI that has to be driven by non-trivial amounts of JavaScript. If you need to write all of that JS anyway, and you _don’t_ need the first page load benefits that SSR gives you, you’ll be better off just building a [static app shell](https://developers.google.com/web/fundamentals/architecture/app-shell) and avoiding the headaches of client-server code reuse, data re-hydration, and dynamic content cache invalidation. — [When should I Server-Side Render?](https://blog.usejournal.com/when-should-i-server-side-render-c2a383ff2d0f) by [Michael Bleigh](https://blog.usejournal.com/@mbleigh)

Single Page Applications that are not server-side rendered can take great advantage from using Service Workers. In most cases the browser requests some data and injects it in a JS template or component. This means that the browser can cache the JS code and the data independently.

The site can then follow different strategies. For instance, it can load immediately with stale data, similar to what usually happens with native apps. It can also decide to render a skeleton while the data is fetched. In any case, it makes an approach like [PRPL](https://developers.google.com/web/fundamentals/performance/prpl-pattern/), easy to implement.

### Installable Website

You might want to make your website installable, close to what everyone knows as an “app”. For this you don’t need many to use many capabilities from the web. As long as your site runs on HTTPS you just need a web manifest, an icon and a ServiceWorker. You can find documentation on [Google’s Developer site](https://developers.google.com/web/fundamentals/app-install-banners/) and [MDN](https://developer.mozilla.org/en-US/docs/Web/Apps/Progressive/Installable_PWAs).

Your site doesn’t need to be fully functional offline to make it installable. Take for instance Spotify’s Progressive Web App.

<div class="videoWrapper">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/EvcjSldzQ1E" frameborder="0" allowfullscreen></iframe>
</div>

<small class="caption">Spotify's Web Player works as an installable PWA.</small>

As you see, the PWA is installable, yet it doesn’t have support for offline navigation nor playback. When there is no connection, the PWA shows this custom page:

<img
    style="max-width:100%; border: 0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1541171689/shades-of-pwa/spotify-offline.png 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1541171689/shades-of-pwa/spotify-offline.png 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1541171689/shades-of-pwa/spotify-offline.png 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1541171689/shades-of-pwa/spotify-offline.png 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1541171689/shades-of-pwa/spotify-offline.png"
    alt="Spotify web player shows an offline page when there is no internet connection" />

Installable PWAs are not limited to mobile. They are already supported on [ChromeOS, Windows and Linux](https://developers.google.com/web/progressive-web-apps/desktop), and pretty soon on Mac too (Chrome 72+).

#### More features enabled by Service Workers

I have only talked about some use cases for ServiceWorkers and other elements of PWAs, but there are more. Browsers can show [push notifications](https://developers.google.com/web/fundamentals/push-notifications/) after the user has enabled it for a certain site, and the push notifications are delivered even when the site is not opened. This makes it ideal for reengage with users without having to wait for them to visit your site again.

You can also use [background sync](https://developers.google.com/web/updates/2015/12/background-sync), ideally for schedule data sending beyond the life of the page. Think of uploading pictures or sending chat messages even after the user leaves the page.

### More Resources

I love reading about real sites that have adopted PWAs and have shared their findings. I particularly like [Addy Osmani’s talk “Production Progressive Web Apps With JavaScript Frameworks”](https://www.youtube.com/watch?v=aCMbSyngXB4), showcasing some case studies from large web sites that have been integrating these technologies to improve their key metrics.

<div class="videoWrapper">
    <iframe width="1764" height="1080" src="https://www.youtube.com/embed/aCMbSyngXB4" frameborder="0" allowfullscreen></iframe>
</div>

They are good examples to demonstrate that you don’t need to re-architecture an existing site to use PWA goodness, and that you can apply some of these concepts and see improvements in perceived performance very quickly.
