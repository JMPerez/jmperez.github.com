---
layout: post
title: 'Cómo hemos cambiado - Un antiguo proyecto web'
date: 2013-02-13 07:30:50+00:00
permalink: como-hemos-cambiado-antiguo-proyecto-web
---
Ayer, mi buen amigo [Alberto Juan (@aprezia)](https://twitter.com/Aprezia), me enviaba [un link a un perfil de GTMetrix](http://gtmetrix.com/reports/82.165.143.130/L2CqUhX8). Él sabe que me encanta la optimización web. Y yo le echaba un vistazo rápido a los números y pensaba que se podía mejorar bastante el Page Speed y YSlow de ese sitio.
[![Captura de pantalla del proyecto Inmodomus](/assets/images/posts/inmodomus-300x276.jpg)](/assets/images/posts/inmodomus.jpg)

<!-- more -->
Y en ningún momento me había dado cuenta de que [ese sitio web, Inmodomus](http://82.165.143.130:2005/publico/), lo habíamos implementado 8 años atrás Alberto y yo para una práctica en la asignatura [Programación en Internet de la Universidad de Alicante](http://gplsi.dlsi.ua.es/asignaturas/pi/). Y hasta teníamos una buena [documentación web](http://82.165.143.130:2005/documentacion/).

Hoy los desarrolladores web estamos inmersos en un montón de cambios continuos. Todos los días aparecen tecnologías, herramientas y técnicas que vienen a mejorar el desarrollo. Y uno pocas veces echa la vista atrás y se da cuenta de cómo se hacían las cosas antes. Y cómo las hacía uno mismo.

Ahora miro el rendimiento de los sitios web, juego cambiando el tamaño de la ventana y esperando que la página sea Responsive y se pueda ver bien en cualquier tamaño de pantalla. Por aquel entonces estábamos más preocupados de la compatibilidad con IE6, a nivel funcional (poco JS, Vanilla JS) y a nivel estético (bordes redondeados con GIFs). Y nadie había escuchado nada de desarrollar web para dispositivos móviles.

En cuanto al JS, un fichero llamado functions.js. Y yo mismo me acuerdo de este tweet que escribí hace poco:
<blockquote class="twitter-tweet" lang="es"><p>If you have a JS file called "functions.js",you're doing it wrong.</p>&mdash; José Manuel Pérez (@jmperezperez) <a href="https://twitter.com/jmperezperez/status/269063474808770560">15 de noviembre de 2012</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

En este tipo de proyectos se evitaba usar librerías y frameworks para que aprendiéramos el código desde abajo, y cómo los patrones de diseño emergían como soluciones naturales a problemas recurrentes. Por entonces el JS que se usaba era básico, muy básico. En este caso, un fichero con unas cuantas funciones globales que añadían chequeos de valores del lado del cliente (los mismos que se aplicaban en el lado de servidor con PHP / ASP), logrando un Progressive Enhancement. Un bonito término que no aprendí hasta tiempo después cuando a la gente le empezaba a preocupar el SEO, los navegadores antiguos o con JS deshabilitado, y el rendimiento web.

Cuando trabajaba en [Tuenti](http://tuenti.com) me preguntaba que estaba haciendo yo cuando Tuenti empezó. Y aquí en [Spotify](http://spotify.com), lo mismo. Ahora veo lo que estaba haciendo, y creo que viendo algunas webs actuales, el proyecto se hizo con mucha cabeza y buen resultado, teniendo en cuenta los conocimientos web allá por 2005.

Y también me resulta poco menos que curioso que la práctica asignada fuera sobre implementar un portal inmobiliario. Creo que refleja perfectamente las aspiraciones y dónde estaba el negocio por aquel entonces. Espero no equivocarme pensando que ahora habrán cambiado la temática del proyecto.

A veces es bueno parar un poco y echar la vista atrás. Ver de dónde veníamos y las cosas increíbles que se pueden hacer hoy en día en la web.
