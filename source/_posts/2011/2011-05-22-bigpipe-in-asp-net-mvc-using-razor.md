---
layout: post
title: 'BigPipe in ASP.Net MVC using Razor'
date: 2011-05-22 11:55:24+00:00
description: Razor to implement BigPipe using ASP.Net MVC. You can use the new view engine to early flush pagelets content and mimic this technique created by Facebook.
tags:
  - asp net mvc
  - bigpipe
  - razor
permalink: bigpipe-in-asp-net-mvc-using-razor
---

It's been some time since I posted the tutorial to implement [Facebook's BigPipe using Microsoft ASP.Net MVC](/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-1). And since then, Razor view engine has increased its presence for providing a way to implement cleaner views and make it easy to avoid ending up with spaghetti code.

Though now I am focused on PHP, in my previous job we decided to migrate to Razor as soon as possible since it is a more convenient way to implement ASP.NET MVC views, while you can keep your models and controllers code the same. However, Razor does not behave well with the proposed BigPipe solution due to its way of managing the partial views code. You can't write to the output in your inner views using Response.Write() nor flush because Razor renders pages from inside out. Thus, the inner most view is rendered and written to a buffer, and then the partial view / content place holder where it is defined, and so, until the outer most layout is reached. Then, the content of the buffer is written and flushed to the browser.

<!-- more -->
This provides the developer interesting new patterns. For instance, you can import JavaScript or CSS files depending on the content rendered in the views, and import them in the head section of your page, since when the layout is reached, we already know which dependencies to load to provide the functionality needed by the different elements of the page. Some days ago I received a message from **James Hull** ([@bigfellahull on twitter](http://twitter.com/bigfellahull)) explaining a way to achieve BigPipe using Razor.

Pagelets containers
-------------------

The way to define a pagelet container is the same. Just write the container out to the buffer and all is well.

```csharp
helper.ViewContext.Writer.Write("div id=\"" + pagelet.Container + "\"</div>");
```

Early flushing
-------------------
However, to perform the early flush and flushing each pagelet required a little thinking. James has been looking for a solution and he found out that the best approach is to manually write the buffer to the response.

So, in the layout (master) page, we can cast the ViewContext.Writer buffer to a string writer and then get the underlining string builder. Then you can write this string builder to the response, flush it and set the string builder's length to 0. This seems to be what razor does under the covers so we are just doing it a little earlier.

```csharp
var sb = ((StringWriter)ViewContext.Writer).GetStringBuilder();
Response.Write(sb);
Response.Flush();
sb.Length = 0;
Html.ExecutePagelets();
```

We can do the same with the pagelets,

```csharp
lock (_locker) {
  helper.ViewContext.Writer.Write(pagelet.Serialise());
  var sb = ((StringWriter)helper.ViewContext.Writer).GetStringBuilder();
  helper.ViewContext.HttpContext.Response.Write(sb);
  helper.ViewContext.HttpContext.Response.Flush();
  sb.Length = 0;
}
```

And now it works fine in razor!

I am really happy that James ([@bigfellahull](http://twitter.com/bigfellahull)) has been researching a way to port this technique to Razor, that is called to be the *de facto* ASP.Net view engine.
