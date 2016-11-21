---
layout: post
title: Using ES6 today
date: 2015-07-20 10:20:00+02:00
description: Setting up ES6 in your next web project isn't that difficult... if you know how.
tags:
  - es6
permalink: use-es6-today
---

Yesterday I was reading [How to Use ES6 for Universal JavaScript Apps](https://medium.com/javascript-scene/how-to-use-es6-for-isomorphic-javascript-apps-2a9c3abe5ea2) and decided to create [a small template](https://github.com/JMPerez/es6-template) from which I can start a project using ES6 both client and server-side. _Note: You can replace the term "ES6" with ES2015, ES.next or whatever it's called today, you get the idea._

<!-- more -->
Although everyone is promoting ES6 nowadays, the truth is that using it in a real project is not that straightforward. I spent some time with [LinkedIn to JSON Résumé](https://github.com/JMPerez/linkedin-to-json-resume) trying to figure out how to easily compile to ES5 and how to import modules as defined in ES6 instead of NodeJS's `require`.

Generally speaking I haven't been a big fan of CoffeeScript. Nor LESS nor SASS. I could use them in a small project to understand their reason to be, but I haven't enough reasons to sell it to my colleagues when building or rewriting a real project.

It's not that it doesn't have its advantages, it's that today the hot thing is X and tomorrow is Y. I'm even using `Makefile` in some projects just to not have to decide between `grunt` and `gulp`.

Sticking to the standard does make sense. And using tools to polyfill it until it becomes a reality in all modern browsers.

So I can't but recommend you start to get familiar with ES6 and try to apply it in small projects first, to get used to it and be better prepared for the coming ES7.
