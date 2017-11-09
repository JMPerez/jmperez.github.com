---
layout: post
title: 'Estudiando el rediseño de la web del Senado de España'
date: 2012-11-12 18:17:35+00:00
tags:
  - javascript
  - optimization
  - performance
permalink: estudiando-el-rediseno-de-la-web-del-senado-de-espana
---

Echa un vistazo al [análisis más reciente que he hecho de la web del Senado](/revisitando-nueva-web-senado), donde hablo sobre algunos cambios que han llevado a cabo desde que publicó el nuevo sitio.
[![Portada de Senado.es](/assets/images/posts/senado-es-portada-300x175.jpg)](/assets/images/posts/senado-es-portada.jpg)

<!-- more -->
Hoy se ha presentado el rediseño de la web del Senado de España. Sin entrar a valorar su coste o la necesidad, quería analizarla desde el punto de vista de implementación frontend.

Particularmente, me gustan los análisis que hacen webs como [zoompf](http://zoompf.com/blog) sobre distintos sitios web, presentando los problemas encontrados y ofreciendo soluciones.

Aquí hablaré sobre algunos problemas de ámbito general y otros específicos sobre rendimiento web.

## Problemas generales
Hay algunos problemas relacionados con XSS (que parece que ya se ha resuelto), indexado y navegación.

### senado.es no funciona sin www
[![Conversación en Twitter sobre redirección de la web del Senado](/assets/images/posts/www-senado-300x153.png)](/assets/images/posts/www-senado.png)

Al igual que en la anterior versión de la web, la dirección [senado.es](http://senado.es) no funciona. Es necesario acceder a [www.senado.es](http://www.senado.es) para poder ver el contenido. Aunque se puede solucionar fácilmente, es un pena que se les haya pasado por alto.

Pese [haber sido notificados](https://twitter.com/jmperezperez/status/267910552288911360), 2 días después del lanzamiento, el problema persistía.

### No indexable
Por alguna razón, han decidido que su [robots.txt](http://www.senado.es/robots.txt) indique a los buscadores que su contenido no se indexe ([fuente](https://twitter.com/polpitart/status/267930153592709120)).

```
#No permitimos acceso a todos los robots de indexación
User-agent: Oracle Secure Enterprise Search
Disallow:
User-agent: *
Disallow: /
Disallow: /legis9/publicaciones/html/textos/CG_B015.html
Disallow: /legis9/publicaciones/pdf/cortes/bocg/CG_B015.PDF
Disallow: /legis9/publicaciones/html/textos/CG_B100.html
Disallow: /legis9/publicaciones/pdf/cortes/bocg/CG_B100.PDF
# No limitamos la hora de indexación
#Visit-time: 0300-0400
```

Además, no se ha implementado ningún tipo de redirección para mantener el acceso a las páginas de la antigua web que estaban indexadas en los motores de búsqueda ([fuente](http://formatinternet.wordpress.com/2012/11/12/los-problemas-del-desarrollo-web-en-espana-resumidos-en-senado-es/)).

### Problemas de conexi&#243;n
Desde que se publicó, el nuevo sitio web ha estado sin funcionar varias veces, ya sea por supuestos ataques DOS o por cualquier otra causa. Esto muestra que la infraestructura no es adecuada o no se han previsto mecanismos para mantener la web operativa en situaciones de mucho tráfico.

### Selecci&#243;n de idioma
Aunque el sitio soporta múltiples idiomas, al cambiar el idioma se hace un envío de un formulario POST, se establece el idioma pero la URL se mantiene. Esto, unido a la política de indexación, hace imposible indexar el contenido en los distintos idiomas soportados por la web.

### No responsive ni m&#243;vil
La verdad es que es difícil justificar la inexistencia de un sitio móvil o soporte de responsive design cuando se lleva a cabo un sitio completamente nuevo. Unido al poco cuidado en la carga de los distintos componentes de la página, se hace poco recomendable utilizar el sitio desde un dispositivo móvil ([fuente](http://mobitest.akamai.com/m/results.cgi?testid=121114_K2_5)).

## Rendimiento web
Si entramos a valorar el rendimiento web tenemos bastantes puntos que tratar. Puedes echar un vistazo a [las puntuaciones Page Speed y YSlow de la página principal en GTmetrix](http://gtmetrix.com/reports/www.senado.es/cCUUkJUm), el resultado de [WebPageTest usando Chrome desde París](http://www.webpagetest.org/result/121112_7M_DP6/) y [IE8 desde Madrid](http://www.webpagetest.org/result/121112_RQ_F0H/), y el [análisis de zoompf](http://scans.zoompf.com/s/e2b8609e20721c1548291f3fd94acaed/report.html), este último teniendo en cuenta 146 páginas de la web del Senado.
![Puntuación Page Speed y YSlow de www.senado.es](/assets/images/posts/gtmetrix-senado-es.jpg)
_Puntuación Page Speed y YSlow de www.senado.es_

### Compresi&#243;n gzip
Sólo en la página principal se podría ahorrar 476.6KiB (un 30% del total) habilitando la compresión gzip ([fuente](http://gtmetrix.com/reports/www.senado.es/cCUUkJUm)).

### Falta de cacheo
No se especifica política alguna de cacheo de los distintos recursos (JS, PNG, JPG) por lo que el navegador decide si los cachea o no y por cuánto tiempo. Además, los recursos no especifican correctamente su tipo Mime ([fuente](http://gtmetrix.com/reports/www.senado.es/cCUUkJUm)).

### Errores 404
Al menos en la página principal, hay 2 requests que resultan en errores 404 ([fuente](http://www.webpagetest.org/result/121112_7M_DP6/1/details/)).
![Errores 404 en la web del Senado](/assets/images/posts/404-senado-es.jpg)
_Errores 404 en la web del Senado_

### Im&#225;genes no optimizadas
Las imágenes GIF, PNG y JPG pueden ser optimizadas ahorrando una cantidad valiosa de tráfico ([fuente](http://scans.zoompf.com/s/e2b8609e20721c1548291f3fd94acaed/report.html#187)).

### No sprites
Hay 51 peticiones a imágenes en la página principal (de las 66 que hay en total). Muchas de ellas se corresponden con pequeños iconos que podrían fácilmente formar parte de un sprite. Y, mejor aún, algunas imágenes podrían reemplazarse utilizando CSS3.

### Minificaci&#243;n de ficheros
El único CSS o JS minificado es la librería jQuery. Todo el resto de ficheros, incluida [una versión personalizada de jQuery UI](http://www.senado.es/web/js/jquery-ui-1.8-custom-v.js), está sin minificar. Claramente, no existe un proceso de _build_ que tenga en cuenta la minificación de estos ficheros antes de subirlos al sitio web.

### Malas pr&#225;cticas de Javascript
Echando un vistazo a ficheros como [funciones.js](http://www.senado.es/web/js/funciones.js), vemos como se repiten una y otra vez los mismos selectores de elementos del DOM.

```js
function inicializarVariablesGenerales(){
	// No lleva el var por eso son globales
	globales = {
		monthNames: [$('#calendario_nombre_meses option').eq(0).text(),
					 $('#calendario_nombre_meses option').eq(1).text(),
					 $('#calendario_nombre_meses option').eq(2).text(),
					 $('#calendario_nombre_meses option').eq(3).text(),
					 $('#calendario_nombre_meses option').eq(4).text(),
					 $('#calendario_nombre_meses option').eq(5).text(),
					 $('#calendario_nombre_meses option').eq(6).text(),
					 $('#calendario_nombre_meses option').eq(7).text(),
					 $('#calendario_nombre_meses option').eq(8).text(),
					 $('#calendario_nombre_meses option').eq(9).text(),
					 $('#calendario_nombre_meses option').eq(10).text(),
					 $('#calendario_nombre_meses option').eq(11).text()
					],
		resultAjax: new Array(31),
		dateFormat: 'ddmmyy',
		firstDay: 1,
                ...
```

## Otros sitios cubriendo detalles de implementaci&#243;n
Otras webs están recogiendo también algunos problemas a nivel técnico:

- [Los problemas del desarrollo web en España resumidos en senado.es](http://formatinternet.wordpress.com/2012/11/12/los-problemas-del-desarrollo-web-en-espana-resumidos-en-senado-es/) en format internet
- [La nueva timo web del Senado que cuesta medio millón de euros](http://www.pedroventura.com/desarrollo-web/la-nueva-timo-web-del-senado-que-cuesta-medio-millon-de-euros/) en pedroventura.com
- [Análisis de la web del Senado](http://www.social4u.es/analisis-de-la-web-del-senado/) en social4u.es

## M&#225;s problemas
Si sabes de algún problema más o alguna posible mejora, añádelo en los comentarios. El propósito de este post es promover las mejores prácticas en cuanto a desarrollo web se refiere.
