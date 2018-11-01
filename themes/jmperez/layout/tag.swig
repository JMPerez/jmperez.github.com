<h1>Posts with tag <span style="color:#666">{{ page.tag }}</span></h1>
<div class="row posts-list">
 {% for post in page.posts %}
  {% if post.lang == 'en' %}
   <div class="wrapper">
     <div class="post">
       <a href="{{ url_for(post.path) }}">
         <h2>{{ post.title }}</h2>
       </a>
       {% if post.excerpt %}
       {{ post.excerpt }}
        <div class="post-data">
          <a class="button" href="{{ url_for(post.path) }}">Continue reading <span class="outscreen"> about {{ post.title }}</span>...</a>
        </div>
      {% endif %}
     </div>
   </div>
  {% endif %}
  {% endfor %}
  {{ partial('_partial/pagination')}}
</div>
