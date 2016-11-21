---
layout: post
title: 'Tutorial: Implementing Facebook''s BigPipe Using ASP.Net MVC - Part 2'
date: 2010-09-22 19:34:36+00:00
description: Build Facebook's BigPipe using C#. Source code to make pagelets and achieve delayed parallel execution in an ASP.Net MVC website.
excerpt: Second part of the tutorial to Build Facebook's BigPipe using C#. Source code to make pagelets and achieve delayed parallel execution in an ASP.Net MVC website.
tags:
  - asp net mvc
  - bigpipe
  - facebook
permalink: tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-2
---

Parts of the tutorial

1.  [Introduction to BigPipe](/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-1)
2.  How ASP.Net MVC fits in the model. Registering and generating pagelets
3.  [Browser implementation of BigPipe. Loading pagelets and their
    resources effectively](/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-3)
4.  [Check out the demo Visual Studio solution](https://github.com/JMPerez/BigPipe)

In [the previous post of this tutorial](/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-1) I made an overview explaining how Bigpipe works and why it can improve users' perceived speed when loading our pages.

<!-- more -->
Basically Bigpipe combines early flushing, parallel processing and a managed resources loading in the browser to prioritize showing content quickly over loading and executing JavaScript files.

In this second post I will show how ASP.Net MVC features fit in the BigPipe model. Code snippets will help to illustrate he different parts. I will upload the source code in a Visual Studio 2010 project during the next days, so you can download it and further explore this technique.

View structure
--------------

Our view structure will be the usual when working with ASP.Net MVC:

-   `Site.Master`: Contains the skeleton of the HTML document. It will
    also fire the execution of the pagelets.
-   `SomePage.aspx`: Fills the ContentPlaceHolders of the Site.Master.
    It will include the different pagelets.
-   `Pagelet1.ascx`, `Pagelet2.ascx`... : The partial views that
    provides content to some areas that compose the page.

Pagelets as RenderActions
-------------------------

Our pagelets will be included using RenderActions. Pagelets are supposed
to take some time to be executed, so it makes sense that these will need
to access data in some way. These data will be retrieved in a controller
to keep MVC paradigm.

Registering pagelets
--------------------

First of all, we will declare a Pagelet class that is going to be used
to register the Pagelets. A pagelet will contain an instance of Data,
that will be serialized as JSON.

```csharp
public class Data
{
    public string Id { get; set; }
    public string Content { get; set; }
    public IEnumerable<string> Css { get; set; }
    public IEnumerable<string> Js { get; set; }
}

public class Pagelet
{
    public static JavaScriptSerializer jss = new JavaScriptSerializer();

    Func<string> Action { get; set; }
    public readonly string Container;
    public Data Data { get; set; }

    /// <summary>
    /// Manages a pagelet
    /// </summary>
    /// <param name=container>The id of the div container in which the output will be appended</param>
    /// <param name=action>The action to execute that will generate the output</param>
    public Pagelet(string container, Func<string> action)
    {
        this.Container = container;
        this.Action = action;
        this.Data = new Data() { Id = container };
    }

    public void Execute()
    {
        this.Data.Content = Action();
    }

    public string Serialize()
    {
        return <script> var js_pagelet =
            + jss.Serialize(Data)
            + ; document.getElementById(\
            + Container
            + \).innerHTML = js_pagelet.Content; </script>;
    }
}
```

The Js and Css arrays of strings will contain the files of these types needed by the pagelet to be styled and work correctly (in the next post I will make heavier use of these fields when covering the Javascript script).

The `Serialize()` method will generate the code to make the call to inject the code into its container.

Next, we will define some helpers that will be used to register the pagelet and store the output of the RenderAction call.

We want the rendered content to be converted into a JSON object so, instead of just rendering the action (writing the output directly to the response), we will render the action storing the result in a string. For this, we will use RenderActionToString.

We need a way to get the result of the RenderAction as a string. Following a similar method to the one used to [render a partial view to a string](http://www.klopfenstein.net/lorenz.aspx/render-partial-view-to-string-in-asp-net-mvc), we can declare extension methods to get the output of an action:

```csharp
public static class RendererHelper {
    /// <summary>Fake IView implementation, only used to instantiate an HtmlHelper.</summary>
    public class FakeView : IView
    {
        #region IView Members
        public void Render(ViewContext viewContext, System.IO.TextWriter writer)
        {
            throw new NotImplementedException();
        }
        #endregion
    }

    public static string RenderActionToString(this HtmlHelper helper, HttpRequest request, string controller, string action)
    {
        //Create memory writer
        var sb = new StringBuilder();
        var memWriter = new StringWriter(sb);

        //Create fake http context to render the view
        var fakeResponse = new HttpResponse(memWriter);
        var fakeContext = new HttpContext(request, fakeResponse);
        var fakeControllerContext = new ControllerContext(
            new HttpContextWrapper(fakeContext),
            helper.ViewContext.RouteData,
            helper.ViewContext.Controller);

        var oldContext = HttpContext.Current;
        HttpContext.Current = fakeContext;

        //Use HtmlHelper to render partial view to fake context
        var html = new HtmlHelper(new ViewContext(fakeControllerContext,
            new FakeView(), new ViewDataDictionary(), new TempDataDictionary(), memWriter),
            new ViewPage());
        html.RenderAction(action, controller);

        //Restore context
        HttpContext.Current = oldContext;

        //Flush memory and return output
        memWriter.Flush();
        return sb.ToString();
    }
}
```

HtmlHelper already has the `Action` method extension that gets the result of an action in a string, but it can be problematic when using multiple threads to execute the pagelets, as I explain in the [third part of this tutorial](/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-3).
```csharp
public static class BigPipeHelper
{
    public static void RegisterPagelet(this HtmlHelper helper, Pagelet pagelet)
    {
        var context = helper.ViewContext.HttpContext;
        bool jsEnabled = context.Request.Cookies[js] != null &amp;&amp; context.Request.Cookies[js].Value == true;

        if (!jsEnabled)
        {
            //JavaScript is not enabled, so we write the execution to the output and
            //not register the pagelet
            if (pagelet.Data.Css != null)
                foreach (string css in pagelet.Data.Css)
                    helper.IncludeCss(css);

            pagelet.Execute();
            context.Response.Write(string.Format(<div id=\{0}\>{1}</div>, pagelet.Container, pagelet.Data.Content));
            context.Response.Flush();
            return;
        }

        List<Pagelet> pagelets = (List<Pagelet>)context.Items[Pagelets];
        if (pagelets == null)
        {
            pagelets = new List<Pagelet>();
            context.Items[Pagelets] = pagelets;
        }
        pagelets.Add(pagelet);

        //write pagelet container
        context.Response.Write(<div id=\ + pagelet.Container + \></div>);
    }
}
```

We will use [HttpContext.Items](http://www.4guysfromrolla.com/articles/060904-1.aspx) to store the pagelets. The aspx page will decide to render each action or register a pagelet for later execution, depending on Javascript support. When using BigPipe we will choose the later one.

Then, in Site.Master, just before closing the body tag, we will make a flush so the browser can process the code generated so far, and then we will start executing the pagelets.

```html
  <% Response.Flush(); %>
  <% Html.ExecutePagelets(); %>
</body>
</html>
```

The pagelets will be executed in a set of parallel threads. Each thread will execute the render action and will write a Javascript call to process the pagelet. After writing this response, we will flush it so the browser can start processing the code for the just generated pagelet.

```csharp
static readonly object _locker = new object();
public static void ExecutePagelets(this HtmlHelper helper)
{
    var context = helper.ViewContext.HttpContext;
    List<Pagelet> pagelets = (List<Pagelet>)context.Items[Pagelets];
    if (pagelets == null) return;

    Parallel.For(0, pagelets.Count, (i) =>
    {
        var pagelet = pagelets[i];
        pagelet.Execute();
        lock(_locker) {
            context.Response.Write(pagelet.Serialize());
            context.Response.Flush();
        }
    });
}
```

Parallel.For (C# 4.0) creates a set of threads and continues with the next instruction once they all have finished. For each pagelet, we store in the Content field the result of executing its Action() method, this is, the output of the RenderAction. Next we write to the output the Data object as a JSON string and flush it.

### Implementing the browser side of Bigpipe
I did not want to make just a proof of concept of Bigpipe, but also implement a basic system that covers this technique from the server to the browser.

In the next post I will focus on the script that will manage the loading of CSS and JavaScript resources for the pagelets. This script is independent of the technology and programming language used on server. I will also show some resources loading charts to see how BigPipe affects this.

**Update September 26th:** I add a locker in the `ExecutePagelets` method to make response writing thread safe.

**Update September 27th:** I add support for javascript disabled browser, generating content immediately when registering pagelets in `RegisterPagelet` method.
