'use strict';

var fs = require('hexo-fs');
var pathFn = require('path');

var CleanCSS = require('clean-css');

var cache = {};

hexo.extend.helper.register('inline_css', function(path) {
  if (!(path in cache)) {
    var baseDir = this.base_dir;
    var source = pathFn.resolve(__dirname, '../source');
    var cssFile = pathFn.resolve(source, path);
    var contents = fs.readFileSync(cssFile + '.css');
    var minified = new CleanCSS().minify(contents).styles;
    cache[path] = minified;
  }
  return '<style>' + cache[path] + '</style>';
});
