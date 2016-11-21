---
layout: post
title: 'Tips to implement an embeddable widget'
date: 2013-12-19 17:41:06+00:00
tags:
  - widgets
permalink: embeddable-widget
---

Embeddable widgets (or gadgets) allow users to easily include
functionality provided by another site. Some examples are [Twitter
button](https://about.twitter.com/resources/buttons) or the
[Facebook like button](https://developers.facebook.com/docs/plugins/like-button/),
but also more complex ones
like [Disqus comments](http://disqus.com/websites/). They can be included on a site easily,
normally through an `iframe` or some JS snippet which will create an
iframe. Although at first sight these widgets seem basic, lots of things
need to be taken into account when implementing one.

<!-- more -->
## Embeddable code

These widgets are meant to be easy to add to any site. And the style and functionality of the widget shouldn't be affected by that from the page in which it is being embedded. Thus, a natural solution for this problem is to use `iframe`s. The iframe can be included directly, or appended through a Javascript code. Using the Javascript code has several advantages:

-   It can expose an API to manipulate the widget and subscribe to
    events triggered by it more naturally (more on that later).
-   Users can control better when to show the iframe (lazy loading).
    Although with iframes it is possible, it is more explicit when using
    JS.
-   Passing parameters to the widget feels better than doing the same
    through a `data` attribute. And it allows passing parameters such as
    JSON objects or functions that more awkward to include as a `data`
    attribute.
-   The same JS code can add more functionalities, like generating other
    types of buttons or even providing a whole Javascript SDK.
-   It allows listening to `resize` events and change the layout of the
    widget accordingly.

And disadvantages:

-   Sometimes it is not possible for users to include custom JS code
    where they want to include the widget.
-   Includes an extra request for a script file. In most of the cases
    the script will just be injecting the iframe, in a similar way as
    other scripts for other widgets. Thus, a regular site can end up
    requesting many JS files doing something very similar. I recommend
    you to have a look at [C3PO](http://www.phpied.com/c3po-common-3rd-party-objects/)
    which explains a common loader for this kind of widgets.

You can read more on the differences between providing an iframe code
snippet or a JS one on [StackOverflow](http://stackoverflow.com/questions/5359815/widget-design-what-is-better-iframes-or-javascript).

## Other things to consider

### Versioning

Releasing a new version of the widget and see it automatically updated
on every site is a great experience. But if your change is a breaking
one (i.e. different attributes, different size...) then you need to
create a different version of the widget, or will break the sites using
it. So make sure you include an identifier for the version in the URL
for your iframe or the JS resource in the snippet.

### Options

Most widgets allows customisation through a set of options. These
usually include:

-   **Target**: If you are liking a page it will be the URL of the page.
    If you are following a user it will be the identifier for the user.
-   **Layout**: Different layouts for different sizes of the button.
-   **Theme**: Light / dark. You might want your widget to have a
    transparent background so it merges with that on the site. In that
    case, be careful with the color of your text because it can become
    unreadable.
-   **Locale**: The language that will be used to localise the text of
    the widget (see the [Localisation section](#localisation) for more info).
![Youtube Subscribe Button](/assets/images/posts/youtube-subscribe-button.png)

_Notice the light and dark themes and try to foresee what would happen if
you embed the light one in a dark site._

These options are normally specified as data attributes in the iframe, or passed to the JS function that creates the widget if using a JS snippet.

### Browser compatibility

Most basic widgets like buttons should not I would encourage you to support as many browsers as possible. You don't have as much control on the device capabilities and the type of user as if you were coding a full web page, so try to make your widget work in every possible scenario.

### Performance (and making it async)

Your widget will affect the performance of the sites using it. Thus, it
is important to follow the usual rules (see PageSpeed, YSlow). Try also
to use scarcely large libraries. In addition, you shouldn't use
`document.write`, or the page using it will block rendering. If your
snippet needs to load a JS file, do it in a async way. If not, if the
request for your file fails, it will become a [SPOF](http://www.stevesouders.com/blog/2011/10/13/frontend-spof-survery/).

Best way is to use an [async snippet](http://calendar.perfplanet.com/2013/browser-wishlist-2013/#async3pc). The general pattern is:

```js
(function() {
  var d = document,
      h = d.getElementsByTagName('head')[0],
      s = d.createElement('script');

  s.type = 'text/javascript';
  s.async = true;
  s.src = '/js/myfile.js';
  h.appendChild(s);
} )();
```

You can find plenty of examples by having a look at [this list of
popular scripts with async loading](https://developers.google.com/speed/docs/insights/UseAsync).

### Localisation

If you want to localise your widget, there are several options. You can detect the language by reading the HTTP `Accept-Language` header sent in the request, and localise your widget accordingly. Thus, it will be rendered using the preferred user's language, and you could default to English if you can't provide a localisation for the languages listed in the header.

Even though that is a good solution, the widget can still be rendered in a language different from the language of the rest of the page in which your widget has been embedded, which is not optimal. A better solution is to support an option in the embed code so the page can force a specific locale for the widget.

You may need to adjust the width of the widget to accommodate different languages.

The localisation also applies to numbers. If your widget shows a quantity (i.e. the amount of likes, followers, subscribers) take into account the localisation for the number. Also, you may consider rounding the number, which also should be localised. Thus, 24,356,000 could become '24M' in English, or '24 millones' in Spanish, where '24M' would be ambiguous.

If you are interested in rounding, [here you have a jsFiddle showing the algorithm used in Twitter's Follow Button](http://jsfiddle.net/sUVFC/).

## Useful resources

If you are thinking of using a SDK, I definitely recommend checking out [this JavaScript SDK design guide] (http://sdk-design.js.org/).

## Conclusion

Build widgets that don't affect the performance of the sites using it,
and strive for compatibility.
