---
layout: post
title: Hablando sobre PWA en el podcast WeCodeSign
date: 2017-10-03 20:00:00+02:00
description: He grabado un podcast sobre Progressive Web App para WeCodeSign. Escúchalo o lee la transcripción.
permalink: wecodesign-pwa
image:
  url: /assets/images/posts/wecodesign-pwa.jpg
  width: 1024
  height: 470
tags:
  - pwa
---

Esta semana se ha publicado [el podcast sobre Progressive Web Apps](http://wecodesignpodcast.com/2017/10/03/progressive-web-apps/) que grabé con Ignacio Villanueva y Carmen Ansio para WeCodeSign.

<!-- more -->

En él hablamos sobre qué son las PWA, cómo se originaron y cómo podemos implementarlas. También compartimos algunos recursos útiles que nos harán más fácil trabajar con Service Workers.

[![WeCodeSign Progressive Web Apps](/assets/images/posts/wecodesign-pwa.jpg)](http://wecodesignpodcast.com/2017/10/03/progressive-web-apps/)

[WeCodeSign](http://wecodesignpodcast.com) es uno de los podcasts líderes sobre desarrollo y diseño en español, y ha sido un honor formar parte de él. Podéis escucharlo desde su web, en [iTunes](https://itunes.apple.com/es/podcast/wecodesign-podcast/id1113501272), [iVoox](http://www.ivoox.com/escuchar-audios-wecodesign-podcast_al_5101204_1.html), [Spreaker](http://www.spreaker.com/user/8737490) y [Podkas](https://www.podkas.com/directorio/weckdesign-podcast-de-httpstwitter-comwecodesign/).

---

## Transcripción

**[Ignacio Villanueva] En el programa de hoy hablaremos sobre las Progressive Web Apps ,que es un término que se acuña a una nueva generación de aplicaciones que se basa en las nuevas tecnologías web para incrementar su funcionalidad. Tenemos el placer de contar con José Manuel Pérez, desarrollador web en Spotify.**

**Os dejamos con la entrevista, esperamos que la disfrutéis, y como siempre nos vemos al final.**

**Una vez más traemos a un invitado nuevo como siempre. Esta vez es un desarrollador que no trabaja en España y nos contará un poco acerca del tema y vamos a hablar sobre Progressive Web Apps.**

Así que bienvenido, José Manuel.

[José M. Pérez]
Hola, muchas gracias. Pues sí, soy un desarrollador web, llevo unos diez años prácticamente haciendo web. Estudié informática en la Universidad de Alicante. Por aquel entonces la web era un desconocido. Como parte del plan de estudios estudiabas cómo hacer aplicaciones WAP. Prácticamente hacer aplicaciones móviles utilizando J2ME era lo único que había y tenías  que luchar tú un poquito para encontrar alguna asignatura optativa donde se utilizara web y, bueno, hoy en día la verdad es que la situación ha cambiado bastante. Y nada, me alegro un montón de que la web sea mucho más importante que antes. Llevo cinco años trabajando en Spotify en Estocolmo trabajando haciendo web híbrida para móvil, aplicándolo a la aplicación de móvil aplicando web también a la aplicación híbrida de escritorio, utilizando web para implementar la aplicación para televisión y para PlayStation y últimamente estoy trabajando en el reproductor web. Así que nada, está súperbien porque te das cuenta de que puedes desarrollar utilizando el mismo lenguaje y prácticamente tienes acceso a cualquier plataforma. Esto viene un poco también de cuando solía trabajar en Tuenti en el sitio móvil de Tuenti, también ahí estuve haciendo cosillas para hacer una aplicación híbrida. También se integraban ciertas vistas dentro de la aplicación nativa.

Y nada, asegurándote de que la web funcionara en Nintendo DS, en PSP (PlayStation Portable), en la Blackberry 8520 que es lo que utilizaba todo el mundo. Y la verdad es que en esos momentos es cuando te das cuenta de que no puedes asumir nada, que un navegador tenga Javascript no significa que vaya a tener la capacidad de funcionar como te esperas, que haya una función declarada no significa que vaya a funcionar luego. Así que aprendí bastante a hacer lo que se llama Progressive Enhancement para asegurarte de que funciona con HTML y CSS y luego ya añadir funcionalidad con Javascript.

He sido bastante defensor de ese paradigma, aunque últimamente está siendo un poco complicado con todo el desarrollo de Javascript prácticamente basado en el lado de cliente. Esto es un poco lo que he estado haciendo últimamente.

**[I] Bueno, una pasada, porque la verdad es que hasta ahora, por lo menos que nos hayan comentado, no hemos tenido ningún invitado ni ninguna invitada que nos haya hablado sobre desarrollo Javascript para PSPs ni tecnologías un poco más antiguas, en este caso consolas.**

[J] En aquel momento yo trabajaba en Tuenti y la mayoría de usuarios eran jóvenes, se conectaban a Internet con lo que podían, normalmente utilizaban wifi, no tenían una conexión de datos. Se conectaban tarde, por la noche, prácticamente a escondidas de los padres, utilizando la consola o lo que podían tener a mano. De hecho la misma aplicación móvil funcionaba tanto en estas consolas portátiles como en la PlayStation 3 por ejemplo. Era un desafío bastante grande porque además utilizaban Netfront como navegador, no era WebKit, y daban un montón de problemas. Una de las razones por las que me interesó Spotify es porque tenían una plataforma para desarrollar aplicaciones web dentro de la aplicación de escritorio. Hoy en día es una cosa un poco más normal. Los que usamos Slack sabemos que tiene una versión web y otra de escritorio que es prácticamente lo mismo, Whatsapp también tiene una versión web y Telegram lo mismo. Se están viendo más y más ejemplos de aplicaciones que pueden correr tanto en webs como ser empaquetadas para poder instalarlas. En aquel entonces era una cosa bastante novedosa y es algo que me gustaría tratar en el tema de hoy; esta moda de Progressive Web Apps y hablar un poco de lo que teníamos antes y a lo que vienen a sustituir.

>  PWA es un término de marketing, no se corresponde con ninguna versión nueva del estándar de Javascript. Muchas veces lo comparo con Web 2.0 o HTML5.

**[Carmen Ansio] ¿Nos podrías explicar así resumidamente que es una Progressive Web App?**

[J] Pues lo primero que voy a decir es que es un término de marketing, no se corresponde con ninguna versión nueva del estándar de Javascript, ni nada parecido. Muchas veces lo comparo con Web 2.0 o HTML5. HTML5 sí era una versión nueva pero en realidad estamos hablando de todas estas APIs nuevas para poder desarrollar aplicaciones web o sitios web para los que les vamos a ir añadiendo alguna una funcionalidad.

El término Progressive Web App lo acuñó Alex Russell  y Frances Berriman que eran 2 desarrolladores de Google. Hace un par de años escribieron [un post](https://infrequently.org/2015/06/progressive-apps-escaping-tabs-without-losing-our-soul/) y describían el término como websites que son responsive, que se parecen a aplicaciones nativas, que se puede instalar en la pantalla de inicio y que en algunos casos soportan modo offline. Es bastante interesante porque Alex estuvo hace poco explicando, [en una serie de tweets](https://twitter.com/slightlylate/status/879458731519389697), cómo surgió el tema y el término PWA.

Hay mucha gente a la que no le gusta lo de Progressive Web Apps y no entiende por qué es "app" y no es "site". En cuanto lees sobre el tema básicamente te dicen que PWA no es un término ara los desarrolladores, sino para para tu jefe. Es un término para el inversor, para el que va a hacer campaña de marketing de tu sitio. Es una forma de continuar construyendo proyectos en la web de forma abierta, que parezcan una aplicación y que normalmente tu compañía quiere hacer como aplicación nativa y no como web. Y la quieren hacer tres veces: una vez para Android, otra para iOS y otra, si pueden para Windows Phone. Al final es otra forma de decir que tenemos una serie de APIs, vamos a llamarla de alguna forma y con eso a ver si la gente se siente atraída y lo identifica como algo cool, algo novedoso, y que valga la pena verlo.

Esto lo escribieron ellos cuando estaban evaluando si tenían que tender hacia desarrollar aplicaciones para Chrome utilizando su sistema propietario, o tenían que ir más hacia un sistema más abierto, que es lo que defendían Alex y Francis. Se sentaron y estuvieron hablando sobre cómo unificar en un término esa funcionalidad de añadir a la pantalla de inicio, ServiceWorkers, notificaciones push y demás,

Cuando los desarrolladores escuchamos Progressive Web App tenemos que parar por un momento y pensar qué quiere decir, qué hay detrás. Google está promoviendo PWA y lo hace como una marca. Nosotros tenemos que verlo como un conjunto de herramientas que tenemos que tomar y aplicar a nuestras webs si así lo queremos. Muchas compañías que estaban centradas en desarrollar aplicaciones nativas ahora ven la web como una alternativa válida.

> Hay mucha gente nueva en Internet en muchos países emergentes que no quiere descargar. Las tarifas de datos son carísimas y quieren consumir contenido directamente, sin pasar por el proceso de instalación.

**[I] Sí porque además hace tiempo que se demuestra que muchos usuarios se instalan cinco aplicaciones en el móvil y el resto no las abren nunca más. Son las típicas de mensajería instantánea, de redes sociales y las 2 extra de turno que se usen por el motivo que sea. Hay gente que obviamente sí usa más aplicaciones, los que estamos más en la web porque somos desarrolladores o más frikis, como queramos llamarlo. Supongo que depende un poco de cada perfil. Pero no hay que olvidar que la inmensa mayoría no somos nosotros que es todo el resto de personas que usan muy muy muy muy poquitas cosas.**

[J] Hasta ahora, para las empresas el objetivo era estar en las tiendas de aplicaciones y ésta era la única forma de obtener visibilidad. Si no estaban ahí el usuario no iba a poder descubrir la aplicación. Hubo un boom de aplicaciones que prácticamente no servían para nada. Para usar una aplicación tengo que pasar por todo el proceso de encontrar la aplicación, descargarla e instalarla, ocupando un espacio en el teléfono. En occidente, que hemos crecido con smartphones y tenemos buenas tarifas de datos, tenemos todavía la costumbre de estas aplicaciones. Pero hay mucha gente nueva en Internet en muchos países emergentes que no quiere descargar. Las tarifas de datos son carísimas y quieren consumir contenido directamente, sin pasar por el proceso de instalación.

Es curioso porque yo trabajo en Spotify y siempre tenemos este dilema de si debemos promocionar las aplicaciones nativas (por ejemplo descargar la aplicación de escritorio) y qué casos de uso cubre un reproductor web. ¿Puede reemplazar un reproductor web a la aplicación de escritorio? Este tipo de conversaciones las tenemos casi todos los días. Hay un montón de empresas que están viendo que tienen que ir hacia web si quieren estar donde va a estar el próximo billón (mil millones) de usuarios. Lo vemos con Twitter y Uber, que hace poco lanzó su mobile site, y con muchos otros. Habitualmente son compañías de India y de China las que más están empujando por este tipo de desarrollos.

Creo que es un buen momento para explicar que hay detrás de las PWAs y qué engloban.

**[I] Perfecto, cuéntanos un poco porque obviamente ya hemos dicho que no son tecnologías completamente nuevas. Es un Progressive Enhancement, que se venía haciendo desde hace ya mucho tiempo. Los que desarrollamos para web debemos tener en cuenta tecnologías más antiguas y dispositivos más antiguos para que tengan una mínima experiencia. Luego vamos sumando funcionalidades para llegar a dar a nuestros usuarios lo que creemos que es mejor para ellos, o lo que creemos que ayuda al negocio en este caso.**

[J] Yo creo que al final eso es lo que tenemos que hacer. Nos tenemos que centrar en qué quiere el usuario y ver cuál es la solución técnica. Muchas veces cuando aparece este tipo de tecnologías todo el mundo quiere utilizarlas. Intentan un proyecto en el que aplicarlas, cuando en realidad debería ser al contrario.

Cuando hablamos de PWAs lo hacemos principalmente de ServiceWorkers. A veces también de añadir un manifest.json y notificaciones push. ServiceWorker es un fichero Javascript que el navegador se va a descargar una vez cargada la página y es capaz de interceptar peticiones. Cualquier petición que se haga a tu dominio va a ser capturada por este ServiceWorker. Ahí ya puedes hacer lo que quieras: puedes devolver tu respuesta personalizada, puedes acceder a una caché si quiere devolver datos cacheados, etc. En resumen, es un proxy, un fichero Javascript que se pone en medio. Hay un montón de “recetas” (cookbook). Si buscáis en google encontraréis muchas cosas que puedes con ServiceWorkers.

Por ejemplo vas a tu página web o blog y quieres poder volver a ver el contenido cuando no haya conexión a internet. En este caso puedes tener un ServiceWorker que se descarga el contenido para tenerlo accesible offline. Otro ejemplo es hacer una petición para obtener una imagen y que el ServiceWorker se encargue de devolver el formato que soporta el navegador, como por ejemplo webp.

La principal característica es offline, que no la teníamos bien implementada hasta ahora. Sí que existía una tecnología llamada Application Cache que prácticamente nadie utilizaba porque era muy difícil de implementar, y que está soportada todavía en iOS. Cuando hablamos de soporte para estas APIs siempre iOS y Safari quedan un poco fuera. Ésta es la tecnología que ServiceWorker intenta reemplazar.

> Debemos hacer un uso justo y limpio de estas tecnologías o si no va a resultar en problemas y habrá que establecer límites, lo que no es bueno para nadie.

**[I] De hecho ahora mismo es el único navegador moderno que no tiene ServiceWorker integrado, frente a Chrome, Firefox, Opera o Samsung Web Browser.**

[J] Para ser correcto, en Edge están trabajando en implementarlo y Safari ha anunciado que hay cierto interés en implementarlo en su plan de aquí a 5 años, así que con suerte llegará. También podemos hablar de la práctica empresarial de Google promoviendo PWAs frente a Apple, que no lo hace. Podemos ver que hay quizás ciertos intereses detrás de estas decisiones.

Algo que también permiten los ServiceWorkers es la sincronización background, de tal forma que no necesitas ni siquiera tener la pestaña abierta de tu página para poder acceder al contenido. Si despliegas una nueva versión de tu web puedes comprobar en un ServiceWorker instalado si hay una nueva versión y descargarte los assets. Así, una nueva petición del usuario a tu web puede usar directamente esos nuevos assets, cargando más rápido.

Un problema es que con el poder de un ServiceWorker viene también una gran responsabilidad. Mucha gente ve el hecho de hacer que una página funcione offline con una excusa para poder descargar toda la web por si acaso el usuario quiera acceder a una de las páginas. Es algo que a mí personalmente no me gusta. Por ejemplo si accedo a tu blog quizás esté interesado en ver esa página offline pero no me gustaría que utilizaras mi conexión a internet para descargar todo el contenido y todas las imágenes de tu blog para hacerlo disponible offline. Hay un conjunto de buenas prácticas como por ejemplo mostrar un botón para que el usuario pueda hacer cierto contenido offline. Debemos ser cuidadosos en este aspecto. Cuando instalas una aplicación en iOS o en Android ves cuántos MBs te estás descargando, al menos para la instalación inicial. Cuando accedes a una página web tú no lo sabes, Debemos hacer un uso justo y limpio de estas tecnologías o si no va a resultar en problemas y habrá que establecer límites, lo que no es bueno para nadie.

**[C] ¿Hay otros mecanismos de almacenamiento?**

[J] Cuando interceptas estas peticiones almacenas los datos en una caché y hay una forma de hacer que el contenido se almacene de forma temporal o persistente. El navegador considera que todo lo que descargas lo puede eliminar si lo necesita, pero hay una cierta cantidad de datos para los que puedes decir que por favor lo mantenga. Esto se calcula como un porcentaje del total de espacio disponible, teniendo en cuenta también cookies y localStorage. Antes había por ejemplo un límite de 5MB en localStorage. Ahora el navegador dedica un porcentaje del espacio de disponible en disco duro para almacenar datos. Así que en principio no hay límite, y ése es el problema. Desde una web puedes hacer una descarga grande hasta que el navegador se quede sin espacio y lance una excepción.

A la hora de implementar ServiceWorkers se puede hacer o bien a mano o utilizando una librería. Google tiene un par de librerías buenas que para incluir en proyectos: una se llama [sw-toolbox](https://github.com/GoogleChromeLabs/sw-toolbox) y la otra [sw-precache](https://github.com/GoogleChromeLabs/sw-precache). Hay 3 páginas que me gustan bastante sobre ServiceWorkers. Una es una página de ejemplos que hay en googlechrome/samples y Jake Archibald, que trabaja en Google, tiene también un [documento muy bueno que se llama The Offline Cookbook](https://developers.google.com/web/fundamentals/instant-and-offline/offline-cookbook/), y por último Mozilla tiene en [serviceworke.rs](https://serviceworke.rs/) una lista de diferentes estrategias a la hora de implementar ServiceWorkers.

**[I] Pues luego las anotamos y las dejamos en el programa. Algo que has mencionado son las Push Notifications, que no sé si van directamente ligadas con el hecho de usar una PWA, pero que es algo que va de la mano. Por ejemplo utilizando websockets, obtener información en directo y que vas recopilando en función de cuándo la envías desde un servidor y el usuario va recibiendo ese feedback.**

[J] Todo esto se basa en ServiceWorkers porque al final necesitas tener algo corriendo. Si tu página no está en primer plano tienes que tener un ServiceWorker que es lo que se va a quedar ejecutándose cuando el usuario cierra esa ventana o esa pestaña. Las notificaciones push son la misma notificación push que se ve normalmente en una aplicación. Va por otra vía pero al final la parte visual es exactamente igual.

Las notificaciones push eran una de las razones principales por las que las empresas querían hacer aplicación nativa. Una de las razones era el descubrir esa aplicación, para lo cual necesitabas hacer una aplicación nativa y ponerla en la tienda, la segunda era poder tener notificaciones push. Es útil para que el usuario vuelva a tu aplicación y no es suficiente con que el usuario instale la aplicación. Prácticamente hoy tenemos acceso a todo lo que tiene acceso una aplicación nativa.

**[I] Hay ciertas APIs que de momento funcionan ahí ahí. Hablamos con tecnologías web sin tener algo de por medio como pueda ser PhoneGap o Ionic. Nosotros desarrollamos una plataforma con WebRTC y tuvimos un montón de problemas para implementarlo porque obviamente no está soportado en varios navegadores. Hasta Edge 14 ó 15 no funcionaba. Obviamente Internet Explorer tampoco. Safari no funcionaba hasta hace muy poquito o han dicho que lo van a implementar en la siguiente versión del sistema operativo y obviamente funcionaba en Chrome. Aunque Chrome es una gran mayoría en uso a nivel mundial no hay que olvidar que hay muchos otros usuarios que no usan Chrome.**

[J] Sí, y luego todos aquellos que usen iPhone están fuera de momento de las PWAs. No es posible añadir una web a la pantalla de inicio y abrirlo a pantalla completa. Como decía, es un tema de marketing. PWA no deja de ser una web de toda la vida a la que le hemos añadido una funcionalidad extra para ponerlo en la pantalla de inicio y que no se abra el navegador, y soporte offline.

> ServiceWorker es un progressive enhancement, no puedes suponer que va a estar ahí.

**[C] Hablando de ese soporte offline y de ServiceWorkers, he leído el término “offline first”. ¿Nos podías comentar un poco cómo funciona?**

[J] Es gracioso porque estaba escuchando [el podcast que hicisteis con Diana sobre Mobile First](http://wecodesignpodcast.com/2017/07/04/mobile-first/). A veces nos hablan de offline first, a veces nos hablan de mobile first y a veces de content first cuando se habla sobre response design. Al final como desarrollador dices ¿qué tengo que hacer?

La idea de offline first está muy bien, no dar nada por hecho, que tu web pueda funcionar sin conexión a internet. Pero a la hora de implementarlo viene la parte difícil porque al introducir ServiceWorkers normalmente introduces el cacheo de fichero Javascript y también un sistema de templates. Para esto funciona muy bien utilizar librerías como Preact o Vue, donde tienes los templates y tienes el JS y no tienes nada server-side. Esto es muy fácil de cachear. También offline se podía conseguir hasta ahora utilizando unas buenas cabeceras de respuesta. Muchas veces no hace falta utilizar ServiceWorkers si quieres que tu página siga funcionando o que no repitas una request. Es cuestión de decirle al navegador que cachee el contenido durante más tiempo. Cuando hablan de offline first se entiende que no hay que asumir cuáles son las condiciones de la red. Supón que no hay red, ¿cómo va a comportarse tu página?

Uno de las características de ServiceWorkers es que la primera vez que visitas una página, ésta no se va a renderizar utilizando ServiceWorkers. El SW se añade después, lo descarga el navegador y sólo funciona para las siguientes peticiones. Es un progressive enhancement, no puedes suponer que el Service Worker va a estar ahí. Para que tu contenido sea offline primero tienes que visitar la web y tienes que poder cargar este ServiceWorker, que descargará el contenido. Me gusta offline first, igual que se suele pensar sobre qué pasaría si no se pudiera descargar o ejecutar Javascript, en cuyo caso habría que hacer, por ejemplo, Server Side Rendering. O ¿qué pasaría si el usuario tiene problemas de accesibilidad, qué va a ocurrir con el contenido, va a ser leído por lectores de accesibilidad? Todo esto al final va sumando y tenemos que pensar en una experiencia buena para que luego le añadamos funcionalidad. Y offline first no deja de ser otra más. Cuesta mucho decidir qué va primero ¿contenido, mobile, offline? Son metodologías diferentes. Como desarrolladores a veces estamos cansados, hay un poco de fatiga con todo lo que sale nuevo y hay que leerlo e intentar decir “vale, esto lo sitúo aquí y forma parte de mis herramientas para en algún momento determinado poder aplicarlas”.

**[I] Hay una página web de una desarrolladora que se llama [inaudible] que tiene un botoncito para hacer offline un post determinado, como decías tú al principio “quiero que este post en concreto, que me interesa escuchar a lo mejor cuando no tenga conexión”, pues lo guarda y te cachea las imágenes y todo lo que tiene ese post. Ella graba con voz cada uno de los artículos que escribe y deja que los escuches de forma offline si quieres. Creo que es una manera muy buena para dejar que el usuario decida si quiere descargar ese episodio o en este caso un artículo y que lo pueda leer cuando va en el metro sin conexión. No nos olvidemos que aunque vivimos en grandes ciudades en muchísimas ocasiones tenemos eso que llaman Lo-Fi. No tienes conexión suficiente porque estás dentro de un túnel y durante un período de tiempo determinado tienes una conexión realmente mala o directamente ninguna.**

[J] Sí, también lo llaman Lie-Fi, como que es un poco de mentira. Te dice que tiene wi-fi pero intenta descargar cosas por la wi-fi y no acaba de traerse nada. Yo creo que ése es un buen caso de uso. Jake Archibald, que es uno de los ingenieros de Google que ha estado dando presentaciones sobre esto, tiene una PWA para ver artículos de Wikipedia. Y tiene un botón para descargar un artículo y poder leerlo luego. Creo que esa funcionalidad es muy buena. Yo tengo un blog y no uso JS para nada, excepto para un SW. Y si te quedas sin conexión puedes leer el post que estabas leyendo más un par de enlaces más que todo que tengo arriba en el menú. Y ya está, no necesitas nada más. Está muy bien darle al usuario la posibilidad de que si quieren puedan descargar el contenido online. Me parece súper bien y creo que ése es el tipo de casos de uso que tenemos que intentar cubrir, y no intentar usarlo para todo sólo porque es nuevo.

> Mucha gente cree que esto de las PWA es sólo para sitios web grandes o de empresas importantes. En realidad puedes añadir un SW y manifest a cualquier web.

**[I] Antes has hablado del Manifest. Aunque ya sabemos que es un JSON y que da ciertas funcionalidades como decir “bájate este archivo, baja este otro”. ¿Para qué otras cosas se puede utilizar el Manifest?**

[J] Yo creo que estaban un poco hartos de añadir cabeceras “meta” dentro dentro de las páginas y decidieron crear un fichero donde definir un JSON con un montón de información que queremos tener para esta integración. En Google lo llaman A2HS (Add to Home Screen) y es lo que va a utilizar el sistema operativo móvil para poder abrir la aplicación. Tú le dices con qué orientación quieres abrirla y qué iconos quieres utilizar. Cuando implementas una PWA puedes comprobar dentro de tu código si está corriendo en modo aplicación (lanzada desde la pantalla de inicio) o si está corriendo dentro del navegador, utilizando display-mode. Si es standalone significa que está instalada y corriendo desde la pantalla de inicio. Está bien para analytics, para saber cuánta gente ha instalado la aplicación y la está utilizando así. También puedes utilizarlo para media-queries, para poder cambiar ligeramente en el estilo de la página dependiendo de si lo has lanzado desde la pantalla de inicio o no. Uno de los casos de uso sería mostrar botones de navegación cuando lo lanzas en fullscreen.

Mucha gente cree que esto de las PWA es sólo para sitios web grandes o de empresas importantes. En realidad puedes añadir un SW y manifest a cualquier web. Hay directorios de PWAs (por ejemplo [PWA Directory](https://pwa-directory.appspot.com/) o [PWA Rocks](https://pwa.rocks)) a poder descubrir dentro de Bing PWAs y te va a ofrecer la posibilidad de instalarlas. Es una especie de store pero en lugar de tú publicar ahí, Microsoft va a utilizar el mismo crawler que usan para Bing y va a poder mostrar ahí directamente la web.

No creo que las PWAs estén restringidas a webs grandes y pienso que todo el mundo debería probarlas. Los desarrolladores deberíamos hacer pruebas con nuestras webs. Cuando empecé a utilizar ServiceWorkers me di cabezazos contra el ordenador porque las herramientas de desarrollo no estaban muy desarrolladas, valga la redundancia. Cuando hacía una petición no sabía si la respuesta estaba viniendo del ServiceWorker o de verdad estaba sirviendo el fichero del servidor. Teníasque buscar por ahí un menú había muy oculto para activar la opción de que todas las peticiones dentro de localhost fueran directamente al fichero y que no se cacheen. Esto ha mejorado muchísimo.

Tenemos muchas estrategias sobre cómo hacer versionado de cachés. Cuando almacenas en ServiceWorker estás almacenando en la memoria del navegador. Si haces cambios en tu web y lanzas una nueva versión y versionas de la misma forma que versionas otros scripts, deberías ser un buen ciudadano, acceder a la versión previa que tenías cacheada y eliminarla del navegador. Si no al final vas a acumular un montón de bundles de Javascript o templates que ya no se necesitan.

Sé que hay alguna pregunta sobre utilizar PWAs con React, Vue y otras librerías. Si habéis utilizado alguna vez Create React App, que es una especie de boilerplate para crear aplicaciones React, también existe la posibilidad de utilizar estas mismas herramientas para crear PWAs. Create React App va a crear directamente por defecto una PWAs y, si utilizáis Preact, lanzaron su CLI para crearlas con Preact, y Vue también tiene su CLI con el que se generan PWAs por defecto.

**[C] Como has comentado antes, Apple no tiene soporte para para PWAs. ¿Ves un poco de guerra entre Google y Apple?**

[J] A veces parece que sí, al igual que Internet Explorer no implementaba nada nuevo en su navegador y entonces salió Firefox que implementaba todo. Mucha gente se pasó a Firefox y posteriormente a Chrome. Siempre existe esta guerra de navegadores y de las empresas que hay detrás. Me gusta mucho Google, que está empujando por estos estándares. Si desarrollamos PWAs el usuario no necesitará ir a la Store a descargarse nada, y ahora mismo tanto puede Google com oApple se llevan un porcentaje cuando descargas aplicaciones de pago y también de los pagos in-app. Al principio Apple sólo ofrecía herramientas web para desarrollar “aplicaciones” para iPhone, no existía nada para hacer una aplicación nativa. Todo giraba en torno a crear webs que tuviera el mismo look&feel. Luego descubrieron que ahí es donde estaba el negocio cuando empezaron a proporcionar estas herramientas para desarrollar aplicaciones nativas. Es difícil que vayas a ir en contra de tu principal fuente de ingresos. Google parece que tienen los ingresos más diversificados. Al confiar en una plataforma de anuncios Google se va a llevar dinero por anuncio, que también se muestran en la web (eg PWA).

Hay mucho trabajo para estandarizar estas APIs, implementarlas de una forma buena idea y de releasearlas. Pero estoy seguro de que también hay decisiones de negocio. Google se ha posicionado claramente hacia promover esta serie de APIs, hacen workshops en varios sitios del mundo explicando cómo usarlas, muestran cómo diferentes webs están implementando esta funcionalidad (qué problemas tenían de rendimiento, cómo han añadido PWAs y han ido mejorando, cuáles son las métricas que se ha movido como mayor retención de usuarios o más páginas vistas). Trabajan codo con codo con empresas grandes como Flipkart - el “Amazon” de India - o ele.me, que es una empresa muy grande de China de venta de comida online.

Apple va un poco por su cuenta. Es verdad que Safari está cambiando, implementando mucha funcionalidad que faltaba, pero da la sensación de que son reacios a implementar PWAs. Para entender mejor las razones pienso que es útil pensar cómo puede afectar a las fuentes de ingresos que los desarrolladores migren a web. Las empresas tienen un número limitado de trabajadores y muchas cosas que quieren hacer. Tienen que priorizar unas frente a otras y por lo que sea no están priorizando los ServiceWorkers y toda la funcionalidad para añadir webs a pantalla de inicio para ejecutarlas de forma standalone.

**[I] Yo creo que en este caso Apple a lo mejor no tiene publicidad directa como hace Google, y le da un poco más igual. Como tiene tantísimos beneficios a través de la App Store perder ese mercado, que es inmenso, es un peligro obviamente para ellos. Ahora mismo los que últimamente llegan tarde son Edge y Safari (Edge está mejorando un montón pero aún quedan algunas cosillas) y, en mi opinión, está claro por qué no lo están implementando. Con la salida de Technology Preview, que es la versión de desarrollador, sí está cambiando, pero le queda mucho para que, como pasa con Firefox y Chrome, se actualicen de forma constante.**

[J] También está la restricción de que no puedes correr ningún navegador con otro motor. Así que aunque tú instales Chrome o Firefox en iPhone estás corriendo Webkit por detrás, el motor de Safari. Puedes personalizar la experiencia alrededor del navegador pero no implementar PWAs. Eso es una decisión de negocio, y ahí no hay ninguna excusa. No puedes decir “queremos hacer el entorno más seguro”. Podrían utilizar el proceso de envío y revisión de aplicaciones y que tú pudieras ofrecer un motor de renderizado diferente. Es su ecosistema y controlan lo que ofrecen a los usuarios. El target de usuarios es diferente. Por ejemplo, en India o China el mercado de iOS es bastante más pequeño que en otros países de nuestro alrededor. Cada empresa juega sus cartas.

Como desarrolladores lo tenemos que ver como una funcionalidad añadida. Si lo soporta el navegador podemos utilizarlo y si no lo soporta, como hemos hecho bien nuestro trabajo, va a dar lo mismo porque el usuario va a poder disfrutar de nuestra web. Son APIs para mejorar nuestra web pero nunca tenemos que asumir que están ahí. Y lo bueno de ServiceWorker es que no se puede asumir su soporte, dado que la primera vez que carga la página no se puede utilizar.

**[I] Si te parece pasamos las preguntas que nos han dejado por Twitter. Pregunta Manuel si has tocado Vue para las PWAs o si sabes algún recurso sobre ServiceWorkers y notificaciones push en castellano.**

[J] No he usado Vue todavía. He estado leyendo sobre Vue pero me he enfocado más en React, que lo estoy utilizando en un proyecto grande, y probando Preact e Inferno por cuestiones de tamaño. Afortunadamente no necesitamos utilizar ninguna de estas librerías para crear PWAs. Como dije, mi blog sólo utiliza Javascript para crear un ServiceWorker y tener contenido offline. Las PWAs no requieren frameworks ni librerías específicos. Ni siquiera tienen que ser una SPA.

Recomiendo utilizar Vue CLI para crear PWAs con Vue. Habrán tomado algunas decisiones por ti, abstrayéndote para bien o para mal de los detalles de implementación, pero te servirá para crear un esqueleto para una aplicación.

Sobre recursos en español hay una web que se llama “[Tu primera Progressive Web App](https://developers.google.com/web/fundamentals/codelabs/your-first-pwapp/)” y la escribió Pete LePage, que es un desarrollador de Google. Es una traducción al español de la documentación oficial. Es un muy buen recurso y es más detallado que otros artículos que se pueden encuentran en español en Internet.

**[I] Fernando nos pregunta cómo encajan con las PWAs Que, React y Angular.**

[J] Recomiendo que cada uno escoja el framework/librería con la que se sientan más a gusto. Todas estas soluciones son similares y se pueden crear PWAs con ellas.

**[I] Fernando nos deja una segunda pregunta. Quiere saber si se adaptan los servicios workers correctamente a las aplicaciones híbridas Ionic o PhoneGap.**

[J] Es una buena pregunta. Es difícil saber dónde está la frontera entre entrar desarrollando una web que luego va a correr en una WebView, como en el caso de PhoneGap o Ionic. También hay alternativas nativas como ReactNative o NativeScript. Si estás desarrollando en iOS no vas a tener soporte para ServiceWorker independientemente de si es el navegador o si es una WebView porque no deja de ser el mismo navegador; no vas a tener soporte.

En el caso de Android no estoy seguro de cómo funcionan los ServiceWorkers dentro de las WebViews. Por ejemplo, quizás se cachea, quizás se mantiene en memoria sólo para esa WebView específica. No he llegado a trabajar con PWAs dentro de una aplicación híbrida.

**[C] Vamos a pasar a la tanda de preguntas que hemos. Manuel pregunta si puedes recomendar algún libro que hable sobre PWAs.**

[J] Hasta ahora no conocía ningún libro sobre PWAs y me he puesto a buscar. Casualmente acaba de salir un libro que está en Early Release y se llama “[Building Progressive Web Apps: Bringing the Power of Native to the Browser](http://shop.oreilly.com/product/0636920052067.do)” de O’Reilly. El autor creó también una librería que utilicé para un proyecto llamada “annyang” para hacer reconocimiento de voz.

Es más habitual encontrar información sobre PWAs en posts (sobre todo los de Developer Relations de Google) y más tarde llegan a libros.

**[C] A Manuel le gustaría saber en qué orden se comienza a desarrollar este tipo de aplicaciones.**

[J] Primero haz una web bien y luego mejórala. Considera PWA como un añadido. No intentes utilizar PWAs desde el principio o como una forma de solucionar problemas. Por ejemplo, si tienes problemas de performance no es buena idea que intentes solucionarlos con PWAs diciendo “sí, esto cacheo con un ServiceWorker y ya está”. Hay otras cosas que vas a tener que mirar antes.

Busca otras soluciones como por ejemplo hacer split del bundle: en lugar de mandar 1MB manda 200kB y luego carga el resto de forma asíncrona. No veas PWAs como el martillo y cualquier problema como un clavo.

**[C] David nos hace la última pregunta. Está interesado en saber que si el cliente sigue requiriendo una alternativa en forma de aplicación para tenerla en las stores, ¿qué tecnología utilizarías? ¿Cordova con React? ¿React Native?**

Es un problema porque aunque tengas una PWA es probable que te digan que la quieren ver en la tienda. Hay dos alternativas. Puedes implementar una aplicación híbrida con Cordova o Ionic 2, que utiliza Angular, y la empaquetas dentro de un navegador. También puedes utilizar lo último de lo último y utilizar React Native. En este caso tienes que reescribir la vista porque los componentes van a ser diferentes. Lo bueno es que, si la has estructurado bien, puedes reutilizar toda la parte de negocio (por ejemplo Redux). Esta opción es buena si quieres tener una aplicación con un muy buen rendimiento. También existe NativeScript, que se puede utilizar con Preact.

Independientemente de la solución trata de desacoplar el código. Intenta tener claro qué parte pertenece a la vista y cuál es lógica de negocio. Mueve código estable a una API, de forma que dé igual cuál sea la interfaz que consume los datos. Esto te permite hacer cambios tanto en la API (por ejemplo reescribiéndola en otro lenguaje) como el front (por ejemplo, crear un nuevo cliente para otra plataforma o utilizar una librería diferente).

Lo que usas hoy se va a quedar “anticuado” en un par de años, así que siempre intenta modularizar el código y optimiza para el mantenimiento y migración del código más que esforzarse en acoplar tu proyecto demasiado con un framework.

**[I] Si te parece con esto cerramos las preguntas de Twitter y pasamos a la más difícil. Dinos cómo ves la web dentro de 5 ó 10 años.**

[J] Pues es una pregunta difícil. Pienso en el desarrollo de los móviles y es impensable lo que hacíamos hace cinco años comparado con lo que hacemos ahora. Hace poco estuve en una charla donde un ponente dijo que somos la última generación que sabrá lo que es un navegador y creo que el futuro de la web es olvidarse del concepto “navegador”, o por lo menos como la única forma de consumir contenidos en la web.

La web se integra ahora mismo en móviles utilizando PWAs, pero también como una Webview en una aplicación nativa. Tenemos Chrome OS como el mejor ejemplo de cómo ejecutar sitios web que funcionan como aplicaciones. Y tenemos también ejemplos como AMP de Google donde generas contenido que luego va a estar directamente embebido dentro del buscador, o Instant Articles para integrar contenido en Facebook, y Apple News.

En mi trabajo me doy cuenta de que muchas veces la web se utiliza como un gran backend. Por ejemplo, Google indexa el contenido de Spotify y utilizando la web en la que trabajo (open.spotify.com), extrayendo metadatos para su buscador, que se muestran en un lateral al buscar artistas. También se utiliza para Google Home o Alexa de Amazon para su integración con web. Y de forma similar, cuando compartes en Facebook o Twitter, sus bots utilizan metadatos extraídos de la página para mostrar una previsualización.

Tenemos que dejar de pensar que hacemos webs que sólo van a ser consumidas a través de un navegador. Creamos contenido utilizando herramientas web pero no tenemos ningún control sobre dónde se van a visualizar. Un ejemplo es WebVR, donde es difícil controlar el entorno, y no existe el concepto de “página”.

Tenemos que mirar más allá, pensar en nuevas interfaces y cuál va a ser el papel de la web  ahí y olvidarse de controlar en entorno. Cuando llegaron los móviles con navegador fue un desafío crear webs. ¿Un sitio aparte? ¿Responsive? Este problema es fácil comparado con lo que viene ahora.

**[C] ¡Sí que está difícil saber lo que vendrá! Si te parece entramos en las ráfagas, y aquí va la primera. Dinos alguien que te haya inspirado.**

Me gustaría mencionar gente con la que he trabajado y me ha inspirado. Me gustó mucho trabajar en Tuenti con Alberto Grajera (@manquismo) que ahora está en Cabify, Davide Mendolia (@davideme) que está en Karumi, y Felipe Ribeiro (@felipernb) con quien trabajo en Spotify. Son desarrolladores que solían hacer web, aunque algunos hacen ahora móvil, y te recuerdan qué es lo importante cuando estás trabajando. La toma de requisitos, evaluar el problema con una mente ingenieril y no dejarse llevar por modas (por ejemplo últimas librerías). A todos nos gusta utilizar lo último pero tenemos que anteponer el hecho de que hay un usuario detrás, que necesita ese proyecto a tiempo y que funcione bien. Hay una empresa que te está pagando por hacer el trabajo, y va a haber un compañero que va a entrar a tu equipo y tiene que heredar o trabajar contigo en ese código. Estas 3 personas me han ayudado mucho a centrarme en lo que de verdad es importante.

Hay gente conocida del mundo web que me gusta seguir, y que me han inspirado de una forma diferente. Steve Souders fue quien hizo reverse engineering de cómo el navegador hacía peticiones y gestionaba las dependencias entre ellas. Fue quien puso las bases de lo que hoy se conoce como WPO (Optimización de rendimiento web).

Nicholas C. Zakas, que trabaja en Yahoo, hablaba sobre patrones para escribir Javascript mantenible. Stoyan Stefanov, que trabaja en Facebook, es otro track de Javascript. Algunos más “recientes” son Addy Osmani, que es un devrel de Google que da muchas charlas muy entretenidas. Y por último Dan Abramos, que quien haya trabajado con Redux sabrá que es quien responde cualquier pregunta sobre el tema, y trabaja en Facebook.

**[I] Los dejamos todos anotados para que la gente conozca a gente nueva, aprenda cosas nuevas y amplíe sus horizontes. Recomiéndanos ahora un recurso, una página web o un blog que consideres imprescindible.**

No podía elegir sólo uno, así que he escogido varios. Me gustan mucho las newsletter y estoy suscrito a Frontend Focus y Javascript Weekly, que comparten muchos enlaces a posts y vídeos de conferencias.

Me gusta mucho ver vídeos de charlas, como por ejemplo los de las JSConf. Esta conferencia es de las principales en JS, las entradas son caras, pero publican todos los vídeos en Youtube, así que es un buen recurso para ponerse al día. Google IO, el evento anual de Google, publican muchos vídeos de sus charlas. Hace un par de meses fue la edición de 2017 y ya están subidos.

Hay un par de webs que visito bastante: CSSTricks y Smashing Magazine, que hablan sobre frontend en general.

Un buen libro es “High Performance Browser Networking” de Ilya Grigorik, que es un ingeniero De Google. Te explica todo el stack, qué ocurre cuando se hace una petición y todos los puntos en los que podemos trabajar para mejorar el rendimiento de una web.

**[I] Perfecto. Igualmente lo dejamos apuntado para que la gente los pueda ver.**

**[C] Recomiéndanos ahora a un invitado o invitada a quien te gustaría que invitásemos al programa.**

[J] Jaume Sanchez Elias (@thespite en Twitter) es un chico que hace WebGL, WebVR y cosas muy chulas. Hace poco coincidí con él en una charla y me encantó conocerlo. Es muy enriquecedor cuando conoces a gente puntera que es capaz de inspirar tanto a los desarrolladores web. Es impresionante lo que puede conseguir con estas herramientas. Jaume hace que parezca fácil, pero en realidad hay mucho trabajo detrás. Me gustaría escuchar a Jaume hablar de estos temas.

**[I] Perfecto, pues le haremos llegar desde aquí la invitación. Por último recomiéndanos un tema que te gustaría tratar en el programa.**

[J] Soy un enamorado de mejorar la performance. Me gustaría saber si le preocupa a los desarrolladores, si son capaces de convencer a la gente de producto de que es algo a lo que hay que dedicarle tiempo, y si se ve como una feature más. Cuáles son los casos prácticos, si han introducido alguna mejora que se tradujera en más usuarios u otras métricas. Echo en falta ejemplos, sobre todo de empresas españolas, donde se vean mejoras de rendimiento que hayan movido métricas importantes para la empresa.

**[I] Muy bien, pues con esto cerramos el programa. La verdad es que ha sido un verdadero placer tenerte con nosotros. Hemos obtenido un montón de información y sobre temas útiles para que a la gente le pique el gusanillo y se ponga a investigar y a realmente implementarlo.**

[J] Lo divertido es que es fácil jugar con nuestras webs, e inspeccionar el código de cualquier web, aprendiendo de cómo han aplicado otros PWA.

**[C] Muchísimas gracias José Manuel por haber aceptado nuestra invitación.**

[J] A vosotros, un honor.

**[I] Muchas gracias.**

[Música] Recomendaciones. El espacio de sugerencias y recursos útiles para los diseñadores y desarrolladores web.

**[I] En el programa de hoy os traemos cuatro links, así que allá van mis dos primeros. El primero de los links es [un artículo que ha escrito Jason Grigsby de Cloudfour acerca de las PWAs](https://cloudfour.com/thinks/progressive-web-app-questions/), explicando lo que significa y lo que hacen. Decía que hace unas semanas le escribía un estudiante en su proyecto final y quería preguntarle cómo funcionaban y para qué servían. El segundo link es una herramienta de auditoría que se puede usar a través de terminal y a través de página web, y es [Lighthouse](https://github.com/GoogleChrome/lighthouse). Es una herramienta que ha desarrollado Google, principalmente Paul Irish, para auditar y ver las métricas de nuestras PWAs.**

**[C] El primero de mis links viene de la web de desarrolladores de Google, en la cual tenéis [una checklist para poder testear y comprobar si cumple todos los requisitos necesarios](https://developers.google.com/web/progressive-web-apps/checklist) y además poder poner atención a los detalles y de esa manera mejorar la experiencia a nuestros usuarios. El segundo de mis links es [un listado de recursos que Timmy ha colgado en su página web personal sobre las PWAs](https://www.timmykokke.com/2017/06/the-pwa-resource-list/).**
