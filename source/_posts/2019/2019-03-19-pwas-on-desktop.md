---
layout: post
title: What PWAs for Desktop means for Users and Developers
date: 2019-03-19 09:15:00+1:00
description: Progressive Web Apps for desktop fills an important gap for the web. Native apps might not be worth thanks to the new capabilities of the web
image:
  url: /assets/images/posts/spotify-pwa.jpg
  width: 900
  height: 600
permalink: pwas-on-desktop
tags:
  - pwa
---

As Progressive Web Apps make their way on desktop I wanted to talk about why I consider this is a breakthrough. I have talked in the past [about different uses cases for PWA](/shades-of-pwa/). In this post I want to focus on PWAs for desktop.

<div style="position:relative;padding-bottom:76.47%;margin-bottom:1rem">
<img
    style="max-width:100%; border: 0;position:absolute;top:0;left:0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1552998597/spotify-pwa-mac_szshj0.png 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1552998597/spotify-pwa-mac_szshj0.png 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1552998597/spotify-pwa-mac_szshj0.png 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1552998597/spotify-pwa-mac_szshj0.png 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1552998597/spotify-pwa-mac_szshj0.png"
    alt="" />
</div>

The current version of Google Chrome stable is Chrome 73. This version [lets you install Progressive Web Apps natively on macOS](https://twitter.com/rauschma/status/1105599978880331777). You can find more information about the release on [Pete LePage's "New in Chrome 73" notes](https://developers.google.com/web/updates/2019/03/nic73#pwas-everywhere).
<!-- more -->

Wasn't this possible before? Well, yes. On Chrome 72 the only option was to [wait for a `beforeinstallprompt` event](https://developers.google.com/web/fundamentals/app-install-banners/#listen_for_beforeinstallprompt) to then show some button on your page to let the user install the website as a PWA. Since version 73 users can install the PWA directly from Chrome’s context menu.

Now, going back to why this is a milestone. [I recently tweeted about how to install Spotify's web player as a PWA](https://twitter.com/jmperezperez/status/1107565909906997250) using Chrome's context menu.

I got this great question:

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">What benefit does this give you vs the regular downloaded desktop app? (Sorry for the ignorance 😅)</p>&mdash; Functor Flavius 𝝺 (@FlavioCorpa) <a href="https://twitter.com/FlavioCorpa/status/1107782132791947271?ref_src=twsrc%5Etfw">18 March 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Understanding What to Optimize for
If you are working on a new website you will see that PWAs for desktop is a nice addition to your site. Users who want to run it as a desktop app can do it. This has some obvious benefits, nicely summarized on [Pete LePage's "Desktop Progressive Web Apps" article](https://developers.google.com/web/progressive-web-apps/desktop):

> They're fast. Feel integrated because they launched in the same way as other apps, and run in an app window, without an address bar or tabs. They're reliable because service workers can cache all of the assets they need to run. And they create an engaging experience for users.

If you have been working on a project that was a desktop app, the question can be the opposite: **"What benefit does a desktop app gives you vs the website?"**. We have seen this battle over and over again on the mobile landscape, with apps vs mobile web. The main advantage of an app is its discoverability, through the Play Store / App Store, but more than that is the presence on your home screen. When you install the app on your phone it's there on your grid of apps. You will see the icon easily and you will open it with just a tap. You might get notifications if you opt-in, which will be a good way for the app owner to let you re-engage with you. Doing this on the web is possible, but more difficult. The discoverability is less straightforward. Knowing that a web site can be installed is not that obvious.

Discoverability is great, but companies look at other important metrics that installable apps excel at against the web: **retention and engagement**. If you have a shortcut to an app on your home screen you will be more likely to use the app than if you don't have it. Same thing if you get push notifications. And in the case of Spotify's desktop application you will even get the app open automatically when you start your computer. It's difficult not to engage with it.

For services with both app and website there is also another aspect that is usually disregarded. Users that have downloaded and installed your app have higher intention of using the app than those that only only the web version. It's natural to think that the end goal is to take users to the platform that has better metrics, so the web is usually seen as a place to put banners and modals that beg the user to install the app.

What is ignored is that in the way towards the installable app **there will be many users abandoning because they don't want to, or can't, download and install the app**.

Retention and engagement was one of the reasons why Spotify keeps developing a desktop application, but also capabilities. A desktop application allowed performant music streaming in the days when network was the bottleneck. It also let premium users download music to be played offline. And it also had a much better integration with the operating system (eg adding custom buttons to the Touch Bar on MacOS, or custom taskbar buttons on Windows).

<div style="position:relative;padding-bottom:75%;margin-bottom:1rem">
<img
    style="max-width:100%; border: 0;position:absolute;top:0;left:0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1552998304/spotify-mac-touch-bar_q7ywci.jpg 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1552998304/spotify-mac-touch-bar_q7ywci.jpg 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1552998304/spotify-mac-touch-bar_q7ywci.jpg 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1552998304/spotify-mac-touch-bar_q7ywci.jpg 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1552998304/spotify-mac-touch-bar_q7ywci.jpg"
    alt="Picture of a Macbook Pro running the Spotify app, with custom controls in the Touch Bar" />
</div>

## What the Web can Do

The web has been ticking off most of these. Take for instance offline capabilities with encrypted content which [Paul Lewis explained how to implement two years ago](https://www.youtube.com/watch?v=--KA2VrPDao).

For companies that currently have 2 implementations of their service, one as an app and another as a website, the question should be "is the cost of developing 2 different versions of the same thing worth it?". And in most cases PWA for desktop means that, at least on desktop, there is no strong advantage in having the overhead of developing multiple versions. This is especially true in the case that the code base of these versions differs greatly, as in the case of Spotify's desktop app and web player.

The web has also a couple of great benefits over a hybrid app on desktop. Push notifications encourage users to go back to your site even if it's not open currently on a browser. And more importantly, the web makes it extremely easy to deliver feature updates and fixes (bug fixes, security fixes, code roll backs). No need to go through release cycles nor app store approvals. Having every user on the latest version is a great perk that should be more appreciated.

## Conclusion

As I wanted to highlight, for the user the good news is that there are no news. They can install a PWA as a desktop application and won't miss any "truly desktop app" capabilities. For a company, though, this can save a lot of duplicated work, help their developers move faster and deliver the best experience for the user regardless of their device.

Because the web was always great for this.
