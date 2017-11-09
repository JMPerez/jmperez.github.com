---
layout: post
title: 'Hybrid apps: It''s not only about mobile'
date: 2012-07-22 18:20:17+00:00
tags:
  - hybrid apps
permalink: desktop-hybrid-apps-not-only-mobile
---

One month ago I moved to Stockholm to start working at [Spotify](http://www.spotify.com). For those of you who don't know what Spotify is about, I will tell you Spotify is a service that offers you legal and free access to a huge library of music. There are Spotify clients for a lot of different platforms, and right now I am working on the desktop one as a web developer.
![Spotify desktop client showing its HTML5 support](/assets/images/posts/spotify-apps-html5.jpg)

<!-- more -->
## Hybrid mobile apps

I already talked about [hybrid applications](/developing-mobile-webapp-first/#hybrid). By hybrid apps we usually mean hybrid mobile apps, since it is normally used when describing the approach of building an application for a mobile device that includes content that is generated using web technologies. In fact, I had the change of working on hybrid mobile applications when working at Tuenti. Both [Tuenti Classic](https://play.google.com/store/apps/details?id=com.tuenti.android.client) and [Tuenti Social Messenger](https://play.google.com/store/apps/details?id=com.tuenti.messenger) include content that is loaded in a WebView.

**Update 2014-05-12**: It is interesting to see that the hybrid app development is still a thing. Take a look to [Hybrid sweet spot: Native navigation, web content](http://signalvnoise.com/posts/3743-hybrid-sweet-spot-native-navigation-web-content) which summarises some of the advantages of the hybrid approach.

## Hybrid desktop apps

But hybrid apps are also present in desktop. And that's the magic of web development, where I can use web technologies to provide content to a large amount of devices, and as a developer use the very same tools and techniques that I used to build websites. Being abstracted from the underlying operating system, the browser embedded in the client allows you implement once and have it available across Windows, Mac and Linux. It's a nice way for developers to [write apps](https://developer.spotify.com/technologies/apps/) without having to learn a different stack of technologies.

## More web content for desktop

Web is used more and more when applications want developers to create content for it. Think of [Google Chrome Extensions](https://chrome.google.com/webstore/category/extensions) or [Metro Apps on Windows 8](http://channel9.msdn.com/Events/BUILD/BUILD2011/APP-162T). So when working with web technologies, try to write reusable code or libraries that can be shared across platforms and embrace feature detection whenever your code needs to be aware of what environment it is being running on.
