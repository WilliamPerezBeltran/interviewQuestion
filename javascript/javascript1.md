https://en.wikipedia.org/wiki/React_(JavaScript_library)

let const var 

https://www.freecodecamp.org/news/var-let-and-const-whats-the-difference/

https://stackoverflow.com/questions/762011/whats-the-difference-between-using-let-and-var

Aquí es donde entran los Higher-Order Components.

Un Higher-Order Components es, como dice la documentación oficial:

[…] a function that takes a component and returns a new component.

Es decir, una función que toma un componente como parámetro y retorna un nuevo componente.
https://hpneo.dev/2019/03/19/usando-hocs.html

====================================================

cuales son los tipos primitivos en javascript?
¿Cómo debo estructurar mi proyecto?

cual arquitectura utiliza en las carpetas de react 
cual es la mejor arquitectura de archivos para crear una aplicación web react????


actualizaciones de javascript con emacscript ?
los tipos de hook  ? 

que es una funcion inpura en javascript ?
=================================================================
que es una funcion pura en javascript ?
https://www.etnassoft.com/2016/06/21/las-funciones-puras-en-javascript-concepto-ejemplos-y-beneficios/


Como la mayoría de los principios de la programación funcional, el concepto de función pura es simple, y precisamente esa simplicidad hace que al principio sea difícil apreciar su belleza y los beneficios que ofrece. Más adelante vamos a ver como las funciones puras hacen que nuestro código sea más fácil de predecir, aislar, reusar y testear, más fácil de razonar con menos contexto... pero nos toca empezar por el principio… bueno, al grano.
Decimos que una función es pura cuando cumple los siguientes requisitos:
1.Dados los mismos inputs (argumentos) siempre retorna lo mismo (transparencia referencial).
2.No tiene efectos colaterales.

ver:
https://medium.com/laboratoria-developers/introducci%C3%B3n-a-la-programaci%C3%B3n-funcional-en-javascript-parte-2-funciones-puras-b99e08c2895d





Las funciones puras son funciones que:

con una entrada dada, siempre devuelve la misma salida
No confían en ninguna variable fuera de su alcance.
no modifican el estado de la aplicación ( sin efectos secundarios )

https://riptutorial.com/es/javascript/example/27399/funciones-puras

=================================================================
que es un clusure en javascript ?

un closure es una funcion que es libre de variables 
ver:
https://medium.com/@sergiodxa/definiendo-conceptos-closure-y-scope-en-javascript-9081f1e113e6

https://dmitripavlutin.com/simple-explanation-of-javascript-closures/
=================================================================

nombre los tipos de hooks que ha utilizado ?
https://www.seowebconsultora.es/tipos-de-hooks/
=================================================================


¿Qué es una promesa en Javascript?
Una promesa es un objeto que representa la terminación o error de un evento
asincrónico. Un evento asincrónico es “algo” que sucede en otro momento distinto al
que estamos ejecutando nuestro código. Si bien las promesas se pueden crear con un
constructor, es más común usarlas.
La forma de usarlas es la siguiente:
miPromesa.then(function() {
 //codigo a ejecutar despues de que la promesa finalice
})
Este código lo que hace ejecutar el código que está en el método “then”, una vez que la
promesa “miPromesa” haya finalizado correctamente.

=================================================================
¿Qué es un callback?
Un callback es una función (callback) que la pasás a otra función (miFuncion) como
parámetro. El callback se ejecuta cuando la “miFuncion” finalice.
Un ejemplo sería:
var callback = function() {
 console.log(‘termine!!!’)
}
var miFuncion = function(callback) {
Gustavo Hernán Dohara http://www.gustavodohara.com
 // codigo de la funcion
 // la funcion finalizo
 callback();
}
===============

Las funciones que llaman a otras funciones o que devuelven funciones, se conocen como funciones de orden superior, muchas veces también recibe el nombre de función de devolución de llamada (callbacks).
Donde podemos tener dos tipos: Síncrono y Asíncrono
a — síncrono
Síncrono: Es cuando se ejecuta una operación de entrada/salida de manera secuencial, por lo que debemos de esperar a que se complete para poder procesar el resultado.

b — asíncrono
Asíncrono: Ejecutar una operación, donde la finalización es notificada de manera diferida.

=================================================================
describa el ciclo de vida de uncomponente?
https://es.wikipedia.org/wiki/React

El Estado
El estado de un componente se define como una representación del mismo en un momento concreto, es decir, una instantánea del propio componente. Existen dos tipos de componentes con y sin estado, denominados statefull y stateless.

Ciclos de vida
El ciclo de vida es una serie de estados por los cuales pasan los componentes statefull a lo largo de su existencia. Se pueden clasificar en tres etapas de montaje o inicialización, actualización y destrucción. Dichas etapas tienen correspondencia en diversos métodos.

shouldComponentUpdate permite al desarrollador prevenir el re-renderizado innecesario de un componente, devolviendo falso si no es necesario.
componentDidMount es llamado una vez que el componente es "montado" (el componente ha sido creado en la interfaz de usuario, usualmente asociándolo con el nodo del DOM). Esto es comúnmente usado para provocar la carga de datos desde una fuente remota a través de una API.
componentWillUnmount es llamado inmediatamente antes de que el componente es "desmontado". Es comúnmente usado para limpiar la demanda de dependencias del componente que no será simplemente removido con el desmontaje del componente.
render es el método más importante de los ciclos de vida y el único requerido en cualquier componente. Es usualmente llamado cada vez que el estado del componente es actualizado, reflejando los cambios en la interfaz de usuario.

=================================================================
=================================================================
=================================================================
=================================================================


Aquí es donde entran los Higher-Order Components.

Un Higher-Order Components es, como dice la documentación oficial:

[…] a function that takes a component and returns a new component.

Es decir, una función que toma un componente como parámetro y retorna un nuevo componente.
https://hpneo.dev/2019/03/19/usando-hocs.html

====================================================

cuales son los tipos primitivos en javascript?
¿Cómo debo estructurar mi proyecto?

cual arquitectura utiliza en las carpetas de react 
cual es la mejor arquitectura de archivos para crear una aplicación web react????


actualizaciones de javascript con emacscript ?
los tipos de hook  ? 

que es una funcion inpura en javascript ?
=================================================================
que es una funcion pura en javascript ?
https://www.etnassoft.com/2016/06/21/las-funciones-puras-en-javascript-concepto-ejemplos-y-beneficios/


Como la mayoría de los principios de la programación funcional, el concepto de función pura es simple, y precisamente esa simplicidad hace que al principio sea difícil apreciar su belleza y los beneficios que ofrece. Más adelante vamos a ver como las funciones puras hacen que nuestro código sea más fácil de predecir, aislar, reusar y testear, más fácil de razonar con menos contexto... pero nos toca empezar por el principio… bueno, al grano.
Decimos que una función es pura cuando cumple los siguientes requisitos:
1.Dados los mismos inputs (argumentos) siempre retorna lo mismo (transparencia referencial).
2.No tiene efectos colaterales.

ver:
https://medium.com/laboratoria-developers/introducci%C3%B3n-a-la-programaci%C3%B3n-funcional-en-javascript-parte-2-funciones-puras-b99e08c2895d





Las funciones puras son funciones que:

con una entrada dada, siempre devuelve la misma salida
No confían en ninguna variable fuera de su alcance.
no modifican el estado de la aplicación ( sin efectos secundarios )

https://riptutorial.com/es/javascript/example/27399/funciones-puras

=================================================================
que es un clusure en javascript ?

un closure es una funcion que es libre de variables 
ver:
https://medium.com/@sergiodxa/definiendo-conceptos-closure-y-scope-en-javascript-9081f1e113e6

https://dmitripavlutin.com/simple-explanation-of-javascript-closures/
=================================================================

nombre los tipos de hooks que ha utilizado ?
https://www.seowebconsultora.es/tipos-de-hooks/
=================================================================


¿Qué es una promesa en Javascript?
Una promesa es un objeto que representa la terminación o error de un evento
asincrónico. Un evento asincrónico es “algo” que sucede en otro momento distinto al
que estamos ejecutando nuestro código. Si bien las promesas se pueden crear con un
constructor, es más común usarlas.
La forma de usarlas es la siguiente:
miPromesa.then(function() {
 //codigo a ejecutar despues de que la promesa finalice
})
Este código lo que hace ejecutar el código que está en el método “then”, una vez que la
promesa “miPromesa” haya finalizado correctamente.

=================================================================
¿Qué es un callback?
Un callback es una función (callback) que la pasás a otra función (miFuncion) como
parámetro. El callback se ejecuta cuando la “miFuncion” finalice.
Un ejemplo sería:
var callback = function() {
 console.log(‘termine!!!’)
}
var miFuncion = function(callback) {
Gustavo Hernán Dohara http://www.gustavodohara.com
 // codigo de la funcion
 // la funcion finalizo
 callback();
}
===============

Las funciones que llaman a otras funciones o que devuelven funciones, se conocen como funciones de orden superior, muchas veces también recibe el nombre de función de devolución de llamada (callbacks).
Donde podemos tener dos tipos: Síncrono y Asíncrono
a — síncrono
Síncrono: Es cuando se ejecuta una operación de entrada/salida de manera secuencial, por lo que debemos de esperar a que se complete para poder procesar el resultado.

b — asíncrono
Asíncrono: Ejecutar una operación, donde la finalización es notificada de manera diferida.

=================================================================
describa el ciclo de vida de uncomponente?
https://es.wikipedia.org/wiki/React

El Estado
El estado de un componente se define como una representación del mismo en un momento concreto, es decir, una instantánea del propio componente. Existen dos tipos de componentes con y sin estado, denominados statefull y stateless.

Ciclos de vida
El ciclo de vida es una serie de estados por los cuales pasan los componentes statefull a lo largo de su existencia. Se pueden clasificar en tres etapas de montaje o inicialización, actualización y destrucción. Dichas etapas tienen correspondencia en diversos métodos.

shouldComponentUpdate permite al desarrollador prevenir el re-renderizado innecesario de un componente, devolviendo falso si no es necesario.
componentDidMount es llamado una vez que el componente es "montado" (el componente ha sido creado en la interfaz de usuario, usualmente asociándolo con el nodo del DOM). Esto es comúnmente usado para provocar la carga de datos desde una fuente remota a través de una API.
componentWillUnmount es llamado inmediatamente antes de que el componente es "desmontado". Es comúnmente usado para limpiar la demanda de dependencias del componente que no será simplemente removido con el desmontaje del componente.
render es el método más importante de los ciclos de vida y el único requerido en cualquier componente. Es usualmente llamado cada vez que el estado del componente es actualizado, reflejando los cambios en la interfaz de usuario.

=================================================================
=================================================================
=================================================================
=================================================================

