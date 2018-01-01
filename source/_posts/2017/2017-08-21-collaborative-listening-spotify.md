---
layout: post
title: Collaborative listening on Spotify using Connect endpoints
date: 2017-08-21 19:50:00+02:00
description: A project to create a collaborative room to listen to songs in sync using Next.JS and Spotify's Connect Web API endpoints.
permalink: collaborative-listening-spotify
image:
  url: /assets/images/posts/c-collaborative.png
  width: 1200
  height: 899
---

This is a post about a hack project I have been working on lately, and I wanted to share some information about why and how I built it.

tl;dr [Here is **the demo**](https://c-spotify.herokuapp.com) and [**the project on GitHub**](https://github.com/JMPerez/c).

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto,c_scale/v1510476635/c-collaborative_k8kxsa.png"
    sizes="(max-width: 768px) 100vw, 684px" alt="C, collaborative room to listen to Spotify"/>

<!-- more -->

<small class="caption">A screenshot of C, a simple collaborative room built using Spotify’s Web API.</small>

### Collaborative listening

The idea is basic. You go to a page where you can propose songs to listen to, and other people do the same thing. The playback is synchronised for all users that are connected in that moment.

These pages are called “rooms”, and are normally based on some genre, to guide users when proposing songs. You don’t want to hear “Despacito” in a the latest rock album in a “80s Classic Hits“ room. The songs that are going to play next, which are in a queue, can also be voted up (sometimes down too). Great if you don’t feel like proposing new songs but you see one you like in the proposed ones.

As I said, this is not new at all, and in fact it was part of Spotify’s desktop application since [end of 2011](https://www.youtube.com/watch?v=apvqiFsJcas), as an app called Soundrop:

<div class="videoWrapper">
  <iframe width="720" height="405" src="https://www.youtube.com/embed/cavizRODpL0" frameborder="0" allowfullscreen></iframe>
</div>

<small class="caption">Video showing the Soundrop Spotify App.</small>

The app was based on the now defunct [Spotify Apps API](https://developer.spotify.com/technologies/apps/). This set of tools allowed custom web apps to run in an isolated view on Spotify’s desktop application, being able to control playback and user’s library.

Soundrop as a collaborative app is no more. After the removal of the Apps API [they pivoted to a different product](http://www.show.co/blog/heavy-hearts).

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto,c_scale/v1510495292/spotify-app-finder_lfgest.jpg"
    sizes="(max-width: 768px) 100vw, 684px" alt="Spotify App Finder"/>
<small class="caption">List of the initial Spotify Apps. Source: [evolver.fm](http://evolver.fm/2011/12/02/spotify-apps-slated-to-roll-out-next-week/)</small>

The Apps API was the first project I worked on when I joined in Spotify in 2012. I would review submissions, support developers that had questions about how to use it, and create example apps.

The project [was discontinued end of 2014](https://techcrunch.com/2014/11/13/rip-spotify-apps-rip-soundrop/), and with it these integrations. The Apps API were replaced by mobile SDKs ([iOS](https://developer.spotify.com/technologies/spotify-ios-sdk/) and [Android](https://developer.spotify.com/technologies/spotify-android-sdk/)) and a [REST API](https://developer.spotify.com/web-api/), which we called Web API. The Web API had endpoints for fetching metadata and managing the user’s library through some scopes. If you have ever consumed any other API using OAuth 2.0, this one follows the same approach.

Though there were many endpoints added through the time, it was still impossible to control the playback through the API. This changed recently with the release of [the Connect endpoints](https://developer.spotify.com/web-api/web-api-connect-endpoint-reference/).

### Spotify Connect

Say you are playing music on your phone. You arrive home and want to start playing on your desktop application. You can transfer the playback from the phone to the desktop, which will pick it up from that moment. The combination phone ↔ desktop works also with speakers, video consoles and the Web Player, which makes this very powerful. These capabilities are called [Connect](https://www.spotify.com/connect/).

The Connect endpoints allow you to list the devices available for the user and transfer the playback between them. The set of endpoints is still in beta and subject to change, but it’s handy to work on a few hacks.

#### Now Playing

A few weeks ago [I published a post talking about a small library I built to fetch what you are playing on Spotify](/spotify-connect-api). The library is handy for not having to deal with the authorisation flow, and makes it easy to crease visualisations such as [this one](https://codepen.io/jmperez/full/MmwObE):

{% codepen jmperez MmwObE 0 result 389 %}

I created some other visualisations and organised them on [this Codepen collection](https://codepen.io/collection/AyVBYB).

### Implementing basic collaborative listening with Connect

Now that we’ve gone through an overview of what we want to accomplish and what tools we have available, let’s go for it.

When you log in with your Spotify account you will enter a room where y**ou can add songs and let the website control your playback** (you should have a Spotify application opened, like the mobile app, desktop app or [web player](https://open.spotify.com))

If you think about it, **a room for adding songs is basically a chat room**. Instead of sending regular text messages you send commands like “add song” or “remove song” and the server makes sure all connected users get the updates and are kept in sync.

One use case is using the demo only as a controller, and not a speaker. Imagine that we have a speaker at work. We might want to queue songs but not having them playing from our computer. That’s what the mute/unmute button does. It will mute or stop syncing your playback with the room’s playback.

Another feature, or lack of it, is that the controller is the web site and not the server. **Your playback will be synced with the room as long as you have the website open**. This could be changed by letting the server make these requests on your behalf. After all, it has access to your refresh token when logging in. However, it’s easy to forget that you didn’t log out from the demo and freak out when something is changing your playback randomly, so that’s why I didn’t take this approach.

A limitation is that the project only works with Spotify Premium accounts, [due to this restriction on the Connect endpoints](https://developer.spotify.com/web-api/working-with-connect/#Premium%20Only). You can still add songs, but the “play” command won’t work if your account is a free one.

**The Robot**

You are not alone in the room. **A bot called “Robot” is always online**, taking care of adding songs to the queue when it gets empty, based on previous submitted songs by users.

The data is provided by the Web API through its [Get Recommendations Based on Seeds](https://developer.spotify.com/web-api/get-recommendations/) endpoint. This endpoint returns a list of tracks that are based on a list of artists, genres and tracks, and you can set constraints on many music attributes.

Thus, you could want the Robot to put more energetic music on Fridays. Or have a robot adding recommendations based on Rock music in a Rock room. For this one, check out [the list of available genre seeds](https://developer.spotify.com/web-api/get-recommendations/#available-genre-seeds). At the moment there are 126 genres of them. Not bad!

**Future?**

The demo is basic. The design is unpolished and the site is limited to a single room. However, it’s easy to deploy on a custom instance and the main goal is to serve to others that want to integrate with Spotify’s APIs. It’s open source, so you can fork it and do as you wish.

The project would be easy to tweak to cover other use cases. One of them would be **synchronised sessions**. Say I listen to great music (no, I don’t) and someone wants to tune in and listen exactly to what I’m listening to. You _just_ need to assume every publishing user is a room, listen to changes in user’s playback and publish them, synchronising the subscribed users.

### Nerdy details

The project uses React + Redux for rendering, and Node in the backend,this is all done using [Next.js](https://github.com/zeit/next.js/), which also make Server-Side Rendering easy. An additional tweak is that React is replaced with Preact in production for a smaller payload. The whole thing is deployed on a Heroku instance.

One of the reasons I wanted to hack on Next.js was to have a better picture of its overhead. For this hack, the main page loads a bundle for the index page that is ~2.8kB minified & gzipped, and the common bundle which is 80.6kB minified & gzipped. It’s not the lightest alternative, but **Next.js is designed to scale well as you add more pages to your site**, due to how the bundles are split per page out of the box. Adding a large component to one page will not have an impact in the JS loaded for another page.

I have played with several ideas in the code base, that’s why it’s not very uniform and you’ll see, for example, several ways of doing CSS-in-JS.

I use this kind of hacks to give some new libraries and techniques a try, making them part of my tool belt and maybe using them in some real project. It’s also good to give Spotify’s Web API folks some feedback about the endpoints.

Regarding Next.js this project was pretty much an excuse to try out this library/framework. Yes, I could have picked any other project but my ideas always gravitate around Spotify-stuff. I wanted to see how opinionated it was, how SSR worked in that page-component pattern they use, and how it feels working with it.

#### Why Next.js

If you’ve ever tried to set up your own React.JS + ES6 + Webpack + react-intl + whatnot and have succeed without sweating, I’m your fan. Whenever I try, I always end up using some boilerplate project with everything in place.

I like [create-react-app](https://github.com/facebookincubator/create-react-app). It makes everything so easier, and you can always go leave the wizard mode by eject-ing. No lock-in.

I have been following Next.js from the distance. I would read about it, but never had the time nor the energy to give it a try. I decided it was about time I put it in practice.

![Learn Next.js](/assets/images/posts/learn-nextjs.png)

<small class="caption">[learnnext.js](https://learnnextjs.com) is a great interactive step-by-step tutorial. If I ever write a library I’ll make sure the tutorial is as great as the library itself, so it’s easy to learn and adopt.</small>

I started reading a bit and followed [LearnNext.js](https://learnnextjs.com). I found it too basic at first, then I jumped to the code, but quickly had to go back to the tutorial. It’s good not to take shortcuts. Their tutorial might seem easy but there are some concepts that are important, or you face problems soon.

The best resource I found for Next.js is [the examples folder in their repo](https://github.com/zeit/next.js/tree/master/examples). It’s pure gold. Lots of concise examples of how to use Next.js with pretty much anything. Pick ’n’ mix. I wanted to combine express + preact + redux + socket.io, and I had examples there for all of this.

I would say the most difficult part is when you realise that part of your code is running on the server. It’s quite surprising, but it’s what SSR is about. `localStorage` and `fetch` would fail, and other browser-only properties we are used to access when working with JS.

Overall I’m really happy. Most of your code is the same and you only need to adapt a bit to their routing. That’s what I like the most. It gives you the glue to put everything together, but you can still use the tools you are used to.

Zeit’s project are really awesome. Simple but extremely useful.

If you haven’t done it yet, have a look at [**the demo**](https://c-spotify.herokuapp.com) and [**the project on GitHub**](https://github.com/JMPerez/c).
