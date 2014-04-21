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

---

Parts of the tutorial

1.  Introduction to BigPipe
2.  [How ASP.Net MVC fits in the model. Registering and generating
    pagelets]({{ site.url }}/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-2)
3.  [Browser implementation of BigPipe. Loading pagelets and their
    resources effectively]({{ site.url }}/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-3)
4.  [Check out the demo Visual Studio solution](https://github.com/JMPerez/BigPipe)

Through a series of posts I will explain how we can implement BigPipe Facebook using ASP.Net MVC.

In this first post I will describe what BigPipe is and sketch how we can make a similar implementation using ASP.Net MVC.

You can clone the code from [the BigPipe project on GitHub](https://github.com/JMPerez/BigPipe)  that includes all the source code needed to run the sample.

## What is BigPipe
BigPipe is a [website performance technique]({{ site.url }}/techniques-optimize-web-sites) used and coined by Facebook to serve web pages improving user's perceived load speed. In general, it consists of serving quickly the main content of the page, and then serve the content from other regions of the page called pagelets.

The implementation of these pagelets is performed in parallel on the server and served to the browser as soon as they are generated. This allows:

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

<div class="svg-container"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 721 106" style="max-height: 106px; margin-bottom: 5%;">
 <g>
  <title>Sequence of the different stages during a pagelet generation</title>
  <path id="svg_6" d="m3.519989,3.55249l133.499985,0l44.500015,50.499496l-44.500015,50.500504l-133.499985,0l44.5,-50.500504l-44.5,-50.499496z" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#DDDDDD"></path>
  <text xml:space="preserve" text-anchor="left" font-family="Helvetica, Arial, sans-serif" font-size="20" id="svg_7" y="47" x="60" fill-opacity="null" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">Generate</text>
  <text xml:space="preserve" text-anchor="left" font-family="Helvetica, Arial, sans-serif" font-size="20" id="svg_8" y="71" x="60" fill-opacity="null" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">pagelet</text>
  <path id="svg_9" d="m137.519989,3.55249l133.5,0l44.5,50.499496l-44.5,50.500504l-133.5,0l44.5,-50.500504l-44.5,-50.499496z" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#BBBBBB"></path>
  <text xml:space="preserve" text-anchor="left" font-family="Helvetica, Arial, sans-serif" font-size="20" id="svg_10" y="47" x="188" fill-opacity="null" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">Send it to</text>
  <text xml:space="preserve" text-anchor="left" font-family="Helvetica, Arial, sans-serif" font-size="20" id="svg_11" y="71" x="188" fill-opacity="null" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">the browser</text>
  <path id="svg_12" d="m271.519989,3.55249l133.5,0l44.499969,50.499496l-44.499969,50.500504l-133.5,0l44.5,-50.500504l-44.5,-50.499496z" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#DDDDDD"></path>
  <text xml:space="preserve" text-anchor="left" font-family="Helvetica, Arial, sans-serif" font-size="20" id="svg_13" y="47" x="318" fill-opacity="null" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">Download</text>
  <text xml:space="preserve" text-anchor="left" font-family="Helvetica, Arial, sans-serif" font-size="17" id="svg_14" y="71" x="318" fill-opacity="null" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">CSS resources</text>
  <path id="svg_15" d="m405.519989,3.55249l133.500031,0l44.499939,50.499496l-44.499939,50.500504l-133.500031,0l44.5,-50.500504l-44.5,-50.499496z" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#BBBBBB"></path>
  <text xml:space="preserve" text-anchor="left" font-family="Helvetica, Arial, sans-serif" font-size="20" id="svg_16" y="47" x="462" fill-opacity="null" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">Append</text>
  <text xml:space="preserve" text-anchor="left" font-family="Helvetica, Arial, sans-serif" font-size="20" id="svg_17" y="71" x="462" fill-opacity="null" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">pagelet</text>
  <path id="svg_18" d="m539.519958,3.55249l133.500061,0l44.499939,50.499496l-44.499939,50.500504l-133.500061,0l44.500061,-50.500504l-44.500061,-50.499496z" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#DDDDDD"></path>
  <text xml:space="preserve" text-anchor="left" font-family="Helvetica, Arial, sans-serif" font-size="20" id="svg_19" y="47" x="595" fill-opacity="null" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">Download</text>
  <text xml:space="preserve" text-anchor="left" font-family="Helvetica, Arial, sans-serif" font-size="17" id="svg_20" y="71" x="595" fill-opacity="null" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">JS resources</text>
 </g>
</svg></div>

Apart from the pagelet generation, parallelism is also applied during the processing of the pagelet by the browser. Each pagelet can define a set of CSS and JS files that it needs to work properly. These files are requested in such a way that it keeps a good performance.

Graph showing how pagelets resources are requested:
![Graph showing how pagelets resources are requested]({{ site.url }}/assets/images/posts/bigpipe-pagelet-process-en1.png)

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

[In part 2 of the tutorial]({{ site.url }}/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-2) I explain how to use ASP.Net MVC to implement BigPipe, using RenderActions and threads pool to execute the pagelets.

#### Other resources

Some other people have implemented the basics of this technique using Java ([Bruno Fernandez-Ruiz](http://www.olympum.com/java/facebook-bigpipe-in-an-async-servlet/) and [Stephan Schmidt](http://codemonkeyism.com/facebook-bigpipe-java/)) and using Node.js ([Subbu Allamaraju](http://www.subbu.org/blog/2010/07/bigpipe-done-in-node-js)).
