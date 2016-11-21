---
layout: post
title: 'Updates on BigPipe using ASP.NET MVC'
date: 2010-12-11 17:17:14+00:00
tags:
  - bigpipe
  - facebook
  - performance
permalink: updates-on-bigpipe-using-asp-net-mvc
---

It's been several weeks since I wrote [a tutorial to implement BigPipe using C# and ASP.Net MVC](/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-1). And I have just read [a PDF from a presentation at Velocity China](http://velocity.oreilly.com.cn/index.php?func=session&amp;name=Facebook%E7%BD%91%E7%AB%99%E7%9A%84Ajax%E5%8C%96%E3%80%81%E7%BC%93%E5%AD%98%E5%92%8C%E6%B5%81%E6%B0%B4%E7%BA%BF) in which Changhao Jiang, from Facebook, explains some details about Bigpipe, as well as other techniques they use to improve Time to interact (both real and perceived), as well as data savings. These techniques (named Quickling and PageCache) are based on hijax and an intelligent update of specific content of the page instead of the whole page when data changes.

<!-- more -->
According to Changhao Jiang, this is the improvement when using BigPipe on Facebook:
![Improvement when using BigPipe on Facebook](/assets/images/posts/bigpipe-tti-improvement-e1320910397828.png)

My first project using BigPipe as I explained is about to go online. Overall I can say that BigPipe approach has helped divide pages into independent chunks using RenderAction, opposite to overpopulating a single action to retrieve all data needed by the page. And I have faced some problems involving pagelet content.

##HTML to JSON
When using JavascriptSerializer (or JsonResult) to convert HTML content to JSON, the generated code is not as nice as Facebook's.

While yours will look similar to
```js
bigpipe.onPageletArrive({"Id":"my-pagelet","Content":"\\r\n\r\n\u003cdiv class=\"my-div\"\u003e\r\n    \u003c ...
```

Facebook's is more like this:
```js
bigpipe.onPageletArrive({"Id":"my-pagelet","Content":"<div class=\"my-div\"> ...
```

So (1) it can be a good idea to strip whitespace from your code and (2) maybe you would like to replace those \u003c and \u003e (see [this discussion at stackoverflow](http://stackoverflow.com/questions/1058895/cant-get-to-show-up-in-json-string) and [this other link](http://forums.asp.net/t/1440943.aspx)).

##Javascript code not being executed when appended to document using ajax
If your pagelet contains Javascript code, you'd better off moving it from the content of the pagelet to a javascript file to be downloaded and executed as I explain in the tutorial. When you append the content of the pagelet to the container, its Javascript code will not be executed, so take this into account.

In the next days I will update the code of the tutorial to include minor changes that I have found can improve it. And when I have more information about how my little bigpipe is performing I will write a post about it.
