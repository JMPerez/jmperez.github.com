<div class="row posts-list">
 {% for post in page.posts %}
   <div class="wrapper">
     <div class="post">
       <a href="{{ url_for(post.path) }}">
         <h2>{{ post.title }}</h2>
       </a>
       {% if post.excerpt %}
       <p>
        {{ post.excerpt }}
        </p>
        <div class="post-data">
          <a class="button" href="{{ url_for(post.path) }}">Continue reading <span class="outscreen"> about {{ post.title }}</span>...</a>
        </div>
      {% endif %}
     </div>
   </div>
   {% endfor %}
   {{ partial('_partial/pagination')}}
</div>
