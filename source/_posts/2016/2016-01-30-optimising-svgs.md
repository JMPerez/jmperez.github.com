---
layout: post
title: SVG Optimisation using SVGOMG and FontForge
date: 2016-01-30 09:40:00+01:00
description: How to optimise your SVGs rounding values and using SVGOMG
image:
  url: /assets/images/posts/spotify-fontforge.png
  width: 638
  height: 385
tags:
  - svg
permalink: optimising-svgs
---

<style>.language-xml{white-space: normal}</style>
Lots of websites have started replacing their icon fonts and small icons with SVGs. They support CSS manipulations, animations and are great for responsive sites. But it is important to keep an eye on their size.

<!-- more -->
## How SVGs are included in a page

Since the SVGs are usually small in size, lots of developers decide to inline them. Especially when replacing a web icon font, which can be fetch in a single request.

Some sites inline the SVGs as part of their CSS file. This can be done uri-encoding the SVG data, or converting it to base 64, but [this one results in a larger payload](https://css-tricks.com/probably-dont-base64-svg/).

<div style="text-align:center">
[![Including SVGs in the markup](/assets/images/posts/svg-inline-html-use.png)](/assets/images/posts/svg-inline-html-use.png)
</div>

Some other sites include them as part of the markup, defining them as `<symbol />`s, and adding a reference to them where they should be rendered through the `<use />` tag. I like this one because it is easier to just serve the SVGs used in that page. If you use this, remember to define the symbols above the reference to them, or some browsers (e.g. Safari on iPhone) will not render the SVGs.

<div style="text-align:center">
[![Including SVGs inlined in the CSS](/assets/images/posts/svg-inline-css.png)](/assets/images/posts/svg-inline-css.png)
</div>

In any case, the SVGs are making their way to the critical path, and saving bytes won't result in a worse experience.

## Next step, optimise the SVGs

So far we have our SVGs on the page and they are rendered. SVGs are text-based and they compress really well. However, there is normally room for improvement and we can shave some bytes using an optimiser.

If you have used ImageOptim to optimise bitmap images, then you will love this one. [SVGOMG](https://jakearchibald.github.io/svgomg/) is a website where you drag&drop your SVG and get an optimised version. It uses [svgo](https://github.com/svg/svgo), which you can also use from the console or as part of your build process.

SVGO will optimise paths and merge layers. If you want to be able to open the optimised SVG and edit in in some tool like Inkscape, remember to save the original one somewhere else.

## Going beyond, more optimisations

If you have read this far, you will welcome ideas to further optimise your SVGs. A few weeks ago I came across a series of posts by [Andreas Larsen](https://twitter.com/larsenwork) on Medium that I strongly recommend checking out:

- [Optimising SVGs for Web Use - Part 1](https://medium.com/larsenwork-andreas-larsen/optimising-svgs-for-web-use-part-1-67e8f2d4035#.2bnvih6cw)
- [Optimising SVGs for Web Use - Part 2](https://medium.com/larsenwork-andreas-larsen/optimising-svgs-for-web-use-part-2-6711cc15df46#.al4v73web)
- [Optimising SVGs for Web Use - Part 2½](https://medium.com/larsenwork-andreas-larsen/optimising-svgs-for-web-use-part-2-1-598815d74f9c#.rv7i93abh)

Optimising SVGs "by hand" might look a bit tedious and only at reach of a few ones, but the gains are big.

## An example: Spotify logo

I decided to try to use some of Andreas' ideas and try to optimise the Spotify logo.

<div style="text-align:center">
[![Editing the Spotify logo in fontForge](/assets/images/posts/spotify-fontforge.png)](/assets/images/posts/spotify-fontforge.png)
</div>

This is what I did:

1. Install fontForge: I had to install X11 and then fontForge. fontForge can be used to create and edit fonts, so the grid and rules have been thought for that use case. Still, it can be used for a regular SVG.
2. Import the SVG that you want to optimise.
3. Scale it up using Element > Transformations > Transform. We will be rounding the values to integers, so try to find a multiplier that will reduce the _error_ when rounding. Rounding the numbers means that we remove the decimal part, but be careful not to scale the SVG up a lot, or the integer part will also grow.
4. Simplify the path using `Element > Simplify > Simplify`. If you see some path being oversimplified, undo and simplify the rest.
5. Round to integer using `Element > Round > To Int`.
6. In my case, I had to tweak the position of the SVG. It might be because I was using wrong values for ascent, descent, underline and height. You can use `Element > Font Info > General` to modify these values.
6. Export it as SVG.
7. Open [SVGOMG](https://jakearchibald.github.io/svgomg/), import the resulting SVG and download the optimised one.

In my case it went down from 2.24kB to 915 bytes, both compressed as reported by SVGOMG.

Original:

<div class="code-wrap">
```html
<svg id="Layer_1" style="enable-background:new 0 0 566.93 170.04" xmlns="http://www.w3.org/2000/svg" xml:space="preserve" viewBox="0 0 566.93 170.04" version="1.1" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" width="567" height="171" fill="#000000"><path d="m87.996 1.277c-46.249 0-83.743 37.493-83.743 83.742 0 46.254 37.494 83.745 83.743 83.745 46.251 0 83.743-37.491 83.743-83.745 0-46.246-37.49-83.738-83.744-83.738zm38.404 120.78c-1.504 2.467-4.718 3.24-7.177 1.737-19.665-12.019-44.417-14.734-73.567-8.075-2.809 0.644-5.609-1.117-6.249-3.925-0.643-2.809 1.11-5.609 3.926-6.249 31.9-7.293 59.263-4.154 81.336 9.334 2.46 1.51 3.24 4.72 1.73 7.18zm10.25-22.799c-1.894 3.073-5.912 4.037-8.981 2.15-22.505-13.834-56.822-17.841-83.447-9.759-3.453 1.043-7.1-0.903-8.148-4.35-1.04-3.453 0.907-7.093 4.354-8.143 30.413-9.228 68.221-4.758 94.071 11.127 3.07 1.89 4.04 5.91 2.15 8.976zm0.88-23.744c-26.994-16.031-71.52-17.505-97.289-9.684-4.138 1.255-8.514-1.081-9.768-5.219-1.254-4.14 1.08-8.513 5.221-9.771 29.581-8.98 78.756-7.245 109.83 11.202 3.722 2.209 4.943 7.016 2.737 10.733-2.2 3.722-7.02 4.949-10.73 2.739z"/><path d="m232.09 78.586c-14.459-3.448-17.033-5.868-17.033-10.953 0-4.804 4.523-8.037 11.249-8.037 6.52 0 12.985 2.455 19.763 7.509 0.205 0.153 0.462 0.214 0.715 0.174 0.253-0.038 0.477-0.177 0.625-0.386l7.06-9.952c0.29-0.41 0.211-0.975-0.18-1.288-8.067-6.473-17.151-9.62-27.769-9.62-15.612 0-26.517 9.369-26.517 22.774 0 14.375 9.407 19.465 25.663 23.394 13.836 3.187 16.171 5.857 16.171 10.63 0 5.289-4.722 8.577-12.321 8.577-8.44 0-15.324-2.843-23.025-9.512-0.191-0.165-0.453-0.24-0.695-0.226-0.255 0.021-0.488 0.139-0.65 0.334l-7.916 9.421c-0.332 0.391-0.29 0.975 0.094 1.313 8.96 7.999 19.98 12.224 31.872 12.224 16.823 0 27.694-9.192 27.694-23.419 0.03-12.01-7.16-18.66-24.77-22.944z"/><path d="m294.95 64.326c-7.292 0-13.273 2.872-18.205 8.757v-6.624c0-0.523-0.424-0.949-0.946-0.949h-12.947c-0.523 0-0.946 0.426-0.946 0.949v73.602c0 0.523 0.423 0.949 0.946 0.949h12.947c0.522 0 0.946-0.426 0.946-0.949v-23.233c4.933 5.536 10.915 8.241 18.205 8.241 13.549 0 27.265-10.43 27.265-30.368 0.02-19.943-13.7-30.376-27.25-30.376zm12.21 30.375c0 10.153-6.254 17.238-15.209 17.238-8.853 0-15.531-7.407-15.531-17.238 0-9.83 6.678-17.238 15.531-17.238 8.81-0.001 15.21 7.247 15.21 17.237z"/><path d="m357.37 64.326c-17.449 0-31.119 13.436-31.119 30.592 0 16.969 13.576 30.264 30.905 30.264 17.511 0 31.223-13.391 31.223-30.481 0-17.031-13.62-30.373-31.01-30.373zm0 47.714c-9.281 0-16.278-7.457-16.278-17.344 0-9.929 6.755-17.134 16.064-17.134 9.341 0 16.385 7.457 16.385 17.351 0 9.927-6.8 17.127-16.17 17.127z"/><path d="m425.64 65.51h-14.247v-14.566c0-0.522-0.422-0.948-0.945-0.948h-12.945c-0.524 0-0.949 0.426-0.949 0.948v14.566h-6.225c-0.521 0-0.943 0.426-0.943 0.949v11.127c0 0.522 0.422 0.949 0.943 0.949h6.225v28.791c0 11.635 5.791 17.534 17.212 17.534 4.644 0 8.497-0.959 12.128-3.018 0.295-0.165 0.478-0.483 0.478-0.821v-10.596c0-0.327-0.17-0.636-0.45-0.807-0.282-0.177-0.633-0.186-0.922-0.043-2.494 1.255-4.905 1.834-7.6 1.834-4.154 0-6.007-1.886-6.007-6.113v-26.756h14.247c0.523 0 0.944-0.426 0.944-0.949v-11.126c0.02-0.523-0.4-0.949-0.93-0.949z"/><path d="m475.28 65.567v-1.789c0-5.263 2.018-7.61 6.544-7.61 2.699 0 4.867 0.536 7.295 1.346 0.299 0.094 0.611 0.047 0.854-0.132 0.25-0.179 0.391-0.466 0.391-0.77v-10.91c0-0.417-0.268-0.786-0.67-0.909-2.565-0.763-5.847-1.546-10.761-1.546-11.958 0-18.279 6.734-18.279 19.467v2.74h-6.22c-0.522 0-0.95 0.426-0.95 0.948v11.184c0 0.522 0.428 0.949 0.95 0.949h6.22v44.409c0 0.523 0.422 0.949 0.944 0.949h12.947c0.523 0 0.949-0.426 0.949-0.949v-44.406h12.088l18.517 44.398c-2.102 4.665-4.169 5.593-6.991 5.593-2.281 0-4.683-0.681-7.139-2.025-0.231-0.127-0.505-0.148-0.754-0.071-0.247 0.087-0.455 0.271-0.56 0.511l-4.388 9.627c-0.209 0.455-0.03 0.989 0.408 1.225 4.581 2.481 8.716 3.54 13.827 3.54 9.56 0 14.844-4.453 19.502-16.433l22.461-58.04c0.113-0.292 0.079-0.622-0.1-0.881-0.178-0.257-0.465-0.412-0.779-0.412h-13.478c-0.404 0-0.765 0.257-0.897 0.636l-13.807 39.438-15.123-39.464c-0.138-0.367-0.492-0.61-0.884-0.61h-22.12z"/><path d="m446.5 65.51h-12.947c-0.523 0-0.949 0.426-0.949 0.949v56.485c0 0.523 0.426 0.949 0.949 0.949h12.947c0.522 0 0.949-0.426 0.949-0.949v-56.481c0-0.523-0.42-0.949-0.95-0.949z"/><path d="m440.1 39.791c-5.129 0-9.291 4.152-9.291 9.281 0 5.132 4.163 9.289 9.291 9.289 5.127 0 9.285-4.157 9.285-9.289 0-5.128-4.16-9.281-9.28-9.281z"/><path d="m553.52 83.671c-5.124 0-9.111-4.115-9.111-9.112s4.039-9.159 9.159-9.159c5.124 0 9.111 4.114 9.111 9.107 0 4.997-4.04 9.164-9.16 9.164zm0.05-17.365c-4.667 0-8.198 3.71-8.198 8.253 0 4.541 3.506 8.201 8.151 8.201 4.666 0 8.201-3.707 8.201-8.253 0-4.541-3.51-8.201-8.15-8.201zm2.02 9.138l2.577 3.608h-2.173l-2.32-3.31h-1.995v3.31h-1.819v-9.564h4.265c2.222 0 3.683 1.137 3.683 3.051 0.01 1.568-0.9 2.526-2.21 2.905zm-1.54-4.315h-2.372v3.025h2.372c1.184 0 1.891-0.579 1.891-1.514 0-0.984-0.71-1.511-1.89-1.511z"/></svg>
```
</div>

Optimised:

<div class="code-wrap">
```html
<svg xmlns="http://www.w3.org/2000/svg" width="1134" height="340"><path fill="%23fff" d="M8 171c0 92 76 168 168 168s168-76 168-168S268 4 176 4 8 79 8 171zm230 78c-39-24-89-30-147-17-14 2-16-18-4-20 64-15 118-8 162 19 11 7 0 24-11 18zm17-45c-45-28-114-36-167-20-17 5-23-21-7-25 61-18 136-9 188 23 14 9 0 31-14 22zM80 133c-17 6-28-23-9-30 59-18 159-15 221 22 17 9 1 37-17 27-54-32-144-35-195-19zm379 91c-17 0-33-6-47-20-1 0-1 1-1 1l-16 19c-1 1-1 2 0 3 18 16 40 24 64 24 34 0 55-19 55-47 0-24-15-37-50-46-29-7-34-12-34-22s10-16 23-16 25 5 39 15c0 0 1 1 2 1s1-1 1-1l14-20c1-1 1-1 0-2-16-13-35-20-56-20-31 0-53 19-53 46 0 29 20 38 52 46 28 6 32 12 32 22 0 11-10 17-25 17zm95-77v-13c0-1-1-2-2-2h-26c-1 0-2 1-2 2v147c0 1 1 2 2 2h26c1 0 2-1 2-2v-46c10 11 21 16 36 16 27 0 54-21 54-61s-27-60-54-60c-15 0-26 5-36 17zm30 78c-18 0-31-15-31-35s13-34 31-34 30 14 30 34-12 35-30 35zm68-34c0 34 27 60 62 60s62-27 62-61-26-60-61-60-63 27-63 61zm30-1c0-20 13-34 32-34s33 15 33 35-13 34-32 34-33-15-33-35zm140-58v-29c0-1 0-2-1-2h-26c-1 0-2 1-2 2v29h-13c-1 0-2 1-2 2v22c0 1 1 2 2 2h13v58c0 23 11 35 34 35 9 0 18-2 25-6 1 0 1-1 1-2v-21c0-1 0-2-1-2h-2c-5 3-11 4-16 4-8 0-12-4-12-12v-54h30c1 0 2-1 2-2v-22c0-1-1-2-2-2h-30zm129-3c0-11 4-15 13-15 5 0 10 0 15 2h1s1-1 1-2V93c0-1 0-2-1-2-5-2-12-3-22-3-24 0-36 14-36 39v5h-13c-1 0-2 1-2 2v22c0 1 1 2 2 2h13v89c0 1 1 2 2 2h26c1 0 1-1 1-2v-89h25l37 89c-4 9-8 11-14 11-5 0-10-1-15-4h-1l-1 1-9 19c0 1 0 3 1 3 9 5 17 7 27 7 19 0 30-9 39-33l45-116v-2c0-1-1-1-2-1h-27c-1 0-1 1-1 2l-28 78-30-78c0-1-1-2-2-2h-44v-3zm-83 3c-1 0-2 1-2 2v113c0 1 1 2 2 2h26c1 0 1-1 1-2V134c0-1 0-2-1-2h-26zm-6-33c0 10 9 19 19 19s18-9 18-19-8-18-18-18-19 8-19 18zm245 69c10 0 19-8 19-18s-9-18-19-18-18 8-18 18 8 18 18 18zm0-34c9 0 17 7 17 16s-8 16-17 16-16-7-16-16 7-16 16-16zm4 18c3-1 5-3 5-6 0-4-4-6-8-6h-8v19h4v-6h4l4 6h5zm-3-9c2 0 4 1 4 3s-2 3-4 3h-4v-6h4z"/></svg>
```
</div>

You can see how the multiple `<path />`s have been merged into one and the values are now integers.

In this pen I have included both the original and the optimised logo:

{% codepen jmperez BjYaKg 0 result 367 %}
