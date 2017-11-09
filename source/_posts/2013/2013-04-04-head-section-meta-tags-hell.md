---
layout: post
title: 'Polluting the head section for the sake of adding 3rd party services'
date: 2013-04-04 15:09:47+00:00
tags:
  - meta
permalink: head-section-meta-tags-hell
---

![Meta tags hell](/assets/images/posts/head-meta-tags.png)
The head section of a page is becoming the place to include information for integrating your page with external services. Thus, if you want to include support for [Facebook's Open Graph Protocol](http://developers.facebook.com/docs/opengraphprotocol/) or [Twitter Cards](https://dev.twitter.com/docs/cards), you need to include some custom meta tags inside the head section. This also applies to iOS large app icons or Microsoft shortcut integration.

<!-- more -->
Have a look at a page such as [this news on The Verge](http://www.theverge.com/2013/4/3/4179236/the-facebook-phone-is-coming-and-its-already-in-your-pocket/) and view its source HTML code. Removing common meta tags such as content type, favicon, RSS or description, we have this:

```html
<!-- Apple Touch Icon -->
<link rel="apple-touch-icon" href="/images/verge/apple-touch-icon.png" />

<!-- Windows 8 Pinned sites -->
<meta name="application-name" content="The Verge" />
<meta name="msapplication-starturl" content="/"/>
<meta content="name=Products; action-uri=/products; icon-uri=http://cdn2.sbnation.com/images/verge/favicon.vc44a54f.ico" name="msapplication-task" />
<meta content="name=Reviews; action-uri=/reviews; icon-uri=http://cdn2.sbnation.com/images/verge/favicon.vc44a54f.ico" name="msapplication-task" />
<meta content="name=Features; action-uri=/features; icon-uri=http://cdn2.sbnation.com/images/verge/favicon.vc44a54f.ico" name="msapplication-task" />
<meta content="name=Show; action-uri=/on-the-verge; icon-uri=http://cdn2.sbnation.com/images/verge/favicon.vc44a54f.ico" name="msapplication-task" />
<meta content="name=Forums; action-uri=/forums; icon-uri=http://cdn2.sbnation.com/images/verge/favicon.vc44a54f.ico" name="msapplication-task" />
<meta name="msapplication-TileColor" content="#666666"/>
<meta name="msapplication-TileImage" content="http://cdn3.sbnation.com/images/verge/windows8-pinned-icon.ve36f4a6.png"/>

<!-- Google Site Verification, used for Analytics and Webmaster Tools -->
<meta name="google-site-verification" content="TYyhlycNMOtUSht2aoB7heWTK8m-H45_YJizKavkO8s" />
<meta name="google-site-verification" content="IucFf_TKtbFFH8_YeFyEteQIwYPdANM1R46_U9DpAr4" />
<meta name="google-site-verification" content="TYyhlycNMOtUSht2aoB7heWTK8m-H45_YJizKavkO8s" />
<meta name="google-site-verification" content="tDoQLOfV4VmPZrTuSNDQnSyTfhgDRlOMaXgYQ0Bb9Bc" />

<!-- Verification for Bing -->
<meta name="msvalidate.01" content="D385D0326A3AE144205C298DB34B4E94" />

<!-- Verification for Yahoo! Site Explorer -->
<META name="y_key" content="0184e2558f89b639" />

<!-- Facebook integration -->
<!-- Note, same one as <meta name="description"> -->
<meta property="og:description" content="After a years-long lead up of false starts, half-measures, and rumors, Facebook&amp;#39;s phone plans will finally be revealed tomorrow. The event, in which Facebook promises to show off its &amp;quot;new home on..." />
<meta property="fb:app_id" content="179668695452017" />
<meta property="og:image" content="http://cdn0.sbnation.com/entry_photo_images/7969055/20121213-DSC_8473-3VERGE_large_large.jpg" />
<meta property="og:site_name" content="The Verge" />
<!-- Note, same one as <title> -->
<meta property="og:title" content="The Facebook phone is coming, and it&amp;#39;s already in your pocket" />
<meta property="og:type" content="article" />
<meta property="og:url" content="http://www.theverge.com/2013/4/3/4179236/the-facebook-phone-is-coming-and-its-already-in-your-pocket" />

<!-- Twitter integration -->
<meta name="twitter:card" content="summary" />
<meta name="twitter:url" content="http://www.theverge.com/2013/4/3/4179236/the-facebook-phone-is-coming-and-its-already-in-your-pocket" />
<!-- Note, same one as <title> -->
<meta name="twitter:title" content="The Facebook phone is coming, and it&amp;#39;s already in your pocket" />
<!-- Note, same one as <meta name="description"> -->
<meta name="twitter:description" content="After a years-long lead up of false starts, half-measures, and rumors, Facebook&amp;#39;s phone plans will finally be revealed tomorrow. The event, in which Facebook promises to show off its &amp;quot;new home on..." />
<meta name="twitter:image" content="http://cdn0.sbnation.com/entry_photo_images/7969055/20121213-DSC_8473-3VERGE_large_large.jpg" />
<meta name="twitter:site" content="verge" />
<meta name="twitter:creator" content="backlon" />

<!-- Sailthru integration -->
<!-- Note, same one as <title> -->
<meta name="sailthru.title" content="The Facebook phone is coming, and it&amp;#39;s already in your pocket" />
<meta name="sailthru.tags" content="general,general,the-verge" />
<meta name="sailthru.date" content="2013-04-03" />
<!-- Note, same one as <meta name="description"> -->
<meta name="sailthru.description" content="After a years-long lead up of false starts, half-measures, and rumors, Facebook&amp;#39;s phone plans will finally be revealed tomorrow. The event, in which Facebook promises to show off its &amp;quot;new home on..." />

<!-- Facebook shared/liked image -->
<link rel="image_src" href="http://cdn0.sbnation.com/entry_photo_images/7969055/20121213-DSC_8473-3VERGE_large_large.jpg" type="image/jpeg" data-width="300" data-height="250"  />
```

Of course, it is up to you to include this, and they may improve your user experience or increase the click-through rate. But I sometimes feel we are doing it wrong, and we shouldn't be including data for every request, just in case it is needed.

_Update 29 nov 2015: There is a way of reducing the amount of meta tags by combining some of them, and moving some others to a `manifest.json` file. You can read about this on [Metadata markup](https://adactio.com/journal/9881)._

For validating services, I think it is more sensible to just upload a file, instead of adding a meta tag that is served to everyone (and no one needs except for the validation service). For structured content I would personally prefer services to use a standard like [microdata](http://microformats.org/wiki/microdata)/[microformats](http://microformats.org/wiki/microformats) (which [Google Rich Snippets](http://support.google.com/webmasters/bin/answer.py?hl=en&amp;answer=99170) has proved to be very useful). In fact, [Schema.org](http://www.schema.org/docs/schemas.html) already covers some of the most popular types of content, adding structure and semantics.

Take this as a piece of information, so you can realize that adding this to every response, only for a few browsers/robots to understand, looks like a waste of bandwidth. Think it twice before blindly adding meta tags if you are going to make use of these services. And if you are a developer of these services, try to default to the `title` and `meta description` already provided by the page, instead of forcing the page to duplicate these values for your service.

If you need to include those tags, you have little room for savings. You can still save some bytes checking if it makes sense to include that data depending on the information we get from the request. Note that this often involves server-side user agent sniffing, which is pretty discouraged.

Facebook's Open Graph Protocol
------------------------------

There doesn't seem to be a way of detecting whether the request is coming from a Facebook fetcher at the moment.

Twitter Cards
-------------

Twitter uses Twitterbot to fetch the contents of your site when someone tweets a link to one of your pages, and they have just released [new card types](https://dev.twitter.com/docs/cards/types/product-card). They used to have information about the user agent used when scrawling Twitter Cards on [https://dev.twitter.com/docs/cards\#crawling](https://dev.twitter.com/docs/cards#crawling) but it seems to have disappeared after the launch of new Cards and the changes on their documentation site.

Other service-specific content that is added in the header
----------------------------------------------------------

### iOS Web Applications

There is a well-known way of [adding some features to iOS web apps](http://developer.apple.com/library/ios/#documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html), so when they are added to the Home Screen, they show a specific icon and they mimic a native application. Detecting this is reduced to check whether the device is an iOS device by looking at its user agent.

### IE9+ pinned tags on Windows 8+

You can integrate your website with [Windows 7 using Internet Explorer 9 creating pinned sites](http://msdn.microsoft.com/en-us/library/gg131029.aspx). Detect whether the user is using IE9 or a more recent one. You can skip OS check, so the only ones that will receive these without understanding it will be IE9 on Windows Vista.
