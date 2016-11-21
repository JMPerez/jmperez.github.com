---
layout: post
title: What I've been up to recently
date: 2015-06-27 12:55:00+01:00
description: Some open-source projects I have been working on recently. Rest APIs, ES6 and Audio API.
tags:
  - es6
permalink: what-i-have-been-up-to
---

Yes! It's been a while since I last posted on this blog. I haven't come up with new ideas for some time, but I do have been working on some projects I had on GitHub and needed a revisit.

<!-- more -->
## Calculating tempo of a song using Javascript

I recently realised the [site for calculating the BPM for a song](https://github.com/JMPerez/beats-audio-api) didn't work on iPhone. After some research it turned out that the audio `OfflineContext` behaviour is different on iOS mobile than in the rest of platforms. Also, I was composing a dynamic SVG that result in the browser rendering an empty SVG, ignoring its contents. Hopefully that's fixed now too.

## LinkedIn to JSON Resume

I am a big fan of APIs. Ever since I started using them for my end career project at University, I have worked both on implementing and consuming them.

Companies exposing their data through public APIs benefit from interesting integrations, expanding the platforms and use cases they have presence. But they are also afraid of giving out business core data for free.

[Twitter](http://thatmikeflynn.com/2012/08/17/oh-twitter/), [Netflix](http://techcrunch.com/2014/06/13/netflix-api-shutdown/) or [LinkedIn](http://thenextweb.com/dd/2015/02/12/linkedin-takes-aim-developers-plans-lock-apis/) are some well known cases of APIs that have introduced changes to become more restrictive. These changes are never welcome by developers, but nevertheless applications relying on any 3rd party API will always be prone to break.

So yes, the [the LinkedIn to JSON Resume exporter](https://github.com/JMPerez/linkedin-to-json-resume) broke because LinkedIn only allows apps access to a user's full profile if those apps are used as part of a "apply for this position" section of a company's site. That's even though the user is always in control of what data an application can access, using a permission dialog (OAuth scopes).

Luckily there is a way for users to export their LinkedIn data, and that's what the exporter tool is using. It was also my first project written using ES6 / ES.netxt / ES2015, which uses browserify + babelify to run the code on a browser.

The code is similar to _regular_ Javascript, with some syntactic sugar, but I think it was a good opportunity to get used to the new syntax and get on board with the latest additions to the language.

## RAML to Swagger

I have been exploring API specification languages for the creation of wrappers and documentation. [Michael Thelin](http://www.michaelthelin.se/?p=861) writes about how we are using RAML in Spotify for building the [Spotify Web API Console](https://developer.spotify.com/web-api/console/), which has results in open-sourcing [the RAML python parser](https://github.com/spotify/ramlfications) that [Lynn Root](https://github.com/econchick) developed as part of the console.

There are lots of tools built around RAML and Swagger for creating documentation, libraries, visualisations or even mock servers.

I didn't like the very few converters from RAML to Swagger, so I decided to start mine. Even though they are not fully equivalent, the [raml2swagger](https://github.com/JMPerez/raml2swagger) script does a decent job, and will allow us (and hopefully whoever needs it) explore the whole myriad of tools for API specifications, starting from a RAML spec.

---

That's all for now!
