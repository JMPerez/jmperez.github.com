---
layout: post
title: 'Lazy loading Javascript: On-demand scripts to faster load times'
date: 2010-11-13 16:14:34+00:00
description: How to load JavaScript on-demand using stub functions and progressive enhancements
tags:
  - javascript
  - lazy loading
  - performance
  - stub
permalink: ondemand-javascript-lazy-loading-stubs
---

Loading on-demand code can boost website performance in the sense that the browser does not need to request and execute Javascript code that is not needed. Depending on the script, a different approach can be taken to lazy load it.

<!-- more -->
## Progressive enhancement Javascript
This is by far the best scenario. Javascript is used to improve user experience but the web page can work without Javascript (in example, browsers with Javascript disabled). In this case, script loading can be delayed to the very moment it is needed or it can be loaded after some timeout.

An example would be a form used to post a comment. This form could be ajaxify using a script that is requested when the textarea is focused. This way, this script would just be downloaded when potentially needed. Another example would be an input search that is improved using autocompletion once it is focused.

## Using mocks/stubs for Javascript-only functionality
Some times Javascript is used to allow functionality that cannot implemented other way. In this case, a mockup approach can be taken.

Mockup Javascript only defines the signatures of the functions and as
little functionality as possible. We can use mocks to load the "real"
Javascript and avoid calls to non-declared functions. This is similar to
how [Microsoft Doloto](http://www.stevesouders.com/blog/2009/09/08/doloto-javascript-download-optimizer/) works. Stub functions can make as little as
just preventing undefined symbols, or as much as loading real script and
re-execute the javascript call so that the real script (that has
just overridden the stub function) executes. Steve Souders explains this
technique in his [*Even faster web sites* book](http://books.google.es/books?id=E7p-07kNfXYC&lpg=PA24&ots=ULjpQKecMk&dq=souders%20doloto&pg=PA24#v=onepage&q&f=false).


We would have one file to functions declarations (mockup) and another file that will override mockup:

**functions_mock.js**

```js
function loadJs(url, cb) {
  var script = document.createElement('script');
  script.setAttribute('src', url);
  script.setAttribute('type', 'text/javascript');

  var loaded = false;
  var loadFunction = function () {
    if (loaded) return;
    loaded = true;
    cb &amp; cb();
  };
  script.onload = loadFunction;
  script.onreadystatechange = loadFunction;
  document.getElementsByTagName("head")[0].appendChild(script);
};

function factorial(n) {
  loadJs('functions.js', function() {
    factorial(n);
  });
}
```

**functions.js**
```js
function factorial(n) {
  if (n>1) return n*factorial(n-1);
  return 1;
}
```

**index.html**
```html
<!doctype html>
<head>
	<meta charset="utf-8">
	<script src="functions_mock.js"></script>
</head>
<body>
	<button onclick="alert(factorial(10));">Factorial!</button>
</body>
</html>
```
Maybe the `factorial` function is not the best one. In fact, the size of mock file is greater than the "real" JavaScript file, but the idea is that mock file would replace large functions, achieving smaller files and faster execution times, especially if we use stubs to only prevent undefined symbols and load real scripts after some delay.

In the case of stub loading real script we should take into account that some functions may need synchronous downloading of real script file. This is the case of functions that return a value that is used later. In our example, if we change the button call function to something like:
```html
<button onclick="var f = factorial(10); alert(f);">Factorial!</button>
```

we will get an undefined value because factorial stub function returns before calling real function. This can be solved by loading functions.js in a blocking way, though this can affect user experience.

In conclusion, we should consider what is the best way to defer JavaScript execution (and if it is worth). Personally I think that it can be useful in the case of large JavaScript files with few global variables that we can manage properly.
