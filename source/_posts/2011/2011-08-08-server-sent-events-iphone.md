---
layout: post
title: 'Server Sent Events on iOS'
date: 2011-08-08 19:13:31+00:00
description: Server Sent Events are fired on iOS even when the page is not active. Are there any good applications for this?
tags:
  - ajax
  - ios
  - polling
  - server sent events
permalink: server-sent-events-iphone
---

You have probably heard about web sockets, which promise to be a better  alternative to short and long polling to achieve real time updated  websites. But maybe you didn't know about **server sent events**. They are nice to send information from server to client using the same server  technology you probably have, using a lighter approach than polling.

[Here you can find a nice explanation](http://www.html5rocks.com/en/tutorials/eventsource/basics/), and you can give it a try by visiting this [Server-sent Event Demo](http://html5.firejune.com/demo/sse.html) from a capable browser.

<!-- more -->
## How iOS devices react to Server Sent Events

[[Server Sent Event on iPhone](/assets/images/posts/server-sent-events-iphone-200x300.png)](/assets/images/posts/server-sent-events-iphone.png)
_SSE will fire on iOS even if the page is not active_

Having a look at how iPhone behaves when using Server Sent Events I  realized that even if the tab showing a page using SSE is not the  active one, Server Sent Events are processed. In short, events are  processed as long as that page is loaded in any tab, no matter if it  focused or not, and even after Safari is closed using Home button or the  device is locked using the top button. The difference is that only when using Safari, a loading spinner is shown on top.

The behaviour of iPad is quite similar. It also processes SSE when it is locked or when a different tab is active, but it won't process them when closing Safari.

Is this how iPhone and iPad should behave? [According to W3C](http://dev.w3.org/html5/eventsource/), yes. They state:

> The "push proxy" service uses a technology such as OMA push to convey   the event to the mobile device, which wakes only enough to process the   event and then returns to sleep.

But I can't find out how this can be useful at all. If only a notification system was  available, a chat application could be implemented and notify the user  whenever other person in the chat mentions him. But currently there's no way a  non-active page can react to a server sent event, thus no useful event processing.
