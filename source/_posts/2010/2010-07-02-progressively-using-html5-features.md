---
layout: post
title: 'Using HTML5 features today'
description: You can already use different HTML5 to improve your websites. These are some
  that I have already started to use in several web applications, offering an equivalent
  functionality in older browsers.
date: 2010-07-02 11:17:27+00:00
tags:
  - cookies
  - html5
  - localstorage
  - progressive enhancement
permalink: progressively-using-html5-features
---

I have already started to use different HTML5 features to progressive
enhance web applications developed in my current job. HTML5 has a good
thing: users with modern browsers can enjoy enhancements without harming
those who use older ones. This allows you integrate new features
provided by HTML5 and don't worry about incompatibilities.

<!-- more -->
So far we are using:

-   **New input types**: though currently our customers use desktop
    browsers above all, these new input types degrade gracefully to
    typical input texts while showing a custom keyboard when you focus
    them using a mobile browser (ie: mobile safari). Thus, specific
    keyboard optimized to numerical, email address or url inputs
    provides a better experience if supported by the browser.
-   **Placeholder** attribute: Placeholder provides a straightforward
    way to show a hint to inform the users about the content the have to
    provide inside an input element (for instance you can place the
    label text or a date format). This is nicely supported in webkit
    browsers and can be easily implemented using javascript as a
    fallback.
-   **LocalStorage** vs cookies: LocalStorage is great to store current
    user browsing preferences like expanded/collapsed menus or selected
    tabs. It is much better than using cookies if you do not need to
    read their content in your server. This reduces data traffic in
    every request for resources residing in the same domain you set he
    cookie. A nice example is [the jQuery UI tabs plugin](http://jqueryui.com/demos/tabs/#cookie), which has
    an option to remember the selected tab using a cookie. This cookie
    would have to contain every selected tab in each of your pages.
    Another example is [the persistence approach that TreeView plugin
    takes](https://github.com/jzaefferer/jquery-treeview/blob/master/jquery.treeview.js#L191),
    also based on cookies. Why don't just use localStorage to
    keep that information? In addition, taking into account graceful
    degradation, cookies approximation can be used if localStorage is
    not supported by the browser (although even IE8 supports it
    currently).

HTML5 provides a bunch of other features you should be taking into
account in your projects. Maybe you don't find them useful at all, but
they can be the solution to problems you may encounter. Until IE9 starts
to take off and replaces IE8 (and especially, please, IE6 and IE7) we
will have to adopt HTML5 features progressively, trying to offer an
alternative implementation to those older browsers.
