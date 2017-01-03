---
layout: post
title: Assessing New Technology
date: 2017-01-03 9:10:00+01:00
description: It is easy to bless or criticise a piece of technology without understanding what they do. Let's change this.
image:
  url: /assets/images/posts/tools.jpg
  width: 640
  height: 426
permalink: assessing-new-technology
---

Try this library, it's the best thing ever. Try this technique, it will make your site automatically faster. I read and hear people praising libraries or technologies very often. It can come as a blog post, talk at a conference or informal conversation. It is fine to talk about the benefits of using A over B, but be alert if A doesn't seem to have any drawbacks.

<!-- more -->

![A picture of some tools](/assets/images/posts/tools.jpg)

I have done it myself. Most devs (at least web ones) are excited about the progress in network protocols, browser APIs and libraries amongst others. Gone are the days of building web sites for Netscape and <IE6 with FrontPage, debugging with alerts, requesting many unminified files. I don’t want to go back to those days, and I hope you do not either.

It might be that I'm getting old, grumpy and boring. Or "experienced" might be the word. I even think it might have to do with web fatigue (à la JS).

HTTP/2, React, AMP, BEM… every new thing seems to fix the pains of our web sites. **And we don’t do ourselves a favour when we jump on the bandwagon and amplify their benefits, without even trying them out**. Without being capable of understanding the effects of embracing them. The negative effects.

We shouldn’t become sales people, but engineers  with a toolset, aware of the limitations and trade-offs of each of them. **No single tool is the best one for every project**.

The contrary also happens many times. People will also criticise without having enough information, only because the general consensus is to be against it (eg using jQuery or Angular). Sometimes it looks like it's a "with me or against me" situation.

## Trade-offs and nuances
I appreciate it when people talk honestly about technology and don't get driven by the idea that the new thing is always better. Sure, it has been created for a reason, probably to fill a gap or improve a specific aspect, but it will likely come with some problems.

Everything is fine when you are implementing _Hello World_ (should I say also a _Todo app_)? However, it might not work for another project, like the one you are involved right now at your company.  Those need to be stable, scalable, testable and maintainable.

## Talking publicly about new tech - conferences and blog posts
I find it quite valuable when someone talks about using a certain technology applied to a real project. They are usually stories about illusions, obstacles, work-arounds, trade-offs. Those are close to real life experiences than what most sources will claim.

Before recommending a solution, make sure you know about its drawbacks. Don’t limit yourself to describe its benefits. **Tell how you tried to apply it, what issues you found and how you managed to solve or mitigate them**.

I like watching recorded talks from web conferences. I think that the best talks are those about real projects where something went wrong. Basically, any real project. Even better when the speaker works at a medium-size company, where projects are big large enough to have representative issues, and the company is small enough so the speaker can give details openly.

If you need some examples, check out these talks:
* [Michael Mifsud’s “Real World HTTP/2”](https://www.youtube.com/watch?v=3WIDa5-bPDs) on the effects of applying HTTP/2 to 99designs’s web site.
* Vitaly Friedman’s “How We Moved To HTTP/2 To Improve Performance… And Failed” on how [Smashing Magazine](https://www.smashingmagazine.com) was moved to HTTP/2 and had issues with web fonts and ads. Unfortunately, there is no recording, but his talk [Cutting-Edge Responsive Web Design](https://www.youtube.com/watch?v=a_1--3T8y6Y) covers some of these points.
* [Ally Palanzi’s Accessibility matters. Let’s do something about it](https://www.youtube.com/watch?v=skzcEKewOwc) on how to drive awareness about accessibility at a company and make it part of the development workflow.
* [Espen Brunborg, Gordon McLachlan and Bart Oleszczyk's Walking the Tightrope Between Mediocrity and Bankruptcy](https://vimeo.com/144499045) on the challenge to build good projects and keep clients happy.
* [Felipe Ribeiro's JavaScript @ Spotify](https://www.youtube.com/watch?v=9UsnX5X_DF0) on how Spotify embraced web to build the desktop client and the journey to balance teams autonomy and consistency in tech.

In short, look for content explaining issues encountered while adopting that technology.

## Assessing technology
When assessing a piece of technology like a library, framework, compression algorithm, etc, ask yourself these questions:

**How mature is it?**

In general, the longer it has been around, the more scenarios it’s been used on, more bugs have been fixed, more documentation is available and more people able to help you if issues arise.

> The nice thing about boringness (or constrained) is that the capabilities of these things are well understood. But more importantly, their failure modes are well understood — Dan McKinley on [Choose Boring Technology](http://mcfunley.com/choose-boring-technology).

The fact that it is used by a large company definitely helps getting some backing. Still, that company might have resolved issues with tooling that won’t necessarily share publicly.

**What will be the technical problems if I use it for my project?**

Performance issues? Increase in build time? Dependencies you don't control? Sooner than later you will need to dig into the internals of the technology to understand what is going on.

**Will it be embraced/enforced in my project?**

For this, other members in the project need to be knowledgeable so they can maintain it and apply it to new areas of the project. Otherwise it will become something you introduced that nobody feels comfortable with. That is why it is important to get buy-in from your colleagues, document the solutions and use tools like linters and checkers to enforce these solutions.

## Apply it to a small project
I’m not saying you shouldn’t try out that new shiny thing.

Let’s say React seems to solve some problems you are facing in a project, or at least that’s what you think after seeing all the hype about Facebook’s library. Try building first a side project with it, or a prototype that resembles the project you are working on. Don’t skip aspects like expressiveness, debuggability, performance, testability and scalability. Sure, it’s going to be very difficult to know about these unless you make the project larger, or do some research.

If you can’t spend your free time on a side project, ask for some time to work on a prototype. It will help if you time-box it, so your colleagues and stakeholders can expect some conclusions on a given date. Some companies also arrange hack days, hackathons or something like Google’s 20% that you can use to experiment.

## Conclusion
Let's try to get more informed about how every tool fits in our projects, their limitations and how to choose the most suitable one given a set of constraints. Our approach should be analytical, and not get driven by the novelty or the feeling of a few people.
