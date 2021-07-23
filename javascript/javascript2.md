¿Qué es el DOM virtual?
El DOM virtual (VDOM) es un concepto de programación donde una representación ideal o “virtual” de la IU se mantiene en memoria y en sincronía con el DOM “real”, mediante una biblioteca como ReactDOM. Este proceso se conoce como reconciliación.
Este enfoque hace posible la API declarativa de React: le dices a React en qué estado quieres que esté la IU, y se hará cargo de llevar el DOM a ese estado. Esto abstrae la manipulación de atributos, manejo de eventos y actualización manual del DOM que de otra manera tendrías que usar para construir tu aplicación.
Ya que “DOM virtual” es más un patrón que una tecnología específica, las personas a veces le dan significados diferentes. En el mundo de React, el término “DOM virtual” es normalmente asociado con elementos de React ya que son objetos representando la interfaz de usuario. Sin embargo, React también usa objetos internos llamados “fibers” para mantener información adicional acerca del árbol de componentes. Éstos pueden ser también considerados como parte de la implementación de “DOM virtual” de React.

¿Por qué JSX?
React acepta el hecho de que la lógica de renderizado está intrínsecamente unida a la lógica de la interfaz de usuario: cómo se manejan los eventos, cómo cambia el estado con el tiempo y cómo se preparan los datos para su visualización.
En lugar de separar artificialmente tecnologías poniendo el maquetado y la lógica en archivos separados, React separa intereses con unidades ligeramente acopladas llamadas “componentes” que contienen ambas. Volveremos a los componentes en otra sección, pero si aún no te sientes cómodo maquetando en JS, esta charla podría convencerte de lo contrario.
React no requiere usar JSX, pero la mayoría de la gente lo encuentra útil como ayuda visual cuando trabajan con interfaz de usuario dentro del código Javascript. Esto también permite que React muestre mensajes de error o advertencia más útiles.
Con eso fuera del camino, ¡empecemos!




JSX
JSX es una extensión a la sintaxis de Javascript que permite insertar código HTML. Usando JSX podemos crear elementos React fácilmente:




Componentes en React
Como decíamos anteriormente, un componente en React es un elemento independiente y reeutilizable. Además existen dos tipos de componentes en React:

Componentes funcionales: Solo tienen propiedades.
Componentes de clase: Tienen propiedades, ciclos de vida y propiedades.



¿El método setState() es asíncrono?
Sí. Si bien esta naturaleza puede no manifestarse claramente en muchos escenarios, el método setState() es asíncrono ya que las acciones realizadas a través del mismo pueden ser agrupadas y atendidas en lotes.

React puede retrasar la actualización tras un setState() o agrupar los cambios necesarios en lotes, por ejemplo, para renderizar varios componentes dependientes de forma simultánea. Este proceso transitorio busca un mejor rendimiento y no garantiza un comportamiento síncrono ni un renderizado inmediato del componente.

Esto puede derivar en que el acceso al estado inmediatamente después de invocar setState() no muestre aún los cambios transferidos, pero varias de las configuraciones para setState() evitarían esta situación.






¿Qué es una promesa en Javascript?
Una promesa es un objeto que representa la terminación o error de un evento asincrónico. Un evento asincrónico es “algo” que sucede en otro momento distinto al
que estamos ejecutando nuestro código. Si bien las promesas se pueden crear con un
constructor, es más común usarlas.
La forma de usarlas es la siguiente:
miPromesa.then(function() {
 //codigo a ejecutar despues de que la promesa finalice
})
Este código lo que hace ejecutar el código que está en el método “then”, una vez que la
promesa “miPromesa” haya finalizado correctamente.


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
