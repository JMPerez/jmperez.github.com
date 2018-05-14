<div>
  <div class="me">
    <img src="https://res.cloudinary.com/jmperez/image/upload/w_240,f_auto,c_scale/v1519156883/profile_ysrm5y.jpg" style="border-radius:100%" alt="José M. Pérez" sizes="120px" width="120" height="120">
    <h1>José M. Pérez</h1>
    <p>Engineer at <a href="https://spotify.com">Spotify</a> and Web Perf geek.
  </div>
</div>
<div class="row posts-list">
 {% for post in page.posts %}
  {% if post.lang == 'default' %}
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
