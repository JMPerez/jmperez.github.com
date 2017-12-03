---
layout: post
title: React Alicante 2017 - A summary of the talks
date: 2017-10-01 20:00:00+02:00
description: First React conference in Spain, covering React and React Native. An international event with workshops and talks.
permalink: react-alicante-2017
image:
  url: /assets/images/posts/react-alicante-glenn-reyes.jpg
  width: 2000
  height: 1123
tags:
  - web
  - conference
  - react
---

This weekend I have been in Spain to attend [React Alicante](http://reactalicante.es). This is the first edition of this conference, focused in React and React Native.

Continue reading to know more about the event and its contents.

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto,f_auto,c_scale,w_1368/v1510326427/react-alicante-glenn-reyes_kokxlw.jpg"
    sizes="(max-width: 768px) 100vw, 684px" alt="Glenn Reyes speaking at React Alicante" />
<small class="caption">Glenn Reyes speaking at React Alicante</small>

<!-- more -->

The conference was 3-day long, one day with workshops introducing React and React Native, and 2 days for talks in a single track.

It’s the first edition of the conference, and I believe it’s also the first React conference arranged in Spain. It was truly international, with all talks delivered in English (something unusual in Spain) and 250 attendees from 25+ countries.

The most impressive is that **it was arranged by 2 Spanish expats who form the company [Limenius](https://limenius.com/), based in Munich**. [Nacho](https://twitter.com/nacmartin) and [Victoria](https://twitter.com/vicqr) did an impressive job, putting together a top-level conference with a great line-up and contents. They managed to prove that its possible to arrange a good conference in a well-communicated location like Alicante, with good weather and interesting attractions, while making it affordable (the regular tickets for the talks were 99).


<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto,f_auto,c_scale/v1510331531/react-alicante-nacho-martin_wzczdx.jpg"
    sizes="(max-width: 768px) 100vw, 684px" alt="Nacho Martín speaking at React Alicante" />
<small class="caption">Nacho Martín speaking at React Alicante</small>

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto,f_auto,c_scale/v1510331531/react-alicante-flavio-corpa_tg37vj.jpg"
    sizes="(max-width: 768px) 100vw, 684px" alt="Flavio Corpa during his talk" />
<small class="caption">Flavio Corpa during his talk</small>

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto,f_auto,c_scale/v1510331531/react-alicante-overview_hncowx.jpg"
    sizes="(max-width: 768px) 100vw, 684px" alt="Overview of React Alicante" />
<small class="caption">General overview of the full room</small>

There were several talks touching on style guides and the difficult world of creating UI components that can be customisable in options and theming. Other topics were forms, CSS in JS, Redux/Mobx, code splitting, GraphQL, and React Native.

They covered pretty well the current ecosystem of tools when working with React, and they shared learnings that can be applied to our daily jobs.

Do you want more details about the talks? Continue reading for a short description of each of them and links to their slides.

### Talks — Conference Day 1

#### The effect of React on web standards by [Karl Horky](https://twitter.com/karlhorky) - [Slides](https://work.karlhorky.com/talks/packages/2017-09-28-react-alicante-the-effect-of-react-on-web-standards/)

An overview of how the Web Standards committees work and how libraries (jQuery, Dojo, Angular, Knockout, Ember, React) and languages (CoffeeScript) have helped to introduce changes in the DOM and browser APIs.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">&quot;React - Not just a library&quot; indeed!<a href="https://twitter.com/karlhorky?ref_src=twsrc%5Etfw">@karlhorky</a> opening the <a href="https://twitter.com/ReactAlicante?ref_src=twsrc%5Etfw">@ReactAlicante</a> conference by talking about webstandards 🙌 <a href="https://t.co/4tnVZoyn79">pic.twitter.com/4tnVZoyn79</a></p>&mdash; React Vienna Meetup (@ReactVienna) <a href="https://twitter.com/ReactVienna/status/913665862829297665?ref_src=twsrc%5Etfw">29 September 2017</a></blockquote>

It also included a summary of the current TC39 standards proposals and their stage in the specification process.

#### Modular CSS by [Andrey Okonetch](https://twitter.com/okonetchnikov) - [Slides](https://speakerdeck.com/okonet/modular-css-v2-css-in-js-edition)

This was a fantastic talk taking us through how we used to build sites and the challenges to keep CSS maintainable. It goes through all the stages from pre-BEM, BEM, CSS modules and JSS (CSS in JS).

Andrey explains how CSS in JS is not such a bad idea, the same way JSX broke the separation of concerns by getting closer to the components logic.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">Gmail and Google Maps in the history of CSS with <a href="https://twitter.com/okonetchnikov?ref_src=twsrc%5Etfw">@okonetchnikov</a> at <a href="https://twitter.com/ReactAlicante?ref_src=twsrc%5Etfw">@ReactAlicante</a> <a href="https://t.co/3zfpAp2WqS">pic.twitter.com/3zfpAp2WqS</a></p>&mdash; Karl Horky (@karlhorky) <a href="https://twitter.com/karlhorky/status/913683058594902017?ref_src=twsrc%5Etfw">29 September 2017</a></blockquote>

At the end, he talks about the ecosystem of tools to help us either inlining CSS in JS or creating optimised CSS rules that reduce code duplication. In short, it lets machines do what they are best at.

The talk covers a topic that is really hot at the moment. In fact several other talks also brought up the idea of moving the styles within the components to help with maintainability, theming and critical css rendering. If you like these topics I recommend you to check [Mark Dalgleishs talk at CSSConf EU 2017](https://www.youtube.com/watch?v=MT4D_DioYC8).

#### React >> Redux a development workflow by [Braulio Diez](https://twitter.com/braulio_sl)

Braulio was really energetic and gave a talk about how you might not always need Redux when working with React. I couldn’t find tweets nor slides from the talk, so I’ll wait for the videos to add more content.

#### React-Storybook: Design, Develop, Document and Debug your React UI components by [Marie-Laure Thuret](https://twitter.com/mlthuret) - [Slides](https://speakerdeck.com/mlthuret/storybook-dev-design-debug-and-document-your-ui-components)

I loved this talk! Do you know that feeling when you are listening someone explaining all your current pains and provides you with great solutions? That’s how I felt.

Not only did she talked about how to use StoryBook, but also how it was the source of truth and a communication tool with designers and between developers. You send a PR that makes a change in a component? Link directly to the story for that component so the reviewer sees the result without having to browse through the site.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr"><a href="https://twitter.com/mlthuret?ref_src=twsrc%5Etfw">@mlthuret</a> talking about documentation and Visual Regression Testing with StoryBook <a href="https://twitter.com/hashtag/ReactAlicante?src=hash&amp;ref_src=twsrc%5Etfw">#ReactAlicante</a> <a href="https://twitter.com/hashtag/NiceTalk?src=hash&amp;ref_src=twsrc%5Etfw">#NiceTalk</a> <a href="https://t.co/3trWkSmlIK">pic.twitter.com/3trWkSmlIK</a></p>&mdash; Gabriel Garcia Seco (@GGarciaSeco10) <a href="https://twitter.com/GGarciaSeco10/status/913712092900843521?ref_src=twsrc%5Etfw">29 September 2017</a></blockquote>

I was recently looking for tools to do visual regression testing to catch CSS issues, but in the end we decided to skip it. I liked that Marie-Laure talked about this and demoed [Loki](https://loki.js.org), which I didnt know about, that integrates with StoryBook and provides visual diffing. It looked easy to use and a great complement to unit tests and snapshot tests for components.

#### A practical guide to Redux Form by [Erik Rasmussen](https://twitter.com/erikras) - [Slides](https://speakerdeck.com/erikras/a-practical-guide-to-redux-form) and [Code](//github.com/erikras/reactalicante2017)

Im fortunate that I dont have to deal with forms that often. If I ever have to do it with React, I think I would go for [Redux Form](https://redux-form.com/).

Creating a form involves having multiple fields with a similar logic. It’s easy to end up duplicating code and dealing with unmaintainable code that only works for a given form. Redux Form helps removing boilerplate code and integrates beautifully with Redux.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">.<a href="https://twitter.com/erikras?ref_src=twsrc%5Etfw">@erikras</a> on the difficulties of using forms, including use in environments with unidirectional data flow such as React. <a href="https://t.co/qSteZV458r">pic.twitter.com/qSteZV458r</a></p>&mdash; Karl Horky (@karlhorky) <a href="https://twitter.com/karlhorky/status/913717121032519681?ref_src=twsrc%5Etfw">29 September 2017</a></blockquote>

Erik did a ver smooth live demo, going from a simple form as we would implement it, and showing how to add more functionality through Redux Form while refactoring the code.

I personally love it when I see examples of Higher-Order Components that simplify the code. It’s usually not obvious how they can solve some patterns, and it’s one of the most powerful features of functional programming applied to React.

#### React Native  Case study: From zero to a super hero app by [Ferran Negre](https://twitter.com/ferrannp) - [Slides](https://ferrannp.github.io/slides/react-native-zero-to-superhero/)

Ferran ent through some features that most mobile applications need to deal with, and explained the challenges to implement them using React Native. He applied it to an application he had developed to follow TV Series (it reminded me to [iShows](https://itunes.apple.com/us/app/ishows-tv-powered-by-trakt-tv/id992387872)).

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">So happy to have talked in front of such a huge audience (250) in the sunny and beautiful Alicante! <a href="https://twitter.com/hashtag/reactnative?src=hash&amp;ref_src=twsrc%5Etfw">#reactnative</a> <a href="https://twitter.com/hashtag/react?src=hash&amp;ref_src=twsrc%5Etfw">#react</a> <a href="https://twitter.com/ReactAlicante?ref_src=twsrc%5Etfw">@ReactAlicante</a> <a href="https://t.co/crlrB1ungY">pic.twitter.com/crlrB1ungY</a></p>&mdash; Ferran Negre (@ferrannp) <a href="https://twitter.com/ferrannp/status/913774705521430529?ref_src=twsrc%5Etfw">29 September 2017</a></blockquote>

It turns out developing React Native applications is not as straightforward as it seems, especially if you want to mimic exactly how a native application behaves in some cases. Some examples are the lack of automatic refresh of the app when changing the system language, or doing data synchronisation when the app is in the background. Ferran has been documenting lots of tips to solve this issues on his [Medium](https://medium.com/@ferrannp), and contributed with Java bridges to expose native functionality to React.

#### Mutable or Immutable? Lets do both! by [Mattia Manzati](https://twitter.com/MattiaManzati) - [Slides](https://mattiamanzati.github.io/slides-react-alicante-2017/)

Mattia compares MobX and Redux showing their pros and cons and then introduces [mobx-state-tree](https://github.com/mobxjs/mobx-state-tree) which aims to combine the best of MobXs mutability and Reduxs immutability.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">.<a href="https://twitter.com/MattiaManzati?ref_src=twsrc%5Etfw">@MattiaManzati</a> blowing people’s minds at <a href="https://twitter.com/hashtag/ReactAlicante?src=hash&amp;ref_src=twsrc%5Etfw">#ReactAlicante</a>. 👍 <a href="https://t.co/vD7Cbjm8yP">pic.twitter.com/vD7Cbjm8yP</a></p>&mdash; Erik Rasmussen (@erikras) <a href="https://twitter.com/erikras/status/913784924485844994?ref_src=twsrc%5Etfw">29 September 2017</a></blockquote>

Not having used myself MobX, and being comfortable with the simplicity of React, it was a bit difficult to wrap my head around the problems solved by the library.

#### Why I Love Create React App by [Valerii Sorokobatko](https://twitter.com/tuchk4) - [Write up](https://medium.com/@tuchk4/react-alicante-2017-why-i-love-create-react-app-ed2670b03cc3)

Valerii explains how they used create-react-app at his company to provide a unified developer experience and avoid dealing with config and setup, focusing on building features instead. I like how he shows that even though you might be tempted to eject, it might be better to find an alternative that keeps you using create-react-app and getting its updates.

I love that the talk is supported by [a write up on Medium](https://medium.com/@tuchk4/why-i-love-create-react-app-e63b1be689a3), which makes it easily digestible for someone that doesnt have time to go through the video.

#### Custom CSS is the path to inconsistent UI by [Artem Sapegin](https://twitter.com/iamsapegin) - [Slides](https://sapegin.github.io/slides/inconsistent-styles)

The title of this lightning talk is a strong statement, and Artem explains during his talk that we should avoid magic numbers and use components to solve typography and spacing in CSS.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">.<a href="https://twitter.com/iamsapegin?ref_src=twsrc%5Etfw">@iamsapegin</a> about standard UI design and solutions for this at <a href="https://twitter.com/ReactAlicante?ref_src=twsrc%5Etfw">@ReactAlicante</a> <a href="https://t.co/eB5NDnHsme">pic.twitter.com/eB5NDnHsme</a></p>&mdash; Karl Horky (@karlhorky) <a href="https://twitter.com/karlhorky/status/913745863297683456?ref_src=twsrc%5Etfw">29 September 2017</a></blockquote>

To solve spacing specifically he developed [react-spaceman](https://github.com/sapegin/react-spaceman) (see [the demo](https://sapegin.github.io/react-spaceman/)), inspired by [Nathan Curtis’ framework](https://medium.com/eightshapes-llc/space-in-design-systems-188bcbae0d62).

Artem is also the author of [Styleguidist](https://react-styleguidist.js.org/), which was subject of [Sara Vieira’s](https://twitter.com/NikkitaFTW) talk the day after (read more below).

#### Beyond JavaScript: The Real Benefit of React Native by [Wojciech Ogrodowczyk](https://twitter.com/sharnik)

This lightning talk tried to make us developers more critic about what languages we use.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">.<a href="https://twitter.com/sharnik?ref_src=twsrc%5Etfw">@sharnik</a> teaching about language choices, using an example of the Pirahã People in the Amazon <a href="https://t.co/PFd22TQnxF">pic.twitter.com/PFd22TQnxF</a></p>&mdash; Karl Horky (@karlhorky) <a href="https://twitter.com/karlhorky/status/913752918091866113?ref_src=twsrc%5Etfw">29 September 2017</a></blockquote>

Instead of saying we are JS developers we should consider ourselves developers and see the good and bad points of the different languages. Use the best tool for the job.

#### How to make React applications really reactive with Focal? by [Gregory Shehet](https://twitter.com/AGambit95) - [Slides](https://www.dropbox.com/sh/hnbra4ezcj72jj2/AAAHVE9lrkusriYtDsTyCr7Ga?dl=0)

Gregory went through an example application using Reactive Programming and Observables in his lightning talk, and showed how [Focal](https://github.com/grammarly/focal) can overcome the limitations of React for rendering Observables.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">.<a href="https://twitter.com/AGambit95?ref_src=twsrc%5Etfw">@AGambit95</a> on rendering observables within React using Focal at <a href="https://twitter.com/ReactAlicante?ref_src=twsrc%5Etfw">@ReactAlicante</a> <a href="https://t.co/LhmOofGgmj">pic.twitter.com/LhmOofGgmj</a></p>&mdash; Karl Horky (@karlhorky) <a href="https://twitter.com/karlhorky/status/913791213681115137?ref_src=twsrc%5Etfw">29 September 2017</a></blockquote>

### Talks — Conference Day 2

#### End to End testing React applications by [Forbes Lindesay](https://twitter.com/ForbesLindesay) - [Repo (with slides)](https://github.com/ForbesLindesay/end-to-end-testing-react-applications)

Forbes, who ran the [React workshop](https://github.com/ForbesLindesay/intro-to-react) at the conference, also gave a talk. Forbes used to work in the Ads team at Facebook London, and a very active programmer with many projects on GitHub.

In his talk he presented an alternative Testing Pyramid compose by static analysis + javascript unit tests + end to end tests, describing tools to use and the limitations of every step. Lots of these tools like Flow, Jest or Prettier have actually been created at Facebook and now for part of the workflow of many of us.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">Starting this second day of talks with End to end testing React applications by <a href="https://twitter.com/ForbesLindesay?ref_src=twsrc%5Etfw">@ForbesLindesay</a> <a href="https://twitter.com/hashtag/ReactAlicante?src=hash&amp;ref_src=twsrc%5Etfw">#ReactAlicante</a> <a href="https://t.co/h414HbNAqO">pic.twitter.com/h414HbNAqO</a></p>&mdash; ReactAlicante ⚛️🌞🥘 (@ReactAlicante) <a href="https://twitter.com/ReactAlicante/status/914025944855334912?ref_src=twsrc%5Etfw">30 September 2017</a></blockquote>

End to end tests usually present problems, being slow, unreliable and expensive. Forbes has worked on [cabbie](https://github.com/ForbesLindesay/cabbie) and [taxi-rank](https://github.com/ForbesLindesay/taxi-rank) to make this easier. Cabbie is a webdriver client for Node.js. With it you can control Chrome through chromedriver, but also run the tests using JSDom through taxi-rank, which can run way faster than controlling a real browser, and could be a good alternative in some cases.

#### Writing highly reusable React components by [Javi Velasco](https://twitter.com/javivelasco)

Javi is the author of [react-toolbox](http://react-toolbox.com), a suite of React components that use Material Design. The project started back in October 2015 and Javi explained some architectural decisions that were taken and he would address now in a different way.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">.<a href="https://twitter.com/javivelasco?ref_src=twsrc%5Etfw">@javivelasco</a> about to start showing us how to write highly reusable React components <a href="https://t.co/Iy0nzkP3Dx">pic.twitter.com/Iy0nzkP3Dx</a></p>&mdash; ReactAlicante ⚛️🌞🥘 (@ReactAlicante) <a href="https://twitter.com/ReactAlicante/status/914037890828718080?ref_src=twsrc%5Etfw">30 September 2017</a></blockquote>

I like these talks that show the evolution of a project since that’s what we live everyday with. We build for what’s needed today and try to make it last, but 2 years in a web project are very long and we quickly find better ways of dealing with past issues.

Javi explained the theming and customizable constraints imposed by those components, and how he was thinking of isolating the functionality in a [react-toolbox-core package](https://www.npmjs.com/package/react-toolbox-core) ([here the branch](https://github.com/react-toolbox/react-toolbox/tree/agnostic-components) and [demo](https://github.com/javivelasco/react-toolbox-airbnb)), and make it easy to use any CSS-in-JS (aka JSS) method for styling.

#### The Dream of Styleguide Driven Development by [Sara Vieira](https://twitter.com/NikkitaFTW) - [Slides](https://styleguide-driven-development-anvohjeduy.now.sh/) and [Repo](https://github.com/SaraVieira/styleguide-driven-development)

Sara talked about how to split a design into smaller chunks (eg typography, buttons, icons and cards) and isolate them in a style guide that serves to communicate with the designers.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">React <a href="https://twitter.com/styleguidist?ref_src=twsrc%5Etfw">@styleguidist</a> at <a href="https://twitter.com/hashtag/reactalicante?src=hash&amp;ref_src=twsrc%5Etfw">#reactalicante</a> by <a href="https://twitter.com/NikkitaFTW?ref_src=twsrc%5Etfw">@NikkitaFTW</a> 🥘🛥🌅<a href="https://t.co/r7pbggUMag">https://t.co/r7pbggUMag</a> <a href="https://t.co/E2F0QlSnh8">pic.twitter.com/E2F0QlSnh8</a></p>&mdash; Artem Sapegin ☕ (@iamsapegin) <a href="https://twitter.com/iamsapegin/status/914057821397897216?ref_src=twsrc%5Etfw">30 September 2017</a></blockquote>

Creating new pages is a matter of putting those components together, instead of coming up with new ways to codify the style needed for each page. Sara showed 2 tools for creating style guides: [Styleguidist](https://github.com/styleguidist/react-styleguidist) and [Storybook](https://storybook.js.org/).

Storybook had been covered at the first day of the conference, so Sara focused on demoing Styleguidist and showing the differences between the two.

Regardless of the tool, I really think we should componentise early and evolve the design based on the components.

#### Building a Realtime Chat with GraphQL Subscriptions by [Nikolas Burk](https://twitter.com/nikolasburk) - [Slides](https://www.slideshare.net/nburk/building-a-realtime-chat-with-react-graphql-subscriptions) and [Demo code](https://github.com/nikolasburk/graphql-chat)

Many of us have heard about GraphQL but arent using it in production. Nikolas gave a quick overview about GraphQL and coded a chat application based on React + [Apollo](http://dev.apollodata.com/). For the backend he used [graphcool](http://graph.cool/), a hosted GraphQL service.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr"><a href="https://twitter.com/nikolasburk?ref_src=twsrc%5Etfw">@nikolasburk</a> speaking on GraphQL subscriptions <a href="https://twitter.com/ReactAlicante?ref_src=twsrc%5Etfw">@ReactAlicante</a> <a href="https://t.co/tmqHVJSTG3">pic.twitter.com/tmqHVJSTG3</a></p>&mdash; Shawn Leberknight (@shawns_beard) <a href="https://twitter.com/shawns_beard/status/914070758892163072?ref_src=twsrc%5Etfw">30 September 2017</a></blockquote>

Nikolas made it look really easy, and thanks to the tools we have today at reach using GraphQL is not a daunting task anymore.

#### Code-splitting in React apps by [Glenn Reyes](https://twitter.com/glnnrys) - [Slides](https://speakerdeck.com/glennreyes/code-splitting-in-react-apps)

I was hoping someone would bring up the topic of performance, and that was Glenn. He address the topic of code splitting, generating several bundles out of the JS and CSS code in our React apps.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">Our own <a href="https://twitter.com/glnnrys?ref_src=twsrc%5Etfw">@glnnrys</a> is kicking off with code splitting in <a href="https://twitter.com/reactjs?ref_src=twsrc%5Etfw">@reactjs</a> apps <a href="https://twitter.com/ReactAlicante?ref_src=twsrc%5Etfw">@ReactAlicante</a> 👏👏👏 <a href="https://t.co/pvHAUU0JrX">pic.twitter.com/pvHAUU0JrX</a></p>&mdash; React Vienna Meetup (@ReactVienna) <a href="https://twitter.com/ReactVienna/status/914078814342467584?ref_src=twsrc%5Etfw">30 September 2017</a></blockquote>

Using `import()`, a higher-order component and Webpack we can easilly split our bundles in vendor + app chunks, but also at a path or a component level. Thus the browsers requests the bundles needed for the views as we browse them (or we let the browser preload them when it’s idle).

I liked the mention to [Next.js](https://github.com/zeit/next.js/), which has built-in lots of these concepts, and the idea of using [react-perimeter](https://github.com/aweary/react-perimeter) to lazy load components as the user moved the cursor close to an element.

#### Redux Saga, the Viking way to manage side effects by [Nacho Martín](https://twitter.com/nacmartin) - [Slides](https://www.slideshare.net/nachomartin/redux-sagas-react-alicante)

Nacho was one of the organisers and apart from the React Native workshop he also presented a talk. He described Redux Saga as a way to manage side-effects.

If you have ever tried to get promises back from dispatching actions or orchestrate other sub-actions as a result of actions, youre likely to have used sagas or something like [redux-thunk](https://github.com/gaearon/redux-thunk).

He started the talk in the best possible way, by saying:

> Maybe you don’t need redux-saga

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">.<a href="https://twitter.com/nacmartin?ref_src=twsrc%5Etfw">@nacmartin</a> about to start his talk, showing how to manage side-effects with Redux Saga <a href="https://twitter.com/hashtag/ReactAlicante?src=hash&amp;ref_src=twsrc%5Etfw">#ReactAlicante</a> <a href="https://t.co/C9egYqumQp">pic.twitter.com/C9egYqumQp</a></p>&mdash; ReactAlicante ⚛️🌞🥘 (@ReactAlicante) <a href="https://twitter.com/ReactAlicante/status/914114831367725058?ref_src=twsrc%5Etfw">30 September 2017</a></blockquote>

More often than not we like to pull more and more tooling when developing React applications just because we think we need them. Nacho explained where Sagas fit and how the use generators underneath, which makes writing async code always as easy as writing synchronous one.

I think it’s a good library when thunks fail short.

#### The Road to a Statically Typed Future by [Patrick Stapfer](https://twitter.com/ryyppy) - [Slides](https://speakerdeck.com/ryyppy/the-road-to-a-statically-typed-future-reactalicante-2017)

Patrick talked about typing (eg using Typescript or Flow) and how it improves functional patterns writing JS apps, but also as contracts communications client and server to accomplish fully-typed architectures.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">The evolution of static type systems with <a href="https://twitter.com/ryyppy?ref_src=twsrc%5Etfw">@ryyppy</a> at <a href="https://twitter.com/ReactAlicante?ref_src=twsrc%5Etfw">@ReactAlicante</a> <a href="https://t.co/8wW5MGlrAA">pic.twitter.com/8wW5MGlrAA</a></p>&mdash; Karl Horky (@karlhorky) <a href="https://twitter.com/karlhorky/status/914125965390905344?ref_src=twsrc%5Etfw">30 September 2017</a></blockquote>

Finally, Patrick shows how ReasonML and BuckleScript can enforce code correctness even more with an example of a Tic Tac Toe game implementation.

#### Case study: Lucentum, creating our own React component library by [Flavio Corpa](https://twitter.com/FlavioCorpa)

Flavio talked about Lucentum, a component library he developed for a client. He shared his learnings and challenges theming and creating awefully complex components, while keeping everything working.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr"><a href="https://twitter.com/FlavioCorpa?ref_src=twsrc%5Etfw">@FlavioCorpa</a> speaking on React component library: case study <a href="https://twitter.com/ReactAlicante?ref_src=twsrc%5Etfw">@ReactAlicante</a> <a href="https://t.co/Rk59QaLBge">pic.twitter.com/Rk59QaLBge</a></p>&mdash; Shawn Leberknight (@shawns_beard) <a href="https://twitter.com/shawns_beard/status/914144631495041024?ref_src=twsrc%5Etfw">30 September 2017</a></blockquote>

It was a down-to-earth talk in which most of us felt identified with. It was also a nice way to link back to Javi Velasco’s talk about UI components, and how difficult it is to build them to be flexible and accommodate for any imaginable situation.

#### Deploying atomic design system at scale by [Nick Balestra](https://twitter.com/nickbalestra) - [Slides](https://speakerdeck.com/nickbalestra/deploying-atomic-design-system-at-scale)

Nick talked about scaling websites through [OpenComponents](https://github.com/opentable/oc). Think of the microservice approach taken all the way till the frontend.

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto,f_auto,c_scale/v1510331530/react-alicante-nick-balestra_gzaig6.jpg"
    sizes="(max-width: 768px) 100vw, 684px" alt="Nick Balestra speaking at React Alicante" />

I liked his presentation very much’W eve been trying to solve some of these issues at Spotify for years, in creative ways like [pushing the boundaries of what iframes can do](https://speakerdeck.com/jmperez/cross-platform-web-development).

OC’s approach (and thus OpenTable’s, the company that built it) is to have parts of the UI served my different services, that can be written in different languages, and maintained/versioned/deployed by a certain team without dependencies on others. The same services can be used to compose email messages or create embeddable widgets.

I still wonder how everything can be put in place without breaking anything, and where shared state is stored. Still, this architecture seems to work OpenTable.

### Videos

The videos for the talks are expected to be published in the coming weeks. I’ll link to them when they are live.

I really hope the conference will be back next year. I think these initiatives help showing that there is a lot of talent in Alicante and it can be a very good destination for remote workers and companies.

<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
