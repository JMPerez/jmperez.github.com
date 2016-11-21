---
layout: post
title: Subtle animations to improve the user experience
date: 2014-05-01 11:30:00+02:00
tags:
  - animations
permalink: animations-improve-ux
---

I have just come across the post [Improve the payment experience with animations - Behind the scenes of Stripe Checkout
](https://medium.com/p/3d1b0a9b810e). I must say that I don't usually take into account animations when building a UI, since the priority is always the layout and I seldom have time to enhance the interface with subtle animations.

After reading the article one starts appreciating those transitions that became a thing when the iPhone went out (maybe [too much on iOS7?](http://www.theguardian.com/technology/2013/sep/27/ios-7-motion-sickness-nausea). The good thing is that good animations make the interface look smoother and more professional, and it just feels great to use it. However, it is very easy to end up overusing animations and applying them to lots of elements just because it is possible.

<!-- more -->
> If you disable animations, the flow should feel broken; if it is not, this might mean your animations are superfluous.
— _[Michaël Villar](https://medium.com/p/3d1b0a9b810e)_

On the web, it is sometimes difficult to create proper animations without lots of hacks like duplicating elements and setting fixed dimensions and absolute positioning. And this, together with responsive design, makes it a real challenge.

There are many websites for getting inspired and seeing how animations are used in practice. Many of those sites are listed on  [Interface Animations and Transitions: where to get inspiration](https://blog.stephaniewalter.fr/en/interface-animations-and-transitions-where-to-get-inspiration/).

## Practical example
I would like to save a form and give feedback to the user. One possibility is to click on save and then show an [alert](http://getbootstrap.com/components/#alerts) on top of the form. However, what should we do when the user starts modifying the form again? One possibility is to remove the alert. Collapsing the alert would reflow the form and would look a bit ugly. Another possibility is to use something like the notifications shown on Gmail on top of the page, fixed positioned.

If the user continues editing and we didn't remove the alert, then when she saves again she doesn't get any feedback about the most recent saving action. Does that alert refer to this save or to the previous one?

Then I thought it would be useful to have the Save button change between Save - Saving - Saved, similar to [the example on the post](https://medium.com/p/3d1b0a9b810e). A first draft was this:

<iframe src="https://jsfiddle.net/JMPerez/khjs3x9x/show/" width="100%" height="150px"></iframe>

After that, I found [this post](http://minimalmonkey.com/fun-animations-with-css3/) and applied some transitions:

<iframe src="https://jsfiddle.net/JMPerez/kbtr8mqs/show/" width="100%" height="170px"></iframe>

Even though I'm not super happy with the result I think that a button like that with some animation can be very useful when saving data in a form.
