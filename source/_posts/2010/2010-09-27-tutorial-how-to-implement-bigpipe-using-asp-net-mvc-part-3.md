---
layout: post
title: 'Tutorial: Implementing Facebook''s BigPipe Using ASP.Net MVC - Part 3'
date: 2010-09-27 19:25:11+00:00
description: Last part of my tutorial on Implementing BigPipe, focused on browser side, loading CSS and JS resources efficiently using a small script.
excerpt: Third part of the tutorial to Build Facebook's BigPipe using C#. Source code to make pagelets and achieve delayed parallel execution in an ASP.Net MVC website.
tags:
  - asp net mvc
  - bigpipe
  - facebook
permalink: tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-3
---

Parts of the tutorial

1.  [Introduction to BigPipe](/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-1)
2.  [How ASP.Net MVC fits in the model. Registering and generating
    pagelets](/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-2)
3.  Browser implementation of BigPipe. Loading pagelets and their
    resources effectively
4.  [Check out the demo Visual Studio solution](https://github.com/JMPerez/BigPipe)

In this third part of the tutorial to carry out a technique similar to BigPipe I will cover the browser side. BigPipe is not only focused on server side, but it also sets how the different resources that our pagelets need have to be requested and loaded in the document.

<!-- more -->
## Registering a pagelet and its resources
In the Pagelet class I will declare a constructor that accepts a list of CSS files and a list of JavaScript files needed by the pagelet:
```csharp
public Pagelet(string container, Func<string> action, IEnumerable<string> css, IEnumerable<string> js)
{
    this.Container = container;
    this.Action = action;
    this.Data = new Data()
    {
        Id = container,
        Css = css,
        Js = js
    };
}
```

In my sample code I am registering two pagelets in the View:
```csharp
<%  HttpRequest req = HttpContext.Current.Request;
    Html.RegisterPagelet(new Pagelet(
        "pagelet1-pagelet",
        () => Html.RenderActionToString(req, "home", "pagelet1"),
        new []{"../../Content/Pagelet1.css"},
        new []{"http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js",
                "../../Scripts/Pagelet1.js"}
    )); %>

...
<% Html.RegisterPagelet(new Pagelet(
    "pagelet2-pagelet",
    () => Html.RenderActionToString(req, "home", "pagelet2"),
    new[] { "../../Content/Pagelet2.css" },
    null
    )); %>
```

As I said before, `Html.Action()` method can be used to store the result
of an action in a string. However, it may throw exception if you use
multi-threading to execute the different pagelets since it doesn't keep
a reference to original request. In fact, we are storing the current
request in the `req` variable to avoid this exception when using
`Html.RenderActionToString`. If you'd rather use a single-threaded `for`
to go through the pagelets in the `ExecutePagelets` method (i.e. if you
see that parallel `for` implies too much overload), then go for the
`Action` method.

Facebook's approach
-------------------

In this tutorial I am implementing a simple solution covering BigPipe
principles from server to browser. However, Facebook's implementation
is far more complex, taking into account resource dependencies and
events. If we have a look at a sample call to their `onPageletArrive`
Javascript function, we can see that they pass a JSON object similar to
this one:
```json
{
    "id": ",
    "phase": 4,
    "is_last": true,
    "append": false,
    "bootloadable": [

    ],
    "css": [
        "MPQqY",
        "uwtW6",
        "wWhUT"
    ],
    "js": [
        "RpPeo",
        "C9ueD",
        "q+PxV",
        "Ok1Y0",
        "dOwRG"
    ],
    "resource_map": [

    ],
    "requires": [

    ],
    "provides": [

    ],
    "onload": [

    ],
    "onafterload": [

    ],
    "onpagecache": [

    ],
    "onafterpagecache": [

    ],
    "refresh_pagelets": [

    ],
    "invalidate_cache": [

    ],
    "content": [

    ],
    "page_cache": false
}
```

From there, we will cover `id`, `css`, `js` and `content` fields. Most
of the rest of fields are self-explainable, and they could be
implemented easily on our basic BigPipe implementation.

Javascript detection
--------------------

We will detect Javascript using a cookie that will be written using
Javascript. The first request to our page will not send that cookie, so
we will serve a non-BigPipe version. I prefer this to making a
redirection to the same page if Javascript is enabled.

In the Site.Master, just before ending body tag we can add the Javascript detection code:
```csharp
    <% if (Request.Cookies["js"] == null) { %>
    <script>
    var exdate=new Date();
    exdate.setDate(exdate.getDate()+90);
    document.cookie = "js=true;expires=" + exdate.toUTCString();
    </script>
    <% } %>
```

Loading CSS and JS
------------------

We will need a basic Javascript script that allows us:

-   Load in parallel the set of CSS resources needed by each pagelet
-   Append the HTML code of a pagelet inside its container
-   Request in parallel all the Javascript files needed by the set of
    pagelets, once they all have been appended to the document, and
    execute them

Moreover, the size of the script has to be as small as possible, since
it will be a blocking script.

```js
 var Loader = function () {
     var d = document,
         head = d.getElementsByTagName("head")[0];

     var loadJs = function (url, cb) {
         var script = d.createElement('script');
         script.setAttribute('src', url);
         script.setAttribute('type', 'text/javascript');

         var loaded = false;
         var loadFunction = function () {
             if (loaded) return;
             loaded = true;
             cb &amp;&amp; cb();
         };
         script.onload = loadFunction;
         script.onreadystatechange = loadFunction;
         head.appendChild(script);
     };

     var cachedBrowser;

     var browser = function () {
         if (!cachedBrowser) {
             var ua = navigator.userAgent.toLowerCase();
             var match = /(webkit)[ \/]([\w.]+)/.exec(ua) ||
				/(opera)(?:.*version)?[ \/]([\w.]+)/.exec(ua) ||
				/(msie) ([\w.]+)/.exec(ua) ||
				!/compatible/.test(ua) &amp;&amp; /(mozilla)(?:.*? rv:([\w.]+))?/.exec(ua) ||
				[];
             cachedBrowser = match[1];
         }
         return cachedBrowser;
     };

     var loadCss = function (url, cb) {
         var link = d.createElement("link");
         link.type = "text/css";
         link.rel = "stylesheet";
         link.href = url;

         if (browser() == "msie")
             link.onreadystatechange = function () {
                 /loaded|complete/.test(link.readyState) &amp;&amp; cb();
             }
         else if (browser() == "opera")
             link.onload = cb;
         else
         //FF, Safari, Chrome
             (function () {
                 try {
                     link.sheet.cssRule;
                 } catch (e) {
                     setTimeout(arguments.callee, 20);
                     return;
                 };
                 cb();
             })();

         head.appendChild(link);
     };

     return { loadCss: loadCss, loadJs: loadJs };

 } ();

 function PageLet(p, domInserted) {
     var data = p,
		remainingCss = 0;

     var loadCss = function () {
         //load css
         if (data.Css &amp;&amp; data.Css.length) {
             remainingCss = data.Css.length;
             for (var i = remainingCss; i--; )
                 Loader.loadCss(data.Css[i], function () {
                     ! --remainingCss &amp;&amp; insertDom();
                 });
         }
         else
             insertDom();
     }

     var insertDom = function () {
         document.getElementById(p.Id).innerHTML = p.Content;
         domInserted();
     }

     var loadJs = function () {
         if (!data.Js) return;
         //load js
         for (var i = 0; i < data.Js.length; i++)
             Loader.loadJs(data.Js[i]);
     }

     return { loadCss: loadCss, loadJs: loadJs };
 }

 var BigPipe = function (count) {

     var d = document,
        pagelets = []; 		/* registered pagelets */

     var onPageletArrive = function (p) {
         count = count || p.count;
         var pagelet = new PageLet(p, function () {
             if (! --count) {
                 //load js
                 for (var i = 0; i < pagelets.length; i++)
                     pagelets[i].loadJs();
             }
         });
         pagelets.push(pagelet);
         pagelet.loadCss();
     };

     return { onPageletArrive: onPageletArrive };
 };

```

Once minimized using Google Closure, the size is 1.27KB (666 bytes gzipped), so we have a very small script that fits our requirements.

Resources chart
---------------

The following chart shows how resources are loaded:
![Resources loading graph using BigPipe](/assets/images/posts/bigpipe-02.jpg)

We can see that the main document flushes early, starting the requests for Site.css
and BigPipe.js, which are in the head section of our view. When pagelets
are executed (I have set a Thread.Sleep in both pagelets) their CSS
resources are requested and only after they have been appended to the
document their Javascript resources are downloaded and executed.

Further improvements
--------------------

There are a lot of points that can be improved. I have thought of
several of them, what could lead to a more complex solution that can
provide BigPipe to ASP.Net MVC in a not so experimental way.

### Fire event before starting loading js for pagelets

Scripts that are needed by the page but do not need to be loaded before
executing pagelets can be delayed and be requested when the pagelets'
scripts are.

### Manage dependencies between scripts

As Facebook does, it can be a good idea to incorporate dependencies
solving logic to request and execute JavaScript resources in the best
order.

Avoid double insertion. If two pagelets require the same script, it is
only necessary to request once.

### Manage pagelets resources in a unique place

In my solution, pagelets' resources are specified in the view that is
including them. If we decide to change the implementation of a pagelet
and now we need a different set of resources (i.e. an extra JS resource)

Drawbacks of this implementation
--------------------------------

At first I see a performance problem when the browser does not support
Javascript. As we are registering pagelets as PartialViews rendered
inside the body ContentPlaceHolder, we have no way to include CSS
resources back to the head section, since it has already been generated.
So we have to include the CSS link elements inside the body, blocking
renderization.

The good thing is that we save bytes not writing script elements when we
detect the browser has JavaScript disabled.
