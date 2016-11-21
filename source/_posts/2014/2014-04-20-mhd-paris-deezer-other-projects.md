---
layout: post
title: Music Hack Day Paris 2014 and other projects
date: 2014-04-20 10:20:00+02:00
image:
  url: /assets/images/posts/mhd-paris.jpg
  width: 2048
  height: 1470
tags:
  - spotify
  - music hack day
permalink: mhd-paris-deezer-other-projects
---

It's been some time since my previous post and I wanted to write a short one telling what has been going on.

## Personal projects

I have several small personal projects around Spotify in which I am working in my free time. I recently attended the Music Hack Day Paris 2014, where I coded [Spotify iQuiz](http://jmperezperez.com/hacks/iquiz/), an iQuiz-like web app that uses your Spotify playlists and to create some questions about albums and tracks you saved. I think the most fun part is the Speech Synthesis API, which provides a very easy to use text-to-voice feature, right on your browser.

<!-- more -->
For these hack projects I definitely need some framework on which build quickly a project. I always try to avoid it at first, and end up using a template engine (when I'm fed up of generating markup using JS), plus too many DOM manipulations and a bad time fixing small issues. This time I started from [this template I built](https://github.com/JMPerez/grunt-template), which was helpful for combining and minimizing all the small JS modules I created, and generate the files that I would deploy.

I'm also starting to take into account tests and code coverage earlier in the development process. I am applying it to the [spotify-web-api-js](https://github.com/JMPerez/spotify-web-api-js) project using grunt with mocha and blanket. I am running tests and checking the coverage from the console as I save files. I have unsuccessfully tried to generate LCOV that I can report to [Coveralls](https://coveralls.io/), and I think that having the output in the console is good so far.

## Paris

Well, and apart from that I got the change of visiting Paris again after 14 years!
[![Eiffel Tower](/assets/images/posts/mhd-paris.jpg)](/assets/images/posts/mhd-paris.jpg)
