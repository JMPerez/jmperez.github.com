---
layout: post
title: 'Mloc.js conference in Budapest'
date: 2013-02-17 16:05:54+00:00
tags:
  - conference
  - javascript
permalink: mlocjs-conference-budapest
---

These days I have been attending the [mloc.js conference](http://mloc-js.com/) in Budapest. It was a nice experience with a great organisation and good speakers working around Javascript limitations (more about that below).
![Welcome our heroes! at Terminal Building, Budapest](/assets/images/posts/design-terminal-welcome-heroes-300x171.jpg)

_Welcome our heroes! at Terminal Building, Budapest_

<!-- more -->
The mloc.js conference was quite focused on generating JS from compiled languages and programming paradigms for safer, faster, more productive development tools. Initially it also included multiplatform development using JS as a runtime environment.

Not much information about large scale applications on JS, and a lot about generating JS from compiled languages, often functional ones, to work-around the lack of static typing in JS. To name some of them: Scala, Haskell, F# and C#.

Lots of speakers were pointing out the limitation of Javascript in regards of typing, but instead of using what the language provides or extending it somehow, they encouraged developers to use a completely different language to generate Javascript. Then, it was needed to mock the interface of popular JS libraries so their code could still refer to these libraries and not break.

Even though I find this interesting, sometimes it became a bit too dense. I wondered many times the real application of such compilers, how they could help out when developing a large code base, and if it was really worth it trying to introduce them in a project.
[![Nick Fisher talking about the new design of Soundcloud](/assets/images/posts/nick-fisher-soundcloud-300x234.jpg)](/assets/images/posts/nick-fisher-soundcloud.jpg)
_Nick Fisher talking about the new design of Soundcloud_

I did like a lot talks around solving the so-called callback hell, improvements in Mozilla's SpiderMonkey, information about Bacon.js, a new compiler for CoffeeScript, and insights on how the new Soundcloud site was implemented.

The conference also included some 4-minute long lightning talks, and I gave one of them about web development in Spotify ([slides here](https://speakerdeck.com/jmperez/x-platform-web-dev-in-spotify)).

[On Lanyrd](http://lanyrd.com/2013/mlocjs/) you can find the whole list of talks and slides.
