---
layout: post
title: Usando SVG como placeholders — Más técnicas de carga de imágenes
date: 2017-10-29 23:30:00+01:00
description: Optimización del rendimiento web utilizando carga diferida de imágenes con SVGs como placeholders, representando contornos, formas y siluetas.
image:
  url: /assets/images/posts/svg-placeholders/jmperez-composition-primitive.jpg
  width: 2040
  height: 1024
tags:
  - svg
permalink: es/svg-placeholders
lang: es
i18n:
  en: svg-placeholders
  es: es/svg-placeholders
---

Me apasiona la optimización del rendimiento de imágenes y hacer que las imágenes carguen rápido. Una de las áreas de estudio más interesantes es el placeholder: qué mostrar cuando la imagen todavía no se ha cargado.

Durante los últimos días me he encontrado con algunas técnicas de carga que usan SVG, y me gustaría describirlas en este post.

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto,c_scale/v1509278557/jmperez-composition-primitive_j8zyfn.jpg"
    sizes="(max-width: 768px) 100vw, 684px"
    alt="Ejemplo de un SVG generado utilizando 10 y 100 triángulos basado en una imagen de mapa de bits" />
<small class="caption">Los SVGs generados a partir de imágenes pueden ser usados como placeholders. ¡Sigue leyendo!</small>

<!-- more -->
En esta publicación hablaré sobre estos temas:

* Descripción general de los diferentes tipos de placeholders
* Placeholders basados en SVG (contornos, formas y siluetas)
* Automatización del proceso.

### Descripción general de los diferentes tipos de placeholders

En el pasado [he escrito sobre placeholders y lazy-load de imágenes](/lazy-loading-images), y también [he dado charlas sobre ello](https://www.youtube.com/watch?v=szmVNOnkwoU). Cuando se hace lazy-load de imágenes es conveniente pensar en qué renderizar como placeholder, dado que puede tener un gran impacto en el rendimiento percibido por el usuario. Hace un tiempo describí algunas opciones:

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto,c_scale/v1509278557/placeholder-options_vtwp6b.png"
    sizes="(max-width: 768px) 100vw, 684px" />
<small class="caption">Diferentes estrategias para rellenar el área de una imagen mientras ésta carga.</small>

* **Mantener el espacio vacío para las imágenes**: En un mundo de diseño responsive, reservar el área para la imagen evita que el contenido salte. Los cambios de layout son malos desde el punto de vista de la experiencia de usuario, pero también son nefastos en cuanto al rendimiento. El navegador debe recalcular el layout cada vez que obtiene las dimensiones de una imagen, para dejar espacio para la misma.
* **Placeholder**: Imagina que estamos mostrando la imagen de perfil de un usuario. Quizás queremos mostrar una silueta como imagen de background. Esta imagen se muestra mientras la imagen principal está cargando, pero también si la petición falla o si el usuario no ha establecido ninguna imagen de perfil. Habitualmente estas imágenes son vectoriales, y dado su pequeño tamaño son excelentes candidatas para ser servidas inline.
* **Color sólido**: Podemos tomar un color de la imagen y usarlo como color de fondo en el placeholder. Puede ser el color dominante, el más vibrante… La idea es que está basado o extraído de la imagen que se desea cargar, y el resultado debería ayudar a suavizar la transición entre "no imagen" e "imagen cargada".
* **Imagen desenfocada**: También llamada técnica _blur up_. Se renderiza una versión muy pequeña de la imagen y se hace la transición a la imagen completa. La imagen inicial es pequeña tanto en píxeles como en kBs. Para eliminar artefactos de compresión la imagen se amplía y se desenfoca. He escrito previamente sobre este tema en [Cómo Medium hacer carga progresiva de imágenes](/medium-image-progressive-loading-placeholder), [Usando WebP para crear previsualizaciones pequeñas](/webp-placeholder-images), y [Más ejemplos de carga progresiva de imágenes](/more-progressive-image-loading).

Resulta que hay muchas otras variaciones y mucha gente inteligente desarrollando otras técnicas para crear placeholders.

Una de ellas es generar gradientes o degradados en vez de colores sólidos. Los gradientes pueden crear una previsualización de la imagen final más precisa, con unos pocos bytes extra.

<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto,c_scale,w_1368/v1509278575/gradient-background_jyymty.jpg"
    sizes="(max-width: 768px) 100vw, 684px" alt="Usando gradientes como fondos. Captura tomada de Gradify"/>
<small class="caption">Usando gradientes como fondos. Captura de Gradify, que ya no está disponible on-line. El código [está en GitHub](https://github.com/fraser-hemp/gradify).</small>

Otra técnica consiste en utilizar SVGs basados en la imagen, que está popularizándose gracias a algunos hacks y experimentos recientes.

### Placeholders basados en SVG

Sabemos que los SVGs son ideales para imágenes vectoriales. En la mayoría de casos queremos cargar una imagen de mapa de bits (JPG, PNG...), así que la cuestión es cómo vectorizar la imagen. Podemos utilizar contornos, formas y áreas.

#### Contornos

En [un post anterior](/drawing-edges-svg) expliqué cómo calcular los contornos de una imagen y animarlos. Mi objetivo inicial era intentar dibujar regiones, vectorizando la imagen, pero no sabía cómo hacerlo. Me di cuenta de que usando los contornos también podía ser innovador y decidí animarlos para crear un efecto de "dibujado".

<div class="codepen-aspect-ratio" style="margin-bottom: 10px; padding-bottom: 100%; position: relative; width: 100%">
{% codepen jmperez oogqdp 0 result 600 600 %}
</div>

#### Formas

También podemos usar SVG para dibujar áreas de la imagen en lugar de contornos o bordes. De alguna manera estaríamos vectorizando una imagen de mapa de bits para crear un placeholder.

En su día intenté hacer algo similar con triángulos. Puedes ver el resultado en mis charlas [en CSSConf](/cssconfau16/#/45) y [Render Conf](/renderconf17/#/46).

<div class="codepen-aspect-ratio" style="margin-bottom: 10px; padding-bottom: 74%; position: relative; width: 100%">
{% codepen jmperez BmaWmQ 0 result 444 600 %}
</div>

Este codepen es una prueba de concepto de un placeholder basado en SVG compuesto por 245 triángulos. La generación de los triángulos utiliza la [triangulación de Delaunay](https://es.wikipedia.org/wiki/Triangulaci%C3%B3n_de_Delaunay) a partir del proyecto [polyserver de Possan](https://github.com/possan/polyserver). Como es de esperar, a mayor número de triángulos, mayor es el tamaño del fichero resultante.

#### Primitive y SQIP, una técnica LQIP basada en SVG

Tobias Baldauf ha estado trabajando en otra técnica LQIP (_Low-Quality Image Placeholder_) usando SVGs llamada [SQIP](https://github.com/technopagan/sqip). Antes de adentrarnos en SQIP, me gustaría describir [Primitive](https://github.com/fogleman/primitive), una librería que SQIP utiliza internamente.

Primitive es fascinante y recomiendo definitivamente que le eches un ojo. Convierte una imagen de mapa de bits en un SVG compuesto por formas que se solapan. Su pequeño tamaño lo hace ideal para incluirlo de forma inline en la página. Así se consigue reducir una petición, a la vez que se renderiza un placeholder bastante cercano a la imagen final incrustada en el cuerpo del HTML inicial.

Primitive genera una imagen basada en figuras como triángulos, rectángulos y círculos entre otros. En cada paso añade una figura. A más pasos, la imagen resultante se va pareciendo más a la imagen original. Si el formato de salida elegido es SVG, también significa que el fichero será más grande cuantas más figuras contenga.

Para comprender cómo funciona Primitive lo ejecuté tomando un par de imágenes de prueba. Generé SVGs a partir de las imágenes usando 10 y 100 triángulos:

<div>
<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:228,f_auto,c_scale,w_500/v1509367394/pexels-photo-281184-square-10.svg_ifiu2z.png"
    sizes="(max-width: 768px) 33vw, 228px" alt="Procesando una imagen usando Primitive con 10 triángulos" style="width:32%;float:left;margin-right:2%;padding-bottom:10px" /><img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:228,f_auto,c_scale,w_500/v1509367394/pexels-photo-281184-square-100.svg_tkr8el.png"
    sizes="(max-width: 768px) 33vw, 228px" alt="Procesando una imagen usando Primitive con 100 triángulos" style="width:32%;float:left;margin-right:2%;padding-bottom:10px" /><img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:228,f_auto,c_scale,w_500/v1509367395/pexels-photo-281184-square_tuhvso.jpg"
    sizes="(max-width: 768px) 33vw, 228px" alt="Imagen original" style="width:32%;float:left;padding-bottom:10px" />
</div>

<small class="caption">Procesando [esta imagen](/assets/images/posts/svg-placeholders/pexels-photo-281184-square.jpg) con Primitive, usando [10 triángulos](/assets/images/posts/svg-placeholders/pexels-photo-281184-square-10.svg) y [100 triángulos](/assets/images/posts/svg-placeholders/pexels-photo-281184-square-100.svg).</small>

<div>
<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:228,f_auto,c_scale,w_500/v1509367394/pexels-photo-618463-square-10.svg_aeonon.png"
    sizes="(max-width: 768px) 33vw, 228px" alt="Procesando una imagen usando Primitive con 10 triángulos" style="width:32%;float:left;margin-right:2%;padding-bottom:10px" /><img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:228,f_auto,c_scale,w_500/v1509367394/pexels-photo-618463-square-100.svg_t6pwcv.png"
    sizes="(max-width: 768px) 33vw, 228px" alt="Procesando una imagen usando Primitive con 100 triángulos" style="width:32%;float:left;margin-right:2%;padding-bottom:10px" /><img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:228,f_auto,c_scale,w_500/v1509367395/pexels-photo-618463-square_pmbi9x.jpg"
    sizes="(max-width: 768px) 33vw, 228px" alt="Imagen original" style="width:32%;float:left;padding-bottom:10px" />
</div>

<small class="caption">Procesando [esta imagen](/assets/images/posts/svg-placeholders/pexels-photo-618463-square.jpg) con Primitive, usando [10 triángulos](/assets/images/posts/svg-placeholders/pexels-photo-618463-square-10.svg) y [100 triángulos](/assets/images/posts/svg-placeholders/pexels-photo-618463-square-100.svg).</small>

Usando 10 triángulos las imágenes empiezan a parecerse a la versión original. Estas imágenes SVG pueden ser adecuadas como placeholders. De hecho el código del SVG de 10 triángulos es muy pequeño, unos 1.030 bytes, que pueden reducirse hasta unos 640 bytes si pasamos la salida por SVGO.

```html
<svg xmlns="http://www.w3.org/2000/svg" width="1024" height="1024"><path fill="#817c70" d="M0 0h1024v1024H0z"/><g fill-opacity=".502"><path fill="#03020f" d="M178 994l580 92L402-62"/><path fill="#f2e2ba" d="M638 894L614 6l472 440"/><path fill="#fff8be" d="M-62 854h300L138-62"/><path fill="#76c2d9" d="M410-62L154 530-62 38"/><path fill="#62b4cf" d="M1086-2L498-30l484 508"/><path fill="#010412" d="M430-2l196 52-76 356"/><path fill="#eb7d3f" d="M598 594l488-32-308 520"/><path fill="#080a18" d="M198 418l32 304 116-448"/><path fill="#3f201d" d="M1086 1062l-344-52 248-148"/><path fill="#ebd29f" d="M630 658l-60-372 516 320"/></g></svg>
```

Las imágenes generadas con 100 triángulos son más grandes, en kB, como es de esperar. En esta prueba las imágenes ocupan unos 5kB tras aplicar SVGO (8kB antes). Tienen un gran nivel de detalle en un tamaño comedido. La decisión de cuántos triángulos usar depende mucho del tipo de imagen (por ejemplo contraste, cantidad de colores, complejidad de la forma) y el nivel de detalle deseado.

Sería posible crear un script similar a [cpeg-dssim](https://github.com/technopagan/cjpeg-dssim) que ajusta la cantidad de formas hasta llegar a un umbral de [similaridad estructural](https://en.wikipedia.org/wiki/Structural_similarity), o un máximo número de formas en el peor caso.

Los SVGs resultantes son una buena opción también como imágenes de fondo. Dado que son vectoriales y tienen un tamaño limitado, son un buen candidato para imágenes _hero_ y fondos de gran tamaño que de otro modo mostrarían artefactos de compresión.

#### SQIP

En [palabras de Tobias](https://github.com/technopagan/sqip):

> SQIP es un intento de encontrar un balance entre estos dos extremos: hace uso de [Primitive](https://github.com/fogleman/primitive) para generar un SVG consistente en varias formas sencillas que aproximan las principales características visibles dentro de la imagen, optimiza el SVG utilizando [SVGO](https://github.com/svg/svgo) y le añade un filtro de desenfoque gaussiano. Esto produce un placeholder SVG que pesa sólo ~800–1000 bytes, se ve bien en todas las pantallas y proporciona una pista visual del contenido de la imagen que se va a cargar.

El resultado es similar a utilizar una imagen pequeña como placeholder en la técnica blur-up (lo que [Medium](/medium-image-progressive-loading-placeholder) y [otros sitios](/more-progressive-image-loading) hacen). La diferencia es que, en lugar de utilizar una imagen bitmap como JPG o WebP, el placeholder usa SVG.

Si ejecutamos SQIP con las imágenes originales obtenemos esto:

<div>
<img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:342,f_auto,c_scale,w_670/v1509370309/pexels-photo-281184-square-sqip.svg_zspgb0.png"
    sizes="(max-width: 768px) 50vw, 342px" alt="SQIP aplicado a una imagen" style="width:49%;float:left;margin-right:2%;padding-bottom:10px" /><img
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:342,f_auto,c_scale,w_670/v1509370308/pexels-photo-618463-square-sqip.svg_qjrexh.png"
    sizes="(max-width: 768px) 50vw, 342px" alt="SQIP aplicado a una imagen" style="width:49%;float:left;padding-bottom:10px" />
</div>

<small class="caption">Las imágenes resultantes tras aplicar SQIP sobre [la primera imagen](/assets/images/posts/svg-placeholders/pexels-photo-281184-square-sqip.svg) y [la segunda](/assets/images/posts/svg-placeholders/pexels-photo-618463-square-sqip.svg).</small>

El SVG resultante ocupa ~900 bytes. Inspeccionando el código podemos observar el filtro `feGaussianBlur` aplicado al grupo de formas:

```html
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2000 2000"><filter id="b"><feGaussianBlur stdDeviation="12" /></filter><path fill="#817c70" d="M0 0h2000v2000H0z"/><g filter="url(#b)" transform="translate(4 4) scale(7.8125)" fill-opacity=".5"><ellipse fill="#000210" rx="1" ry="1" transform="matrix(50.41098 -3.7951 11.14787 148.07886 107 194.6)"/><ellipse fill="#eee3bb" rx="1" ry="1" transform="matrix(-56.38179 17.684 -24.48514 -78.06584 205 110.1)"/><ellipse fill="#fff4bd" rx="1" ry="1" transform="matrix(35.40604 -5.49219 14.85017 95.73337 16.4 123.6)"/><ellipse fill="#79c7db" cx="21" cy="39" rx="65" ry="65"/><ellipse fill="#0c1320" cx="117" cy="38" rx="34" ry="47"/><ellipse fill="#5cb0cd" rx="1" ry="1" transform="matrix(-39.46201 77.24476 -54.56092 -27.87353 219.2 7.9)"/><path fill="#e57339" d="M271 159l-123-16 43 128z"/><ellipse fill="#47332f" cx="214" cy="237" rx="242" ry="19"/></g></svg>
```

SQIP también puede imprimir como resultado una etiqueta `img` con el contenido del SVG codificado en Base 64:

```html
<img width="640" height="640" src="example.jpg" alt="Add descriptive alt text" style="background-size: cover; background-image: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAw...<stripped base 64>...PjwvZz48L3N2Zz4=);">
```

#### Siluetas

Acabamos de ver cómo usar SVGs para contornos y formas básicas. Otra posibilidad es vectorizar las imágenes "trazándolas". [Mikael Ainalem](https://twitter.com/mikaelainalem) compartió [un codepen](https://codepen.io/ainalem/full/aLKxjm/) hace unos días mostrando cómo usar una silueta con 2 colores como placeholder. El resultado es muy bonito:

<video controls style="max-width:100%" width="690" height="459">
  <source src="https://res.cloudinary.com/jmperez/video/upload/dpr_auto,f_auto,q_auto,c_scale/v1509278615/silhouette-lazy-loading_evq9xq.mp4" type="video/mp4">
</video>

En este caso los SVGs están dibujados a mano, pero la técnica inspiró rápidamente a desarrolladores que crearon integraciones con herramientas que automatizaban el proceso.

- [Gatsby](https://www.gatsbyjs.org), un generador de sitios estáticos basado en React, soporta estos SVGs trazados. Utiliza [un port de potrace a JavaScript](https://www.npmjs.com/package/potrace) para vectorizar las imágenes.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">Excited to announce that Gatsby now has super simple support for traced SVG!<br><br>Thanks to <a href="https://twitter.com/fk?ref_src=twsrc%5Etfw">@fk</a> for his great work!<a href="https://t.co/XfgEDbSILA">https://t.co/XfgEDbSILA</a> <a href="https://t.co/wTwOgT8C5V">pic.twitter.com/wTwOgT8C5V</a></p>&mdash; Gatsby (@gatsbyjs) <a href="https://twitter.com/gatsbyjs/status/923304195666485248?ref_src=twsrc%5Etfw">25 October 2017</a></blockquote>

- [Craft 3 CMS](https://craftcms.com), que también añadió soporte para siluetas. Utiliza [un port de potrace a PHP](https://github.com/nystudio107/craft3-imageoptimize/blob/master/src/lib/Potracio.php).

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">Cool video of using inline SVG images as lazy loading placeholders w/ ImageOptimize &amp; Craft 3 from <a href="https://twitter.com/slebbo?ref_src=twsrc%5Etfw">@slebbo</a> <a href="https://t.co/E1dYA4ayow">https://t.co/E1dYA4ayow</a> <a href="https://twitter.com/hashtag/craftcms?src=hash&amp;ref_src=twsrc%5Etfw">#craftcms</a> <a href="https://t.co/ruf8i6URCT">pic.twitter.com/ruf8i6URCT</a></p>&mdash; nystudio107 (@nystudio107) <a href="https://twitter.com/nystudio107/status/920673966091534338?ref_src=twsrc%5Etfw">18 October 2017</a></blockquote>

- [image-trace-loader](https://github.com/EmilTholin/image-trace-loader), un loader de Webpack que utiliza potrace para procesar las imágenes.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">I just released image-trace-loader, a <a href="https://twitter.com/hashtag/webpack?src=hash&amp;ref_src=twsrc%5Etfw">#webpack</a> loader that exports traced outlines as image/svg+xml data.<a href="https://t.co/2VZaKVaE4p">https://t.co/2VZaKVaE4p</a> <a href="https://t.co/vRma67R7zb">pic.twitter.com/vRma67R7zb</a></p>&mdash; Emil Tholin (@Tholle1234) <a href="https://twitter.com/Tholle1234/status/920423596346019840?ref_src=twsrc%5Etfw">17 October 2017</a></blockquote>

También es interesante ver una comparación de la salida obtenida por el loader de webpack de Emil (basado en potrace) y los SVGs dibujados a mano de Mikael.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">Comparison of <a href="https://twitter.com/mikaelainalem?ref_src=twsrc%5Etfw">@mikaelainalem</a> &#39;s SVG lazy-loading technique <a href="https://t.co/mbqVpxzn72">https://t.co/mbqVpxzn72</a> with @Tholle123&#39;s webpack loader <a href="https://t.co/3jxjtNP8dm">https://t.co/3jxjtNP8dm</a> <a href="https://t.co/tChcPK0mIK">pic.twitter.com/tChcPK0mIK</a></p>&mdash; Yuriy Nemtsov (@nemtsovy) <a href="https://twitter.com/nemtsovy/status/920647706799955970?ref_src=twsrc%5Etfw">18 October 2017</a></blockquote>

Asumo que la salida generada por potrace utiliza las opciones por defecto. Adicionalmente, es posible ajustarlas. Lee [las opciones para image-trace-loader](https://github.com/EmilTholin/image-trace-loader#options), que son prácticamente [las que se pasan a potrace](https://www.npmjs.com/package/potrace#parameters).

## Resumen

Hemos visto diferentes herramientas y técnicas para generar SVGs basados en imágenes bitmap y utilizarlos como placeholders. De la misma forma que [WebP es un formato fantástico para previsualizaciones](/webp-placeholder-images/), SVG es también un formato interesante para aplicar en los placeholders. Podemos controlar el nivel de detalle (y por consiguiente, su tamaño), es altamente comprimible y es fácil de manipular con CSS y JS.

## Recursos extra
Este post llegó a [lo alto de Hacker News, consiguiendo muchos puntos y comentarios](https://news.ycombinator.com/item?id=15696596). Me siento orgulloso por ello, y por todos los enlaces a otros recursos que han sido compartidos en los comentarios de esa página. Aquí tienes algunos de ellos:

- [Geometrize](https://github.com/Tw1ddle/geometrize-haxe) es un port de Primitive escrito en Haxe. También hay [una implementación en JavaScript](https://github.com/Tw1ddle/geometrize-haxe-web) que puedes probar directamente [en tu navegador](http://www.samcodes.co.uk/project/geometrize-haxe-web/).
- [Primitive.js](https://github.com/ondras/primitive.js), que es un port de Primitive en JavaScript. También, [primitive.nextgen](https://github.com/cielito-lindo-productions/primitive.nextgen), que es un port de la aplicación de escritorio de Primitive utilizando Primitive.js y Electron.
- Hay un par de cuentas de Twitter donde puedes ver ejemplos de imágenes generadas con Primitive y Geometrize: [@PrimitivePic](https://twitter.com/PrimitivePic) y [@Geometrizer](https://twitter.com/Geometrizer).
- [imagetracerjs](https://github.com/jankovicsandras/imagetracerjs), que es un tracer de imágenes ráster y vectorizador escrito en JavaScript. También hay ports para [Java](https://github.com/jankovicsandras/imagetracerjava) y [Android](https://github.com/jankovicsandras/imagetracerandroid).

## Posts relacionados
Si te ha gustado este post, echa un vistazo a estos otros en los que he escrito sobre técnicas para cargar imágenes:

- [Cómo Medium carga imágenes de forma progresiva](/medium-image-progressive-loading-placeholder)
- [Usando WebP para crear pequeñas previsualizaciones](/webp-placeholder-images)
- [Más ejemplos de carga de imágenes progresiva](/more-progressive-image-loading)

<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
