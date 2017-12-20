---
layout: post
title: How Medium does progressive image loading
date: 2015-10-19 00:05:00+02:00
description: This post explains how Medium renders an image placeholder using low-res thumbnails and canvas
image:
  url: /assets/images/posts/medium-placeholder.png
  width: 476
  height: 608
tags:
  - images
  - ux
permalink: medium-image-progressive-loading-placeholder
---

Recently, I was browsing a post on Medium and I spotted a nice image loading effect. First, load a small blurry image, and then transition to the large image. I found it pretty neat and wanted to dissect how it was done.

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto,f_auto,c_scale/v1510693577/medium-placeholder_ciusf2.png"
    sizes="(max-width: 768px) 100vw, 684px" alt="A screenshot of a blurry placeholder while the image is loaded" style="margin: 0 auto "/>

<!-- more -->
## Medium's technique

To see how image loading works in Medium, it is best to see a demo:

<video controls style="max-width:100%" width="854" height="480">
  <source src="/assets/images/posts/medium-progressive-loading.mp4" type="video/mp4">
</video>

I have performed a [WebPageTest test](http://www.webpagetest.org/video/compare.php?tests=151018_XD_KDF-r:1-c:0) against [this page on Medium](https://medium.com/backchannel/exclusive-why-apple-is-still-sweating-the-details-on-imac-531a95e50c91) where you can see how it loads too. And if you want to see it by yourself, open Medium's post in your browser, disable the cache and throttle the response so it takes longer to fetch the images and you can see the effect.

Here is what is going on:

  1. **Render a div where the image will be displayed**. Medium uses a `<div/>` with a `padding-bottom` set to a percentage, which corresponds to the aspect ratio of the image. Thus, they prevent reflows while the images are loaded since everything is rendered in its final position. This has also been referred to as [intrinsic placeholders](http://daverupert.com/2015/12/intrinsic-placeholders-with-picture/).

  2. **Load a tiny version of the image**. At the moment, they seem to be requesting small JPEG thumbnails with a very low quality (e.g. 20%). The markup for this small image is returned in the initial HTML as an `<img/>`, so the browser starts fetching them right away.

  3. Once the image is loaded, **it is drawn in a `<canvas/>`**. Then, the image data is taken and passed through a custom `blur()` function You can see it, a bit scrambled, in the `main-base.bundle` JS file. This function is similar, though not identical, to [StackBlur](http://www.quasimondo.com/StackBlurForCanvas/StackBlurDemo.html)'s blur function. At the same time, **the main image is requested**.

  4. Once the main image is loaded, **it is shown** and the `canvas` is hidden.

All the transitions are quite smooth, thanks to the CSS animations applied.

## Markup
A bird's eye view of the markup for an image:

```html
<figure>
  <div>
    <div/> <!-- this div keeps the aspect ratio so the placeholder doesn't collapse -->
    <img/> <!-- this is a tiny image with a resolution of e.g. ~27x17 and low quality -->
    <canvas/> <!-- takes the above image and applies a blur filter -->
    <img/> <!-- the large image to be displayed -->
    <noscript/> <!-- fallback for no JS -->
  </div>
</figure>
```

And a concrete example, so you see what goes in those tags:

```html
<figure name="7012" id="7012" class="graf--figure graf--layoutFillWidth graf-after--h4">
  <div class="aspectRatioPlaceholder is-locked">
    <div class="aspect-ratio-fill" style="padding-bottom: 66.7%;"></div>
    <div class="progressiveMedia js-progressiveMedia graf-image is-canvasLoaded is-imageLoaded" data-image-id="1*sg-uLNm73whmdOgKlrQdZA.jpeg" data-width="2000" data-height="1333" data-scroll="native">
      <img src="https://cdn-images-1.medium.com/freeze/max/27/1*sg-uLNm73whmdOgKlrQdZA.jpeg?q=20" crossorigin="anonymous" class="progressiveMedia-thumbnail js-progressiveMedia-thumbnail">
        <canvas class="progressiveMedia-canvas js-progressiveMedia-canvas" width="75" height="47"></canvas>
        <img class="progressiveMedia-image js-progressiveMedia-image __web-inspector-hide-shortcut__" data-src="https://cdn-images-1.medium.com/max/1800/1*sg-uLNm73whmdOgKlrQdZA.jpeg" src="https://cdn-images-1.medium.com/max/1800/1*sg-uLNm73whmdOgKlrQdZA.jpeg">
        <noscript class="js-progressiveMedia-inner">&lt;img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1800/1*sg-uLNm73whmdOgKlrQdZA.jpeg"&gt;</noscript>
    </div>
  </div>
</figure>
```

_Note that the actual image sizes requested depend on the device._


## An attempt to reproduce the effect

I have prepared [this CodePen](http://codepen.io/jmperez/pen/yYjPER) where I have implemented the same effect, though using CSS filters for the blur instead of a canvas (see below more info about this variant).

Here is a demo (click 'Run Pen' to run it):

{% codepen jmperez yYjPER 0 result 403 100% preview %}

You can see it better [in full screen](http://codepen.io/jmperez/full/Xmzobe/). I recommend that you use network throttling and disable cache to notice the full animation.

This filmstrip view shows the above codepen when disabling cache and throttling to "Good 3G":
![Chrome Inspector Timeline Capture](/assets/images/posts/medium-codepen.png)

## Is it worth it?
Clearly, there is a lot of things going on to be able to render an image this way, and it can be discouraging to do something similar on your site. A few years ago it would have been impossible to do this animations and blur effects in a performant way, but the truth is that most of the times the latency is the bottleneck, not the device capabilities, and we can play with these visual explorations.

Having full control of the loading of images has some advantages:

- **Lazy loading**. Using JS for making the requests allows them to be in control of what images are requested. While all the small thumbnails are requested, the large images are only requests when they are within the viewport.

- **Better placeholder**. The thumbnails are very small, barely 2kB, which combined with the blurry effect allows for a better placeholder than a solid colour, without sacrificing payload.

- **Tailored image sizes**. Medium serves different images sizes depending on the device that makes the requests, which optimises the weight of the page.

## Variants
Before finding out about this technique, I thought of using a similar approach for a site I'm working on.

### Inlining image data
Instead of making a request for the small thumbnails, it is possible to inline them using data URIs. This increases the size of the HTML, but accelerates the rendering of the placeholder, which is immediate one the markup is downloaded. The blur effect allows these images to be really small. I did some tests with 0.5kB size images, and the result was similar to using a 4x larger image.

### Blur effect

By default, when a browser renders a small image scaled up, it applies a light blur effect to smooth the artefacts of the image. The effect can also be [turned off](http://superuser.com/questions/530317/how-to-prevent-chrome-from-blurring-small-images-when-zoomed-in) for images like QR codes.

>[...]the browser would render it in a way that didn’t make it look blocky[...] from [Google Developers](https://developers.google.com/web/updates/2015/01/pixelated).

This works both in Chrome, Safari and Firefox (I haven't tried on IE yet), though the smoothing effect is more prominent in Chrome. Here is a demo, but you can see it better [in full screen](http://codepen.io/jmperez/full/Xmzobe/):

{% codepen jmperez Xmzobe 0 result 367 %}

Note how the artefacts are smoothen. Keep in mind that the image is only 27px wide and has very low quality, which should result in an awful scaled-up version, but it isn't. If the above effect is enough for you, then you don't need to use more complicated alternatives.

The blur effect can also be achieved using [CSS Filter Effects](http://codepen.io/aniketpant/pen/DsEve). [Its support is quite wide](http://caniuse.com/#feat=css-filters) aside from IE. I'm pretty sure Medium tried this before going to a canvas solution, which feels far too over-engineered, but for some reason they decided not to use it.

{% codepen jmperez PPOXzY 0 result 367 %}

The advantage of this technique is that you can easily tweak how much blur you want and everything is achieved using CSS.

Another option is to use a SVG filter, as explained in [The “Blur Up” Technique for Loading Background Images](https://css-tricks.com/the-blur-up-technique-for-loading-background-images/) and [Textured Gradients in Pure CSS](http://rentafounder.com/textured-gradients-in-pure-css/).

### Other ways of improving placeholders: Google Images Search

A simpler technique is used by Google Search when searching for images from a smartphone:
[![Searching on Google Images from the phone](/assets/images/posts/google-images-placeholder.png)](/assets/images/posts/google-images-placeholder.png)
_&uarr; Google Images Search shows a solid background as placeholder (left image is while loading, right when already loaded)._

They pick a colour (maybe the dominant colour of the picture?) and they use it a solid colour background. It gives the user the feeling that images loads faster.

### An even more advanced one: Facebook's 200 byte technique

Earlier this year Facebook posted "[The technology behind preview photos](https://code.facebook.com/posts/991252547593574/the-technology-behind-preview-photos/)", an interesting article about serving 42 x 42px image previews without the JPEG header.

The scenario is a bit different, since these "images" are served to the Facebook mobile client, which knows how to prepend the header to compose a valid JPEG image. In the case of a website, we would need to compose this using Javascript, which would probably remove most of the savings. A solution would be to use a Service Worker to do the composition, though we would still need some Javascript to send a "request" with the image contents.

In any case, it seems a bit overkilling for the web, but I wanted to include it as a reference. [Using WebP for generating this preview images](/webp-placeholder-images/) can lead to similar savings without having to resort to "creative" solutions.

### LQIP: Low Quality Image Placeholders

Instead of waiting for the final image to be rendered, we can serve a highly compressed image first, and then switch to the large one. This is what  [Low Quality Image Placeholders (LQIP)](http://www.guypo.com/introducing-lqip-low-quality-image-placeholders/) consists of. The idea is similar to Medium's, but serving an image with the same dimensions but higher compression.

## Conclusion

As our pages load more and more images, it is good to think of their loading process on our pages, since it affects performance and user experience.

If you are generating several thumbnail sizes for your images, you can experiment using a very small one to use it as the background while the final image loads.

<div class="read-next" style="padding:1em;background-color:#fdf6ea;margin:2rem 0">
<p><strong>Related Posts</strong></p>
<ul>
<li>I gave a talk at CSSConf about progressive images. You can watch the video and slides on <a href="/cssconf-au-2016/">Speaking at CSSConf Australia 2016</a>.</li>
<li>I collected more examples of sites using a similar technique on <a href="/more-progressive-image-loading/">More examples of Progressive Image Loading</a> and <a href="/svg-placeholders">How to use SVG as a Placeholder</a>.</li>
<li>Interested in other image tips and tricks? Check out <a href="/image-optimization-lossy-lossless-techniques">Image optimization: Lossy, lossless and other techniques</a>.
</li>
</ul>
</div>
