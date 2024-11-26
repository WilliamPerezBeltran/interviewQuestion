# Rails Interview Preparation Guide

## Preguntas y Respuestas

### ¿Has trabajado con migraciones? Explícalas.
Las migraciones en Rails son herramientas que permiten gestionar los cambios en la estructura de la base de datos de forma controlada y versionada. Cada migración representa una instrucción o conjunto de instrucciones que definen cómo se debe crear, modificar o eliminar tablas, columnas, índices u otros elementos en la base de datos.

#### Pasos típicos:
1. **Generar una migración**: Se usa el comando `rails generate migration <nombre>` para crear un archivo de migración.
2. **Editar el archivo de migración**: El archivo contiene métodos `change`, `up`, o `down`, donde se definen las operaciones necesarias.
3. **Ejecutar la migración**: Se aplica con `rails db:migrate`.
4. **Versionamiento**: Rails registra las migraciones ejecutadas en la tabla `schema_migrations`, asegurando que no se ejecuten dos veces.

### ¿Cómo gestionas la complejidad en los niveles de vista, controlador y modelo en tus proyectos Rails? Compara y contrasta los enfoques que has tomado.
1. **Modelos**:
   - Evitar lógica compleja dentro del modelo para mantenerlo limpio.
   - Usar **concerns** o **servicios** para lógica de negocio reutilizable.

2. **Controladores**:
   - Mantenerlos delgados delegando lógica al modelo o servicios.
   - Usar filtros como `before_action` para evitar redundancia.

3. **Vistas**:
   - Mantener vistas simples utilizando helpers y componentes parciales.
   - Utilizar gemas como **ViewComponent** para encapsular lógica de UI.

#### Comparación:
- **Controlador delgado vs. modelo gordo**: Un enfoque con controladores delgados delega trabajo al modelo, pero puede sobrecargar los modelos. Para balancear, se usan servicios o presentadores.
- **Servicios**: Ayudan a centralizar operaciones complejas que pueden afectar múltiples capas.

### ¿Cuál es el mayor error que has cometido al diseñar una aplicación Rails?
Un error común es no planificar adecuadamente la estructura inicial del proyecto. Por ejemplo:
- **Problema**: No anticipar la necesidad de funcionalidad asíncrona y tratar de incorporarla en una etapa avanzada.
- **Lección**: Priorizar el diseño de sistemas escalables y modulares desde el principio para facilitar futuras adaptaciones.

### ¿Cómo determinas cuándo debes hacer que una parte particular de la funcionalidad sea asíncrona? ¿Cómo lo harías?
1. **Criterios para asíncronía**:
   - Cuando una operación es intensiva en tiempo o recursos (ej., envíos de correos, procesamiento de imágenes).
   - Si impacta negativamente en la experiencia del usuario si se realiza de forma síncrona.

2. **Implementación**:
   - Usar una cola de tareas como **Sidekiq**.
   - Configurar un worker para manejar la operación.
   - Enviar la tarea al worker con `MyWorker.perform_async`.

---

## Explicaciones Detalladas

### Proceso de una petición en Rails
1. **Enrutamiento**:
   - La petición llega al router (`config/routes.rb`), que decide el controlador y acción adecuados.
2. **Controlador**:
   - El controlador procesa la solicitud, interactúa con los modelos y decide qué vista renderizar o datos devolver.
3. **Modelo**:
   - Si se requiere acceder o modificar datos, el controlador interactúa con los modelos.
4. **Vista**:
   - Rails genera HTML o JSON a partir de las vistas o respuestas configuradas en el controlador.
5. **Respuesta**:
   - Rails devuelve el resultado al navegador o cliente.

---

### Describe el Asset Pipeline
El Asset Pipeline en Rails administra, compila y sirve los recursos estáticos como CSS, JavaScript e imágenes.

#### Componentes clave:
1. **Preprocesamiento**:
   - Usa herramientas como Sass o CoffeeScript para convertir archivos en formatos más eficientes.
2. **Manifest File**:
   - Archivos como `application.js` y `application.css` definen qué recursos incluir.
3. **Compilación**:
   - Combina y minimiza recursos para reducir el tamaño y mejorar el rendimiento.

#### Ventajas:
- Menor latencia al reducir solicitudes HTTP.
- Fáciles configuraciones para ambientes de desarrollo y producción.

---

### Explica el uso de `yield` y `content_for`
1. **`yield`**:
   - Se usa en layouts para insertar contenido dinámico definido en vistas específicas.
   - Ejemplo:
     ```ruby
     <body>
       <%= yield :header %>
       <%= yield %> <!-- Inserta el contenido principal -->
     </body>
     ```

2. **`content_for`**:
   - Define bloques de contenido que pueden ser utilizados en layouts.
   - Ejemplo:
     ```ruby
     <% content_for :header do %>
       <h1>Bienvenido</h1>
     <% end %>
     ```

---

## ¿Qué deberían saber los desarrolladores de Ruby y Rails?

### Nivel de Entrada
- Conocimiento básico de Ruby y MVC.
- Comandos básicos de Rails (`rails server`, `rails generate`).
- Uso de herramientas como **Git** y bases de datos.

### Nivel Medio
- Patrones de diseño como servicios y presentadores.
- Dominio de Active Record, asociaciones y migraciones.
- Habilidad para optimizar consultas SQL.
- Conocimiento de pruebas con **RSpec** o **Minitest**.

### Nivel Senior
- Diseño y arquitectura de aplicaciones escalables.
- Experiencia en APIs RESTful y GraphQL.
- Optimización de rendimiento y resolución de cuellos de botella.
- Profundidad en conceptos como concurrencia y asíncronía.
- Dominio en el uso de herramientas como Docker y Kubernetes.

---

## Problemas Comunes en Entrevistas
1. **Debugging**:
   - Preguntas sobre cómo identificar y corregir errores en Rails.
2. **Optimización**:
   - Soluciones para mejorar el rendimiento de una consulta o página.
3. **Diseño**:
   - Diseñar un sistema desde cero, como una API RESTful.
4. **Lógica**:
   - Resolver problemas usando Ruby puro.

# Perfil del Candidato: Rails Developer

## **Habilidades y Competencias por Nivel**

---

### **Nivel de Entrada**
1. **Crear y configurar un entorno Rails**:
   - Configuración básica de Rails.
   - Instalación de gemas y herramientas necesarias.

2. **Utilizar generadores**:
   - Crear modelos, controladores y migraciones utilizando generadores Rails.

3. **Gestión de base de datos**:
   - Crear y utilizar migraciones para gestionar esquemas de base de datos.

4. **Pruebas unitarias**:
   - Crear pruebas unitarias utilizando herramientas como RSpec u otros frameworks.

5. **Modelo y validaciones básicas**:
   - Configurar modelos con validaciones estándar.

6. **Manejo de solicitudes HTTP**:
   - Manejar una solicitud GET utilizando un controlador, modelo y vista.
   - Manejar una solicitud POST utilizando un controlador, modelo y vista.

7. **Desarrollo front-end básico**:
   - Conocimientos básicos de HTML, CSS y JavaScript.

8. **GIT básico**:
   - Realizar operaciones fundamentales como clonar, confirmar y empujar repositorios.

---

### **Nivel Medio**
1. **Configuración e implementación en producción**:
   - Configurar y desplegar aplicaciones Rails en entornos de producción.

2. **Comprensión de la pila Rails**:
   - Devoluciones de llamada.
   - Filtros, complementos y motores.
   - Gestión de gemas y Rack.

3. **Active Record**:
   - Comprender y usar asociaciones en Active Record.
   - Definir y utilizar ámbitos para crear abstracciones del modelo.

4. **Pruebas avanzadas**:
   - Definir pruebas con herramientas como Cucumber y RSpec.

5. **Orientación a objetos**:
   - Uso y comprensión de principios de la programación orientada a objetos.

6. **Patrones de diseño**:
   - Explicar qué son los patrones de diseño.
   - Conocer y aplicar patrones básicos en proyectos Rails.

---

### **Nivel Senior**
1. **Análisis y perfilado de aplicaciones**:
   - Identificar y resolver problemas de rendimiento y memoria.
   - Analizar y perfilar aplicaciones en busca de vulnerabilidades de seguridad.

2. **Modelado y optimización de bases de datos**:
   - Comprender el modelado de bases de datos.
   - Analizar y optimizar consultas SQL.

3. **Ajuste de implementaciones en producción**:
   - Configuración avanzada de servidores como Passenger, Thin, Apache, etc.

4. **Metaprogramación en Ruby**:
   - Comprender y usar metaprogramación para soluciones más dinámicas.

5. **Habilidades interpersonales**:
   - Mentoría a otros desarrolladores.
   - Comunicación efectiva en equipos.

6. **Planificación y estimación**:
   - Planificar y estimar tareas y proyectos con precisión.

---

Este perfil cubre habilidades esenciales para un desarrollador Rails en diferentes niveles, desde la configuración básica hasta la optimización avanzada en producción y mentoría. 🚀

# Contratación de un Desarrollador Ruby on Rails

Cuando queremos contratar a un desarrollador de Ruby On Rails para nuestro equipo, debemos entender ciertos conceptos clave sobre la posición que ocupará esta persona y las responsabilidades que tendrá.

---

## **Responsabilidades del Desarrollador**

### **Creación de APIs**
Si el desarrollador que se va a contratar será el encargado de escribir las APIs, esta persona debe tener un conocimiento claro de la arquitectura que se utilizará. Por ejemplo, si se opta por **RESTful** (la más usada), el candidato debe tener experiencia en:

1. **Verbos HTTP**:
   - Comprensión y uso adecuado de métodos como `GET`, `POST`, `PUT`, `DELETE`, etc.

2. **Status Codes**:
   - Manejo correcto de códigos de estado HTTP como `200 OK`, `201 Created`, `404 Not Found`, `500 Internal Server Error`, entre otros.

3. **Headers HTTP**:
   - Configuración y uso de encabezados importantes para peticiones y respuestas HTTP.

4. **Arquitectura Cliente-Servidor**:
   - Dominio sobre la separación de responsabilidades entre cliente y servidor.

---

## **Buenas Prácticas del Desarrollador**

Algo que no debería estar infravalorado son las **buenas prácticas** que el desarrollador implementa al momento de escribir código en el back-end. Algunas de las más destacadas incluyen:

1. **API Versioning**:
   - Estructuración adecuada de los endpoints para garantizar escalabilidad y mantener compatibilidad con versiones anteriores.

2. **Seguridad**:
   - Implementación de técnicas como:
     - **Validación de datos de entrada**: Verificar y sanitizar los datos recibidos para prevenir ataques.
     - **CORS (Cross-Origin Resource Sharing)**: Controlar y limitar el acceso desde dominios externos.

3. **Autenticación**:
   - Uso de métodos robustos para garantizar la seguridad, tales como:
     - **OAuth**.
     - **JSON Web Tokens (JWT)**.

---

Estas responsabilidades y buenas prácticas son fundamentales para contratar a un desarrollador que pueda contribuir eficazmente al desarrollo de aplicaciones robustas, seguras y escalables en Rails.

# Preguntas de Entrevista para Desarrollador Ruby on Rails

Las preguntas para entrevistar a un candidato a la posición de desarrollador Ruby On Rails pueden clasificarse en tres categorías principales: **conocimientos propios del lenguaje Ruby**, **conocimientos del framework Rails** y **seguridad**. 

---

## **Lenguaje Ruby**

1. **¿Cuál es la diferencia entre una clase y un módulo?**

2. **¿Cuáles son los tres niveles de control de acceso a métodos para clases y qué significan?**

3. **¿Qué significa "self"?**

4. **Explique qué son los métodos singleton. ¿Qué es Eigenclass en Ruby?**

5. **¿Cuál es la diferencia entre `false` y `nil` en Ruby?**

---

## **Framework Rails**

1. **¿Qué es el Asset Pipeline?**

2. **Explica el patrón "Active Record".**

3. **¿Qué es una Polymorphic Association en Rails?**

4. **Explica la diferencia entre optimistic y pessimistic locking en Rails.**

---

## **Seguridad**

1. **¿En qué consiste el CSRF? ¿Cómo Rails protege a una aplicación en contra de esta falla de seguridad?**

2. **¿Cómo debemos almacenar datos inseguros tales como contraseñas?**

3. **¿Por qué necesitamos usar HTTPS en lugar de HTTP?**

---

Estas preguntas están diseñadas para evaluar tanto el conocimiento técnico como las prácticas de seguridad y arquitectura en el desarrollo con Ruby on Rails.


# Proyectos en Casa como Complemento a la Entrevista

Los proyectos en casa son la mejor manera de ver cómo el programador puede implementar soluciones en Ruby On Rails. Lo ideal es darle una tarea y describir los requerimientos que debe cumplir la aplicación.

---

## Ejemplo de Aplicación

Se requiere una aplicación que nos permita gestionar la productividad de los empleados de una empresa gestionando el flujo de tareas en tres tableros que representarán los estados: **Ideas**, **En progreso**, **Terminadas**.

**Objetivo:** Construir un API que permita a los desarrolladores front-end cumplir con las especificaciones visuales.

---

## Requerimientos Funcionales

Luego de describir el objetivo, es primordial definir cuáles son las funciones que debe tener la API, esto nos dará una perspectiva de la experiencia que tiene y nos permitirá delimitar la cantidad de tiempo que puede tardar una persona en entregar una aplicación pequeña.

Lo ideal es que la mayoría de los proyectos en casa tengan una duración máxima de una semana, ya que muchos candidatos usualmente están presentando otras entrevistas y puede llegar a ser agotador para ellos entregar varios proyectos a la vez.

### Funciones de la API

1. **Iniciar sesión y registrarse con mi correo electrónico.**
2. **Agregar proyectos.**
3. **Agregar, actualizar y eliminar tareas de los proyectos.**
4. **Cambiar de estado las tareas con base en los tres estados definidos anteriormente: ideas, en progreso, terminadas.**

---

## Requerimientos Técnicos

- Se debe entregar una **API** desarrollada en **Ruby On Rails** en un entorno de producción de **AWS**.
- **Autenticación mediante JWT**.
- El desarrollador debe entregar un **repositorio**, ya sea en **Github** o **Bitbucket**.
  
Un ingeniero del equipo o entrevistador técnico debería ser capaz de evaluar cosas como:

- La **calidad del código** en cuanto a la **definición de nombres de variables**, **estructura del proyecto**, **uso de patrones de diseño** y **prácticas de seguridad** implementadas en la API.

# Important Skills for a Senior Ruby on Rails (RoR) Developer

## 1. Application Architecture Design
- **Why it's important:**  
  Senior developers are responsible for designing the overall structure of an application. This ensures that the application is robust, maintainable, and extensible. Good architecture allows for scalability and ease of future development.

- **Key considerations:**  
  - Applying SOLID principles.
  - Ensuring modularity and separation of concerns.
  - Deciding between monolithic vs. microservices architectures.
  - Using design patterns effectively to address common development challenges.

---

## 2. How to Make the Application Scalable
- **Why it's important:**  
  As a business grows, applications must handle increased load without degrading performance. A senior developer must design systems with scalability in mind to meet future demands.

- **Key considerations:**  
  - Implementing database indexing and query optimization.
  - Using caching mechanisms (e.g., Redis, Memcached) to reduce load on the database.
  - Employing queuing systems like Sidekiq or Resque for background job processing.
  - Planning for horizontal and vertical scaling.
  - Utilizing load balancers to distribute traffic effectively.

---

## 3. Broad Knowledge of Gems, When to Use Them, Pros, and Cons
- **Why it's important:**  
  The Rails ecosystem offers a vast selection of gems that can accelerate development and improve functionality. A senior developer must have a broad knowledge of gems to choose the right tools for the right scenarios while understanding their limitations.

- **Key considerations:**  
  - Familiarity with widely used gems like:
    - **Devise** for authentication.
    - **Pundit** or **CanCanCan** for authorization.
    - **ActiveAdmin** for admin panels.
    - **RSpec** for testing.
  - Knowing the pros and cons of using gems:
    - Time-saving and reliable but can lead to dependency bloat.
    - Sometimes custom solutions are more efficient for specific needs.
  - Evaluating the long-term maintenance of gems and their support within the community.

By mastering these skills, a senior RoR developer can lead development teams effectively, design scalable systems, and make informed decisions about tools and technologies to use in their projects.

# Ruby on Rails Interview Evaluation Guidelines

## 1. Code Review
- **Objective:** Evaluate the applicant's understanding of architecture and testing practices.
- **Process:**  
  - Review one of the candidate's Ruby on Rails (RoR) projects.
  - Ensure they understand the architecture by checking how they break the code into the different layers of the stack (e.g., models, controllers, services).
  - Verify the project includes proper testing, preferably using RSpec.

---

## 2. Questions Based on Role Level
### **For Seniors or Juniors:**
- **Quick Test of Basic Ruby Understanding:**  
  - **Question:**  
    ```ruby
    a = 1
    b = 2
    a ||= b
    ```
  - **Goal:**  
    - Determine if the candidate understands how conditional assignment works in Ruby.
    - If they struggle to answer, it may indicate a lack of familiarity with the language basics.

---

## 3. Basic Knowledge
- **Questions:**
  1. What is a class?  
  2. What are open classes?  
  3. What is `super`?  
  4. What does `include` do?  
  5. What is an object?  

---

## 4. Intermediate Knowledge
- **Questions:**
  1. What is a module? What are they for? How do they differ from a class?  
  2. What is a mixin? How is it different from a module?  
  3. What is the difference between a block and a proc?  
  4. What is the difference between a proc and a lambda?  
  5. There are three ways to call a method; can you describe at least two?  

---



# Respuesta al Código y Conceptos

## **Resultado del Código**
### Código:
```ruby
x = 1 

class MyClass 
  y = 2 
  def foo 
     z = 4 
     y ||= 0 
     puts z + y 
  end 
  define_method :bar do |x| 
     z = 5 
     y ||= 0 
     puts z + y + x 
  end 
end 
my_class = MyClass.new 
my_class.foo 
my_class.bar(10) 
my_class.bar 

```

# Rails Questions to Assess Experience

## **Question 1: Rails Version Experience**
- **Ask:** *"Since which version of Rails have you been working?"*
  - **Purpose:**  
    To gauge the length of experience the candidate has with Rails. Someone who started with Rails 1.3.2 has likely been working with the framework longer than someone who began with Rails 5.2.

## **Follow-Up Question: Features in Recent Versions**
- **Ask:** *"What are the main new features of the latest Rails version you've worked with?"*
  - **Purpose:**  
    To ensure the candidate keeps up with recent changes and developments in the Rails ecosystem. It can also reveal their understanding of key updates and their ability to adapt to new features.
  - **Example Expected Answers:**
    - **Rails 6.0:**
      - Introduction of **Action Mailbox** and **Action Text**.
      - Parallel testing support.
      - Multi-database support.
    - **Rails 7.0:**
      - Full support for **Hotwire** (replacing Turbolinks).
      - Asynchronous query loading with Active Record.
      - Removal of dependency on Webpacker for assets.

## **Why These Questions Matter**
- Candidates with a deeper historical context in Rails may have a better grasp of its evolution, strengths, and limitations.
- Understanding new features showcases their ability to leverage modern tools and techniques.

# Preguntas de Entrevista para Ruby on Rails

## =================
1. **Rails Asset Pipeline**:  
   - Explica qué es el *asset pipeline* y cómo ha evolucionado en las diferentes versiones de Rails.
2. **Principios REST**:  
   - El candidato debe ser capaz de explicar los principios de REST y entender cómo funciona el router para mapear solicitudes entrantes.
3. **Middleware de Rack**:  
   - Dado que Rails es una aplicación basada en Rack, el candidato debería poder explicar algunos conceptos clave sobre el middleware de Rack.
=================

## Preguntas y Respuestas para una Entrevista de Ruby on Rails

### **P: Explica cómo (casi) todo es un objeto en Ruby**
- **Descripción**:  
  Esta es una pregunta sencilla basada en un concepto complejo. Aquí es donde puedes mostrar tu conocimiento teórico y demostrar que puedes hablar en profundidad sobre jerarquías de clases, herencia, métodos, encapsulación, polimorfismo, y más.

---

### **P: ¿Cuál es tu herramienta de testing favorita?**
- **Respuesta esperada**:  
  La respuesta específica probablemente no es lo más importante aquí. Lo importante es que puedas demostrar familiaridad con varias herramientas de testing y discutir sus ventajas y desventajas individuales.  
  - ¿Solo has usado las herramientas de testing predeterminadas de Rails?  
    Familiarízate con herramientas como:
    - Rspec
    - FactoryGirl (ahora FactoryBot)
    - Capybara
    - Cucumber

---

### **P: ¿Qué son las Gems y cuáles son tus favoritas?**
- **Respuesta corta**:  
  Las gems son paquetes de código Ruby que puedes instalar para extender o añadir funcionalidades a tu aplicación.
- **Detalles esperados**:
  - Menciona algunas de tus gems favoritas.
  - Explica por qué te gustan.
  - Discute cualquier personalización que suelas añadir.
  - Si has publicado alguna gem, este es un excelente momento para destacarlo.

---

## **Enlace para más información**
[Mindmajix: Ruby on Rails Interview Questions](http://mindmajix.com/ruby-rails-interview-questions/)

---

## **Vistas**:  
- **390 vistas**
- **1 voto positivo**

# Preguntas de Entrevista para Ruby on Rails

## ====================
A medida que hayas estado programando en Rails durante algunos meses, deberías estar expuesto a los conceptos mencionados en la siguiente lista de preguntas:

### Preguntas simples (posiblemente en una entrevista telefónica)

- **¿Cuáles son los beneficios de usar Active Record en lugar de consultas SQL nativas?**  
  - Explica en qué ocasiones deberías elegir uno sobre el otro.

- **Explica cómo funciona el scaffolding en RoR y por qué querrías usarlo.**

- **Conceptos de MVC + routing en Rails.**  
  - Detalla cómo se gestionan las rutas y su relación con el modelo MVC.

- **Da algunos ejemplos de las opciones de "convención sobre configuración" en RoR.**

- **Explica qué son las migraciones de bases de datos en Rails y los beneficios que traen consigo.**

---

### Preguntas un poco más desafiantes

- **¿Cuándo usarías variables de clase vs. variables de instancia en RoR?**

- **¿Cuáles son algunos callbacks de ActiveRecord con los que estás familiarizado?**

- **¿Cuál es la diferencia entre templates, sub-templates y view helpers en Rails?**

---

### Preguntas específicas de Ruby

- **¿Qué significa `self` cuando se usa en una clase?**  
  Explica cómo el contexto cambia dependiendo de su ubicación.

- **¿Qué significa `a ||= b`?**  
  - Proporciona ejemplos de cómo funciona esta asignación condicional.

---

### **Nota Importante**
- No hay mejor forma de prepararse para una entrevista de Rails que estar expuesto al framework de manera constante.

# Expectativas de un Ingeniero Senior en Ruby o Rails

Un ingeniero senior en Ruby o Rails se espera que demuestre la siguiente competencia:

### Habilidades Generales:
- **Buenos habilidades en código limpio.**
- **Buena experiencia en estrategias de pruebas.**
- **Buen conocimiento de patrones de diseño.**
- **Buen concepto en Programación Orientada a Objetos (OOP) y principios SOLID.**
- **Un buen enfoque analítico para la resolución de problemas.**

---

### Habilidades Subjetivas Clave:
Aparte de estas habilidades generales, hay algunas habilidades clave subjetivas que pueden ser evaluadas durante la entrevista:

- **Uso de middlewares.**
- **Rails engines.**
- **Templates en Rails.**
- **Preguntas específicas de bases de datos, como Transacciones de ActiveRecord.**
- **Localización.**
- **Almacenamiento de bases de datos tipo Key-Value.**
- **¿ActionCable quizás?**
- **Arquitectura a nivel alto para abrir una API.**
- **Mixins.**

---

### Consideración Final
Según mi experiencia, la mayoría de las entrevistas para nivel senior no se realizan mediante una entrevista técnica tradicional, sino que se profundiza en la experiencia y recorrido del entrevistado, revisando cómo aborda la resolución de desafíos.


### simple ejemplo
write a function that transforms this:
```ruby
['bob','james','james','susan','susan','susan']
into this
{ 'bob' => 1,  'james' => 2, 'susan' => 3 }
```
A junior candidate might answer the question like this:
This is a really interesting question for an interviewer because it can be answered by in a number of ways depending on the amount exposure to ruby.

```ruby
def wordcount(words) 
  count = {} 
  words.each do |word| 
    if count[word] 
      count[word] = count[word] + 1 
    else 
      count[word] = 1 
    end 
  end 
  count 
end 
```
I would then ask them to take a look at the documentation or the internet and work out how to initialise a hash with a default value.
Hopefully they could come up with something like this:
```ruby
def wordcount(words) 
  count = Hash.new(0) 
  words.each do |word| 
    count[word] += 1 
  end 
  count 
end 
```
The answer from someone who has used ruby for a while might look more like this:

```ruby
def wordcount(words) 
  words.each_with_object(Hash.new(0)) do |word, memo|  
    memo[word] += 1 
  end 
end 
```

For most junior to mid positions I am more interested in how someone can take some new learnings about the language and refactor the answer than knowing the best answer straight away.

For a more advanced candidate I might ask them to explore the behaviour of hash a little more and expose some of the interesting edge case properties . . .

