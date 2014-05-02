---
layout: demo
related_post_url: /prevent-iphone-navigation-bar-ajax-link-click
related_post_title: Avoid showing address bar on iPhone when loading ajax
---

# iPhone address bar on ajax navigation tests

<ul>
  <li>
    <a class="prevent" href="http://jmperezperez.com">This link is ignored. However, it shows the bar</a>
  </li>
  <li>
    <a class="facebook" href="http://jmperezperez.com">This link is ignored. It does not show the bar, and modifies the hash tag.</a>
  </li>
</ul>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque augue ligula, rutrum in fermentum id, gravida eu dolor. Aliquam erat volutpat. Mauris fringilla turpis sed est lobortis vestibulum. Suspendisse bibendum fermentum tortor, ut imperdiet quam sollicitudin quis. Quisque in ante ante. Duis vel ligula nec nunc tristique lacinia. Vestibulum et sem non odio placerat auctor. Aliquam erat volutpat. Donec sed leo eros, eget iaculis nibh. Phasellus consequat molestie lacus sed sodales. Cras tristique, libero et hendrerit adipiscing, mauris sem volutpat est, et fermentum nulla libero ac tellus. Pellentesque quis magna ut leo molestie interdum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Vivamus sit amet turpis id dui ultricies vehicula eget at purus. Nullam felis tortor, dignissim eu porta at, feugiat et erat. Sed dignissim tincidunt nisi, quis eleifend odio auctor vitae. Phasellus lorem lectus, ornare eu egestas sit amet, lacinia ut ipsum. Donec condimentum iaculis nibh, sed dignissim elit pretium ut. Duis condimentum commodo elit, nec mattis nunc aliquet eget. Morbi viverra, ipsum eu blandit cursus, urna risus molestie tortor, sed pulvinar elit dolor ut purus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque turpis orci, laoreet vitae vehicula sed, pulvinar nec lacus. Aenean quis dapibus sem. Nullam in feugiat tellus. Donec vulputate mattis neque bibendum sagittis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla faucibus eros at felis dapibus ac dapibus nisl suscipit. Fusce leo tellus, sollicitudin ut vulputate vel, bibendum nec neque. Quisque ac nisl vel libero dignissim accumsan quis vitae tortor.

<script type="text/javascript">
  //hide bar on page load
  setTimeout(function () {  window.scrollTo(0, 1);}, 500);

  //attach event touchend
  document.addEventListener(
    'touchend',
    function(e) {
      var target = e.target;
      while(target.nodeName !== 'A' && target.nodeName !== 'BODY') {
        target = target.parentNode;
      }
      if (target.nodeName === 'A' &&
        target.className === 'facebook') {
          target.href = '#!' + target.getAttribute('href');
        }
      },
    false
  );

  //attach event click
  document.addEventListener(
    'click',
    function(e) {
      if (e.target.nodeName === 'A') {
        if (e.target.className === 'prevent') {
          e.preventDefault();
        } else if (e.target.className === 'facebook') {
          var href = e.target.getAttribute('href');
          if (href.indexOf('#!') === 0) {
            var newHref = href.substr(2);
            e.target.href = newHref;
            location.hash = newHref;
            e.preventDefault();
          }
        }
      }
    },
    false
  );
</script>
