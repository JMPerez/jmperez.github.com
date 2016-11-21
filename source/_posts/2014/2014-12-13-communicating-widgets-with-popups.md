---
layout: post
title: On widgets, popups and communication between them
date: 2014-12-13 11:45:00+01:00
image:
  url: /assets/images/posts/iframe-widget.png
  width: 479
  height: 406
description: How to communicate from an iframe to a popup served from the same domain i.e. when using login forms in popups.
tags:
  - popup
  - iframe
permalink: communicating-widgets-with-popups
---

**tl;dr**: Communication between an iframe and a popup is not straightforward. If you are implementing a widget-ish element that needs to communicate with other page, Have a read at this (and test your solution on multiple platforms).

<!-- more -->
### An overview

Imagine you want to develop a widget that can be embedded as an iframe in any website. The widget consists mainly on a button that will perform an action. You have seen this before: _Like_ for Facebook, _Follow_ for Twitter, _Follow_ or _Share_ for LinkedIn.

When you click the button you will be prompted with a login form (if not logged in on the service) and after a successful login you will be liking/following/sharing what you wanted.

### On popups and redirections

You probably want the login form to be displayed in a not too intrusive way. You might want to embed it in an iframe, but this shouldn't be allowed by the service. An iframe would hide the URL of the login page, and URLs are a guarantee for the user that the form belongs to the site it is supposed to belong. Otherwise it would be hard to distinguish whether the login form comes from the real site or it is a phishing attempt.

The alternatives are opening a popup or redirecting the user to the login form. I personally like the popup solution. It doesn't cover the whole page, keeps the context of the widget at sight, and also keeps the state of the page.

Working with popups means that you need to think carefully what is going to happen from the moment the user clicks the button until you want to open the popup. As soon as a function execution is not a direct result of an action initiated by the user. This makes totally sense, since we don't want to see unsolicited popups opening while we see a page. As you see, we have again the browser preventing malicious behaviours, but making it difficult for developers that just want to use features for the good.

Opening a popup seems a plausible solution. The login form will return some type of identifier / access token to the iframe when the user logs in. It seems easy but...

### Defining the scenario

Let's suppose that the site `www.example.com` embeds an iframe (from now on, **the iframe**) served from `www.widget.com`. The iframe will try to open a popup (from now on, **the popup**) served from the same domain as the widget. That popup will show a login form and will try to communicate back to the iframe when the user logs in.
![A widget and a popup served from a different domain.](/assets/images/posts/widget-popup-different-domain.png)

### I didn't tell you about mobile

On a mobile browser, a popup opens a new tab, which is more suitable for their screen sizes. Apart from that, the OS can perform some optimizations to save memory and CPU due to foregrounded browser tabs.

Note: I haven't performed a deep research to see what combinations of operating system and browser exhibit each of these issues. But it's enough with one of them failing to try to implement a workaround.

#### `window.opener` is undefined

So you try this:

    var w = window.open(<login_url>,...)

then you would expect `<login_url>` to have access to `window.opener`. However, iOS won't keep a reference to the opener. This prevents us from exposing a function in the iframe that we can access from the popup.

Try it on [JSFiddle](http://jsfiddle.net/JMPerez/hgvsejvb/show/).

#### `storage` is not triggered when writing in `localStorage`
On iOS, don't expect a `storage` event to be triggered from the popup and capture it from the iframe. It won't.

#### window.open doesn't keep a reference to the popup

On Chrome for iOS, you would do:

    var w = window.open(<login_url>,...);
    console.log(w);   // prints undefined

`w` should have a reference to the opened popup, which we could use, for instance, to poll its `w.closed` attribute to see if the user has closed it. This would be useful to detect that the user ignored the login form. However, `w` won't store a reference to the popup on Chrome for iOS.

Try it on [JSFiddle](http://jsfiddle.net/JMPerez/4d0g5csa/show).

#### window.close doesn't work in the popup

On Safari for iOS you can't close yourself. This means that if you were thinking of passing the information to the iframe and then close yourself, you won't be able to do that.

Try it on [JSFiddle](http://jsfiddle.net/JMPerez/18yzm54k/show).

### More limitations

If you have read so far you will wonder whether there are still more issues. And yes, there are. One could assume that mobile browsers limit our functionality for saving resources, but now we have also the browsers using quite restrictive privacy preferences.

Welcome Safari 8 and IE 11.

#### Reading localStorage from a host different than the page's host will fail

Some browsers come with default privacy preferences that will prevent you from carrying out certain operations.
[![Privacy settings in Safari 8](/assets/images/posts/safari-8-privacy-settings.png)](/assets/images/posts/safari-8-privacy-settings.png)

In the image above you can see Safari 8's default privacy settings, with "Allow from websites I visit" checked.

You have learnt that passing messages from the popup to the parent is tricky. You then try to use `localStorage`. Then you realise browsers are blocking these read operations. Note that the iframe is served from a different host. The popup could write to localStorage, but the iframe served from the same host won't be able to read its value.

However, a `storage` event will be triggered when writing in localStorage containing the new stored value. You can read the new value when capturing the event, but not if you try to access localStorage afterwards. Weird, but this is how it works.

And even weirder is that even though localStorage is being blocked, from the iframe you are able to read cookies written from the popup. One would assume that the same limitations should apply to cookies, but that's not the case.

### What to do

So far, the best way I have found is:

- The popup will show a message like "If I don't close myself, close me".
- The popup will write cookies and will write to localStorage
- The iframe will listen to the `storage` event and will poll the cookies.

It's far from ideal but kind of works.
