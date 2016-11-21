---
layout: post
title: 'Modular Javascript + Grunt'
date: 2013-09-07 15:42:12+00:00
tags:
  - testing
  - workflow
permalink: writing-testable-javascript-grunt-workflow
---

Like if it was a new year's resolution, a few weeks ago I decided I
wanted to become a better JS programmer. It's not that I was a bad one,
but I felt I wasn't coding in a maintainable and testable way.

I wanted to make sure I didn't commit JS code with syntax errors, lint
errors or functional errors. And I think I have improved this a lot
after reading about writing testable code and embracing
Grunt.

<!-- more -->
## First things first. Read a bit on it.

It is definitely worth it reading if you care about testing JS code.
![Testable JavaScript by Mark Ethan Trostler](/assets/images/posts/testable-javascript.jpg)

I grabbed the [Testable JavaScript][] book and took it home. Read through it and realize I was
doing it wrong. I had implemented browser tests before using Selenium.
Those also cover indirectly your JS code, but they take longer to run
and introduce dependencies over other modules. They are good for testing
the whole thing, but not something that can be so quickly run that you
do it every time you save a file.

> Write code that you can test. If you can unit test it, better. You
> will end up with small modules you can reuse in other projects. - I
> said to myself

I have probably been coupling too much my JS code with the final output.
For instance, I was reluctant of creating new files only to get smaller
modules. I felt it wasn't worth it for the size of the components I was
making and there wasn't much reusable code across projects.

And I didn't like the idea of exposing variables and functions   which
were meant to be private, both because they increase the final code size
and because those functions are not to be used from outside.

> Write as many modules as you need. Each one of them in a different
> file with a single responsibility - I promised to myself

But by doing so, you can isolate a module, see at a glance what its
purpose is, and implement tests covering it without taking into account
how it is used in the context of the big webapp. Implement unit tests
for them. Each unit test covering one module. Implement mocks and stubs
for the modules the one your are testing depend on. Then, make you main
function depend on them.

## Improving your workflow

It feels very well when you manage to improve your daily workflow. I
didn't know until I was seeing myself more confident about the code I
was writing.

How? I run JSHint on the files as I save them. Lint them. Run unit
tests. Easily combine files and minify them. Using preprocessor? No
prob. Say hello to [Grunt][].

If you are not familiar with Grunt, check it out. And create a blank
project using it. In my case it was useful to see side by side a [basic
config for grunt][] and a more complete one created with the webapp
generator for [yeoman][].

There are plugins for most of the features you need. And if not, it is
quite easy to create one. In my case, I started with a basic
Gruntfile.js, and I tried to understand what was going on. I was
introducing plugins step by step, reading through the options for each
of them. These are the plugins I am using:

-   [JSHint][]: I was pretty happy just having this plugin. It keeps
    your code consistent with coding standards and makes it easy to spot
    syntax errors.
-   Unit test with [Connect][] + [Mocha][]: It makes it possible to run
    client side unit tests written using Mocha on a headless browser.
-   Combination + minification of CSS and JS with [usemin][]: It deals
    with concatenation and minification of static files, plus modifying
    the reference properly (i.e. from your index.html).
-   Asset revisioning with [rev][]: You change the contents of a static
    file, the name changes. No more 'clean the cache and try again'
    issues.
-   String replacement with [replace][]: Useful for basic string
    replacement. I use it to apply different values depending on whether
    I am going to run the code on a dev environment or on the live one.

If you are having problems with your workflow, maybe Grunt can help. In
my case it has enhance my productivity by not having to run manually
lots of commands, and to a web developer it feels more natural than
dealing with make files.

  [Testable JavaScript]: http://shop.oreilly.com/product/0636920024699.do
  [Grunt]: http://gruntjs.com/
  [basic config for grunt]: http://gruntjs.com/sample-gruntfile
  [yeoman]: http://yeoman.io/
  [JSHint]: https://github.com/gruntjs/grunt-contrib-jshint
  [Connect]: https://github.com/gruntjs/grunt-contrib-connect
  [Mocha]: https://github.com/kmiyashiro/grunt-mocha
  [usemin]: https://github.com/yeoman/grunt-usemin
  [rev]: https://github.com/cbas/grunt-rev
  [replace]: https://github.com/outaTiME/grunt-replace
