---
layout: post
title: Common Pitfalls when Serving SVGs and How to Solve Them
date: 2018-09-22 10:20:00+02:00
description: Some ways to reduce the payload of the Spotify logo on their website, which can be applied to other SVGs.
image:
  url: /assets/images/posts/spotify-svg/spotify-svg.png
  width: 1868
  height: 670
permalink: spotify-svg
tags:
  - svg
---

Optimizing SVGs is great for performance, but can we go beyond? In this post I will show some common issues with inlined and responsive SVGs applied to a real website.

Scalable Vector Graphics (SVG) are ideal to show logos and drawings on the web due to their small size. SVGs also have other useful applications, such as [placeholders for lazy loaded images](/svg-placeholders) and [animations](/drawing-edges-svg). In a past post I also explained [how to optimize a SVG](/optimising-svgs) with several tools that remove unneeded code and simplify shapes.

Even if we optimize our SVG assets, we can still make mistakes delivering those to the browser. In this post I am going to explain some issues I found on Spotify's website, where the same SVG is inlined several times and where a responsive SVG logo could save additional network requests.

<img
    loading="lazy"
    style="max-width:100%; border: 0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1537603259/spotify-svg/spotify-svg.png 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1537603259/spotify-svg/spotify-svg.png 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1537603259/spotify-svg/spotify-svg.png 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1537603259/spotify-svg/spotify-svg.png 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1537603259/spotify-svg/spotify-svg.png"
    alt="Spotify SVG logo showing its arcs and points" />

<!-- more -->

If there is something that all Spotify sites have in common, it’s the Spotify logo. It is usually shown in the header of the page, and also in the footer. In addition the Spotify circle logo might appear somewhere in the middle.

<img
    style="max-width:100%; border: 0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1537603261/spotify-svg/spotify-logos.png 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1537603261/spotify-svg/spotify-logos.png 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1537603261/spotify-svg/spotify-logos.png 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1537603261/spotify-svg/spotify-logos.png 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1537603261/spotify-svg/spotify-logos.png"
    alt="Spotify's home page on www.spotify.com. The logo is shown in the header and the footer" />
<small class="caption">Spotify's home page on www.spotify.com. The logo is shown in the header and the footer.</small>

Spotify's logo is served using SVG. This vector format is ideal for drawings and icons. They look crisp on every screen, are usually small in bytes, are compressible, stylable through CSS, scriptable through JS… What’s not to like?

There are still ways to misuse SVGs or not take advantage of its capabilities. In this post I want to explain some improvements that can be applied to the Spotify logo and the way it is served.

### Tip 1: Include it once

SVGs can be inserted on web pages in different ways. In the case of the Spotify logo above it is inlined in CSS, setting it as a `background-image`:

<img
    style="max-width:100%; border: 0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1537603267/spotify-svg/spotify-logo-header.jpg 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1537603267/spotify-svg/spotify-logo-header.jpg 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1537603267/spotify-svg/spotify-logo-header.jpg 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1537603267/spotify-svg/spotify-logo-header.jpg 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1537603267/spotify-svg/spotify-logo-header.jpg"
    alt="Inspecting the Spotify logo in the header" />
<small class="caption">Inspecting the Spotify logo in the header.</small>

Chrome Developer Tools doesn’t show the whole code for the logo. If we inspect it we get this not showing the whole code for the logo, which is this:

```html
<svg id="Layer_1" style="enable-background:new 0 0 566.93 170.04" xmlns="http://www.w3.org/2000/svg" xml:space="preserve" viewBox="0 0 566.93 170.04" version="1.1" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" width="567" height="171" fill="#FFF"><path d="m87.996 1.277c-46.249 0-83.743 37.493-83.743 83.742 0 46.254 37.494 83.745 83.743 83.745 46.251 0 83.743-37.491 83.743-83.745 0-46.246-37.49-83.738-83.744-83.738zm38.404 120.78c-1.504 2.467-4.718 3.24-7.177 1.737-19.665-12.019-44.417-14.734-73.567-8.075-2.809 0.644-5.609-1.117-6.249-3.925-0.643-2.809 1.11-5.609 3.926-6.249 31.9-7.293 59.263-4.154 81.336 9.334 2.46 1.51 3.24 4.72 1.73 7.18zm10.25-22.799c-1.894 3.073-5.912 4.037-8.981 2.15-22.505-13.834-56.822-17.841-83.447-9.759-3.453 1.043-7.1-0.903-8.148-4.35-1.04-3.453 0.907-7.093 4.354-8.143 30.413-9.228 68.221-4.758 94.071 11.127 3.07 1.89 4.04 5.91 2.15 8.976zm0.88-23.744c-26.994-16.031-71.52-17.505-97.289-9.684-4.138 1.255-8.514-1.081-9.768-5.219-1.254-4.14 1.08-8.513 5.221-9.771 29.581-8.98 78.756-7.245 109.83 11.202 3.722 2.209 4.943 7.016 2.737 10.733-2.2 3.722-7.02 4.949-10.73 2.739z"/><path d="m232.09 78.586c-14.459-3.448-17.033-5.868-17.033-10.953 0-4.804 4.523-8.037 11.249-8.037 6.52 0 12.985 2.455 19.763 7.509 0.205 0.153 0.462 0.214 0.715 0.174 0.253-0.038 0.477-0.177 0.625-0.386l7.06-9.952c0.29-0.41 0.211-0.975-0.18-1.288-8.067-6.473-17.151-9.62-27.769-9.62-15.612 0-26.517 9.369-26.517 22.774 0 14.375 9.407 19.465 25.663 23.394 13.836 3.187 16.171 5.857 16.171 10.63 0 5.289-4.722 8.577-12.321 8.577-8.44 0-15.324-2.843-23.025-9.512-0.191-0.165-0.453-0.24-0.695-0.226-0.255 0.021-0.488 0.139-0.65 0.334l-7.916 9.421c-0.332 0.391-0.29 0.975 0.094 1.313 8.96 7.999 19.98 12.224 31.872 12.224 16.823 0 27.694-9.192 27.694-23.419 0.03-12.01-7.16-18.66-24.77-22.944z"/><path d="m294.95 64.326c-7.292 0-13.273 2.872-18.205 8.757v-6.624c0-0.523-0.424-0.949-0.946-0.949h-12.947c-0.523 0-0.946 0.426-0.946 0.949v73.602c0 0.523 0.423 0.949 0.946 0.949h12.947c0.522 0 0.946-0.426 0.946-0.949v-23.233c4.933 5.536 10.915 8.241 18.205 8.241 13.549 0 27.265-10.43 27.265-30.368 0.02-19.943-13.7-30.376-27.25-30.376zm12.21 30.375c0 10.153-6.254 17.238-15.209 17.238-8.853 0-15.531-7.407-15.531-17.238 0-9.83 6.678-17.238 15.531-17.238 8.81-0.001 15.21 7.247 15.21 17.237z"/><path d="m357.37 64.326c-17.449 0-31.119 13.436-31.119 30.592 0 16.969 13.576 30.264 30.905 30.264 17.511 0 31.223-13.391 31.223-30.481 0-17.031-13.62-30.373-31.01-30.373zm0 47.714c-9.281 0-16.278-7.457-16.278-17.344 0-9.929 6.755-17.134 16.064-17.134 9.341 0 16.385 7.457 16.385 17.351 0 9.927-6.8 17.127-16.17 17.127z"/><path d="m425.64 65.51h-14.247v-14.566c0-0.522-0.422-0.948-0.945-0.948h-12.945c-0.524 0-0.949 0.426-0.949 0.948v14.566h-6.225c-0.521 0-0.943 0.426-0.943 0.949v11.127c0 0.522 0.422 0.949 0.943 0.949h6.225v28.791c0 11.635 5.791 17.534 17.212 17.534 4.644 0 8.497-0.959 12.128-3.018 0.295-0.165 0.478-0.483 0.478-0.821v-10.596c0-0.327-0.17-0.636-0.45-0.807-0.282-0.177-0.633-0.186-0.922-0.043-2.494 1.255-4.905 1.834-7.6 1.834-4.154 0-6.007-1.886-6.007-6.113v-26.756h14.247c0.523 0 0.944-0.426 0.944-0.949v-11.126c0.02-0.523-0.4-0.949-0.93-0.949z"/><path d="m475.28 65.567v-1.789c0-5.263 2.018-7.61 6.544-7.61 2.699 0 4.867 0.536 7.295 1.346 0.299 0.094 0.611 0.047 0.854-0.132 0.25-0.179 0.391-0.466 0.391-0.77v-10.91c0-0.417-0.268-0.786-0.67-0.909-2.565-0.763-5.847-1.546-10.761-1.546-11.958 0-18.279 6.734-18.279 19.467v2.74h-6.22c-0.522 0-0.95 0.426-0.95 0.948v11.184c0 0.522 0.428 0.949 0.95 0.949h6.22v44.409c0 0.523 0.422 0.949 0.944 0.949h12.947c0.523 0 0.949-0.426 0.949-0.949v-44.406h12.088l18.517 44.398c-2.102 4.665-4.169 5.593-6.991 5.593-2.281 0-4.683-0.681-7.139-2.025-0.231-0.127-0.505-0.148-0.754-0.071-0.247 0.087-0.455 0.271-0.56 0.511l-4.388 9.627c-0.209 0.455-0.03 0.989 0.408 1.225 4.581 2.481 8.716 3.54 13.827 3.54 9.56 0 14.844-4.453 19.502-16.433l22.461-58.04c0.113-0.292 0.079-0.622-0.1-0.881-0.178-0.257-0.465-0.412-0.779-0.412h-13.478c-0.404 0-0.765 0.257-0.897 0.636l-13.807 39.438-15.123-39.464c-0.138-0.367-0.492-0.61-0.884-0.61h-22.12z"/><path d="m446.5 65.51h-12.947c-0.523 0-0.949 0.426-0.949 0.949v56.485c0 0.523 0.426 0.949 0.949 0.949h12.947c0.522 0 0.949-0.426 0.949-0.949v-56.481c0-0.523-0.42-0.949-0.95-0.949z"/><path d="m440.1 39.791c-5.129 0-9.291 4.152-9.291 9.281 0 5.132 4.163 9.289 9.291 9.289 5.127 0 9.285-4.157 9.285-9.289 0-5.128-4.16-9.281-9.28-9.281z"/><path d="m553.52 83.671c-5.124 0-9.111-4.115-9.111-9.112s4.039-9.159 9.159-9.159c5.124 0 9.111 4.114 9.111 9.107 0 4.997-4.04 9.164-9.16 9.164zm0.05-17.365c-4.667 0-8.198 3.71-8.198 8.253 0 4.541 3.506 8.201 8.151 8.201 4.666 0 8.201-3.707 8.201-8.253 0-4.541-3.51-8.201-8.15-8.201zm2.02 9.138l2.577 3.608h-2.173l-2.32-3.31h-1.995v3.31h-1.819v-9.564h4.265c2.222 0 3.683 1.137 3.683 3.051 0.01 1.568-0.9 2.526-2.21 2.905zm-1.54-4.315h-2.372v3.025h2.372c1.184 0 1.891-0.579 1.891-1.514 0-0.984-0.71-1.511-1.89-1.511z"/></svg>
```

The size of the image, not compressed, is 4,960 bytes. It’s not huge for an image, but we’ll see there are ways to improve it.

The screenshot shows the style applied to `.navbar-logo`, which is the one shown in the header. The same logo is inlined a second time for the footer, applied to the `.footer .footer-logo>a` CSS rule:

<img
    style="max-width:100%; border: 0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1537603267/spotify-svg/spotify-logo-footer.jpg 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1537603267/spotify-svg/spotify-logo-footer.jpg 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1537603267/spotify-svg/spotify-logo-footer.jpg 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1537603267/spotify-svg/spotify-logo-footer.jpg 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1537603267/spotify-svg/spotify-logo-footer.jpg"
    alt="Inspecting the Spotify logo in the header" />
<small class="caption">Inspecting the Spotify logo in the footer.</small>

If that wasn’t enough, it is inlined a third time in the `.navbar-transparent-signup-b .navbar-logo` CSS rule, which is not being applied to this specific page.

Even though gzip helps with the size of the CSS, **a better way would be to include it just once in a CSS class that can be reused as needed**. Stylesheets are part of the critical path, so any savings here means that the page will render faster.

### Tip 2) Optimize the logo

If you take a close look at the SVG code for the Spotify logo you will see an id and style that are not needed. Optimizing SVGs by hand can be tricky, but fortunately there are tools like [SVGOMG](https://jakearchibald.github.io/svgomg/) that will make these and more changes for us.

<img
    style="max-width:100%; border: 0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1537603266/spotify-svg/spotify-logo-svgomg.jpg 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1537603266/spotify-svg/spotify-logo-svgomg.jpg 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1537603266/spotify-svg/spotify-logo-svgomg.jpg 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1537603266/spotify-svg/spotify-logo-svgomg.jpg 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1537603266/spotify-svg/spotify-logo-svgomg.jpg"
    alt="Spotify logo on SVGMOMG" />

Passing the image through the tool, keeping the same shape precision, gives us this code:

```html
<svg xmlns="http://www.w3.org/2000/svg" fill="#FFF" viewBox="0 0 566.93 170.04"><path d="M87.996 1.277c-46.249 0-83.743 37.493-83.743 83.742 0 46.254 37.494 83.745 83.743 83.745 46.251 0 83.743-37.491 83.743-83.745 0-46.246-37.49-83.738-83.744-83.738zm38.404 120.78c-1.504 2.467-4.718 3.24-7.177 1.737-19.665-12.019-44.417-14.734-73.567-8.075-2.809.644-5.609-1.117-6.249-3.925-.643-2.809 1.11-5.609 3.926-6.249 31.9-7.293 59.263-4.154 81.336 9.334 2.46 1.51 3.24 4.72 1.73 7.18zm10.25-22.799c-1.894 3.073-5.912 4.037-8.981 2.15-22.505-13.834-56.822-17.841-83.447-9.759-3.453 1.043-7.1-.903-8.148-4.35-1.04-3.453.907-7.093 4.354-8.143 30.413-9.228 68.221-4.758 94.071 11.127 3.07 1.89 4.04 5.91 2.15 8.976zm.88-23.744c-26.994-16.031-71.52-17.505-97.289-9.684-4.138 1.255-8.514-1.081-9.768-5.219-1.254-4.14 1.08-8.513 5.221-9.771 29.581-8.98 78.756-7.245 109.83 11.202 3.722 2.209 4.943 7.016 2.737 10.733-2.2 3.722-7.02 4.949-10.73 2.739zM232.09 78.586c-14.459-3.448-17.033-5.868-17.033-10.953 0-4.804 4.523-8.037 11.249-8.037 6.52 0 12.985 2.455 19.763 7.509.205.153.462.214.715.174.253-.038.477-.177.625-.386l7.06-9.952c.29-.41.211-.975-.18-1.288-8.067-6.473-17.151-9.62-27.769-9.62-15.612 0-26.517 9.369-26.517 22.774 0 14.375 9.407 19.465 25.663 23.394 13.836 3.187 16.171 5.857 16.171 10.63 0 5.289-4.722 8.577-12.321 8.577-8.44 0-15.324-2.843-23.025-9.512-.191-.165-.453-.24-.695-.226-.255.021-.488.139-.65.334l-7.916 9.421c-.332.391-.29.975.094 1.313 8.96 7.999 19.98 12.224 31.872 12.224 16.823 0 27.694-9.192 27.694-23.419.03-12.01-7.16-18.66-24.77-22.944zM294.95 64.326c-7.292 0-13.273 2.872-18.205 8.757v-6.624c0-.523-.424-.949-.946-.949h-12.947c-.523 0-.946.426-.946.949v73.602c0 .523.423.949.946.949h12.947c.522 0 .946-.426.946-.949v-23.233c4.933 5.536 10.915 8.241 18.205 8.241 13.549 0 27.265-10.43 27.265-30.368.02-19.943-13.7-30.376-27.25-30.376zm12.21 30.375c0 10.153-6.254 17.238-15.209 17.238-8.853 0-15.531-7.407-15.531-17.238 0-9.83 6.678-17.238 15.531-17.238 8.81-.001 15.21 7.247 15.21 17.237zM357.37 64.326c-17.449 0-31.119 13.436-31.119 30.592 0 16.969 13.576 30.264 30.905 30.264 17.511 0 31.223-13.391 31.223-30.481 0-17.031-13.62-30.373-31.01-30.373zm0 47.714c-9.281 0-16.278-7.457-16.278-17.344 0-9.929 6.755-17.134 16.064-17.134 9.341 0 16.385 7.457 16.385 17.351 0 9.927-6.8 17.127-16.17 17.127zM425.64 65.51h-14.247V50.944c0-.522-.422-.948-.945-.948h-12.945c-.524 0-.949.426-.949.948V65.51h-6.225c-.521 0-.943.426-.943.949v11.127c0 .522.422.949.943.949h6.225v28.791c0 11.635 5.791 17.534 17.212 17.534 4.644 0 8.497-.959 12.128-3.018.295-.165.478-.483.478-.821v-10.596c0-.327-.17-.636-.45-.807-.282-.177-.633-.186-.922-.043-2.494 1.255-4.905 1.834-7.6 1.834-4.154 0-6.007-1.886-6.007-6.113V78.54h14.247c.523 0 .944-.426.944-.949V66.465c.02-.523-.4-.949-.93-.949zM475.28 65.567v-1.789c0-5.263 2.018-7.61 6.544-7.61 2.699 0 4.867.536 7.295 1.346.299.094.611.047.854-.132.25-.179.391-.466.391-.77v-10.91c0-.417-.268-.786-.67-.909-2.565-.763-5.847-1.546-10.761-1.546-11.958 0-18.279 6.734-18.279 19.467v2.74h-6.22c-.522 0-.95.426-.95.948v11.184c0 .522.428.949.95.949h6.22v44.409c0 .523.422.949.944.949h12.947c.523 0 .949-.426.949-.949V78.538h12.088l18.517 44.398c-2.102 4.665-4.169 5.593-6.991 5.593-2.281 0-4.683-.681-7.139-2.025-.231-.127-.505-.148-.754-.071-.247.087-.455.271-.56.511l-4.388 9.627c-.209.455-.03.989.408 1.225 4.581 2.481 8.716 3.54 13.827 3.54 9.56 0 14.844-4.453 19.502-16.433l22.461-58.04c.113-.292.079-.622-.1-.881-.178-.257-.465-.412-.779-.412h-13.478c-.404 0-.765.257-.897.636l-13.807 39.438-15.123-39.464c-.138-.367-.492-.61-.884-.61h-22.12zM446.5 65.51h-12.947c-.523 0-.949.426-.949.949v56.485c0 .523.426.949.949.949H446.5c.522 0 .949-.426.949-.949V66.463c0-.523-.42-.949-.95-.949zM440.1 39.791c-5.129 0-9.291 4.152-9.291 9.281 0 5.132 4.163 9.289 9.291 9.289 5.127 0 9.285-4.157 9.285-9.289 0-5.128-4.16-9.281-9.28-9.281zM553.52 83.671c-5.124 0-9.111-4.115-9.111-9.112s4.039-9.159 9.159-9.159c5.124 0 9.111 4.114 9.111 9.107 0 4.997-4.04 9.164-9.16 9.164zm.05-17.365c-4.667 0-8.198 3.71-8.198 8.253 0 4.541 3.506 8.201 8.151 8.201 4.666 0 8.201-3.707 8.201-8.253 0-4.541-3.51-8.201-8.15-8.201zm2.02 9.138l2.577 3.608h-2.173l-2.32-3.31h-1.995v3.31h-1.819v-9.564h4.265c2.222 0 3.683 1.137 3.683 3.051.01 1.568-.9 2.526-2.21 2.905zm-1.54-4.315h-2.372v3.025h2.372c1.184 0 1.891-.579 1.891-1.514 0-.984-.71-1.511-1.89-1.511z"/></svg>
```

That is 4,383 bytes, amounting to 11,6% savings respect the original image.

We can achieve further improvements by simplifying paths and rounding the numbers. For example, instead of having a viewbox of 566.93 x 170.04 we could convert it to 567 x 170. Same thing with the position of the points in the paths.

If you are interested in this topic, I recommend you to read this series of posts by [Andreas Larsen](https://twitter.com/larsenwork):

- [Optimising SVGs for Web Use - Part 1](https://medium.com/larsenwork-andreas-larsen/optimising-svgs-for-web-use-part-1-67e8f2d4035)
- [Optimising SVGs for Web Use - Part 2](https://medium.com/larsenwork-andreas-larsen/optimising-svgs-for-web-use-part-2-6711cc15df46)
- [Optimising SVGs for Web Use - Part 2½](https://medium.com/larsenwork-andreas-larsen/optimising-svgs-for-web-use-part-2-1-598815d74f9c)

I spent some time optimizing the Spotify logo following Andreas’ tips. You can read more about it [on a post I wrote](/optimising-svgs/). I managed to get the logo down to 1,859 bytes, or 62,7% reduction from the original image. The resulting image is visually almost identical to the original one.

[I created a codepen](https://codepen.io/jmperez/pen/BjYaKg) so you can switch between the 2 versions and see it more clearly.

{% codepen jmperez BjYaKg 0 result 400 %}

### Tip 3: Responsive logo!

SVG is really powerful and people are discovering more use cases every day. We can use SVG to create a responsive logo that changes its contents depending on the size of the image. That’s right, the size of the image, not the viewport. This is similar to what container queries are supposed to do, but we can do it today.

Take for example the [Spotify for Artists site](https://artists.spotify.com). On narrow windows it shows the Spotify logo + “for Artists”.

<img
    style="max-width:100%; border: 0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1537603269/spotify-svg/spotify-artists-logo-header.jpg 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1537603269/spotify-svg/spotify-artists-logo-header.jpg 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1537603269/spotify-svg/spotify-artists-logo-header.jpg 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1537603269/spotify-svg/spotify-artists-logo-header.jpg 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1537603269/spotify-svg/spotify-artists-logo-header.jpg"
    alt="Spotify logo on Spotify's Artists page" />

On wider windows it overrides the logo, using a wider one composed of the Spotify logo with “Spotify” + “for Artists”.

<img
    style="max-width:100%; border: 0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1537603271/spotify-svg/spotify-artists-logo-header-wide.jpg 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1537603271/spotify-svg/spotify-artists-logo-header-wide.jpg 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1537603271/spotify-svg/spotify-artists-logo-header-wide.jpg 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1537603271/spotify-svg/spotify-artists-logo-header-wide.jpg 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1537603271/spotify-svg/spotify-artists-logo-header-wide.jpg"
    alt="Spotify logo on Spotify's Artists page (wide version)" />

Instead of serving 2 different SVGs it's possible to serve a single one. Then we define the width and height for the logo and let the logo render one of the versions. The advantage is a smaller payload since we can reuse elements like the Spotify circle logo inside the SVG.

“[Building a responsive image](https://medium.com/9elements/building-a-responsive-image-e4c6229fa1f6)” is a post that explains how to achieve this. It shows how to create a responsive logo with 4 different versions, including a rotated/vertical one. You can see [a demo on codepen](https://codepen.io/enbee81/full/QrNRdm/).

<img
    style="max-width:100%; border: 0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1537603825/spotify-svg/9elements.jpg 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1537603825/spotify-svg/9elements.jpg 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1537603825/spotify-svg/9elements.jpg 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1537603825/spotify-svg/9elements.jpg 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1537603825/spotify-svg/9elements.jpg"
    alt="Responsive logo for 9elements" />
<small class="caption">Taken from [Building a responsive image](https://medium.com/9elements/building-a-responsive-image-e4c6229fa1f6)</small>

I thought I would do the same for the Spotify logo, switching between the “circle” and the “circle + Spotify” versions. I created [a codepen to demo it](https://codepen.io/jmperez/pen/ERMxmZ).

{% codepen jmperez ERMxmZ 0 result 400 %}

The code for the responsive Spotify logo looks like this:

```html
<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" xmlns:xlink="http://www.w3.org/1999/xlink">
 <style>
        .square { visibility: visible; }
        .landscape { visibility: hidden; }
        @media (min-aspect-ratio: 1118/335) {
            .square { visibility: hidden; }
            .landscape { visibility: visible; }
        }
 </style>
 <symbol id="c" viewBox="0 0 335 335">
 <path d="M0 167C0 259 75.7738 335 167.5 335C259.226 335 335 259 335 167C335 75 259.226 0 167.5 0C75.7738 0 0 75 0 167ZM229.315 245C190.432 221 140.58 215 82.753 228C68.7946 230 66.8006 210 78.7649 208C142.574 193 196.414 200 240.283 227C251.25 234 240.283 251 229.315 245ZM246.265 200C201.399 172 132.604 164 79.7619 180C62.8125 185 56.8304 159 72.7827 155C133.601 137 208.378 146 260.223 178C274.182 187 260.223 209 246.265 200ZM71.7857 129C54.8363 135 43.869 106 62.8125 99C121.637 81 221.339 84 283.155 121C300.104 130 284.152 158 266.205 148C212.366 116 122.634 113 71.7857 129Z" fill="black" />
 </symbol>
 <symbol id="s" viewBox="0 0 732 203">
 <path d="M64.75 143C47.75 143 31.75 137 17.75 123C16.75 123 16.75 124 16.75 124L0.75 143C-0.25 144 -0.25 145 0.75 146C18.75 162 40.75 170 64.75 170C98.75 170 119.75 151 119.75 123C119.75 99 104.75 86 69.75 77C40.75 70 35.75 65 35.75 55C35.75 45 45.75 39 58.75 39C71.75 39 83.75 44 97.75 54C97.75 54 98.75 55 99.75 55C100.75 55 100.75 54 100.75 54L114.75 34C115.75 33 115.75 33 114.75 32C98.75 19 79.75 12 58.75 12C27.75 12 5.75 31 5.75 58C5.75 87 25.75 96 57.75 104C85.75 110 89.75 116 89.75 126C89.75 137 79.75 143 64.75 143ZM159.75 66V53C159.75 52 158.75 51 157.75 51H131.75C130.75 51 129.75 52 129.75 53V200C129.75 201 130.75 202 131.75 202H157.75C158.75 202 159.75 201 159.75 200V154C169.75 165 180.75 170 195.75 170C222.75 170 249.75 149 249.75 109C249.75 69 222.75 49 195.75 49C180.75 49 169.75 54 159.75 66ZM189.75 144C171.75 144 158.75 129 158.75 109C158.75 89 171.75 75 189.75 75C207.75 75 219.75 89 219.75 109C219.75 129 207.75 144 189.75 144ZM257.75 110C257.75 144 284.75 170 319.75 170C354.75 170 381.75 143 381.75 109C381.75 75 355.75 49 320.75 49C285.75 49 257.75 76 257.75 110ZM287.75 109C287.75 89 300.75 75 319.75 75C338.75 75 352.75 90 352.75 110C352.75 130 339.75 144 320.75 144C301.75 144 287.75 129 287.75 109ZM427.75 51V22C427.75 21 427.75 20 426.75 20H400.75C399.75 20 398.75 21 398.75 22V51H385.75C384.75 51 383.75 52 383.75 53V75C383.75 76 384.75 77 385.75 77H398.75V135C398.75 158 409.75 170 432.75 170C441.75 170 450.75 168 457.75 164C458.75 164 458.75 163 458.75 162V141C458.75 140 458.75 139 457.75 139H455.75C450.75 142 444.75 143 439.75 143C431.75 143 427.75 139 427.75 131V77H457.75C458.75 77 459.75 76 459.75 75V53C459.75 52 458.75 51 457.75 51H427.75ZM556.75 48C556.75 37 560.75 33 569.75 33C574.75 33 579.75 33 584.75 35H585.75C585.75 35 586.75 34 586.75 33V12C586.75 11 586.75 10 585.75 10C580.75 8 573.75 7 563.75 7C539.75 7 527.75 21 527.75 46V51H514.75C513.75 51 512.75 52 512.75 53V75C512.75 76 513.75 77 514.75 77H527.75V166C527.75 167 528.75 168 529.75 168H555.75C556.75 168 556.75 167 556.75 166V77H581.75L618.75 166C614.75 175 610.75 177 604.75 177C599.75 177 594.75 176 589.75 173H588.75L587.75 174L578.75 193C578.75 194 578.75 196 579.75 196C588.75 201 596.75 203 606.75 203C625.75 203 636.75 194 645.75 170L690.75 54V52C690.75 51 689.75 51 688.75 51H661.75C660.75 51 660.75 52 660.75 53L632.75 131L602.75 53C602.75 52 601.75 51 600.75 51H556.75V48ZM473.75 51C472.75 51 471.75 52 471.75 53V166C471.75 167 472.75 168 473.75 168H499.75C500.75 168 500.75 167 500.75 166V53C500.75 52 500.75 51 499.75 51H473.75ZM467.75 18C467.75 28 476.75 37 486.75 37C496.75 37 504.75 28 504.75 18C504.75 8 496.75 0 486.75 0C476.75 0 467.75 8 467.75 18ZM712.75 87C722.75 87 731.75 79 731.75 69C731.75 59 722.75 51 712.75 51C702.75 51 694.75 59 694.75 69C694.75 79 702.75 87 712.75 87ZM712.75 53C721.75 53 729.75 60 729.75 69C729.75 78 721.75 85 712.75 85C703.75 85 696.75 78 696.75 69C696.75 60 703.75 53 712.75 53ZM716.75 71C719.75 70 721.75 68 721.75 65C721.75 61 717.75 59 713.75 59H705.75V78H709.75V72H713.75L717.75 78H722.75L716.75 71ZM713.75 62C715.75 62 717.75 63 717.75 65C717.75 67 715.75 68 713.75 68H709.75V62H713.75Z" fill="black" />
 </symbol>
 <symbol id="landscape" viewBox="0 0 1118 335">
 <use xlink:href="#c" x="0" y="0" width="335" height="335" />
 <use xlink:href="#s" x="386" y="77" width="732" height="203" />
 </symbol>

 <use class="square" xlink:href="#c" x="0" y="0" width="100%" height="100%" />
 <use class="landscape" xlink:href="#landscape" x="0" y="0" width="100%" height="100%" />
</svg>
```

[After minification](/demos/svg-logo/logo.min.svg), the logo weights 4,423 bytes, which is still smaller than the original logo (4,960 bytes).

### Conclusion

There are many ways we can optimize the delivery of SVGs. Even though they are highly compressible and usually small, there is usually room for delivering them better.

I hope this post has showed you some ways to optimize SVGs and some of its capabilities.
