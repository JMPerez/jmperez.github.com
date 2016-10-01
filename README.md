# JMPerez Blog

This is the source code for my blog [jmperezperez.com](https://jmperezperez.com). It uses [Hexo](https://hexo.io) to generate static pages.

These are some interesting features:

- It is hosted as GitHub pages and served with a custom domain.
- It supports [redirects](https://github.com/JMPerez/jmperez.github.com/blob/hexo/themes/jmperez/layout/redirection.swig) so old URLs are redirected to their new location.
- It uses [clean-css](https://github.com/jakubpawlowicz/clean-css) to minify CSS assets, which are later inlined.
- It has [very good performance](https://developers.google.com/speed/pagespeed/insights/?url=https%3A%2F%2Fjmperezperez.com%2F).
- It supports [AMP (Accelerated Mobile Pages)](https://www.ampproject.org) through [hexo-generator-amp](https://github.com/tea3/hexo-generator-amp).

## Installing it

After cloning the project, install the `npm` dependencies and `Hexo`:

`$ npm i && npm i hexo -g`

## Developing

Run:

`$ hexo server`

Then open http://localhost:4000/ in a browser.

## Generating output

`$ hexo generate`

## Deploying

`$ hexo deploy`
