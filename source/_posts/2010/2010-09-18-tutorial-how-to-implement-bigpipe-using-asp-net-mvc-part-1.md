---
layout: post
title: 'Tutorial: Implementing Facebook''s BigPipe Using ASP.Net MVC - Part 1'
date: 2010-09-18 09:37:07+00:00
description: First part of the tutorial to implement Facebook's BigPipe using ASP.Net
  MVC. BigPipe improves pages loading time dividing them into regions that are generated
  on the server concurrently.
excerpt: Frist part of the tutorial to Build Facebook's BigPipe using C#. Source code to make pagelets and achieve delayed parallel execution in an ASP.Net MVC website.
tags:
  - bigpipe
  - facebook
  - flush
  - optimization
  - performance
permalink: tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-1
---

Parts of the tutorial

1.  Introduction to BigPipe
2.  [How ASP.Net MVC fits in the model. Registering and generating
    pagelets](/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-2)
3.  [Browser implementation of BigPipe. Loading pagelets and their
    resources effectively](/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-3)
4.  [Check out the demo Visual Studio solution](https://github.com/JMPerez/BigPipe)

Through a series of posts I will explain how we can implement BigPipe Facebook using ASP.Net MVC.

<!-- more -->
In this first post I will describe what BigPipe is and sketch how we can make a similar implementation using ASP.Net MVC.

You can clone the code from [the BigPipe project on GitHub](https://github.com/JMPerez/BigPipe)  that includes all the source code needed to run the sample.

## What is BigPipe
BigPipe is a [website performance technique](/techniques-optimize-web-sites) used and coined by Facebook to serve web pages improving user's perceived load speed. In general, it consists of serving quickly the main content of the page, and then serve the content from other regions of the page called pagelets.

The implementation of these pagelets is performed in parallel on the server and served to the browser as soon as they are generated. This allows:

1.  Browser can start rendering the page content earlier (early
    flushing)
2.  Pagelets are served as soon as they are ready and the browser can
    render them in their container.
3.  If one pagelet takes longer to run, it will not delay the generation
    of the rest of pagelets.
4.  Pagelets are generated in several concurrent asynchronous threads
    and when a thread finishes its execution, it flushes the content so
    the browser can start rendering.

Sequence of the different stages during a pagelet generation:

![Sequence of the different stages during a pagelet generation](/assets/images/posts/bigpipe-sequence.svg)

Apart from the pagelet generation, parallelism is also applied during the processing of the pagelet by the browser. Each pagelet can define a set of CSS and JS files that it needs to work properly. These files are requested in such a way that it keeps a good performance.

Graph showing how pagelets resources are requested:

![Graph showing how pagelets resources are requested](/assets/images/posts/bigpipe-pagelet-process.svg)

1.  For each pagelet, request in parallel every necessary CSS resource
2.  Once a pagelet has the necessary CSS files, inject the HTML code
    inside its container.
3.  When every pagelet has finished request its CSS files and is
    inserted in the document, proceed to request in parallel the JS
    files needed by the whole set of pagelets.

By keeping these steps we make sure that the pagelets are appended to
the document and set their style, avoiding a FUOC (Flash Of Unstyled
Content). By delaying the download of JS resources we are prioritizing
CSS requests for content be shown earlier, as well as other pagelets to
be downloaded.

### Requirements

Your browser must support Javascript, since the content is embedded
using Javascript. Our implementation takes into account progressive
enhancement to serve pages not using BigPipe for browsers without
Javascript or search engine bots (keeping SEO and accessibility).

### Benefits

-   Load time perceived by the user is better. Rendering earlier the
    main content of the page, browser starts making requests for
    resources CSS and Javascript earluer, as well as inerpreting the DOM
    tree.
-   We take advantage of the parallelism in the server side,  running
    simultaneously multiple pagelets.
-   In general, improving the parallelism of the system. As the browser
    renders a region, some others are being transmitted through the wire
    and some other being built in the server.
-   Everything is done in a single request by the client. You could
    implement BigPipe using Ajax calls from the browser to generate the
    pagelets, but at the expense of a greater number of requests (this
    will be covered in another post).

### Disadvantages

-   When you flush each pagelet more packets are sent from server to
    client (however we can always decide to send more than one pagelet
    in each flushing).
-   Browser has to interpret the code and insert pagelets in their
    containers. This causes repaintings and reflows which can be
    annoying to the user.

[In part 2 of the tutorial](/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-2) I explain how to use ASP.Net MVC to implement BigPipe, using RenderActions and threads pool to execute the pagelets.

#### Other resources

Some other people have implemented the basics of this technique using Java ([Bruno Fernandez-Ruiz](http://www.olympum.com/java/facebook-bigpipe-in-an-async-servlet) and [Stephan Schmidt](http://codemonkeyism.com/facebook-bigpipe-java/)) and using Node.js ([Subbu Allamaraju](http://www.subbu.org/blog/2010/07/bigpipe-done-in-node-js)).
