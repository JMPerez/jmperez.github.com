---
layout: post
title: 'Optimizing images for web with Google Page Speed and jpegoptim'
date: 2009-06-27 15:42:44+00:00
tags:
  - google page speed
  - images
  - optimization
excerpt: This posts shows a script to recursively optimize a set of JPG files using jpegoptim

---

Having a look at [Google Page Speed](http://code.google.com/speed/page-speed/) I liked 'Optimize images' section, which reports the size reduction that can be achieved in the images of a website, also offering a version of the image after having applied the reduction.

[![Sample applying google page speed to ElPais.com website]({{ site.url }}/assets/images/posts/elpais-google-page-speed-300x173.jpg)]({{ site.url }}/assets/images/posts/elpais-google-page-speed.jpg)

The truth is that when you save a JPG image, you don't know exactly how much compression level apply. Sometimes we try different values until we find the best balance between quality and size. Google Page Speed must be using an algorithm that optimizes this relationship, performing a lossless compression to JPG and PNG files.

As mentioned in the [section on optimization of images](http://code.google.com/speed/page-speed/docs/payload.html#CompressImages), we can use tools like [jpegtran](http://jpegclub.org/) and [jpegoptim](http://freshmeat.net/projects/jpegoptim/)

You can install jpegoptim in GNU / Linux easily. If you are an Ubuntu user, it is included in the section on Graphics (universe) and simply run:

{% highlight bash %}
sudo apt-get install jpegoptim
{% endhighlight %}

If you want to make the optimization of images across your website, or simply reduce the size of your photo albums, you can run this script, that will recursively scan folders to optimize every JPG file. The files will be overwritten with the optimized version.

{% highlight bash %}
optimize() {
  jpegoptim *.jpg --strip-all
  for i in *
  do
    if test -d $i
    then
      cd $i
      echo $i
      optimize
      cd ..
    fi
  done
  echo
}
optimize
{% endhighlight %}

This script uses the option `--strip-all` to strip out the text information contained in the file (comments and EXIF data) that are not necessary on web images (for your own pictures you'd better keep them).

If you are interested in image optimization, I recommend you having a look at:

* [Image optimization: Lossy, lossless and other techniques]({{ site.url }}/image-optimization-lossy-lossless-techniques/)
