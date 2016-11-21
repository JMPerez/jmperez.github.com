---
layout: post
title: Detecting tempo of a song using browser's Audio API
date: 2014-08-09 8:40:00+02:00
image:
  url: /assets/images/posts/bpm-detection-example.png
  width: 383
  height: 368
description: Article about project for detecting BPM of a track using the Audio API, in combination with the Spotify Web API.
tags:
  - spotify
  - bpm
permalink: bpm-detection-javascript
---

This article explains some ideas behind a small project to detect the tempo of a song using the Audio API. I recommend you to have a look at these links before reading the rest of the article: [Demo](http://jmperezperez.com/beats-audio-api/) and [Code on GitHub](https://github.com/JMPerez/beats-audio-api).
![Beat Detection Algorithm Example](/assets/images/posts/bpm-detection-example.png)

<!-- more -->
## Beat detection using Audio API

A couple of days ago I came across [Beat Detection Using Web Audio](http://joesul.li/van/beat-detection-using-web-audio/), a blog post by **Joe Sullivan** where he explained a simple algorithm to calculate the tempo of a song using the Audio API. After reading it, I was curious about how well the algorithm would work for other tracks.

So I sat down and coded a small project using his algorithms and adding a search box to search for songs, and display the result for them.

The algorithm is supposed to work better with the central fragment of a song. This avoids the parts with lower volume and fewer signals we can take to detect the beats.

## Searching songs and obtaining a preview MP3
The APIs of some music streaming services provide a sample of 30 seconds of every song in their catalog. We can't choose what 30 seconds of a track we want (i.e. what the starting point of the chunk is), but they will usually be a fragment of the most representative part of the song, and this is a good candidate for the algorithm.

The bitrate of the samples is rather low, around 96 kb/s according to my tests. I have tried to use them previously for my [karaoke project](http://jmperezperez.com/karaoke/), but the result was very noisy.

Since I'm more than familiar with the [Spotify Web API](https://developer.spotify.com/web-api/), I have chosen it for [searching tracks](https://developer.spotify.com/web-api/search-item/). The search is also quite flexible and normally is enough with the track name (without artist name) to find the song we want.

The Search endpoint returns a list of tracks, and their `preview_url` property points to an MP3 file that we can plug in straight to an `AudioContext` to process it.

## Calculating the tempo
I am following the algorithm described (in great detail) by Joe Sullivan. I have tweaked it a bit to:

1. **Dynamically adjust the threshold to identify peaks**: In some cases a threshold of 0.8 was simply too much and the amount of representative peaks returned too low for doing a proper guess. Thus, I lower the threshold until I have a few more peaks for the given sample.

2. **Round the theoretical tempo to the closest integer**. Otherwise it is rather impossible to get multiple intervals with the same value. At first sight we lose precision, but tempos are usually integers anyway.

To check how well the algorithm works I wanted to know the BPM of the song, calculated by some trustable source. Luckily enough, the same Spotify API provides an endpoint to [get Audio Features for a Track](https://developer.spotify.com/web-api/get-audio-features/). The first version of this project used The Echo Nest API to obtain the tempo of a song. Some time ago this API was discontinued, and this and other endpoints were merged into Spotify's Web API. That means we don't need to match track identifiers from different music services, making everything easier.

The endpoint returns a JSON object with several features of the track, including its `tempo`.

## Rendering the peaks and playing the track

From Joe's post, I really liked the simple graphs showing the peaks of a song as a way of representing what the algorithm was doing. I decided to do the same, and also add a button to play the track along with an indicator that goes through the graph and helps us see what peaks were detected by the algorithm.

## Enhancements?

I'm sure there must be better algorithms to find out the tempo of a song, but this one has proven to be very simple and effective for most of the "danceable" tracks, between 90 and 180 BPM. And I think it's a fun way to use the modern browser's recent APIs.
