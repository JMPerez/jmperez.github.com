<article class="wrapper">
  <div class="post">
    {{ partial('_partial/post-header')}}
    {{ page.content }}
  </div>
  <hr />
  {% if page.tags && page.tags.length %}
    Tags: {{ list_tags(page.tags, { show_count: false }) }}
  {% endif %}
</article>
