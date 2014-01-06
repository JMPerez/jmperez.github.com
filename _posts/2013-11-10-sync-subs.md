---
layout: post
title: 'Pet Project: Sync Subs'
date: 2013-11-10 20:06:33+00:00
tags:
  - amd
  - file api
  - github

---

I have been working recently on [Sync Subs](http://jmperez.github.io/sync-subs/). It is a website that allows you to synchronize a file with subtitles (in SRT format) applying a time offset:

[![Sync Subs - A Subtitles Synchronizer web app]({{ site.url }}/assets/images/posts/sync-subs.png)](http://jmperez.github.io/sync-subs/)

There are lots of websites doing this by letting a user upload a file and then applying the transformation server-side. But with the HTML5 File API you can do this client-side. Thus, you can read the contents of a file, process it and let the user download a file that has been dynamically generated using Javascript in the browser.

I have also been experiencing with Javascript modules written in an AMD style, unit testing, and integration of external services such as [Travis](https://travis-ci.org/JMPerez/sync-subs) (for continuous integration) and [Coveralls](https://coveralls.io/r/JMPerez/sync-subs) (for code coverage).

The code is on [Github](https://github.com/JMPerez/sync-subs) for you to play around with it.
