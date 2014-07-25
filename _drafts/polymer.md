It's been a few weeks since I last posted. Rather than being on vacations resting on a beach, I'be been busy trying out some things I had in my backlog, such as **[Polymer](http://www.polymer-project.org/)**.

## Polymer

Web components group a collection of standards that allow the creation of custom HTML elements. These elements encapsulate HTML, CSS and Javascript which is not accessible from external code.

Browser support at the moment is limited, so until web components are widely supported, there are polyfills such as Polymer or [X-Tag](http://www.x-tags.org/) to getting started.

Google has launched a bunch of Polymer elements, both [Core elements](http://www.polymer-project.org/docs/elements/core-elements.html) and [Paper elements](http://www.polymer-project.org/docs/elements/paper-elements.html), which match their concept of Material Design. As a developer hearing about new things being released every day, I have started to appreciate a proper documentation accompanying the code, and I think the developers in charge of Polymer have made a great work.

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
When components are the new kids on the block. Expect overuse and misuse in the coming months. Have you heard about jQuery plugins? There are plugins for everything. Some of them very useful, some of them easily replaced by a short snippet.

I foresee we will have web components for lots of applications that can be solved with little extra markup and a bit of Javascript. Why would I use a `div` with a `class` when I can use my own HTML tag?

As a developer be aware of that. Assess the impact of every element you introduce in your site.

### Performance impact of a Polymer component

If you have heard of Vulcanize, you can skip this section.

Components are included using an import in your page. That means 1 request. But every component can encapsulate request other resources such as images, CSS and Javascript, like a regular web page. And not only that. A key point about components is that they should behave like that,  like components, leveraging the implementation of bigger ones using small ones. Think of having a component for rendering an API console to try out a REST API. It could look like this:

As you see,  it uses other components like pieces of a puzzle. Someone including the Console component on a page will make the browser trigger a request per ech of the different components html pages. You can imagine that we would end up with a ton of requests pretty soon.
