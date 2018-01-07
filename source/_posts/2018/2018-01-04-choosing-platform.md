---
layout: post
title: Choosing a Platform for Blogging
date: 2018-01-04 13:30:00+01:00
description: Why I keep my personal blog, use AMP, and cross-publish to Medium.
image:
  url: /assets/images/posts/tools.jpg
  width: 640
  height: 426
permalink: choosing-platform-blogging
---

Or why no single platform is the best one.

As a web developer I consider **[my personal website](https://jmperezperez.com) part of my portfolio**. It’s the canonical site where I write about the topics I care about. [It helps me remembering ideas and
resources](https://jmperezperez.com/personal-projects/). It also gives me a public presence on Internet beyond [LinkedIn](https://www.linkedin.com/in/jmperezperez) and [Twitter](https://twitter.com/jmperezperez).

But It’s not only about the contents. **It’s also about how they are delivered**. My blog is my playground, a space where I can play with browser APIs and put in practice ideas about accessibility and performance.

<!-- more -->

Several years ago I would use Wordpress to create the content, and wouldn’t care
so much about low-level stuff. After all, I was focused on doing .NET and Java
applications development, and didn’t care much about the web. Nobody read my
blog, and scalability or performance were topics that felt far.

### My Workflow

Fast-forward to these days I use a different workflow:

1.  I write my posts on my personal blog using Markdown. The blog uses
[Hexo](https://hexo.io/) behind the scenes, but this isn’t really important.
Most [static site generators](https://www.staticgen.com/) support Markdown these
days.
2.  Posts and pages are exported to a static HTML pages. As a bonus, an
[AMP](https://www.ampproject.org/) version is also generated. I use a [hexo
generator](https://github.com/tea3/hexo-generator-amp) that does the heavy
lifting to create an AMP-compatible version.
3.  After publishing it, I [import the post on
Medium](https://help.medium.com/hc/en-us/articles/214550207-Import-post).
Imported stories include a [canonical URL](https://support.google.com/webmasters/answer/139066?hl=en) pointing to the original post on my
blog. This is important so search engines don't see it as duplicated content. In 
other words, this is good for SEO.

This workflow seems a good compromise to me.

First, **I want to keep my blog as the canonical place where users will find the
content**. All publishing platforms I have used are still up and running today,
so this is not the issue. I like keeping a link back to my site, where I have
full control of what is delivered, and visitors can know more about me and my
projects.

Second, **I think AMP can be good for users to identify content that loads
fast** (more on this later). I have been following closely some runts about the
AMP format. I’m not a big fan of it, and I would prefer that Google displayed
somehow that a page result is fast enough, without having to be an AMP page.

Third, I don’t want to miss the network effect of a platform like Medium. Until
recently, very few visitors would access my site. When Google is your main
source you need to rank very well. I know enough about SEO to firmly belief
**that the best tip is to create useful content.**

Medium posts look beautiful with very little effort. More importantly, **Medium
has a great network effect**. It makes it easy for people to follow editors (at
least easier than having to subscribe to a RSS feed using some external app or
web) and the content can be showcased through tags. I definitely think that
using Medium has been key to get a higher exposure.

Medium also has [publications](https://toppub.xyz/) where you can submit your stories. An example is [Free Code Camp](https://medium.freecodecamp.org/how-to-get-published-in-the-freecodecamp-medium-publication-9b342a22400e) and [Hacker Noon](https://hackernoon.com/). They can give you feedback to improve your post, and will also do minor editings to make it more compelling.

<img style="margin:0 auto; max-width:300px" 
 src="https://res.cloudinary.com/jmperez/image/upload/w_auto,f_auto,c_scale/v1514724301/medium-stats_dko2nz.png"
    sizes="(max-width: 768px) 100vw, 684px" />
<small class="caption">A screenshot of my posts stats a little after I published that SVG post.</span>

I’m not trying to get as many visits as possible for the sake of it. I have
received lots of interesting comments about my posts on Twitter and Medium. And
these  posts have opened me the doors to speak at conferences, give interviews
and write guest posts. And I hope my posts have inspired and helped other
developers, the same way their contributions have shaped my knowledge.

#### A Word about Performance

As a web developer who likes to talk about Web Performance Optimization, I can’t
help keeping an eye on the platforms where I’m posting my content.

Interestingly, I’m not the only one who cares about it. Some users [discussed
the performance of the SVG placeholders post on
Medium](https://medium.com/@jmperezperez/using-svg-as-placeholders-more-image-loading-techniques-bed1b810ab2c):

> Am I the only person who finds it ironic that a web page about keeping web pages
> small comes with multiple megabytes of Javascript?

> It doesn’t need it, folks. It’s a static blog page.

> [Hacker News comment on Using SVG as image placeholders
> ](https://news.ycombinator.com/item?id=15699302)

In my defense I will say I have little control on Medium.com’s web performance.
Also, Medium’s strong point is not performance, as I’ll show in a moment.

I said earlier that I’m not a big fan of AMP. It is marketed as a project that
“enables the creation of websites and ads that are consistently fast, beautiful
and high-performing across devices and distribution platforms”.

Here’s a quick test I recorded using Webpagetest to measure how quickly the page
loaded on the 3 platforms:

<img
 src="https://res.cloudinary.com/jmperez/image/upload/w_auto,f_auto,c_scale/v1515069420/webpagetest-blog-amp-medium_ktuuib.jpg"
    sizes="(max-width: 768px) 100vw, 684px" /><small class="caption">[WebPageTest
run](http://www.webpagetest.org/video/compare.php?tests=180104_QD_5bacc8fc6eddec2cd66f1d5709164188,180104_YD_da5b176b352b4a2ea79154003240653a,180104_G7_9de5273b03f346f1e9e71bb7cd21420e)
of the same post on 3 different formats/platforms.</span>

As with Medium, AMP is a matter of trade-offs. I really like that the format
enforces good practices, and for most sites it will mean a faster experience.
And the fact that users can identify an AMP site with the thunder icon. T**he
biggest win for AMP is in organizations that would prioritize ads and tracking
pixels over performance.** In [Jeremy Keith](https://adactio.com/journal/9646)’s
words:

> Now when the boss says “Slap a three megabyte JavaScript library on it so we can
> show a carousel”, the developers can only respond with “Google says No.”

> When the boss says “Slap a ton of third-party trackers on it so we can monetise
> those eyeballs”, the developers can only respond with “Google says No.”

Of course, if you are a performance geek you can make things faster. Just keep
in mind that AMP is not a silver bullet. If you want to read more about AMP I
recommend you to check out [Chris Coyier’s “Need to Catch Up on the AMP
Debate?”](https://css-tricks.com/need-catch-amp-debate/).

#### Choose what is best for you

As with everything in this life, **every platform has its pros and cons**.
Hopefully my workflow can help you getting a more informed decision on where you
publish your content.
