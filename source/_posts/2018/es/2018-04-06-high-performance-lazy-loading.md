---
layout: post
title: Cómo mejorar la performance de una web usando lazy-loading y code-splitting
date: 2018-04-06 08:00:00+02:00
description: Cómo usar un High Order Component para detectar cuándo un elemento está visible y hacer lazy-loading de componentes y secciones de nuestras páginas. Manda al navegador sólo lo que es necesario.
image:
  url: /assets/images/posts/observer/high-performance.jpg
  width: 1600
  height: 835
tags:
  - performance
  - lazy-loading
language: es
i18n:
  en: high-performance-lazy-loading/
  es: es/high-performance-lazy-loading/
permalink: es/high-performance-lazy-loading
---

El desarrollo basado en componentes ha marcado un antes y un después en el desarrollo web. Las principales ventajas que suelen mencionarse son la reutilización y la modularización. Componentes bien definidos y encapsulados que podemos usar para construir nuestros sitios, como ladrillos de Legos. Una ventaja adicional es que esta estructura de componentes proporciona una base sólida para mejorar la performance de nuestras webs.

<img
    style="max-width:100%; border: 0"
    sizes="(max-width: 768px) 100vw, 684px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:400,f_auto/v1522995807/high-performance_mbjoct.jpg 400w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:800,f_auto/v1522995807/high-performance_mbjoct.jpg 800w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1200,f_auto/v1522995807/high-performance_mbjoct.jpg 1200w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1522995807/high-performance_mbjoct.jpg 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:684,f_auto/v1522995807/high-performance_mbjoct.jpg"
    alt="" />

Nuestras dependencias son explícitas, por lo que sabemos qué código necesitamos ejecutar para cargar un componente específico. Lazy-loading y bundle-splitting pueden tener un gran impacto en el rendimiento de la página: requests con menos payload, código parseado y ejecutado. Y esto no solo se aplica a JavaScript, sino a cualquier tipo de asset.

Creo que muchas webs pueden aprovecharse de estas técnicas, y me gustaría mostrar algunos ejemplos básicos para solicitar recursos cuando sean necesarios.

<!-- more -->

En este post usaremos Preact/React, pero la idea se puede aplicar a cualquier otra librería basada en componentes.

Vamos a cubrir varios temas:

1.  [Patrones de composición](#Patrones-de-composicion): Descripción general de dos patrones que podemos usar para construir componentes complejos.
2.  [Mejorando el rendimiento de nuestras webs cargando sólo lo necesario](#Mejorando-el-rendimiento-de-nuestras-webs-cargando-solo-lo-necesario): Un caso práctico donde aplicaremos lazy-loading.
3.  [Un pequeño componente para detectar visibilidad](#Un-pequeno-componente-para-detectar-cuando-una-area-es-visible): Un componente sencillo que contiene la lógica para notificar cuándo aparece un elemento en la pantalla.
4.  [Más casos de uso](#Mas-casos-de-uso): Veremos que un componente para detectar la visibilidad también puede ser útil en otras situaciones.
5.  [Haciendo un polyfill de IntersectionObserver bajo demanda](#Haciendo-polyfill-de-IntersectionObserver-bajo-demanda): cómo podemos incluir un polyfill solo cuando sea necesario.
6.  [Code Splitting y CSS-in-JS](#Code-Splitting-y-CSS-in-JS): cómo CSS-in-JS nos permite extender el code-splitting y lazy-loading a CSS, SVGs y otros recursos.
7.  [Implementaciones útiles](#Implementaciones-utiles): librerías npm existentes que implementan el patrón que hemos explicado.

¡Comencemos!

## Patrones de composición

En el desarrollo web basado en componentes éstos no se usan sólo para renderizar píxeles en la pantalla. También pueden encapsular una funcionalidad o comportamiento que se pasa a los componentes hijo.

Para esto se suelen utilizar [High Order Components (HOC)](https://reactjs.org/docs/higher-order-components.html). Estos componentes reciben otro componente y aumentan su funcionalidad.

Si has usado redux, la función `connect` es un HOC que recibe otro componente. Puedes encontrar más ejemplos en "[React Higher Order Components in depth](https://medium.com/@franleplant/react-higher-order-components-in-depth-cf9032ee6c3e)" de Fran Guijarro.

```jsx
const MyComponent = props => (
  <div>
    {props.id} - {props.name}
  </div>
);

// ...

const ConnectedComponent = connect(
  mapStateToProps,
  mapDispatchToProps
)(MyComponent);
```

Function as Child Component (también llamado "[Render Callback](https://reactpatterns.com/#render-callback)") es otro patrón que se usa en situaciones similares. Cada vez es más popular, y puede que lo hayas visto en librerías como [react-media](https://github.com/ReactTraining/react-media) o [unstated](https://github.com/jamiebuilds/unstated).

Veamos este ejemplo tomado de react-media:

```jsx
const MyComponent = () => (
  <Media query="(max-width: 599px)">
    {matches =>
      matches ? (
        <p>The document is less than 600px wide.</p>
      ) : (
        <p>The document is at least 600px wide.</p>
      )
    }
  </Media>
);
```

El componente `Media` llama a sus hijos pasando un argumento `matches`. De esta forma los componentes hijos no necesitan saber sobre la media query. La componentización suele hacer más fácil el testeo y mantenimiento del código.

## Mejorando el rendimiento de nuestras webs cargando sólo lo necesario

Imagina una página web típica. Puedes echar un ojo a [Website Sameness](https://css-tricks.com/website-sameness/) o [Web Design Trends: Why Do All Websites Look The Same?](https://www.friday.ie/journal/why-do-all-websites-look-the-same/) para más inspiración :) . La página de ejemplo que vamos a usar contiene varias secciones o bloques:

- una cabecera (estos días, una imagen grande o "hero image" que ocupa toda el área por encima del fold)
- una sección con algunas imágenes
- otra sección con un componente pesado como un mapa
- un footer

<p style="max-width:300px;display:block;margin-left:auto;margin-right:auto">
<img
    style="max-width:100%"
    sizes="300px"
    srcset="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:300,f_auto/v1523084060/observer/site.png 300w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:600,f_auto/v1523084060/observer/site.png 600w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:900,f_auto/v1523084060/observer/site.png 900w, https://res.cloudinary.com/jmperez/image/upload/w_auto:100:1400,f_auto/v1523084060/observer/site.png 1400w"
    src="https://res.cloudinary.com/jmperez/image/upload/w_auto:100:300,f_auto/v1523084060/observer/site.png"
    alt="Una web típica" />
<small class="caption">La estructura básica de una página que estaremos usando como ejemplo.</small>
</p>

Mapeado a componentes React sería algo como esto:

```jsx
const Page = () => {
  <div>
    <Header />
    <Gallery />
    <Map />
    <Footer />
  </div>;
};
```

Cuando el usuario visita la página, es muy probable que vea la cabecera en la pantalla. Es menos probable que vea la galería, el mapa y el pie de página, a menos que haga scroll.

Seguramente sueles incluir todos los scripts y CSS necesarios para renderizar todas las secciones cuando el usuario carga la página. Hasta hace poco, era difícil definir las dependencias de un módulo y cargar sólo lo que se necesitaba.

Hace años, antes de ES6, algunas empresas con webs grandes crearon soluciones propias para definir dependencias y cargarlas bajo demanda. Yahoo creó [YUI Loader](https://books.google.com/books?id=E7p-07kNfXYC&pg=PA65&lpg=PA65&dq=yahoo+yui+loader&source=bl&ots=UOcpQHdaRp&sig=AGTHNZvPYXWdU9lkj9klzTEa3ys&hl=en&sa=X&ved=0ahUKEwjn26Wti8PZAhUJDSwKHQOsCbIQ6AEIVDAG#v=onepage&q=yahoo%20yui%20loader&f=false) y Facebook hizo lo propio con [Haste, Bootloader y Primer](/facebook-frontend-javascript/).

Cuando envías código innecesario al usuario se desperdician tus recursos y los suyos. Más ancho de banda para transferir los datos, más CPU para parsearlos y ejecutarlos, y más memoria utilizada. Y esos assets robarán los recursos limitados de otros assets críticos que lo necesitan con más urgencia.

¿De qué sirve hacer peticiones innecesarias, como imágenes que el usuario nunca verá? ¿O cargar un componente de terceros como un mapa de Google, con todas sus peticiones adicionales necesarias para procesar?

Un informe de cobertura de código, como [el que proporciona Google Chrome](https://developers.google.com/web/updates/2017/04/devtools-release-notes#coverage) **no nos será de mucha ayuda**. El código JS será ejecutado y el CSS aplicado a elementos que no están visibles.

{% resp_image v1522995652/observer/chrome-coverage.png "La pestaña de Cobertura en Google Chrome" %}
<small class="caption">Pestaña de cobertura de código en Google Chrome ([fuente](https://developers.google.com/web/updates/2017/04/devtools-release-notes#coverage))</small>

Como en todo, **hay pros y contras cuando se usa lazy-loading**. No queremos aplicar lazy-loading a todos los elementos. Debemos tener en cuenta algunas cosas.

- **No usar lazy-loading por encima del fold**. En la mayoría de casos queremos que el contenido por encima del fold se renderice tan pronto como sea posible. Todas las técnicas de lazy-loading introducen un retraso. El navegador tiene que ejecutar el JS que inyecta el HTML en el documento, parsearlo y comenzar a pedir los assets referenciados.

{% resp_image v1522995652/observer/fold.png "No hagas lazy-loading por encima del fold" %}

¿Cómo sabemos dónde queda el fold? La verdad es que es difícil y depende del dispositivo del usuario y de tu layout.

- **Si usas lazy-loading, carga los elementos un poco antes de cuando se necesitan**. Es buena idea evitar mostrar áreas vacías en tu web. Para ello, puedes cargar un elemento cuando esté lo suficientemente cerca del área visible. Por ejemplo, cuando el usuario hace scroll hacia abajo y la imagen a cargar está 100px más abajo, empieza a solicitarla.

{% resp_image v1522995652/observer/preloading.png "Comienza a cargar un poco antes de cuando se necesite" %}

- <p>**Contenido invisible en algunos casos**. Debes tener en cuenta que el contenido cargado usando lazy-loading no se mostrará en estas situaciones:</p>
   - Si el contenido cargado lazy-loading no se ha cargado no se mostrará al intentar imprimir la página.
   - Lo mismo ocurre cuando la página se muestra en lectores RSS que no ejecuten el JS necesario para cargar el contenido.
   - Puedes tener problemas con SEO al indexar contenido cargado con lazy-loading en Google. En el momento de escribir este artículo, Googlebot soporta IntersectionObserver e invoca su callback con cambios en el viewport por encima del fold. Sin embargo, **no invoca el callback para contenido por debajo del fold**. Por lo tanto, **ese contenido no será visto ni indexado por Google**.
     Si tu contenido es importante puedes renderizar el texto y dejar lazy-loading para componentes como imágenes y otros widgets (por ejemplo mapas).

  Aquí estoy cargando [una página de test](https://jmperezperez.com/lazy-load/89b6f20e1d79e9fb902242ab84217b12.html) (puedes ver el código fuente [aquí](https://github.com/JMPerez/lazy-load/blob/master/text-above-fold.js)) usando la función "Fetch as Google" de Google Webmaster Tools. Googlebot renderiza el contenido que queda dentro del viewport, pero no el que se cargaría debajo.

  <div class="videoWrapper">
    <iframe width="1764" height="1080" src="https://www.youtube.com/embed/YEWaufLXX_Q" frameborder="0" allowfullscreen loading="lazy"></iframe>
  </div>
  <small class="caption">Renderizando [una página de prueba](https://jmperezperez.com/lazy-load/89b6f20e1d79e9fb902242ab84217b12.html) usando "Fetch as Google" de Google Webmaster Tools.</small>

<div class="callout">
<strong>Actualización a 10 de mayo de 2019</strong>: Google anunció durante el I/O 2019 que <a href="https://webmasters.googleblog.com/2019/05/the-new-evergreen-googlebot.html">actualizarán Googlebot para usar la última versión de Chrome</a>. Esto acaba con el problema de que Googlebot use Chrome 41 para renderizar páginas, y añade soporte para IntersectionObserver. Si utilizas Google Search Console para comprobar cómo Google renderiza una de tus URLs, todavía recibirás el resultado de renderizar usando Chrome 41. Esto es porque <a href="https://youtu.be/Ey0N1Ry0BPM?t=381">Google aún no ha actualizado sus herramientas de testeo para utilizar un Chrome <em>evergreen</em>.
</div>

## Un pequeño componente para detectar cuando una área es visible

En el pasado hablé sobre [lazy-load de imágenes](/lazy-loading-images/). La misma técnica se puede aplicar a otros elemetos.

Vamos a escribir un componente sencillo que detectará cuando una sección es visible en el viewport. Para hacerlo más breve usaré la [Intersection Observer API](https://developer.mozilla.org/docs/Web/API/Intersection_Observer_API), una tecnología experimental con [bastante buen soporte](https://caniuse.com/#search=intersectionobserver).

```jsx
class Observer extends Component {
  constructor() {
    super();
    this.state = { isVisible: false };
    this.io = null;
    this.container = null;
  }
  componentDidMount() {
    this.io = new IntersectionObserver([entry] => {
      this.setState({ isVisible: entry.isIntersecting });
    }, {});
    this.io.observe(this.container);
  }
  componentWillUnmount() {
    if (this.io) {
      this.io.disconnect();
    }
  }
  render() {
    return (
      // creamos un div para obtener una referencia.
      // Es posible usar findDOMNode() para evitar
      // crear elementos extras, pero findDOMNode está desaconsejado
      <div
        ref={div => {
          this.container = div;
        }}
      >
        {Array.isArray(this.props.children)
          ? this.props.children.map(child => child(this.state.isVisible))
          : this.props.children(this.state.isVisible)}
      </div>
    );
  }
}
```

El componente usa IntersectionObserver para detectar si el contenedor intersecta con el viewport, es decir, si está visible. Aprovechamos los métodos del lifecycle de React para limpiar el IntersectionObserver [desconectándolo](https://developer.mozilla.org/docs/Web/API/IntersectionObserver/disconnect) al desmontar.

Este componente básico puede extenderse con propiedades adicionales pasadas como [opciones para el IntersectionObserver](https://developer.mozilla.org/docs/Web/API/Intersection_Observer_API#Intersection_observer_options) como márgenes o umbrales. Así, podríamos detectar elementos cercanos pero que no intersectan con el viewport. Las opciones se establecen en el constructor y son de sólo lectura. Añadir soporte para opciones requeriría reinstanciar el IntersectionObserver con nuevas opciones cuando cambien, añadiendo lógica extra en `componentWillReceiveProps` que no vamos a cubrir aquí.

Podemos usar este componente para hacer lazy-loading de dos de nuestros componentes, `Gallery` y `Map`:

```jsx
const Page = () => {
  <div>
    <Header />
    <Observer>{isVisible => <Gallery isVisible />}</Observer>
    <Observer>{isVisible => <Map isVisible />}</Observer>
    <Footer />
  </div>;
};
```

En el código anterior paso la propiedad `isVisible` a los componentes `Gallery` y `Map` para que ellos la gestionen. Otra forma de hacerlo es devolver el componente si está visible, o un elemento vacío en caso contrario.

En cualquier caso **asegúrate de que reservas el área para el componente**. No es buena idea que el contenido "salte" cuando el componente se carga, así que si sabes que tu `Map` tiene un alto de 400px, renderiza un contenedor vacío de 400px de altura antes de que el mapa se cargue.

¿Cómo usan los componentes `Map` y `Gallery` la propiedad `isVisible`? Veamos el componente `Map`:

```jsx
class Map extends Component {
  constructor() {
    super();
    this.state = { initialized: false };
    this.map = null;
  }

  initializeMap() {
    this.setState({ initialized: true });
    // loadScript carga un script externo, su definición no se incluye aquí.
    loadScript('https://maps.google.com/maps/api/js?key=<your_key>', () => {
      const latlng = new google.maps.LatLng(38.34, -0.48);
      const myOptions = { zoom: 15, center: latlng };
      const map = new google.maps.Map(this.map, myOptions);
    });
  }

  componentDidMount() {
    if (this.props.isVisible) {
      this.initializeMap();
    }
  }

  componentWillReceiveProps(nextProps) {
    if (!this.state.initialized && nextProps.isVisible) {
      this.initializeMap();
    }
  }

  render() {
    return (
      <div
        ref={div => {
          this.map = div;
        }}
      />
    );
  }
}
```

Cuando se muestra el contenedor en el viewport, hacemos una petición para inyectar el script de Google Maps, y una vez cargado instanciamos el mapa. Éste es un buen ejemplo de código JavaScript que no se necesita al principio y podemos cargar bajo demanda, y por consiguiente el resto de recursos necesarios para mostrar el mapa.

El componente tiene estado propio para evitar volver a inyectar el script de Google Maps.

Veamos el componente `Gallery`:

```jsx
class Gallery extends Component {
  constructor() {
    super();
    this.state = { hasBeenVisible: false };
  }
  componentDidMount() {
    if (this.props.isVisible) {
      this.setState({ hasBeenVisible: true });
    }
  }
  componentWillReceiveProps(nextProps) {
    if (!this.state.hasBeenVisible && nextProps.isVisible) {
      this.setState({ hasBeenVisible: true });
    }
  }
  render() {
    return (
      <div>
        <h1>Some pictures</h1>
        Picture 1{this.state.hasBeenVisible ? (
          <img src="http://example.com/image01.jpg" width="300" height="300" />
        ) : (
          <div className="placeholder" />
        )}
        Picture 2
        {this.state.hasBeenVisible ? (
          <img src="http://example.com/image02.jpg" width="300" height="300" />
        ) : (
          <div className="placeholder" />
        )}
      </div>
    );
  }
}
```

El ejemplo anterior define otro componente con estado. De hecho, estamos almacenando en el estado la misma información que almacena `Map`.

Si la galería se muestra dentro del viewport y más tarde el usuario hace scroll y la galería deja de estar visible, las imágenes permanecerán en el DOM. En la mayoría de los casos, esto es lo que queremos cuando trabajamos con imágenes.

### Componentes hijo sin estado

Un componente sin estado (stateless) también resulta interesante. Nos permitiría quitar de la memoria las imágenes que ya no estén visibles, mostrando placeholders:

```jsx
const Gallery = ({ isVisible }) => (
  <div>
    <h1>Some pictures</h1>
    Picture 1{isVisible ? (
      <img src="http://example.com/image01.jpg" width="300" height="300" />
    ) : (
      <div className="placeholder" />
    )}
    Picture 2
    {isVisible ? (
      <img src="http://example.com/image02.jpg" width="300" height="300" />
    ) : (
      <div className="placeholder" />
    )}
  </div>
);
```

Si haces esto, **asegúrate de que las imágenes tienen las cabeceras de respuesta adecuadas** para que las peticiones subsecuentes usen la caché y no descarguen las imágenes otra vez.

Puedes mover la lógica al componente `Observer` si ves que creas componentes con estado sólo para almacenar si se han mostrado al menos una vez. `Observer` ya tiene estado y puede llamar a sus hijos fácilmente con un argumento adicional `hasBeenVisible`.

```jsx
const Page = () => {
  ...
  <Observer>
    {(isVisible, hasBeenVisible) =>
      <Gallery hasBeenVisible /> // Gallery ya no necesita estado
    }
  </Observer>
  ...
}
```

Otra opción es tener una variación del componente `Observer` que sólo pase una prop como `hasBeenVisible`. Esto tiene la ventaja de que podemos desconectar el IntersectionObserver tan pronto como el elemento se muestre, ya que no vamos a cambiar su valor. Llamaremos a este componente `ObserverOnce`:

```jsx
class ObserverOnce extends Component {
  constructor() {
    super();
    this.state = { hasBeenVisible: false };
    this.io = null;
    this.container = null;
  }
  componentDidMount() {
    this.io = new IntersectionObserver(entries => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          this.setState({ hasBeenVisible: true });
          this.io.disconnect();
        }
      });
    }, {});
    this.io.observe(this.container);
  }
  componentWillUnmount() {
    if (this.io) {
      this.io.disconnect();
    }
  }
  render() {
    return (
      <div
        ref={div => {
          this.container = div;
        }}
      >
        {Array.isArray(this.props.children)
          ? this.props.children.map(child => child(this.state.hasBeenVisible))
          : this.props.children(this.state.hasBeenVisible)}
      </div>
    );
  }
}
```

## Más casos de uso

Hemos utilizado el componente `Observer` para cargar recursos bajo demanda. También lo podemos utilizar para comenzar la animación de un componente cuando se muestre en pantalla.

En este ejemplo tomado de la web de React Alicante se animan unas cifras cuando el usuario hace scroll hasta esa sección.

<div style="text-align:center">
  <video width="1064" height="618" controls src="https://res.cloudinary.com/jmperez/video/upload/dpr_auto,f_auto,q_auto/v1522995652/observer/react-alicante.mp4" />
</div>

Podemos recrearlo con este código (puedes verlo y editarlo [en Codepen](https://codepen.io/jmperez/pen/LQXjYv)):

```jsx
class ConferenceData extends Component {
  constructor() {
    super();
    this.state = { progress: 0 };
    this.interval = null;
    this.animationDuration = 2000;
    this.startAnimation = null;
  }
  componentWillReceiveProps(nextProps) {
    if (
      !this.props.isVisible &&
      nextProps.isVisible &&
      this.state.progress !== 1
    ) {
      this.startAnimation = Date.now();
      const tick = () => {
        const progress = Math.min(
          1,
          (Date.now() - this.startAnimation) / this.animationDuration
        );
        this.setState({ progress: progress });
        if (progress < 1) {
          requestAnimationFrame(tick);
        }
      };
      tick();
    }
  }
  render() {
    return (
      <div>
        {Math.floor(this.state.progress * 3)} days ·
        {Math.floor(this.state.progress * 21)} talks ·
        {Math.floor(this.state.progress * 4)} workshops ·
        {Math.floor(this.state.progress * 350)} attendees
      </div>
    );
  }
}
```

Una vez definido podemos utilizarlo de la misma forma que el resto de componentes. Esta es una muestra del potencial de abstraer la lógica para detectar la visibilidad fuera de los componentes que la necesitan.

## Haciendo polyfill de IntersectionObserver bajo demanda

Hasta ahora hemos utilizado IntersectionObserver para detectar cuándo un elemento se muestra en pantalla. En el momento de escribir este artículo algunos navegadores, como Safari, no soportan IntersecionObserver. Si lo intentamos instanciar el navegador lanzará un error.

Podríamos establecer `isVisible` a `true` cuando IntersectionObserver no esté disponible, lo que en la práctica desactivaría el lazy-loading. En cierta manera consideraríamos lazy-loading como un progressive enhancement:

```js
class Observer extends Component {
  constructor() {
    super();
    // isVisible se inicializa a true si el
    // navegador no soporta IntersectionObserver
    this.state = { isVisible: !(window.IntersectionObserver) };
    this.io = null;
    this.container = null;
  }
  componentDidMount() {
    // sólo inicializamos IntersectionObserver si está soportado
    if (window.IntersectionObserver) {
      this.io = new IntersectionObserver(entries => {
        ...
      }
    }
  }
}
```

Mi opción favorita es incluir un polyfill como el [polyfill para IntersectionObserver de w3c](https://github.com/w3c/IntersectionObserver/tree/master/polyfill). Así, IntersectionObserver funciona en todos los navegadores.

Como estamos hablando de cargar assets bajo demanda, qué mejor que aplicarlo a este caso. Usaremos code-splitting para hacer la petición del polyfill sólo si nos hace falta, es decir, si el navegador no tiene soporte para IntersectionObserver:

```js
class Observer extends Component {
  ...
  componentDidMount() {
    (window.IntersectionObserver
      ? Promise.resolve()
      : import('intersection-observer')
    ).then(() => {
      this.io = new window.IntersectionObserver(entries => {
        entries.forEach(entry => {
          this.setState({ isVisible: entry.isIntersecting });
        });
      }, {});
      this.io.observe(this.container);
    });
  }
  ...
}
```

Puedes ver [una demostración aquí](https://react-intersection-observer.stackblitz.io/) ([código fuente](https://stackblitz.com/edit/react-intersection-observer)). Safari hará una petición extra para cargar el paquete npm `intersection-observer` dado que no soporta IntersectionObserver.

{% resp_image v1522995652/observer/safari-intersection-observer-2.jpg "Captura de pantalla del panel de Red en Safari, mostrando la petición para el polyfill" %}

<small class="caption">Safari hace una request para el polyfill de intersection-observer bajo demanda. No necesitamos cargarlo en navegadores que lo soportan nativamente.</small>

La solución se basa en code splitting. Hay herramientas como [Parcel](https://parceljs.org/code_splitting.html) o [Webpack](https://webpack.js.org/guides/code-splitting/) que crearán un bundle para ese paquete importado, así como la lógica para hacer la petición para ese fichero.

## Code Splitting y CSS-in-JS

Hasta ahora hemos visto cómo usar un HOC para detectar que un elemento está en el viewport. También hemos aprendido cómo cargar JavaScript adicional cuando hace falta.

Code-splitting es bastante común y fácil de implementar a nivel de ruta. El navegador carga bundles adicionales cuando el usuario va navegando a través de diferentes URLs de la web. Herramientas como [react-router](https://github.com/ReactTraining/react-router) y [Next.js](https://github.com/zeit/next.js/) han popularizado code-splitting, integrándolo como parte de dynamic imports.

A través de varios ejemplos hemos visto que se puede implementar code-splitting dentro de una misma ruta, cargando el código para los componentes bajo demanda. Esto es muy útil si tenemos componentes que necesitan mucho código específico, no sólo JavaScript.

Un componente puede referenciar otros recursos o incluso contenerlos "inline". Un ejemplo son SVGs o estilos CSS.

No tiene sentido solicitar estilos que no se van a aplicar a ningún elemento. Solicitar estilos e inyectarlos dinámicamente causa un FOUC (Flash of Unstyled Content). El navegador muestra los elementos HTML con el estilo existente, y una vez que los estilos adicionales son inyectados re-estila el contenido. Con la aparición de soluciones CSS-in-KS (o JSS) esto ya no es un problema. El CSS se incluye inline en el componente, y conseguimos code-splitting verdadero para nuestros componentes. **Con CSS-in-JS llevamos code-splitting más allá, cargando CSS bajo demanda.**

## Implementaciones útiles

En este post he explicado cómo implementar un componente Observer básico. Existing implementaciones de componentes similares que han sido probadas en muchas aplicaciones y soportan más opciones y formas de integrarse en tu proyecto.

Recomiendo echar un vistazo a estas dos librerías:

- [thebuilder/react-intersection-observer](https://github.com/thebuilder/react-intersection-observer)
- [researchgate/react-intersection-observer](https://github.com/researchgate/react-intersection-observer)

## Conclusión

La componentización hace el code-splitting y la carga de recursos bajo demanda más fácil que nunca. Define las dependencias de tu código y usa los bundlers y otras herramientas modernas para hacer peticiones para las dependencias cuando el usuario navegue a nuevas rutas o se muestren nuevos componentes en la página.

---

Me gustaría dar las gracias a [@alexjoverm](https://twitter.com/alexjoverm), [@aarongarciah](https://twitter.com/aarongarciah) y [@FlavioCorpa](https://twitter.com/FlavioCorpa) por revisar este artículo, investigar lazy-loading desde varios puntos de vista, y recomendar herramientas para crear los ejemplos.

Si encuentras alguna errata o información errónea, [no dudes en escribirme](https://twitter.com/jmperezperez).
