---
layout: post
title: 'Web technologies behind Google+'
date: 2011-07-02 18:59:19+00:00
description: What web technologies are behind Google+ website? This is a collection of links to posts explaining interesting features of this brand new network site.
tags:
  - google
  - google plus
permalink: google-plus-technology-overview
---

We are all excited about the Google+ release, and this is a nice opportunity for web developers to find out how some of its more interesting features have been implemented.

I am trying to collect information about implementation details for every innovative functionality that makes Google+ push the limits of web development.

<!-- more -->
Meanwhile I am trying to get useful conclusions by seeing their CSS and JavaScript code and the flow of HTTP requests. Until now I haven't seen especial things involving static resources like images (not using [WebP](http://code.google.com/speed/webp/)), CSS or JavaScript files. I can only say that CSS and JavaScript files are greatly minified, squishing their content to the last byte.

Feedback system

Google Plus feedback system is brilliant. It is very easy to use for low-tech users thanks to their highlight / black out feature and area selection, and useful for Google due to the information they retrieve from the browser, HTML structure and javascript log.
[![Creating a feedback message in Google+, blacking out and highlighting certain areas](/assets/images/posts/feedback-test-1024x572.jpg)](/assets/images/posts/feedback-test.jpg)
_Creating a feedback message in Google+, blacking out and highlighting certain areas_

I find it very interesting how they are taking a screenshot of the web page when you preview the feedback message:
[![Preview of a feedback message in Google+, showing a screenshot of the web page](/assets/images/posts/feedback-test-preview.jpg)](/assets/images/posts/feedback-test-preview.jpg)
_Preview of a feedback message in Google+, showing a screenshot of the web page_

There exist tools like [html2canvas](http://html2canvas.hertzen.com/) that allows the creation of screenshots by reading the DOM tree and applying CSS rules.

More info:

  * [How does the Screenshot part of the Google+ Feedback system work?](http://stackoverflow.com/questions/6527742/how-does-the-screenshot-part-of-the-google-feedback-system-work)

## Google Circle animation

It is nice how fluid the interface is when creating circles and dragging people into them. The animations are very smooth and it is a pleasure to use it, making something that was tedious a fun experience.

More info:

  * [Is the Google+ circle animation implemented in JavaScript or Flash?](https://www.quora.com/Is-the-Google+-circle-animation-implemented-in-JavaScript-or-Flash)

## Google Hangout

This is a feature that extends Google Talk video chat to make it possible to video chat with up to 10 people. This represents a big effort in terms of bandwidth and lag avoidance.

More info:

  * [The technology behind Google+ Hangouts](http://gigaom.com/video/google-hangouts-technology)

## Accessibility

The use of ARIA attributes in the HTML code (aria-haspopup, aria-owns, aria-owner) makes me thing they have take accessibility as a priority. This is in line with their effort for spreading the word about developing accessible websites, as they explained in their talk [Creating Accessible Interactive Web Apps using HTML5](https://www.youtube.com/watch?v=lMrkCoqgoxw) in the recent Google I/O 2011 conference.

## JSON responses forcing AJAX calls

If you inspect the JSON responses content, you will see that they start with

> )]}'

This seems a way to force requests to be made using Ajax calls and avoid retrieving data using script tags, that would result in a error being thrown. This is similar as how facebook adds an infinite loop to their JSON responses using

> for (;;);

More info:

  * [Strange JSON response in Google Plus](http://stackoverflow.com/questions/6618441/strange-json-response-in-google-plus)

## Indexability

Try to disable JavaScript and you'll see that you can't even log in Google+. However, public profiles (make a [basic search for site:plus.google.com](http://www.google.es/search?q=site:plus.google.com)) work quite well when disabling JavaScript. Tabs link to pages where content is loaded correctly, except for Photos and Videos tabs, so that search engines can view and index the most important part of the profile information.

Google has even add [a parameter to look for Google+ profile pages](http://searchenginewatch.com/article/2082771/Deconstructing-Google).

## Tools used to implement Google+

Google+ has been implemented using a set of tools that are mostly open source. In the server side, they use Java Servlets, [BigTable](http://en.wikipedia.org/wiki/BigTable) and [Colossus](http://www.cs.cornell.edu/projects/ladis2009/talks/dean-keynote-ladis2009.pdf). Google+ seems to be using GSE ([Google Servlet Engine](http://code.google.com/p/opengse/)) according to the 'Server' response header when requesting the root page.

And in the client side, they use [Closure](http://code.google.com/closure/).

More info:

  * [Google+ is Built Using Tools You Can Use Too: Closure, Java Servlets, JavaScript, BigTable, Colossus, Quick Turnaround](http://highscalability.com/blog/2011/7/12/google-is-built-using-tools-you-can-use-too-closure-java-ser.html)

  * [I'm a technical lead on the Google+ team. Ask me anything.](http://anyasq.com/79-im-a-technical-lead-on-the-google+-team)

  * [Google+ social network in depth](http://stackoverflow.com/questions/6545811/google-social-network-in-depth)

Have you come across some Google+ implementation detail that should be highlighted? Don't hesitate to comment to this post!
