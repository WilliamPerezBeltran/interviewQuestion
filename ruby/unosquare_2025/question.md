# preguntas de la entrevista con la empresa unosquare 

1.  Que es y para que sirve a||=b
 Es la expresion abreviada de escribir 
 a = a || b 
 - Si a ya tiene un valor distinto de nil o false, se conserva tal cual 
 - si a es nil o false. entonces se asigna el valor de b 
 ¿ Para qué sirve ?
 Se usa mucho para dar valores por defecto a avariables que pueden no estar inicializadas 

ejemplo: 
 ```
 x = nil 
 x ||= 10 # x era nil, ahora seŕa  10
 puts x   # -> 10

 x ||= 20 # x ya tiene 10,  se queda igual 
 puts x   # -> 10 
 ```
 En Resumen: ||= sirve para inicializar una variable solo si aún no tiene valor 

2.  Qué es Struct y para que sirve ? 
En ruby un "Struct" es un clase especial que permite crear objectos ligeros con un conjunto fijo de 
atributos son necesidad de definir manualmente una clase completa. Sirve como una forma rápida y 
práctica de agrupar datos relacionados bajo un mismo objeto .
	
2.1  Historia del concepto / ¿ Por qué lo inventaron ?
Struct fue introducido en ruby o para ofrecer una alternativa mas sencilla y menos "verborsa " que
definir clases completas. La idea viene de los lenguajes como C, donde un "struct"	agrupa variables 
relacionadas en una sola entidad. En ruby , se creó para agilizar la creación de objectos tipo "data container" 
sin sobrecargar el código con lógica extra.

ejemplo:
```
# crear Struct 
Person = Struct.new(:name,:age)

#instanciar un objecto de ese Struct
p1 = Person.new("jose",23)

p p1.name 
p p1.age 
```
2.1  Historia del concepto / ¿ Por qué lo inventaron ?
2.1  Historia del concepto / ¿ Por qué lo inventaron ?
2.1  Historia del concepto / ¿ Por qué lo inventaron ?
2.1  Historia del concepto / ¿ Por qué lo inventaron ?
2.1  Historia del concepto / ¿ Por qué lo inventaron ?
2.1  Historia del concepto / ¿ Por qué lo inventaron ?

3.  Que es y para que sirve a||=b
4.  Que es y para que sirve a||=b
5.  Que es y para que sirve a||=b
6.  Que es y para que sirve a||=b
7.  Que es y para que sirve a||=b
8.  Que es y para que sirve a||=b
9.  Que es y para que sirve a||=b
10.  Que es y para que sirve a||=b
11.  Que es y para que sirve a||=b
12.  Que es y para que sirve a||=b
13.  Que es y para que sirve a||=b
14.  Que es y para que sirve a||=b
15.  Que es y para que sirve a||=b


