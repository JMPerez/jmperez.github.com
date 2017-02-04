<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title>{{ page.title }}{% if page.title %} - {% endif %}JMPerez Blog</title>
  {% if page.description %}<meta name="description" content="{{ page.description }}">{% endif %}
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="author" href="https://plus.google.com/107456024651797783420" />
  <link rel="alternate" type="application/rss+xml" title="Jose M. Perez" href="https://jmperezperez.com/feed.xml">
  <meta name="twitter:card" content="{% if page.image %}summary_large_image{% else %}summary{% endif %}">
  <meta name="twitter:url" content="{{ page_url(config.url + '/' + page.path) }}" property="og:url">
  <meta name="twitter:title" content="{{ page.title }}" property="og:title">
  {% if page.description %}<meta name="twitter:description" content="{{ page.description }}" property="og:description">{% endif %}
  <meta name="twitter:site" content="@jmperezperez">
  {% if page.image %}
  <meta property="og:image" content="{{ page_url(config.url + page.image.url) }}">
  <meta name="twitter:image" content="{{ page_url(config.url + page.image.url) }}">
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
</head>
<body>
  {{ partial('_partial/ga')}}
  {{ partial('_partial/header')}}
  <div id="page">
    {{ body }}
  </div>
  {{ partial('_partial/footer')}}
</body>
</html>
