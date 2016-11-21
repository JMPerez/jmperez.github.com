---
layout: post
title: 'Optimizing images for web with Google Page Speed and jpegoptim'
date: 2009-06-27 15:42:44+00:00
tags:
  - google page speed
  - images
  - optimization
excerpt: This post shows a script to recursively optimize a set of JPG files using jpegoptim
permalink: jpegoptim-optimize-jpg-page-speed
---

Image optimization is a big topic these days. The main culprit in site traffic are images, and [their transfer size is increasing over time](http://httparchive.org/trends.php#bytesImg&reqImg).

You may have wondered how to optimize your images. First, check if there is room for improvement. For that I will be using [Google Page Speed](http://developers.google.com/speed/pagespeed), which offers several tools for analyzing your site. One of them is a handy [online analyzer](http://developers.google.com/speed/pagespeed/insights/). Type there the name of your site and click to analyze it.

<!-- more -->
I like the 'Optimize images' section. It tells you what resources can be optimized and how much traffic you can save, both in the mobile version of your site and the one served for desktop:
[![Analyzing a site using Google PageSpeed Insights online](/assets/images/posts/google-pagespeed-insights-report-thumb.jpg)](/assets/images/posts/google-pagespeed-insights-report.png)
_Analyzing the analyzer: Here you can see the 'Optimize images' section for the Google PageSpeed Insights page. Notice the it reports the optimizable images and how much size you can save._

## Optimizing your JPG images with Jpegoptim

The truth is that when you save a JPG image, you don't know exactly how much compression level you should apply. Sometimes we try different values until we find the best balance between quality and size. Google Page Speed must be using an algorithm that optimizes this relationship, performing a lossless compression to JPG and PNG files.

As mentioned in the [section on optimization of images](http://code.google.com/speed/page-speed/docs/payload.html#CompressImages), we can use tools like [jpegtran](http://jpegclub.org/) and [jpegoptim](http://freshmeat.net/projects/jpegoptim/)

You can install jpegoptim in GNU / Linux easily. If you are an Ubuntu user, it is included in the section on Graphics (universe) and simply run:

```bash
sudo apt-get install jpegoptim
```

If you want to make the optimization of images across your website, or simply reduce the size of your photo albums, you can run this script, that will recursively scan folders to optimize every JPG file. The files will be overwritten with the optimized version.

```bash
optimize() {
  jpegoptim *.jpg --strip-all
  for i in *
  do
    if test -d $i
    then
      cd $i
      echo $i
      optimize
      cd ..
    fi
  done
  echo
}
optimize
```

This script uses the option `--strip-all` to strip out the text information contained in the file (comments and EXIF data) that are not necessary on web images (for your own pictures you'd better keep them).

If you are interested in image optimization, I recommend you having a look at:

## Other tools for optimizing images

I have been using image optimization actively for a long time. Depending on your needs, I recommend you one of these methods:

* **Optimization of a few files through a desktop app (on Mac)**: Use [ImageOptim](http://imageoptim.com). Drag and drop JPG and PNG files and you are goo to go.
* **Optimization of images on Wordpress**: Use [Smush.it](http://wordpress.org/plugins/wp-smushit/). It optimizes uploaded images automatically, and you can also run the plug-in against the existing images.
* **Optimizing PNG files using lossy compression**: Use [TinyPNG](https://tinypng.com). It can reduce PNG images size a lot, but double check the result before, since sometimes you can notice the difference in the colours.

##  Read also

I wrote a post about [Image optimization: Lossy, lossless and other techniques](/image-optimization-lossy-lossless-techniques/) in which I explain some tools and considerations when compressing images.
