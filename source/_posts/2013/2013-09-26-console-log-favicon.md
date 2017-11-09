---
layout: post
title: 'Printing a message in the browser console with a favicon'
date: 2013-09-26 11:40:14+00:00
description: How to use custom styles in console.log to render a favicon with some text in the developer tools console.
tags:
  - console
  - favicon
  - firebug
permalink: console-log-favicon
---

I recently read [this Steve Souder's tweet](https://twitter.com/souders/status/378587712543944704/photo/1) about a `console.log()` message that Etsy is printing out to catch developer's attention. You can see it by visiting [Etsy.com](http://www.etsy.com) and opening the console from the developer tools. Another good one is [Pinterest](https://twitter.com/rosariomgomez/status/466254762367655936).

But I thought it would be even better to show the logo of the site next to the message.

<!-- more -->
## What we will be achieving
![Final result showing a console.log message together with a favicon](/assets/images/posts/console-log-favicon-final.jpg)

Continue reading to know how to achieve it, or have a look [at this jsFiddle](http://jsfiddle.net/J3yZP/).

## Basic idea, compatibility and limitations of the different consoles
You can use styles in the printed messages in the console, at least on Google Chrome and Firebug (support in Firefox is limited, see below). Each of them have a limitation when trying to render the favicon. The idea is to use a style that sets the logo as the background image. Then, set its size and add some margin between the logo and the text.

### Google Chrome
You can check out the [section about styling the console](https://developers.google.com/chrome-developer-tools/docs/console#styling_console_output_with_css) on Google Chrome. It works, but [it doesn't seem to support `background-repeat: no-repeat`](https://plus.google.com/+AddyOsmani/posts/TanDFKEN9Kn#z12wstwg0wr5g1xoy04cepzz1lamdxbqjjg#1365803568707861). So if we use `"%c text"`, the logo repeats all the way until the end of the string. Thus, we have to place the logo on the right side by doing `"text %c"`.
![Chrome doesn't interpret "background-repeat: no-repeat"](/assets/images/posts/console-log-favicon-repeat-chrome.jpg)

### Firebug
Firebug, however, doesn't support custom styles using `%c` in a position other than the start of the string, so we need to use `"%c text"`. In addition, neither margin-left, padding-left or text-indent push the string towards the right side to leave place to the logo, rendering the text on top of the logo. The hacky solution is to add whitespaces between the style and the text: `"%c   text"`.

## A solution that works on both browsers
I haven't found a proper way to detect that the browser is using Firebug. Even if there was, we don't know whether the user opened the Firebug console or the built-in one. Although Firebug also runs on Chrome, most developers use Chrome Developer Tools on Chrome, so with some user agent sniffing (I hate it, but I can't find a more suitable way) we can use one or the other version depending on whether the browser is Chrome or not.

Final result showing a console.log message together with a favicon:
![Final result showing a console.log message together with a favicon](/assets/images/posts/console-log-favicon-final.jpg)

In Firebug, the image needs to be left-aligned:
![In Firebug, the image needs to be left-aligned](/assets/images/posts/console-log-favicon-firebug.jpg)

Below is the code I am using to render the message together with a favicon, in this case Spotify's. You can see it in action [in this jsFiddle](http://jsfiddle.net/J3yZP/).

```js
(function() {
  var faviconUrl = "http://d2c87l0yth4zbw.cloudfront.net/i/_global/favicon.png",
      css = "background-image: url('" + faviconUrl + "');" +
            "background-repeat: no-repeat;" +
            "display: block;" +
            "background-size: 13px 13px;" +
            "padding-left: 13px;" +
            "margin-left: 5px;",
      text = "Do you like coding? Visit www.spotify.com/jobs";
  if (navigator.userAgent.match(/chrome/i)) {
    console.log(text + '%c', css);
  } else {
    console.log('%c   ' + text, css);
  }
})();
```

**Update May 8th 2014**: [Firefox 31 supports basic styling](https://developer.mozilla.org/en/docs/Tools/Web_Console#Styling_messages) in its console, without the need of using Firebug. However, it only allows a [subset of CSS rules](https://bugzilla.mozilla.org/attachment.cgi?id=8404667&action=diff#a/browser/devtools/webconsole/console-output.js_sec2) that doesn't include `background-image`. However, even though `background` is supported, `url()` [is not supported](https://bugzilla.mozilla.org/attachment.cgi?id=8404667&action=diff#a/browser/devtools/webconsole/test/browser_webconsole_console_custom_styles.js_sec1).
