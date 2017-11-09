---
layout: post
title: 'Revisitando la nueva web del Senado'
date: 2012-12-03 21:20:16+00:00
tags:
  - javascript
  - optimization
  - performance
permalink: revisitando-nueva-web-senado
---

Hace unos días hacía un [análisis del rediseño de la web del Senado](/estudiando-el-rediseno-de-la-web-del-senado-de-espana/), justo tras su lanzamiento, desde el punto de vista de rendimiento web y mejores prácticas a la hora de desarrollar sitios web. La nueva web del Senado sufría múltiples problemas poco más que inaceptables para un proyecto tan reciente y con tal presupuesto.

<!-- more -->
Pero al igual que destacaba dichos problemas, unas semanas después debo mencionar que varios de ellos han sido resueltos. Aunque aún quedan algunos por resolver, es de destacar que hayan seguido trabajando en el sitio.
![Web del Senado de España](/assets/images/posts/web-senado.jpg)

## Mejoras
### Senado.es ya funciona sin www
Ahora, la URL [senado.es](http://senado.es) redirecciona a [www.senado.es](http://www.senado.es) ([fuente](http://www.webpagetest.org/result/121203_ZZ_4QD/1/details/))

### Indexable por robots
Su [robots.txt](http://www.senado.es/robots.txt) ha cambiado y ahora permite a los buscadores indexar el contenido del sitio.

### Compresi&#243;n Gzip
Ahora los recursos se sirven con compresión GZIP habilitada ([fuente](http://gtmetrix.com/compare/BN8ZgvCB/3gwi5Qp4)). Entre otras mejoras, la página principal _pesa_ ahora menos de la mitad, y han mejorado considerablemente el índica PageSpeed y YSlow ([fuente](http://gtmetrix.com/reports/www.senado.es/eS68ECWL)).

### Errores 404
Ahora en la página principal, ya sólo hay 1 request que da error 404 ([fuente](http://www.webpagetest.org/result/121203_ZZ_4QD/1/details/)).

## Todav&#237;a hay algunos problemas que solucionar
Pese a todo, aún quedan mejoras por hacer, como la minificación de ficheros, optimización de imágenes, tratar de reducir el número de peticiones y corregir el Mime Type devuelto por el servidor.

Además, con la modificación del fichero [robots.txt](http://www.senado.es/robots.txt) existen detalles dignos de mención. El fichero actual tiene este contenido:

```
User-agent: *
Disallow: /cgi-bin/
Disallow: /detalleiniciativa/
Disallow: /expedientappendixblobservlet/
Disallow: /expedientdocblobservlet/
Disallow: /fichasenador/
Disallow: /resultadobuscador/
Disallow: /senstream/
Disallow: /*senstream*
Disallow: /legis9/publicaciones/html/textos/CG_B015.html
Disallow: /legis9/publicaciones/pdf/cortes/bocg/CG_B015.PDF
Disallow: /legis9/publicaciones/html/textos/CG_B100.html
Disallow: /legis9/publicaciones/pdf/cortes/bocg/CG_B100.PDF
Disallow: /legis4/publicaciones/pdf/senado/bocg/l0019.PDF
Disallow: /legis3/publicaciones/pdf/senado/bocg/l0342.PDF
Disallow: /legis3/publicaciones/pdf/senado/bocg/l0347.PDF
Disallow: /legis2/publicaciones/pdf/senado/bocg/l0140.PDF
Visit-time: 0200-0600
```

Si lo comparamos con [la versión del mismo fichero](/estudiando-el-rediseno-de-la-web-del-senado-de-espana/#no-indexable) cuando publicaron el rediseño, ahora vemos nuevas direcciones bloqueadas.

Que se pretenda evitar el indexado de las iniciativas parlamentarias y fichas de los senadores atenta directamente contra la transparencia de información y el servicio que pretende dar esta web. Además, el bloqueo se realiza sobre una dirección que ni siquiera es la dirección donde está dicho contenido.

¿Por qué se evita el indexado del contenido más útil para el ciudadano?

Aunque en ese caso, en lugar de restringir /detalleiniciativa/, /web/actividadparlamentaria/iniciativas/detalleiniciativa/

Y en vez de /fichasenador/ deberían haber restringido algo como /web/composicionorganizacion/senadores/composicionsenado/fichasenador/

Por otra parte, se evita el indexado de una serie de documentos PDF y páginas HTML, también por alguna razón que me supera. Pero es casi peor el hecho de que de los 6 documentos, sólo 2 existen y las 2 páginas HTML tampoco existen.

Por último, han introducido la limitación del indexado de páginas para que se haga entre las 02:00 y 06:00 AM GMT.  A mí me parece un poco extraño querer limitar el rastreo a las horas de menos tráfico. Un documento creado durante el día no podrá aparecer en los resultados de búsqueda hasta el día siguiente como mínimo. Y no deja de ser una señal de que el sitio no se comporta bien con un tráfico normal más el tráfico que puedan generar los bots de los buscadores.

## Conclusiones
En general, está bien que hayan continuado haciendo mejoras en el sitio, aunque por el camino han tomado decisiones ciertamente discutibles.
