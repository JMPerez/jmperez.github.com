---
layout: post
title: Hiding the outline or :focus ring in an accessible way
date: 2017-08-14 19:50:00+02:00
description: A simple technique to hide the outline CSS property while making your website accessible when using keyboard navigation.
permalink: outline-focus-ring-a11y
image:
  url: /assets/images/posts/css-outline-focus.jpg
  width: 320
  height: 560
tags:
  - web
---

Last week I came across [Removing that ugly :focus ring (and keeping it too)](https://hackernoon.com/removing-that-ugly-focus-ring-and-keeping-it-too-6c8727fefcd2). It's a really good post about  `outline`, that CSS property lots of devs tend to hide. The post explains some a11y-friendly alternatives to not display it, and show it when needed.

<!-- more -->

In the past I have made the same mistake of hiding the `outline` altogether, but no more!

A few months ago I came across a similar technique David Gilbertson describes, while inspecting the markup on Youtube.com. They take accessibility seriously and their player is a very good example to get inspiration from.

I then applied it to one of the Spotify sites I work on. Take [this Spotify page as an example](https://open.spotify.com/track/2ZBNclC5wm4GtiWaeh0DMx?fo=1). This is how it works:

1. Add a `no-focus-outline` CSS class to the `<html>` element.
2. Hide the outline using CSS only in `<a>` and `<button>` elements that descend from that class.
3. When tabbing, remove the CSS class.

The complete code:

**CSS**
```css
.no-focus-outline a:focus,
.no-focus-outline button:focus {
  outline: none;
}
```

**JS**
```js
// Listen to tab events to enable outlines (accessibility improvement)
document.body.addEventListener('keyup', function(e) {
  if (e.which === 9) /* tab */ {
    document.documentElement.classList.remove('no-focus-outline');
  }
});
```

And a video showing what it looks like when tabbing:

<div style="text-align:center">
  <video width="320" height="560" controls src="https://res.cloudinary.com/jmperez/video/upload/v1510495843/css-outline-focus_olx6zh.mp4" />
</div>

Some additional a11y improvements are that I apply the same effect on hover and on focus, like when going through the "More by ..." albums section. Last, but not least, the track row acts as a button to start the playback.

These are some small touches that very few people will realise, but are not difficult to implement and can have a very positive impact for some users.
