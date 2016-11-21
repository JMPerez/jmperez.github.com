---
layout: post
title: 'Avoid showing address bar on iPhone when loading ajax'
date: 2011-06-11 18:28:08+00:00
description: Workaround to avoid showing the loading address bar when loading ajax content on iPhone.
tags:
  - ajax
  - facebook
  - ios
  - javascript
  - mobile
permalink: prevent-iphone-navigation-bar-ajax-link-click
---

You can find a [**demo** showing the default behaviour and the one using Facebook's technique]( /demos/iphone-links). Use an iPhone or iPod Touch to see the effect.

When clicking a link for ajax navigation on iPhone and iPod Touch, the navigation bar slides down and up for every link, even when they are enhanced to support ajax navigation and its click event is captured and we load content using XMLHttpRequest instead.

<!-- more -->
This is a bit annoying and some developers have already tried to solve it. See these links:

  * [Can iPhone Safari be prevented from showing the navigation bar during an AJAX call?](http://stackoverflow.com/questions/1788605/can-iphone-safari-be-prevented-from-showing-the-navigation-bar-during-an-ajax-cal)

  * [iOS urlbar shows then hides when clicking internal link](https://forum.jquery.com/topic/ios-urlbar-shows-then-hides-when-clicking-internal-link)

  * [Stopping the url bar from dropping down - I discovered a workaround](https://forum.jquery.com/topic/stopping-the-url-bar-from-dropping-down-i-discovered-a-workaround)

  * [How do i stop mobile safari from dropping down its URL/Loading bar whenever i submit an ajax request?](http://forum.jquery.com/topic/how-do-i-stop-mobile-safari-from-dropping-down-its-url-loading-bar-whenever-i-submit-an-ajax-request)

The fact of having an anchor with an href attribute is enough for Safari Mobile to show the bar unless the address is preceded by the hash sign. It is not the fact of changing the URL, because if you preventDefault() the click on the link and avoid the navigation, the bar is shown anyway.

I realized that Facebook, among others sites with iPhone adapted versions (see jQtouch, Sencha Touch or Twitter), didn't show that bar dropping from the top of the screen.

Looking at Facebook's mobile site code, I found out that they made a workaround. They attach to the touchend event, which is fired before the click event fires, and then replace the value of the href attribute:

```js
JX.install("MLinkHack", {initialize:function() {
  if(!JX.MTouchClick.hasTouchEvents()) {
    return
  }
  JX.Stratcom.listen("touchend", "tag:a", function(a) {
    var c = a.getNode("tag:a");
    if(c.getAttribute("target") == "_blank") {
      return
    }
    var b = c.getAttribute("href");
    if(!b || b.indexOf("#") === 0) {
      return
    }
    var d = JX.$U(b).getProtocol();
    if(d && d !== "http" && d !== "https") {
      return
    }
    JX.MLinkHack.add(c)
  })
}, statics:{_hack:"#!", add:function(a) {
  a.setAttribute("href", JX.MLinkHack._hack + a.getAttribute("href"))
}, remove:function(b) {
  var a = b.getAttribute("href");
  a = a.indexOf(JX.MLinkHack._hack) === 0 ? a.substr(2) : a;
  b.setAttribute("href", a)
}}});
```

Later, the href value is set back to its original value, calling to the `JX.MLinkHack.remove()` method:

```js
JX.behavior("m-link", function() {
  ...
  JX.Stratcom.listen("click", "tag:a", function(event) {
    if(JX.Stratcom.pass()) {
      return
    }
    try {
      var e = event.getRawEvent();
      var link = event.getNode("tag:a");
      if(link.getAttribute("onclick") || (e.which || e.button) &gt;= 2) {
        return
      }
      if(window.FW_BFF_ENABLED) {
        event.kill();
        FWBff.send("/fb/onclick", [link.getAttribute("href"), link.getAttribute("target")]);
        return
      }
      if(window.user_action) {
        user_action(link, "a", e)
      }
      JX.MLinkHack.remove(link);
      var href = link.getAttribute("href");
      ...
});
```

As we see, this is only done for touch devices. Non-touch devices see normal links, so we can provide the default navigation for the rest of devices. That is nice for our progressive enhancement approach.

This workaround works nice when applied to a hash based ajax navigation. In addition, if we want to use History API, then we could call `history.pushState()` in the click event, once we have replaced the href to its original value. That way we would use the hash as a temporary hack to prevent Safari browser from showing the bar. Have a look at this snippet:

```js
//hide bar on page load
setTimeout(function () {  window.scrollTo(0, 1);}, 500);

//attach event touchend
document.addEventListener(
	'touchend',
	function(e) {
		var target = e.target;
		while(target.nodeName !== 'A' && target.nodeName !== 'BODY') {
			target = target.parentNode;
		}
		if (target.nodeName === 'A' &&
			target.className === 'facebook') {
				target.href = '#!' + target.getAttribute('href');
			}
		},
	false
);

//attach event click
document.addEventListener(
	'click',
	function(e) {
		if (e.target.nodeName === 'A') {
			if (e.target.className === 'prevent') {
				e.preventDefault();
			} else if (e.target.className === 'facebook') {
				var href = e.target.getAttribute('href');
				if (href.indexOf('#!') === 0) {
					var newHref = href.substr(2);
					e.target.href = newHref;
					location.hash = newHref;
					e.preventDefault();
				}
			}
		}
	},
	false
);
```

I will try to check the techniques that other sites have implemented to solve this, but they might be similar to this one.

And I find this less hacky than using a 'link' attribute instead of 'href' attribute in anchors, or replace anchors by buttons, as I have read somewhere.

Want to see it in action? [**See the demo**](/demos/iphone-links).
