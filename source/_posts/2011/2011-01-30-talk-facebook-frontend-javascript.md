---
layout: post
title: 'Front End Tech Talk - Facebook'
date: 2011-01-30 17:29:22+00:00
description: Nice ideas taken from Facebook's Front End Tech Talk about implementing common interactions and patterns to reduce Javascript file size and use progressive enhancement.
tags:
  - bootloader
  - facebook
  - frontend
  - haste
  - javascript
  - primer
permalink: facebook-frontend-javascript
---

Yesterday I watched this [Front End Tech Talk by Facebook](http://www.facebook.com/video/video.php?v=596368660334). I found it very interesting because they explained how they faced the problem of having a lot of javascript code and how they managed to reduce it. I think this can be applied not only to a website of the size of Facebook's, but also any other project where we could refactor existing code.

> We had about 1MB of JS on the homepage

They realized they had a problem with so much JS code and they worked at different levels to shrink it.
[![We had about of 1MB of JS on the homepage](/assets/images/posts/facebook-1mb-javascript-1024x574.jpg)](/assets/images/posts/facebook-1mb-javascript.jpg)

<!-- more -->
## Haste

Haste is a package and dependency manager for CSS and JS files. In each file they specify the name of the package provided by the file and those files that are required to run the file. Thus, Haste can manage what files are needed to run a certain script.

This helps managing how files are requested and even which sets of files should be merged. This system was further explained by [Xiaoliang "David" Wei](http://davidwei.org/cv/talks/) at his talk about [_Static resource management & optimization_](http://velocity.oreilly.com.cn/2010/ppts/VelocityChina2010Dec7StaticResource.pdf) that took place on December 2010 at Velocity China.

## Bootloader

Bootloader consists of a JS library that helps loading and unloading static resources on demand. Not too far of RequireJS or LabJS. It uses dynamic script injection and executes a callback function once the resource is loaded.

The good point is that you can even suggest static resources that are not immediately needed but could be prefetched at background.

## Primer

Makinde Adeagbo [already talked about Primer at JSConf 2010](http://jsconf.blip.tv/file/3839676/) ([slides](http://www.slideshare.net/makinde/javascript-primer)).

A waterfall analysis showed that CSS resources where requested quite at the bottom and a lot of javascript on the head. Moving Javascript code to the bottom showed that the user interface would freeze while downloading/parsing/executing this code and that would provide a bad user experience. In some way, this is quite similar to what Yahoo! also found out, and I explained on my _[The not so good performance tips](/yahoo-tips-website-performance-flush-bottom/)_ post.

They decided to rewrite their JS code so that they could load a small file at the top that would provide the common functionality needed (about 80% of the interactions). And they moved Javascript client code to PHP code on the server. Instead of calling to a function like this one:
[![Before Primer](/assets/images/posts/prev-dialog-code-1024x574.jpg)](/assets/images/posts/prev-dialog-code.jpg)
_Javascript code to build a dialog_

they rewrote dialogs as anchors with a rel="dialog" attribute:
[![Dialog link using Primer](/assets/images/posts/after-dialog-code-1024x574.jpg)](/assets/images/posts/after-dialog-code.jpg) _Simplified code to mark a link as a dialog_

Basically they embraced progressive enhancement. This dialog links would be ajaxified later using a common Javascript code:
[![Adding dialog behavior using Javascript](/assets/images/posts/after-dialog-code-common-1024x573.jpg)](/assets/images/posts/after-dialog-code-common.jpg)
_Adding a listener to manage click events on links marked as dialogs_

And instead of letting Javascript set the title, content and the rest of dialog properties, it is the server the one that serves the dialog formatted as needed.
[![PHP code to generate a dialog](/assets/images/posts/dialog-server-code-1024x574.jpg)](/assets/images/posts/dialog-server-code.jpg)
_PHP chainable code to create a dialog and set different properties_

It is like converting a jQuery widget plugin into an ajax call and let the server generate the widget content.

They used this same approach to replace chunks of similar Javascript code. In async calls that retrieved html to replace existing markup, they are now generating javascript code (using PHP) on the server side and executing it in the async response. And if the url that should be requested when clicking an ajaxified link is a different one, they specify it using a custom `ajaxify` attribute. They also use this `ajaxify` attribute to specify that a form should be ajaxified.

Like Makindo says,

> if you are writing a site with tons and tons of Javascript it is very easy to forget about actual forms

All this common interactions are shown in the comments form:
[![Facebook's comment form](/assets/images/posts/application-comment-form-1024x573.jpg)](/assets/images/posts/application-comment-form.jpg)
_An example of common interactions that in their comment form_

The top red arrow indicates that Comment is a label, so clicking on it focuses the comment textarea.

Some sample Javascript code is available on [https://gist.github.com/376039](https://gist.github.com/376039).

They managed to not only reduce Javascript size, but loading CSS on the top and being able to load Javascript at the bottom in an async mode.

This talk shows that sometimes it is necessary to return to the basic elements and build interactions from there, trying to find common functionality to reduce the code needed, and embracing progressive enhancement as a way to achieve it.
