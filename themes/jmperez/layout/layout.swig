<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <meta http-equiv="Accept-CH" content="DPR, Viewport-Width, Width">
  <title>{{ page.title }}{% if page.title %} - {% endif %}José M. Pérez</title>
  {% if page.description or config.description %}<meta name="description" content="{{ page.description or config.description }}">{% endif %}
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, viewport-fit=cover">
  <link rel="author" href="https://plus.google.com/107456024651797783420" />
  <link rel="alternate" type="application/rss+xml" title="Jose M. Perez" href="https://jmperezperez.com/feed.xml">
  <meta name="twitter:card" content="{% if page.image %}summary_large_image{% else %}summary{% endif %}">
  <meta name="twitter:url" content="{{ page_url(config.url + '/' + page.path) }}" property="og:url">
  <meta name="twitter:title" content="{{ page.title }}{% if page.title %} - {% endif %}José M. Pérez" property="og:title">
  {% if page.description %}<meta name="twitter:description" content="{{ page.description }}" property="og:description">{% endif %}
  <meta name="twitter:site" content="@jmperezperez">
  {% if page.image %}
  <meta property="og:image" content="{{ page_url(config.url + page.image.url) }}">
  <meta name="twitter:image" content="{{ page_url(config.url + page.image.url) }}">
  {% else %}
  <meta property="og:image" content="https://res.cloudinary.com/jmperez/image/upload/f_auto,c_scale/v1519156883/profile_ysrm5y.jpg">
  <meta name="twitter:image" content="https://res.cloudinary.com/jmperez/image/upload/f_auto,c_scale/v1519156883/profile_ysrm5y.jpg">
  {% endif %}
  <meta property="fb:app_id" content="1702266270006013">
  <meta property="fb:pages" content="1639848659664211" />
  <link rel="canonical" href="{{ page_url(config.url + '/' + page.path) }}" />
  {{ inline_css('css/main') }}
  {% if (is_post() && config.generator_amp) %}
  <link rel="amphtml" href="{{ url_for(page.path + 'amp/') }}">
  {% endif %}
  <meta name="theme-color" content="#005689">
  <link rel="manifest" href="/manifest.json">
  {% for url in page.i18n %}
    <link rel="alternate" hreflang="{{ loop.key }}" href="{{ url_for(url + '/') }}" />
  {% endfor %}
</head>
<body>
  {{ partial('_partial/ga')}}
  {{ partial('_partial/header')}}
  <div id="page">
    {{ body }}
  </div>
  {{ partial('_partial/footer')}}
  <script>
   window.addEventListener('load', () => {
     setTimeout(() => {
      var t = window.performance && performance.timing;
      function round2(num) { return Math.round(num * 100) / 100; }
      if (t) {
        var timingStats = document.querySelector('.timing-stats');
        var loadTime = (t.loadEventEnd - t.navigationStart) / 1000;
        var timingStatsHTML = 'This page loaded in ' + round2(loadTime) + ' seconds. ';
        var performanceEntries = performance.getEntriesByType('paint');
        performanceEntries.forEach(function(performanceEntry, i, entries) {
          var name = performanceEntry.name;
          if (name === 'first-paint') {
            name = '<abbr title=' + name + '>FP</abbr>';
          } else if (name === 'first-contentful-paint') {
            name = '<abbr title=' + name + '>FCP</abbr>';
          }
          timingStatsHTML += name + ' was ' + round2(performanceEntry.startTime / 1000) + ' seconds. ';
        });
        timingStatsHTML += '<a href="https://jmperezperez.com/page-load-footer/">More info</a>.';
        timingStats.innerHTML = timingStatsHTML;
      }
    }, 0);
   });
  </script>
</body>
</html>
