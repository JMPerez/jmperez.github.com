hexo.extend.tag.register("resp_image", function(args) {
  var id = args[0];
  var alt = args[1];
  return `<img
      style="max-width:100%"
      sizes="(max-width: 768px) 100vw, 684px"
      loading=lazy
      srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/${id} 400w,
        https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/${id} 800w,
        https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/${id} 1200w,
        https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/${id} 1400w"
        src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/${id}"
        alt="${alt}" />`;
});
