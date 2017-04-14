---
layout: post
title: 'Line-height, multiline ellipsis and responsiveness'
date: 2013-07-09 21:03:12+00:00
tags:
  - css
  - responsive
permalink: line-height-mutiple-line-ellipsis-responsiveness
---

Recently I was implementing a pinterest-ish layout in which the elements have a specific height. These elements contain a title that can expand multiple lines, and an additional text to which I would like to apply a multi-line ellipsis. Initially, I don't know how many lines of text the title will take. The text can be arbitrarily long, and depending on the screen width this number will vary.

<!-- more -->
## Multiline ellipsis

There are [many](http://css-tricks.com/line-clampin/) [ways](http://www.mobify.com/blog/multiline-ellipsis-in-pure-css/) of achieving multiline ellipsis or line clamping. However, I wanted to use an approach that didn't need javascript and could work not knowing in advance how many lines of text are available.

## Line-height to the rescue

I have coded [a jsfiddle](http://jsfiddle.net/vEvbG/5/) that helps to visualise how this works. Try
changing the width of the "Result" window dragging the vertical separator.

<iframe src="https://jsfiddle.net/vEvbG/5/embedded/result,html,css" height="300" width="100%" allowfullscreen="allowfullscreen" frameborder="0"></iframe>

And a screenshot, in case you have problems visualising the jsfiddle:
![Same line-height (small items)](/assets/images/posts/line-height-responsive-01.png)
_Using the same line-height for the text. Notice that the title can take a different amount of lines but the text underneath is not cropped._

The best thing is that you can change the available space, and the image (represented with a grey square) will scale properly, the title will adapt to the available room and the text underneath will try to fill the available space. Check [this example](/assets/images/posts/line-height-responsive-02.png) that shows the same items when the width increases. I found this out having a look at the Discover feature on the [Spotify Web Player](https://play.spotify.com), I realized that even though the images were scaled when changing the screen width, the text underneath was never cropped. It turns out that every line of text has the same height, regardless of the font size. Thus, the title can expand multiple lines and will push the rest of the text. The lack of ellipsis is solved by adding a "More" link:
![Detail of an item in the Spotify Discover feature. When hovering, the "More" link is shown](/assets/images/posts/discover-item-hover.jpg)
_Detail of an item in the Spotify Discover feature. When hovering, the "More" link is shown._
