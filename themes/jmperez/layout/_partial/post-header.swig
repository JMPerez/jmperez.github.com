<header>
<script type="application/ld+json">
{
  "@context": "http://schema.org",
  "@type": "BlogPosting",
  "headline": "{{ page.title }}",
  {% if page.description %}
  "description": "{{ page.description }}",
  {% elseif page.excerpt %}
  "description": "{{ page.excerpt }}",
  {% endif %}
  "mainEntityOfPage":{
      "@type":"WebPage",
      "@id":"{{ config.url }}/{{ page.path }}"
  },
  "datePublished": "{{ page.date.toISOString() }}",
  "dateModified": "{{ page.updated.toISOString() }}",
  {% if page.image %}
  "image": {
    "@type": "ImageObject",
    "url": "{{ config.url }}{{ page.image.url }}",
    "width" : "{{ page.image.width }}",
    "height" : "{{ page.image.height }}"
  },
  {% endif %}
  "author": {
      "@type": "Person",
      "name": "{{ config.author }}"
  },
  "publisher": {
      "@type": "Organization",
      "name": "{{ config.title }}"
      {% if config.generator_amp.logo.height && config.generator_amp.logo.width && config.generator_amp.logo.height %}
      ,
      "logo": {
        "@type": "ImageObject",
        "url": "{{ config.url }}/assets/images/logo.png",
        "width": {{ config.generator_amp.logo.width }},
        "height": {{ config.generator_amp.logo.height }}
      }
      {% endif %}
  }
}
</script>

  <div class="media author">
    <div class="img">
      <a href="/about-me/">
        <img src="/assets/images/jmperez.jpg" class="avatar-img" alt="" height="53" width="53">
      </a>
    </div>
    <div class="bd">
      <address class="name" itemprop="author" itemscope itemtype="https://schema.org/Person"><a href="/about-me/" itemprop="name">José M. Pérez</a></address>
      <meta class="post-data" itemprop="datePublished" content="{{ page.date.toISOString() }}">
          {{ date(page.date, 'MMMM DD YYYY') }}
      </meta>
    </div>
  </div>
  {% if page.url %}
  <a href="{{ page.url }}">
    <h1>{{ page.title }}</h1>
  </a>
  {% else %}
  <h1>{{ page.title }}</h1>
  {% endif %}
</header>
