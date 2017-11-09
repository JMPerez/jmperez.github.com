---
layout: post
title: 'Spotify Apps Development'
date: 2013-09-09 18:35:37+00:00
tags:
  - spotify
  - spotify apps
permalink: developing-spotify-apps
---

I have been working for some time with [Spotify Apps](https://developer.spotify.com/technologies/apps/). Creating them is a great way to extend the Spotify client with extra features using web technologies. As it exposes a Chrome-ish browser, you can tweak your apps and take advantage of running on a well-known environment.

<!-- more -->
## Developing apps for Spotify

Spotify desktop client includes a CEF engine that allows HTML5 web apps to interact through a JS API with the native layer. You can find more info on how to develop an app [on this tutorial](https://github.com/spotify/apps-tutorial).

## Optimizing apps

When your app is published, users can find it and add it to their desktop client. During installation, the app is downloaded and saved in the user's computer, while showing a loading bar. After being installed, users can open the app and make use of it.

In order to offer the best experience, there are some points that should be taken into account.

### Bundle size

It makes sense to try to optimize the size of the bundle so that it takes less time for the user to download it. Also, the less JS code to execute, the better.

In addition, since we know about the environment on which our app will run, we can take advantage of it in several ways. As of September 2013, Spotify 0.9.3 uses a Chrome v.27 browser.

### Javascript code

Of course it is a personal preference, but many developers don't conceive a web app without libraries such as jQuery. Amongst the reasons, we don't like to deal with incompatibilities on the targeted browsers. That is true when you need to take into account browsers like IE6/7, but in this case, the browser on which our web app will run is known and finite.

Thus, you can safely use a webkit-only library if you want an easier to use API, or you can even use Vanilla JS. I really recommend having a look at [Christian Heilmann's talk _Embracing and celebrating redundancy_](http://vimeo.com/40873227) and [this conversion table from jQuery to Javascript](http://sharedfil.es/js-48hIfQE4XK.html).

### CSS code

You can safely skip most browser prefixes. In this case, it doesn't make sense to include `-moz` or `-o` prefixes, since they will be skipped by CEF. Some CSS properties are supported with no prefix (i.e. `border-radius`), although some others aren't (`transition`). Thus, to make sure you are specifying the right rule, take a look at [caniuse.com](http://caniuse.com/). For instance, [this is the page for the transition property](http://caniuse.com/#search=transition).

I recommend you to use a CSS processor such as LESS, so you only define what rules are needed in one specific place.

### Further optimizations

Good web performance practices are quite well known and are the base for the emerging Web Performance Optimization techniques. Additionally, we could write about the best way to architect an app, with lazily loaded resources. Why load resources for every tab in a certain app, and not only the active one?

Ideally, an app should load the required content as fast as possible, and lazy load the rest as it is needed. Avoid loading bars, which are usually a smell of a bigger problem underneath, which is the one that should be targeted.

All in all, developing a Spotify app is quite similar to developing a web app, except that most assets are bundled in a package.
