---
layout: post
title: 'Using C3PO to load Spotify Play Button'
date: 2013-04-06 12:22:30+00:00
tags:
  - spotify play button
  - widgets
permalink: c3po-spotify-play-button
---

[C3PO is a small library developed by Stoyan Stefanov](http://www.phpied.com/c3po-common-3rd-party-objects/) (I bet you know him, otherwise you should) as a way of getting rid off 3rd party Javascript code to load social widgets.

It allows injecting these widgets as iframes, instead of defining their containers and use certain 3rd party JS code to create and inject those iframes. In addition, it provides a simple `parse` function that you can call whenever you want to initialize these widgets. In addition, it exposes a way to send messages from the widget to the parent page using `postMessage`. In his example, the widget sends a `resize` message, that the parent element captures and changes the size of that widget accordingly.

<!-- more -->
I wanted to give it a look and, while I was at it, try to include a Spotify Play Button using the same approach. And it turns out it works. Have a look at [this jsFiddle showing the button in action](http://jsfiddle.net/LZHgX/), along with the social widgets from [Stoyan's example](http://www.phpied.com/files/c3po/c3po.html).

In the case of the SPB widget, it doesn't really use 3rd party JS code to load it. The Embed Code, as provided in [its documentation page](https://developer.spotify.com/technologies/spotify-play-button/), consists of an iframe pointing to a url that receives a Spotify URI. Its dimensions are specified as attributes of the iframe. When the widget loads, it checks what the dimensions of its iframe are, and adapts the size (and the look) of the widget to the available size. I am setting these dimensions using CSS to its parent `<div class="spotify-play-button"></div>` element. Thus, if there is a JS error somewhere preventing the iframe injection, we won't show an empty box.

-   [Demo with the Spotify Play Button only](http://jsfiddle.net/9wT7z/)
-   [Demo with the Spotify Play Button together with the rest of
    widgets](http://jsfiddle.net/LZHgX/)
