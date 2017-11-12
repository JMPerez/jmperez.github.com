---
layout: post
title: Playing with the Spotify Connect API
date: 2017-04-22 00:10:00+02:00
description: The new Web API endpoints let you show what is playing in your Spotify account. It is easy to create views that update in real time.
image:
  url: /assets/images/posts/spotify-connect-api-visualisation-artist.jpg
  width: 1200
  height: 588
tags:
  - api
permalink: spotify-connect-api
---

Spotify [released recently a set of endpoints](https://developer.spotify.com/news-stories/2017/04/10/new-endpoints-beta-web-api-connect/) in beta to fetch information of what is playing and send playback commands. This allows for a wide range of integrations and I wanted to hack a bit with it.

![Spotify Connect](/assets/images/posts/spotify-connect.jpg)

<!-- more -->

#### What is Spotify Connect

[Spotify Connect](https://www.spotify.com/connect/) is a way to transmit the
playback from one device to another one without having to use a physical
connection like a cable or bluetooth. You can send the music from your Spotify
desktop client to a speaker, from the Spotify app on mobile to Spotify for
PlayStation, from the Spotify web player to Chromecast… In short, you have
controllers and devices that can play music.

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto,f_auto,c_scale/v1510477863/spotify-web-player_k5sx2j.png"
    sizes="(max-width: 768px) 100vw, 684px" alt="Spotify Web Player"/>
<small class="caption">Spotify’s Web Player (zoomed in). Clicking on the icon next to the volume we get a list of connected devices (FireTV, desktop client, speakers and the web player).</small>

Your application can become a controller through the Web API endpoints, getting
information about what is playing currently and from where, being able to
transmit the playback to another connected device or interact with the current
context (pausing, changing the volume, skipping, playing something else…).

#### How to use the endpoints

Before using the Connect endpoints we need to obtain an access token on behalf of the user with certain permissions. There is more information about what scopes are needed in the documentation for each endpoint.

You don’t need to have a premium account to get the playback status, a free account is alright. You will do need a premium one if you want to [send commands to change the playback](https://developer.spotify.com/web-api/working-with-connect/#premium-only).

A caveat at the moment is that the endpoints don’t support any kind of web socket connection nor long polling. Thus, if you want to get updates on the position of the current playing track or any other change in the context, you need to poll every few seconds.

#### A small library to make it easier to use the endpoints

The trickiest part of using the Spotify Web API is to implement the authorization flow. [The Authorization Guide](https://developer.spotify.com/web-api/authorization-guide/) does a good job explaining it, but I thought I could do something so developers wouldn’t need to worry about setting up the whole flow, hiding away the authentication and just getting.

That’s why I have created [spotify-player](https://github.com/JMPerez/spotify-player). It’s both a server and a library that you use to communicate with it. To use it, you just need to include a script, call login() and subscribe to the updates:

```html
<script src="https://spotify-player.herokuapp.com/spotify-player.js"></script>
```

```js
var spotifyPlayer = new SpotifyPlayer();

spotifyPlayer.on('update', response => {
  // render the track received
});

spotifyPlayer.on('login', user => {
  if (user === null) {
    // no user
  } else {
    // say hello to the user, and tell them to play something!
  }
});

spotifyPlayer.init();

spotifyPlayer.login();
```

You can forget about [setting up a Spotify application](https://developer.spotify.com/my-applications) and a server, carrying out the token exchange, token refresh, and persisting the current user, **so you can focus on the fun part**.

Other methods include a function to make calls to other Spotify endpoints reusing the same access token, so you can fetch other data that can help you creating a more complete visualisation.

Let’s have a look at [this pen](https://codepen.io/jmperez/full/MmwObE) as an example of a basic visualisation:

{% codepen jmperez MmwObE 0 result 389 %}

And in case you can’t try it or don’t have a Spotify account this is pretty much
what it looks like:

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto,f_auto,c_scale/v1510476629/spotify-connect-api-visualisation-example_hwu7uw.jpg"
    sizes="(max-width: 768px) 100vw, 684px" alt="Example of a visualisation of Spotify"/>
<small class="caption">See [the Pen on Codepen](https://codepen.io/jmperez/full/MmwObE)</small>

I have kept the example very basic since the point is understanding the usage of
the library. If you are into performance and UX you’ll see there is room for
improvement, but as a front-end developer I know an example can get out of hand
very easily when adding things.

I encourage you to fork it and start making your own visualisation. And once you
do it, ping me so I include it in [this Codepen collection](https://codepen.io/collection/AyVBYB).

### Possible applications

*Disclaimer: This is a list of some use cases. You still need to comply with [Spotify’s terms of use](https://developer.spotify.com/developer-terms-of-use/) when implementing
an application that uses Spotify’sWeb API. This might mean adding certain
messaging and link to the song in Spotify.*

#### Dynamic visualisations

You could combine the playback position with [the audio analysis of the track](https://developer.spotify.com/web-api/get-audio-analysis/) to generate dynamic visualisations using loudness, tempo, key, timbre or pitch of the segments that compose the track. You can also use [the endpoint to fetch audio features of a track](https://developer.spotify.com/web-api/get-audio-features/), which gives you high level information about characteristics of the song.

<div class="videoWrapper">
  <iframe width="720" height="405" src="https://www.youtube.com/embed/KO9huh-Y03g" frameborder="0" allowfullscreen></iframe>
</div>

<small class="caption">See [the Pen on Codepen](https://codepen.io/jmperez/full/GmJOMJ)
and [Possan’s original visualisation on GitHub](https://github.com/possan/webgl-spotify-connect-now-playing-screen-example)</small>

#### Now playing view

Are you a coffee-shop owner and people always wonder what song is playing? You could have a TV showing a branded now playing view. You could even have a widget on your website, or a script posting to a social network what is currently playing so your customers know. Or a small browser extension showing what is playing and/or [showing desktop notifications](https://developer.chrome.com/extensions/notifications) when the track changes.

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto,f_auto,c_scale/v1510477615/spotify-connect-api-visualisation-notification_mgxad5.jpg"
    sizes="(max-width: 768px) 100vw, 684px" alt="Spotify Visualisation showing Web Notifications when the track changes"/>
<small class="caption">See [the Pen on Codepen](https://codepen.io/jmperez/full/VbvPbR). When the track changes the browser shows a Web Notification.</small>

Or if you are at home hosting a dinner or party, show on the TV or computer what is playing.

You can combine other Spotify Web API endpoints too. Eg you could [fetch the artists info](https://developer.spotify.com/web-api/get-artist/) to show the artist profile image in the background:

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto,f_auto,c_scale/v1510477674/spotify-connect-api-visualisation-artist_ebk7cc.jpg"
    sizes="(max-width: 768px) 100vw, 684px" alt="Spotify Visualisation showing the artist profile image in the background"/>
<small class="caption">See [the Pen on Codepen](https://codepen.io/jmperez/full/YVXEaz).
    A simple visualisation of what’s playing in Spotify rendering the artist profile image as the background.</small>

You could use an API like [Musixmatch](https://developer.musixmatch.com/)’s and create an app or a website showing the lyrics for the current song, synchronised with the playback position.

And your imagination is the limit. Use [Genius’ API](https://genius.com/developers) to get [annotations](https://docs.genius.com/#annotations-h2) about a song, or search for trivia and more info about the song or artist using [Wikipedia’s API](https://www.mediawiki.org/wiki/API:Main_page). And if you don’t want to miss what’s happening in the world, implement a news ticker in your view using [News API](https://newsapi.org/).

<div class="videoWrapper">
  <iframe width="720" height="405" src="https://www.youtube.com/embed/q4I3ymLgewE" frameborder="0" allowfullscreen></iframe>
</div>

<small class="caption">See [the Pen on Codepen](https://codepen.io/jmperez/full/OmVKOO)<small class="caption">

#### MVP

[The library](https://github.com/JMPerez/spotify-player) is really small and it only supports *reading* the playback state and not send commands. Let’s call it an MVP. I might work on adding more features in the future.
