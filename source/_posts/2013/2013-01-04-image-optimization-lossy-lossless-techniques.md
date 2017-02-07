---
layout: post
title: 'Image optimization: Lossy, lossless and other techniques'
date: 2013-01-04 21:44:57+00:00
tags:
  - images
  - optimization
  - responsive
permalink: image-optimization-lossy-lossless-techniques
---

During last days I have come across interesting articles about images optimization. Images are currently the largest average payload in web sites, meaning a [62%](http://httparchive.org/interesting.php) of all the bytes. With the increasingly importance of responsive design, [responsive images](http://css-tricks.com/which-responsive-images-solution-should-you-use/) are becoming a challenge to face.

I have already talked about image optimization in my [list of optimization techniques](/techniques-optimize-web-sites/#images-optimization) and my short [post about using jpegoptim](/jpegoptim-optimize-jpg-page-speed/). But recently I have read about highly compressed JPG to target high-res screens and progressive JPG images, and I thought it would worth sharing.

<!-- more -->
## Highly compressed JPG images and high resolution screens

[Compressive Images](https://www.filamentgroup.com/lab/compressive-images.html) is a post by Filament Group where they show a way to target responsive images. Instead of using multiple copies of an image with different sizes, you can generate a large JPG image with a compression of 0 quality. That way, not only one single copy can be used to target different screen sizes and resolutions, but there are even large savings in file size comparing to normal 1:1 images.

I have prepared [a demo of the Compressive Images technique](/demos/compressive-images/) where you can test your own images.

<div class="callout">
<strong>Info</strong>: Note that this technique might have a high impact on decoding + resizing, especially on mobile. Tim Kadlec explained it at Velocity SC 2015 in his <a href="https://www.youtube.com/watch?v=jP68rCjSSjM&t=10m56s">Mobile Image Processing talk</a>.
</div>

## Progressive JPEGs

Thanks to [Progressive jpegs: a new best practice](http://calendar.perfplanet.com/2012/progressive-jpegs-a-new-best-practice/) I have learnt that progressive JPGs normally weight less than baseline ones. Not only that, but they make some browsers start rendering the image sooner, preventing showing a white chunk until the full image is downloaded. By using tools such as imageoptim, which runs jpegtran behind the scenes, you can make sure the smallest file is chosen.

That post also links to [Optimizing Images](http://www.bookofspeed.com/chapter5.html), a chapter from Stoyan Stefanov's [Book of Speed](http://www.bookofspeed.com/). In that chapter, Stoyan compiles the main tools to achieve lossless compression of JPG, PNG and GIF images.

If you want to see progressive images in action, check [this demo](http://www.patrickmeenan.com/progressive/view.php?img=http%3A%2F%2Fi2.cdn.turner.com%2Fcnn%2Fdam%2Fassets%2F121205093053-leweb-cyborg-c1-main.jpg) made by [@patmeenan](https://twitter.com/patmeenan) that showing how a JPG is rendered in progressive and baseline mode, and the resulting image of every scan. You can even try with your own image.

## Lossy techniques

To end with, in [Giving Your Images An Extra Squeeze](http://calendar.perfplanet.com/2012/giving-your-images-an-extra-squeeze/) you can see how lossy compression tools can help go the extra mile and reduce even more the size of your images, while keeping quality. It is a nice read about tools such as pngquant and imgmin, as well as the WebP format.

## More resources

If you are interested in image optimization, I recommend you to have a look at [Image Optimization Tools](http://addyosmani.com/blog/image-optimization-tools/), an article by Addy Osmani.
