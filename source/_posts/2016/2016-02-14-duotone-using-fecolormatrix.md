---
layout: post
title: Spotify's new brand identity using feColorMatrix SVG filters
date: 2016-02-14 12:40:00+01:00
description: Using feColorMatrix SVG filters to apply a duotone effect to an image.
image:
  url: /assets/images/posts/duotone.jpg
  width: 887
  height: 501
tags:
  - svg
permalink: duotone-using-fecolormatrix
---

This is a short post where I show how to use SVG and a `feColorMatrix` filter to apply a duotone effect to an image.

<!-- more -->
Demo & Code: [http://codepen.io/jmperez/pen/LGqaxQ](http://codepen.io/jmperez/pen/LGqaxQ)

You may have seen that the [Spotify's new brand identity](http://www.fastcodesign.com/3043547/spotifys-new-look-signals-its-identity-shift) is full of duotone images. My colleague Thodoris described how to achieve this effect [in JS](http://blog.72lions.com/blog/2015/7/7/duotone-in-js) and [in iOS](http://blog.72lions.com/blog/2015/7/18/duotone-in-ios).

The JS version uses `<canvas>`, and after reading [A List Apart's Finessing feColorMatrix](http://alistapart.com/article/finessing-fecolormatrix), where they also mention the duotone images used in [Spotify's Year in Music](https://yearinmusic.spotify.com), I forked [Thodoris' pen](http://codepen.io/72lions/pen/jPzLJX) and used `feColorMatrix` instead:

{% codepen jmperez LGqaxQ 0 result 367 %}

The code consists of a `<svg/>` that has an `<image/>` to which we apply a `<filter />`. The filter uses a `feColorMatrix`, and its values are calculated using JS, though if you already know the range of colours you want to apply there is no need to run JS, just set them in the markup. If you have any issues understanding how the matrix is calculated, check [this question on StackOverflow](http://stackoverflow.com/questions/21977929/match-colors-in-fecolormatrix-filter).
