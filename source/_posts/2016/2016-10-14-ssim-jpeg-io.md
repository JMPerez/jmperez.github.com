---
layout: post
title: JPG compression level, SSIM and Jpeg.io
date: 2016-10-14 18:43:00+01:00
description: It's difficult to select the best compression level for JPG images. SSIM helps measuring image similarity, and tools like Jpeg.io makes it easier.
image:
  url: /assets/images/posts/jpeg-io.jpg
  width: 1025
  height: 712
tags:
  - images
permalink: ssim-jpeg-io
---

The size of images in JPG varies a lot based on the compression level we choose when saving them. Often, we tweak this level by hand until we consider we don't have too many artifacts and the resulting image is close enough to the original one.

The same compression level doesn't generate the same amount of artifacts in two different images. We need to find an automated approach that measures how different (or similar) two images are, and loop through several compression levels to find the most suitable one.

<!-- more -->
## Structural similarity

Some time ago I discovered [cjpeg-ddsim](https://github.com/technopagan/cjpeg-dssim) at [a talk ](/internetdagarna-2015/#High-Performance-Images-by-Tobias-Baldauf) by [Tobias Baldauf](http://tobias.is/about/) who works at Akamai and has written several tools for optimising images.

[Structural similarity](https://en.wikipedia.org/wiki/Structural_similarity) is used for measuring the similarity between two images, which can be applied to our use case. Tobias himself has [a script](https://github.com/technopagan/adept-jpg-compressor) that goes through the whole process of applying SSIM to an image, though you will need to install some libraries to run it.

## ImageOptim and JPEG.io

I'm a big fan of automated tools like [ImageOptim](https://imageoptim.com). Since I normally have full control on the assets of my projects, I can pass the images through it once and commit them optimised.

ImageOptim performs a [lossless optimisation](/image-optimization-lossy-lossless-techniques) by default, removing EXIF data and preview images that are not needed. A lossy mode is available and can be enabled from the app's preferences panel. Lossy presents the same problem, though. What compression level is the right one?

![Imageoptim's Preferences](/assets/images/posts/imageoptim-lossy.png)

Reading [this week's FrontEnd Focus (formerly HTML5 Weekly) newsletter](http://frontendfocus.co/issues/261) I found out about [Jpeg.io](https://www.jpeg.io). This site claims to convert any image into a highly Optimized JPEG, so I decided to give it a try.

I run it through all JPG images on this blog, and I liked seeing that there were savings even though the images had already been optimised:

![Jpeg.io results for some of the images of this blog](/assets/images/posts/jpeg-io-results.png)

Some images were left untouched, while others reduced their size as much as 70% ([before  236kB](/assets/images/posts/spotify-hack-week-2014-presentation-before.jpg), [after 71kB](/assets/images/posts/spotify-hack-week-2014-presentation.jpg)).

### Progressive JPEGs
Another advantage is that it generates [progressive JPGs](http://blog.patrickmeenan.com/2013/06/progressive-jpegs-ftw.html). Compared to baseline JPGs, progressive ones will render a larger area of the image earlier, though more _pixelated_. It provides a standard way to progressive load images without having to do something as fancy as [Medium's technique](/medium-image-progressive-loading-placeholder/).

Note, however, that users might prefer baseline images, [according to a study](http://www.webperformancetoday.com/2014/09/17/progressive-image-rendering-good-evil/), which was later [presented at Velocity](http://conferences.oreilly.com/velocity/velocityny2014/public/schedule/detail/35658):

> When, as with the Progressive JPEG method, image rendition is a two-stage process in which an initially coarse image snaps into sharp focus, cognitive fluency is inhibited and the brain has to work slightly harder to make sense of what is being displayed

### Customisation
Jpeg.io doesn't have any customisation options like image quality or compression. They don't give too many details about the process they apply [on their site](https://www.jpeg.io/about), but they do seem to do some kind of SSIM processing:

> Jpeg.io is a free online interface for rapidly and conveniently converting your images into highly optimized JPEGs using Kraken.io's proprietary JPEG optimization algorithms. [...] you'll get a progressive JPEG compressed to the smallest possible size without perceptible quality loss.

Kraken.io also offers [an alternative web interface](https://kraken.io/web-interface) where they do have some level of customisation, and show the percentage of savings per file.

## Future of SSIM-based optimisation tools
I do hope that we see more libraries that make use of image similarity and we can be easily used in our build pipelines and CMSs.
