---
layout: projects
title: Projects - José Manuel Pérez Pérez
description: Some projects in which I have been working on
---

# Personal Projects

These are some personal projects I have been working on to learn more about certain libraries and browser APIs.

I like trying out "the last new thing" in a small project and publish it [on GitHub](https://github.com/JMPerez), both as a personal reminder of what I did, and to help people looking for examples.
{% raw %}

<h2>Music/Audio Projects</h2>
<ul class="projects">
  <li>
    <h3 style="margin-top:0">Spotify Dedup (mobile)</h3>
    <div class="description">
      <p>A mobile application to find and remove duplicated tracks from your Spotify library.</p>
      <p>I did this to get started building apps with React Native and Expo.</p>
      <div class="project-links"><a href="https://expo.io/@jmperez/spotify-deduplicator">Website</a><a href="https://github.com/JMPerez/spotify-dedup-mobile">GitHub</a></div>
    </div>
  <li>
    <h3 style="margin-top:0">BPM</h3>
    <div class="description">
      <p>Calculating the BPM of a song using Javascript.</p>
      <p>I did this to play with the Web Audio API and show a useful example of using the Spotify Web API.</p>
      <div class="project-links"><a href="https://jmperezperez.com/beats-audio-api/">Website</a><a href="https://github.com/JMPerez/beats-audio-api">GitHub</a></div>
    </div>
  </li>
  <li>
    <h3 style="margin-top:0">Karaoke</h3>
    <div class="description">
      <p>An exploration of audio manipulation using browser libraries to remove voices from songs.</p>
      <p>I did this to play with the Web Audio API... and to realise I'm not very good at singing.</p>
      <div class="project-links"><a href="https://jmperezperez.com/karaoke/">Website</a><a href="https://github.com/JMPerez/karaoke">GitHub</a></div>
    </div>
  </li>
  <li>
    <h3 style="margin-top:0">iQuiz</h3>
    <div class="description">
      <p>A fun quiz game about your saved Spotify playlists. Do you really know about your saved music).</p>
      <p>I did this to play with the Web Audio API and Speech Synthesis API.</p>
      <div class="project-links"><a href="https://jmperezperez.com/spotify-iquiz/">Website</a><a href="https://github.com/JMPerez/spotify-iquiz">GitHub</a></div>
    </div>
  </li>
</ul>

<h2>Some useful tools built as single page apps</h2>
<ul class="projects">
  <li>
    <h3 style="margin-top:0">Abrevio</h3>
    <div class="description">
      <p>A <a href="http://www.hemingwayapp.com/">Hemingway editor</a>-like for text in Spanish language. Get hints as you write to improve your text readability.</p>
      <p>This project is built as a PWA with offline support. It uses React and DraftJS.</p>
      <div class="project-links"><a href="https://abrevio.netlify.app/">Website</a></div>
    </div>
  </li>
  <li>
    <h3 style="margin-top:0">C - Spotify</h3>
    <div class="description">
      <p>A collaborative listening room using Spotify.</p>
      <p>This project uses Spotify's APIs to log users in, search tracks and play them on any device through Connect. It was also an excuse to try out Next.JS.</p>
      <div class="project-links"><a href="https://c-spotify.herokuapp.com">Website</a><a href="https://github.com/JMPerez/c">GitHub</a></div>
    </div>
  </li>
  <li>
    <h3 style="margin-top:0">Sync subs</h3>
    <div class="description">
      <p>A handy tool to apply an offset to a subtitle file.</p>
      <p>I did this to play with the File API, CommonJS modules (including testing), and Service Workers (offline support).</p>
      <div class="project-links"><a href="https://jmperezperez.com/sync-subs/">Website</a><a href="https://github.com/JMPerez/sync-subs">GitHub</a></div>
    </div>
  </li>
  <li>
    <h3 style="margin-top:0">LinkedIn to JSON Resume</h3>
    <div class="description">
      <p>An exporter from a LinkedIn profile to JSON Résumé.</p>
      <p>I did this to play with the File API and ES6.</p>
      <div class="project-links"><a href="https://jmperezperez.com/linkedin-to-json-resume/">Website</a><a href="https://github.com/JMPerez/linkedin-to-json-resume">GitHub</a></div>
    </div>
  </li>
  <li>
    <h3 style="margin-top:0">Spotify Dedup</h3>
    <div class="description">
      <p>A simple tool to remove duplicated tracks from a user's Spotify playlists.</p>
      <p>I did this to play with knockout and handling lots of async operations using promises.</p>
      <div class="project-links"><a href="https://jmperezperez.com/spotify-dedup/">Website</a><a href="https://github.com/JMPerez/spotify-dedup">GitHub</a></div>
    </div>
  </li>
</ul>

<h2>Spotify libraries and explorations</h2>
<ul class="projects">
  <li class="project-full">
    <p>Some libraries to make it easier to use Spotify's Web API:</p>
    <ul>
      <li><a href="https://github.com/JMPerez/spotify-player">spotify-player</a>, a library to interact with Spotify's player endpoint, with built-in authentication and token refresh. Ideal for codepen and any simple demo.</li>
      <li>An exploration of using Polymer to build components for Spotify: a <a href="https://github.com/JMPerez/spotify-search">search component</a>, a <a href="https://github.com/JMPerez/spotify-coverart">responsive cover art</a>, and a <a href="https://github.com/JMPerez/spotify-save-as-playlist">save a playlist button</a>.</li>
      <li><a href="https://github.com/JMPerez/thirtiflux">A basic Spotify Web Player using React and Flux</a></li>
      <li><a href="https://github.com/JMPerez/spotify-web-api-graphql">A proof of concept of a GraphQL provider for the Spotify Web API</a></li>
      <li><a href="https://github.com/JMPerez/spotify-web-api-js">A wrapper for the Spotify Web API in Javascript</a>, and a <a href="https://github.com/JMPerez/spotify-web-api-js-poc">proof of concept of a universal wrapper using ES6 and named exports</a></li>
      <li><a href="https://github.com/JMPerez/spotify-most-followed-popular-artists-genres">A visualization of most followed artists and genres in Spotify</a></li>
      <li><a href="https://github.com/JMPerez/extendify">Extendify</a> is a Chrome extension that adds a Spotify Play Button on Wikipedia and other pages to play music for songs, albums and artists. You can install it <a href="https://chrome.google.com/webstore/detail/extendify/jjajfginmjgdpblfanoimdanifdmcokd">from the Chrome Web Store</a>.</li>
    </ul>
  </li>
</ul>

<h2>Random things</h2>
<ul class="projects">
  <li class="project-full">
    <p>Other projects made just for fun:</p>
    <ul>
      <li><a href="https://github.com/JMPerez/js-crusher">A JS crusher</a> that can be used in JS1K contest submissions.</li>
      <li><a href="https://github.com/JMPerez/promise-throttle">A promise throttle</a> which is useful to avoid rate limiting when using REST APIs.</li>
      <li><a href="https://github.com/JMPerez/raml2swagger">A library to convert REST API definitions from RAML to Swagger</a>.
      <li><a href="https://www.gitbook.com/book/jmperez/wpo/">WPO Techniques: A list of good practices for improving website performance</a>.</li>
      <li><a href="https://perf.reviews/">Perf.reviews</a>: Youtube videos of Web Performance audits of real sites.</li>
    </ul>
  </li>
</ul>
{% endraw %}
