---
layout: post
title: 'Response.Flush to make more responsive websites using ASP.Net MVC'
date: 2010-04-23 07:47:53+00:00
tags:
  - flush
permalink: making-more-responsive-websites-using-asp-net-mvc-response-flush
---

While I was watching a [Google I/O 2009 video](https://www.youtube.com/watch?v=aJGC0JSlpPE) by Steve Souders, the author of [High Performance Websites](http://oreilly.com/catalog/9780596529307) and [Even Faster Websites](http://oreilly.com/catalog/9780596522315), I really liked the fact of using **flushing** to send earlier the document to the browser, allowing a prefetching of external resources.
[![Response Flush in Google Chrome](/assets/images/posts/response-flush-short-300x101.jpg)](/assets/images/posts/response-flush-short.jpg)

<!-- more -->
I looked for the way of using flush in ASP.Net MVC as I am currently developing websites using this platform, and this can be accomplished by using `Response.Flush()`. The idea is to execute a flush in the view after some external files have been referenced. For instance we can call it after the head tag has been closed:
```html
<html>
  <head>
    <link href="reset.css" rel="stylesheet" type="text/css" />
    <link href="my-styles.css" rel="stylesheet" type="text/css" />
    ...
    <asp:ContentPlaceHolder ID="head" runat="server"></asp:ContentPlaceHolder>
  </head>
  <% Response.Flush(); %>
  <body>
    ...
  </body>
</html>
```
It can also be a good idea to call it before a bunch of code that will probably take some time to execute. However, remember that if this code contains database retrievals, this should be accomplished in the controller part, so that when the view starts rendering it has access to the data, stored in its ViewData. Anyway, you can call it in large pages, sending the document split in several parts.

I have found it useful to flush in the Site.Master, just before the ContentPlaceHolder that is used to render the main content, so the browser gets content to be shown to the user (the header) and some files to download (mainly CSS if JS are referenced at the bottom of the page). It is a good idea to parallelize the generation of the rest of the HTML code with the download of a heavy JS file (as it can be the case with jQuery) if it is referenced in the head section. Remember that is usually better to load JS files at the bottom of the document to prevent the browser being blocked while downloading javascript resources.
```html
<html>
  <head>
    <link href="reset.css" rel="stylesheet" type="text/css" />
    <link href="my-styles.css" rel="stylesheet" type="text/css" />
    ...
    <script src="Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <asp:ContentPlaceHolder ID="head" runat="server"></asp:ContentPlaceHolder>
  </head>
  <% Response.Flush(); %>
  <body>
    ...
  </body>
</html>
```
Flushing has its disadvantages. I find it a bit strange to just see the header in the page when it takes some time to load the page. Some people will argue that when navigating to a page it is better showing the user the current page while retrieving the next one and then update the whole page. Others will prefer the user to have quick feedback.

In addition, flushing is more useful when static files are not cached, but once they are cached the flush action will not fire any request to download cached resources, it will just make content appear faster in the browser, what in fact is nice.

According to [MSDN](http://msdn.microsoft.com/en-us/library/ms526001.aspx), `Response.Buffer` must be set to TRUE to use Response.Flush, but this is the default value since IIS 5.0. And we should take into account that

>_[using Response.Buffer]_ saves time because the server does not have to create a new connection for each client request
So this way we can manage the flushing and make it just when it can improve performance, without overloading too much the server.
