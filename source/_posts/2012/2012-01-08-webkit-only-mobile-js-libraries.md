---
layout: post
title: 'On webkit-only mobile javascript libraries'
date: 2012-01-08 16:39:02+00:00
description: Many mobile-focused JS libraries doesn't support Opera or Windows Phone 7. Thus, not all smartphones are covered.
tags:
  - js library
  - windows phone
  - wp7
  - zepto
permalink: webkit-only-mobile-js-libraries
---

During the last days I have been looking for a Javascript library targeted to recent mobile devices. Though I am familiar with jQuery, there is a lot of code that deals with browsers and issues that are specific to desktop browsers, but not to mobile ones, at least when working with browsers running on smartphones and tablets.
[![jQ.mobi demo running on a WP7 emulator](/assets/images/posts/jq-mobi-requires-webkit-browser-164x300.png)](/assets/images/posts/jq-mobi-requires-webkit-browser.png)

All of them work seamlessly on webkit browsers, which are the most broadly used ones, but only a few take into account Internet Explorer, Opera Mobile or Firefox.

<!-- more -->
## The current status of modern mobile browsers

Although there is a vast diversity of mobile devices, I will focus on those running on smartphones and tablets, which normally have a quite good support of HTML5 features and provide a native DOM selector through `document.querySelector` function.

There are nice sites showing comparison of different Javascript libraries for mobile, i.e [Markus Falk's](http://www.markus-falk.com/mobile-frameworks-comparison-chart/).

In my case I would like to find a library that works across all devices that support HTML5. I have been using [zepto.js](http://zeptojs.com) for some time. It is quite small and it has a jQuery-ish syntax. However, it lacks support of some HTML5 compliant browsers:

> Zepto supports Safari, Chrome, Firefox and Opera and any mobile WebKit-based browser, including iOS Mobile Safari, Android browser, HP webOS browser, Blackberry Tablet OS browser and others. Zepto does not support Internet Explorer.

You are the only one who knows better what platforms your products are targeted to and what browsers your visitors are using to reach your site. Just keep in mind that there are more players apart from webkit.

### Windows Phone 7

Not supporting Internet Explorer, Zepto doesn't support Windows Phone 7 devices. [WP7's browser](http://en.wikipedia.org/wiki/Windows_Phone#Web_browser) is an Internet Explorer version for mobile, that at least in its latest version 9 supports widely HTML5 features. At least from a mobile-targeted JS library point of view, it provides `document.querySelectorAll` and it is compatible with the standard way to add, for instance, an event using `element.addEventListener`.

Microsoft is working hard in order to provide Windows Phone 7 devices with a top browser that mobile specific libraries seem to ignore.

### Firefox for Mobile (aka Fennec)

By only supporting webkit devices, Mozilla's [Firefox for Mobile](http://www.mozilla.org/mobile/) is put aside, even though they are working hard on adding promising HTML5 APIs. Recently, I got the chance to play around with the Battery API, the Camera API and the Vibrator API checking out [John Hammink's demos](http://johnhammink.blogspot.com/2011/11/lets-have-look-at-some-recently-landed.html) using a nightly version of this browser on an Android phone.

### Opera Mobile

[Opera Mobile](http://my.opera.com/operamobile/blog/opera-mobile-11-for-android-and-symbian), being powered by a Presto engine, is also disregarded by webkit-only frameworks. And it seems they are doing a great job supporting HTML5 functionality. Seeing how they are performing in the [Android Market](https://market.android.com/details?id=com.opera.browser) with increasing download rates and good reviews, we should keep an eye on it.

## A tip for mobile JS libraries developers

It is clear that supporting more platforms means having to deal with specific browser's issues that may lead to more work to be done in order to maintain the library. Moreover, these libraries have a small size as one of its main constraints.

However, take into account that most recent versions of Internet Explorer and Opera Mobile have a similar feature set to the webkit's one, and adding support to them could be quite easy.

Having a look at their source code, I have seen that some libraries rely on non-standard features, like proprietary property [__proto__](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Object/proto), to provide a chain-able API and add custom functions like addClass or removeClass to an element, or ready to a document.

Take [zepto.js as an example](https://github.com/madrobby/zepto/blob/master/src/zepto.js#L74):

```js
function Z(dom, selector){
    dom = dom || emptyArray;
    dom.__proto__ = Z.prototype;
    dom.selector = selector || '';
    return dom;
}
```

The usage of `__proto__` to extend the DOM element by modifying the prototype chain doesn't work on IE or Opera, as a user [already pointed out](https://github.com/madrobby/zepto/issues/272).

This is an approach to avoid [extending the DOM](http://perfectionkills.com/whats-wrong-with-extending-the-dom/), defining every helper method in every retrieved DOM element, or implementing a wrapper around an HTMLElement like jQuery does with its jQuery object, but only supporting Gecko and Webkit browsers.

## A tip for webapps developers

I would like to tell developers that they should try to go the extra mile and consider supporting non-webkit mobile browsers. Definitely, manufacturers like Nokia are betting on WP7 (you only have to see their [Lumia 800 ad campaign](http://www.huffingtonpost.co.uk/2011/11/30/nokia-lumia-deadmau5-london_n_1120266.html)) and we could see an increase in IE mobile share. In addition, as browsers other than the default one can be installed on some devices like Android ones, opening the door to Opera Mobile and Firefox, we can't be sure that an Android user will be using a webkit browser.
