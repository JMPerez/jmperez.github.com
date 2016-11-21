---
layout: post
title: Polymer and Web Components
date: 2014-08-05 18:30:00+02:00
tags:
  - web components
  - polymer
permalink: implementing-polymer-element
---

It's been a few weeks since I last posted. Rather than being on vacations resting on a beach, I have be been busy trying out some things I had in my backlog, and one of them is **[Polymer](http://www.polymer-project.org/)**. Read below about what Polymer is and my impressions after creating some elements.

<!-- more -->
## Polymer

Web components are a collection of standards that allow the creation of custom HTML elements. These elements encapsulate HTML, CSS and Javascript which is not accessible from external code. Browser support at the moment is limited, so until web components are widely supported, there are polyfills such as Polymer or [X-Tag](http://www.x-tags.org/) to get started.

Google has launched a bunch of Polymer elements, both [Core elements](http://www.polymer-project.org/docs/elements/core-elements.html) and [Paper elements](http://www.polymer-project.org/docs/elements/paper-elements.html), which follow their concept of Material Design. As a developer hearing about new things being released every day, I have started to appreciate a proper documentation accompanying the code, and I think the developers in charge of Polymer have made a great work.

I encourage you to check out their site, which is also a great example of a Jekyll site and [is available on GitHub](https://github.com/Polymer/docs). They even have "Edit on GitHub" links to fork the project and send pull requests to improve it. The documentation contains lots of examples of already made elements, a tutorial about creating one from scratch (called seed-element) and an awesome drag&drop [designer](http://www.polymer-project.org/tools/designer/) that is open source and supports, right from the start, importing your own Polymer elements.

### Seed Element

The seed-element is a basic component you can use as the boilerplate for yours. Even better, it generates a documentation page based on the JSDoc comments of the code, describing the attributes, properties and events of the element. In addition, you can provide a demo page. This page is very handy for showing how the element works, and making use og GitHub pages it is straightforward to serve the page from the element's GitHub repo. Did I mention it also contains a basic test spec plus a test runner?

Following the seed-element file structure has another advantage. There exist sites that index web components that developers are building. So far, I know about these ones:

- [Custom Elements](http://customelements.io/)
- [Component Kitchen](http://component.kitchen)

It's enough with adding a `"web-components"` keyword in the `bower.json` manifest:

```
"keywords": [
  "web-components"
]
```

_Note: The `seed-element` project defines the `"keywords"` value as a comma separated string (i.e. `"seed, polymer, web-components"`). If you see that your web component is not indexed in those sites, try rewriting it as an array of strings instead._

I have been developing myself some components using Polymer, since I like the concept of a self contained piece of HTML, CSS and Javascript. It feels a bit like an AngularJS directive (except for the CSS) and a bit like a great replacement for `iframe`s.

### Replacement for iframes?
Yes. We have used iframes for isolating some functionality or for preventing the style of the outer page from affecting the design of a component. Some widgets had to be implemented as iframes, and this would lead to problems for communicating back and forth between the widget and the hosting page, or the impossibility of detecting changes in window size and resize the iframe accordingly.

Although web components don't fix all the issues, they present themselves as a good candidate to replace iframes in certain use cases.

### A bless and a curse
Web components are the new kids on the block. Expect overuse and misuse of them in the coming months. Have you heard about jQuery plugins? There are plugins for everything. Some of them very useful, some of them easily replaced by a short snippet.

I foresee we will have web components for lots of applications that can be solved with little extra markup and a bit of Javascript. Why would I use a `div` with a `class` when I can use my own HTML tag?

As a developer be aware of that. Assess the impact of every element you introduce in your site.

### Performance impact of a Polymer component

Components are included using an import directive in your page:

```html
<link rel="import" href="my-component.html">
```

This result in one request. But a component can request other resources such as images, CSS and Javascript, in the same way a regular web page does. This may require extra requests. And not only that, since a key point about components is that they should behave like small composable pieces that can be used to create larger components.

Take a look at the following example, which uses 3 components:

```html
<!DOCTYPE html>
<html>
	<head>
		<script src="../platform/platform.js"></script>
		<link rel="import" href="../components/core-input.html">
		<link rel="import" href="../components/spotify-search.html">
		<link rel="import" href="../components/spotify-previewbutton.html">
	</head>
	<body>
		<template is="auto-binding">
		    <core-input id="input" placeholder="Type the name of a track" />
		    <spotify-search query="{{ $.input.value }}" id="search" type="track" />
		    <spotify-previewbutton uri="{{ $.search.result[0].uri }}" />
		</template>
		<script>
			...
		</script>
	</body>
</html>
```

The `core-input` renders an `input` HTML element where the user can type the name of a track. The `spotify-search` component takes the track name and searches for tracks in Spotify matching that name. The `spotify-previewbutton` renders a player with a "play" button to play the track. There are 3 requests to fetch the components, and depending on their implementation they will trigger even more requests.

### Inlining dependencies

Should components inline their dependencies? This is a bit unclear at the moment. The `seed-element` project inlines the Javascript code in its `seed-element.html` file, but it doesn't inline the CSS, which lives in `seed-element.css`. If you choose not to inline the JS code, the `index.html` of the project, which shows basic documentation about the usage of the component, will not process the JSDoc comments in the code, not rendering this useful information.

Including several components may incur in lots of requests. It's turn to **vulcanize**.

### Vulcanize

[Vulcanize](https://github.com/Polymer/vulcanize) is used to concatenate a set of Web Components into one file.

It recursively pulls in all your imports, flattens their dependencies and spits out something that can potentially reduce the number of network requests your app makes.

I recommend you to have a look at [Concatenating Web Components with Vulcanize](http://www.polymer-project.org/articles/concatenating-web-components.html), where Addy Osmani explains how to use this tool.

## Go and experiment with it

The best way of learning a library is to use it. Build a simple web component, try to use it, share it on Github, and publish it on Bower. It will not only help you understand how to create one of these components, but also understand better what happens when you use this paradigm in your site.
