React is a JavaScript library for building user interfaces.

-Declarative: 
	React makes it painless to create interactive UIs. Design simple views for each state in your application, and React will efficiently update and render just the right components when your data 	changes. Declarative views make your code more predictable, simpler to understand, and easier to debug.

-Component-Based: 
	Build encapsulated components that manage their own state, then compose them to make complex UIs. Since component logic is written in JavaScript instead of templates, you can easily pass rich data 		through your app and keep state out of the DOM.

-Learn Once, Write Anywhere: 
	We don't make assumptions about the rest of your technology stack, so you can develop new features in React without rewriting existing code. React can also render on the server using Node and 	power mobile apps using React Native.

==============================================================================
¿qUÉ ES EL Virtual DOM?

https://latteandcode.medium.com/y-eso-del-virtual-dom-de-react-qu%C3%A9-es-3feed6366925

Real DOM
Pero antes de nada, si hay un Virtual DOM tendrá que haber algo real, ¿no? En efecto, el DOM (cuyas siglas son “Document Object Model) es la representación de la interfaz gráfica de nuestra aplicación. Por tanto, cada vez que el estado de la aplicación cambia, lo “esperable” es que también lo haga dicha interfaz para adaptarse a las modificaciones introducidas. Sin embargo, actualizar el DOM es una tarea costosa en cuanto a rendimiento se refiere, por lo que cuantos más cambios de estado sea necesario reflejar en él, más lento irá nuestra web.
¿Y por qué es tan lento realizar esos cambios?
EL DOM posee una estructura en forma de árbol:

Esto provoca que cada vez que modificamos un elemento dentro de él, todos sus hijos tengan que ser pintados de nuevo (hayan o no cambiado). Y justo este proceso es el que provoca los problemas de rendimiento, ya que de por sí renderear elementos en una interfaz gráfica es una tarea costosa. Por tanto, cuantos más elementos queden por debajo de nuestro elemento modificado en la estructura del DOM más elementos tendrán que ser vueltos a pintar en la interfaz gráfica. Y es aquí donde entra el concepto del Virtual DOM con el objetivo de conseguir optimizar esta tarea.



Virtual DOM
El Virtual DOM es una representación en memoria del DOM real que actúa de intermediario entre el estado de la aplicación y el DOM de la interfaz gráfica que está viendo el usuario.
Puesto que cada elemento es un nodo en el árbol del DOM, cada vez que se produce un cambio en cualquiera de estos elementos (o un nuevo elemento es añadido) se genera un nuevo Virtual DOM con el árbol resultante. Dado que este DOM es virtual, la interfaz gráfica aún no es actualizada, sino que se compara el DOM real con este DOM virtual con el objetivo de calcular la forma más óptima de realizar las cambios (es decir, de renderear los menos cambios posibles). De este modo se consigue reducir el coste en términos de rendimiento de actualizar el DOM real.
==============================================================================

 ¿Qué es una promesa?
Una promesa es un objeto que representa un evento único, normalmente como resultado de una tarea asíncrona como una llamada AJAX. Almacenan un valor futuro, ya sea el resultado de una petición HTTP o la lectura de un fichero desde disco.

En la vida real, cuando vamos a un restaurante de comida rápida y pedimos un menú con hamburguesa con bacón y patatas fritas, estamos obteniendo una promesa con el número del pedido, porque primero lo pagamos y esperamos recibir nuestra comida, pero es un proceso asíncrono el cual inicia una transacción. Mientras esperamos a que nos llamen con nuestra sabrosa hamburguesa, podemos realizar otras acciones, como decirle a nuestra pareja que busque una mesa o preparar un tuit con lo rica que está nuestra hamburguesa. Estas acciones se traducen en callbacks, los cuales se ejecutarán una vez se finalice la operación. Una vez nuestro pedido está preparado, nos llaman con el número del mismo y nuestra deseada comida. O inesperadamente, se ha acabado el bacón y nuestra promesa se cumple pero erroneamente. Así pues, un valor futuro puede finalizar correctamente o fallar, pero en ambos casos, finalizar.
