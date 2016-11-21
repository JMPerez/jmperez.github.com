---
layout: post
title: 'AsyncController: Server-side parallelism'
date: 2010-12-24 16:28:37+00:00
tags:
  - asp net mvc
permalink: asp-net-mvc-async-controller
---

I usually face asynchronous WPO from the browser side, for instance making async requests to include Javascript files or AJAX-requesting any other content.

<!-- more -->
Today I have come across a feature that has been around since ASP.Net MVC 2 and that allows Asynchronous processing of controller actions. It is nicely explained on [Using an Asynchronous Controller in ASP.NET MVC](http://msdn.microsoft.com/en-us/library/ee728598.aspx) on MSDN website.

It is very useful on long-running requests, since it avoids thread-blocking while the request is being processed. In addition, it exposes AsyncManager, that can be used to increase parallelism in an action by splitting the execution of independent operations.
