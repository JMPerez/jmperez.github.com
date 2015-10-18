---
layout: post
title: How Medium does progressive image loading
date: 2015-10-19 00:05:00+02:00
description: This post explains how Medium renders an image placeholder using low-res thumbnails and canvas
image: /assets/images/posts/medium-placeholder.png
---

Recently, I was browsing a post on Medium and I spotted a nice image loading effect. First, load a small blurry image, and then transition to the large image. I found it pretty neat and wanted to disect how it was done.<br/><br/>![A screenshot of a blurry placeholder while the image is loaded]({{ site.url }}/assets/images/posts/medium-placeholder.png)

## Medium's technique

To see how image loading works in Medium, it is best to see a demo:

<video controls style="max-width:100%">
  <source src="{{ site.url }}/assets/images/posts/medium-progressive-loading.mp4" type="video/mp4">
</video>

I have performed a [WebPageTest test](http://www.webpagetest.org/video/compare.php?tests=151018_XD_KDF-r:1-c:0) against [this page on Medium](https://medium.com/backchannel/exclusive-why-apple-is-still-sweating-the-details-on-imac-531a95e50c91) where you can see how it loads too. And if you want to see it by yourself, open the post in your browser, disable the cache and throttle the response so it takes longer to load.

Here is what is going on:

  1. **Render a div where the image will be displayed**. Medium uses a `<div/>` with a `padding-bottom` set to a percentage, which corresponds to the aspect ratio of the image. Thus, they prevent reflows while the images are loaded since everything is rendered in its final position.

  2. **Load a tiny version of the image**. At the moment, they seem to be requesting small JPEG thumbnails with a very low quality (20%). The markup for these images is returned in the initial HTML, so the browser starts fetching them right away.

  3. Once the image is loaded, **it is drawn in a `<canvas/>`**. Then, the image data is taken and passed through a custom `blur()` function You can see it, a bit scrumbled, in the `main-base.bundle` JS file. This function is similar, though not identical, to [StackBlur](http://www.quasimondo.com/StackBlurForCanvas/StackBlurDemo.html)'s blur function. At the same time, **the main image is requested**.

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

As you see, there is a lot of things going on to be able to render an image, but it has some advantages:

- **Lazy loading**. Using JS for making the requests allows them to be in control of what images are requested. While all the small thumbnails are requested, the large images are only requestes when they are within the viewport.

- **Better placeholder**. The thumbnails are very small, barely 2kB, which combined with the blurry effect allows for a better placeholder than a solid colour, without sacrificing payload.

- **Tailored image sizes**. Medium serves different images sizes depending on the device that makes the requests, which optimises the weight of the page.

## Variants
Before finding out about this technique, I thought of using a similar approach for a site I'm working on.

### Inlining image data
Instead of making a request for the small thumbnails, it is possible to inline them using data URIs. This increases the size of the HTML, but accelerates the rendering of the placeholder, which is immediate one the markup is downloaded. The blur effect allows these images to be really small. I did some tests with 0.5kB size images, and the result was similar to using a 4x larger image.

### Blur effect

By default, when a browser renders a small image scaled up, it applies a light blur effect to smooth the artifacts of the image. The effect can also be [turned off](http://superuser.com/questions/530317/how-to-prevent-chrome-from-blurring-small-images-when-zoomed-in) for images like QR codes.

>[...]the browser would render it in a way that didn’t make it look blocky[...] from [Google Developers](https://developers.google.com/web/updates/2015/01/pixelated).

This works both in Chrome, Safari and Firefox (I haven't tried on IE yet), though the smoothing effect is more prominent in Chrome. Here is a demo, but you can see it better [in full screen](http://codepen.io/jmperez/full/Xmzobe/):

<p data-height="367" data-theme-id="0" data-slug-hash="Xmzobe" data-default-tab="result" data-user="jmperez" class='codepen'>See the Pen <a href='http://codepen.io/jmperez/pen/Xmzobe/'>Blur effect when scaling up a small image</a> by José Manuel Pérez (<a href='http://codepen.io/jmperez'>@jmperez</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

Note how the artifacts are smoothen. Keep in mind that the image is only 27px wide and has very low quality, which should result in an awful scaled-up version, but it isn't. If the above effect is enough for you, then you don't need to use more complicated alternatives.

The blur effect can also be achieved using [CSS Filter Effects](http://codepen.io/aniketpant/pen/DsEve). [Its support is quite wide](http://caniuse.com/#feat=css-filters) aside from IE. I'm pretty sure Medium tried this before going to a canvas solution, which feels far too over-engineered, but for some reason they decided not to use it.

<p data-height="367" data-theme-id="0" data-slug-hash="PPOXzY" data-default-tab="result" data-user="jmperez" class='codepen'>See the Pen <a href='http://codepen.io/jmperez/pen/PPOXzY/'>Blur effect using CSS blur() filter on a small image</a> by José Manuel Pérez (<a href='http://codepen.io/jmperez'>@jmperez</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

The advantage of this technique is that you can easily tweak how much blur you want and everything is achieved using CSS.

### Google Images Search

A simpler technique is used by Google Search when searching for images from a smartphone:

[![Searching on Google Images from the phone]({{ site.url }}/assets/images/posts/google-images-placeholder.png)]({{{ site.url }}/assets/images/posts/google-images-placeholder.png)
_&uarr; Google Images Search shows a solid background as placeholder (left image is while loading, right when already loaded)._

They pick a colour (maybe the dominant colour of the picture?) and they use it a solid colour background. It gives the user the feeling that images loads faster.

## Conclusion

As our pages load more and more images, it is good to think of their loading process on our pages, since it affects performance and user experience.

If you are generating several thumbnail sizes for your images, you can experiment using a very small one to use it as the background while the final image loads.

And if you are interested in other image tips and tricks, check out [Image optimization: Lossy, lossless and other techniques]({{ site.url }}/image-optimization-lossy-lossless-techniques).
