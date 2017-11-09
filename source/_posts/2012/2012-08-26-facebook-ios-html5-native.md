---
layout: post
title: 'Facebook for iOS: From HTML5 to native'
date: 2012-08-26 10:07:43+00:00
description: Facebook has rewritten their iOS app from HTML5 to native code to provide
  a faster user experience. Having actively promoted HTML5 development, this shows
  hybrid apps performance is still not good enough, but some ideas can be taken from
  this decision.
tags:
  - facebook
  - html5
  - hybrid apps
permalink: facebook-ios-html5-native
---

This week Facebook [announced an update for their iOS app](http://web.archive.org/web/20121019162440/http://newsroom.fb.com/News/A-Faster-Facebook-for-iOS-1b4.aspx) whose main change is a faster overall experience. Going deeper into technical details, we have "[Under the hood: Rebuilding Facebook for iOS](https://www.facebook.com/notes/facebook-engineering/under-the-hood-rebuilding-facebook-for-ios/10151036091753920)", a nice post explaining what changes have been done.

<!-- more -->
## Lessons learned from HTML5

I really recommend reading "[How Facebook Mobile Was Designed to Write Once, Run Everywhere](http://readwrite.com/2011/12/27/redux_how_facebook_mobile_was_designed_to_write_once_run/)" since it provides a better understanding about how Facebook mobile development has evolved. They found HTML5 to be the answer to share code between their mobile site and iOS app, developed as a hybrid app. After their experience on iOS, they decided to do the same with their Android app:

> But, this worked well enough that we said we are going to put the Android app on this party train too. So, we were actually able to write something like the m.site news feed once. Any time you change a news feed story or add a news feed story or add commenting and Liking or whatever, that is going to show up on low-end m.site, high-end m.site, Facebook for iPhone and Facebook for Android the very next day, or whenever we push, which is actually pretty awesome. - Dan Rowinski

This also worked for their iPad app, which was basically the iPhone app with a chat column on landscape mode. Relying on apps that were the glue between the hardware and a webview, made it possible to release minor changes often without the need of releasing a whole app update. So, even though now they have moved to a more native app, they still have provided ways to perform small changes transparently:

> [...] news feed is constantly evolving, and building more in Objective-C creates new challenges when we add in new features. To solve this, we came up with a different plan to let you use the newest features without requiring you to update the entire app: a "fallback" renderer. - [Jonathan Dann](https://www.facebook.com/notes/facebook-engineering/under-the-hood-rebuilding-facebook-for-ios/10151036091753920)

and they will still be using HTML5 in certain parts:

> For areas within the app where we anticipate making changes more often, we will continue to utilize HTML5 code, as we can push updates server side without requiring people to download a new version of the app. - [Jonathan Dann](https://www.facebook.com/notes/facebook-engineering/under-the-hood-rebuilding-facebook-for-ios/10151036091753920)

In fact Facebook has always defended HTML5 in order to circumvent application stores approval processes and offer a more unified experience across devices, with projects such as [Spartan](http://techcrunch.com/2011/06/15/facebook-project-spartan/), and pushing to create a benchmark showing mobile browsers capabilities with [Ringmark](https://developers.facebook.com/blog/post/2012/02/27/announcing-ringmark--a-mobile-browser-test-suite/).

## Rewriting the app from HTML5 to native code

Facebook's decision is similar to the one [using web technologies](/developing-mobile-webapp-first/) in those stages where changes are frequent is a nice idea. Once they knew how they wanted their app to look like and were confident enough, they moved to native, to offer a better user experience to user's of a certain platform. Thus, HTML5 version is still available for many other platforms, both as a website and as hybrid apps (for instance, iOS lower than 4.3) and is doing the job well.

A hybrid app can't offer the same performance as a native app. This is a matter of taking into consideration the pros and cons in terms of code reuse and best experience in every platform. Web implementations run on top of an additional layer, so native code is more likely to have a better performance to achieve the same result. That is why projects such as [Boot to Gecko](/boot-to-gecko-html5/) pretend to set an environment that exposes access to native hardware using Javascript.

There is an ongoing discussion about a deliberately decision from Apple and Google on [not making more efforts on improving Javascript performance on hybrid apps](https://web.archive.org/web/20150516201644/http://branch.com/b/a-blow-to-html5). Though it could make sense, I'd rather think this is not the case.
