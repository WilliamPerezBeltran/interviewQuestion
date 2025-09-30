Aquí tienes un conjunto de preguntas comunes que suelen hacer en entrevistas para desarrollador de software con Ruby on Rails y React. Están organizadas por categoría:

🧠 Preguntas Técnicas – Ruby on Rails
¿Qué es Active Record y cómo funciona?

¿Qué es el problema N+1 y cómo lo solucionas?

¿Cómo defines relaciones has_many :through y has_and_belongs_to_many?

¿Qué sabes de concerns y service objects? ¿Cuándo los usarías?

¿Cómo gestionas background jobs? ¿Qué usas: Sidekiq, DelayedJob, etc.?

¿Cómo configuras y trabajas con rutas anidadas en Rails?

¿Cómo haces testing en Rails? (RSpec, Minitest, FactoryBot)

⚛️ Preguntas Técnicas – React.js
¿Cuál es la diferencia entre componentes de clase y funcionales?

¿Qué son los hooks y cuáles usas con frecuencia?

¿Cómo manejas el estado global? (Redux, Context API, Zustand, etc.)

¿Qué patrón usarías para comunicación entre componentes no relacionados?

¿Cómo optimizas el rendimiento en una app React?

¿Cómo manejas side effects? (useEffect, react-query, etc.)

¿Cómo configuras lazy loading en React?

🔗 Full Stack / Integración RoR + React
¿Cómo conectas un front React con un backend en Rails (API-only)?

¿Cómo manejas autenticación JWT entre frontend y backend?

¿Cómo estructurarías una app full-stack en monorepo vs repos separados?

¿Qué estrategias usas para manejo de errores entre cliente y servidor?

🧪 Testing y Calidad
¿Cómo pruebas tus endpoints en Rails?

¿Cómo haces pruebas unitarias y de integración en React (Jest, Testing Library)?

¿Cómo automatizas pruebas en el CI/CD pipeline?

☁️ DevOps / Despliegue
¿Qué sabes sobre despliegue en Heroku, AWS, Docker, etc.?

¿Has configurado pipelines con GitHub Actions, GitLab CI o Jenkins?

¿Cómo manejarías variables de entorno y secretos?

🗣️ Preguntas de comportamiento
Cuéntame sobre un bug difícil que resolviste.

¿Cómo manejas los conflictos en equipo?

¿Cómo estimas y priorizas tareas?

¿Has trabajado con metodologías ágiles? ¿Cómo fue tu rol en el equipo?

¿Quieres que armemos respuestas modelo o simulacros para alguna de estas preguntas?









Ask ChatGPT
Unlock more with Plus
ChatGPT Plus gives you higher limits, smarter models, and Sora for video.

Get Plus




Tools



ChatGPT can make mistakes. Check important info.




# Preguntas comunes de entrevista para desarrollador Ruby on Rails + React

## Preguntas Técnicas – Ruby on Rails

- ¿Qué es Active Record y cómo funciona?
- ¿Qué es el problema N+1 y cómo lo solucionas?
- ¿Cómo defines relaciones `has_many :through` y `has_and_belongs_to_many`?
- ¿Qué sabes de `concerns` y `service objects`? ¿Cuándo los usarías?
- ¿Cómo gestionas background jobs? ¿Qué usas: Sidekiq, DelayedJob, etc.?
- ¿Cómo configuras y trabajas con rutas anidadas en Rails?
- ¿Cómo haces testing en Rails? (RSpec, Minitest, FactoryBot)

##  Preguntas Técnicas – React.js

- ¿Cuál es la diferencia entre componentes de clase y funcionales?
- ¿Qué son los hooks y cuáles usas con frecuencia?
- ¿Cómo manejas el estado global? (Redux, Context API, Zustand, etc.)
- ¿Qué patrón usarías para comunicación entre componentes no relacionados?
- ¿Cómo optimizas el rendimiento en una app React?
- ¿Cómo manejas side effects? (`useEffect`, `react-query`, etc.)
- ¿Cómo configuras lazy loading en React?

## Full Stack / Integración RoR + React

- ¿Cómo conectas un front React con un backend en Rails (API-only)?
- ¿Cómo manejas autenticación JWT entre frontend y backend?
- ¿Cómo estructurarías una app full-stack en monorepo vs repos separados?
- ¿Qué estrategias usas para manejo de errores entre cliente y servidor?

## Testing y Calidad

- ¿Cómo pruebas tus endpoints en Rails?
- ¿Cómo haces pruebas unitarias y de integración en React (Jest, Testing Library)?
- ¿Cómo automatizas pruebas en el CI/CD pipeline?

## ☁DevOps / Despliegue

- ¿Qué sabes sobre despliegue en Heroku, AWS, Docker, etc.?
- ¿Has configurado pipelines con GitHub Actions, GitLab CI o Jenkins?
- ¿Cómo manejarías variables de entorno y secretos?

##  Preguntas de comportamiento

- Cuéntame sobre un bug difícil que resolviste.
- ¿Cómo manejas los conflictos en equipo?
- ¿Cómo estimas y priorizas tareas?
- ¿Has trabajado con metodologías ágiles? ¿Cómo fue tu rol en el equipo?

====================
=====================================================================================================

## respuestas

# Preguntas comunes de entrevista para desarrollador Ruby on Rails + React

##  Preguntas Técnicas – Ruby on Rails
======================================================================================================
======================================================================================================

- ¿Qué es Active Record y cómo funciona? 

# Active Record en Ruby on Rails

**Active Record** es el ORM (*Object-Relational Mapping*) que usa **Ruby on Rails** para interactuar con bases de datos de forma orientada a objetos.

---

## ¿Qué es?

Active Record representa cada **tabla** de la base de datos como una **clase Ruby**, y cada **fila** como una instancia de esa clase.

> Ejemplo:  
> Si tienes una tabla `users`, Rails crea una clase `User`, y cada registro se convierte en un objeto `User`.

---

## ¿Cómo funciona?

### 🔁 Mapeo automático
Rails mapea automáticamente las columnas de la tabla a atributos del modelo sin necesidad de configuración adicional.

### ⚙️ CRUD fácil
Proporciona métodos como:
- `.create`
- `.find`
- `.update`
- `.destroy`
- `.where`

Estos generan SQL automáticamente.

### 🔗 Relaciones
Permite definir asociaciones como:
- `has_many`
- `belongs_to`
- `has_one`
- `has_and_belongs_to_many`

Para trabajar con datos relacionados sin escribir SQL complejo.

### ✅ Validaciones y Callbacks
Puedes definir:
- **Validaciones** (`validates`)
- **Callbacks** (`before_save`, `after_create`, etc.)

### 🔍 Scopes y consultas encadenadas
Permite:
- Crear consultas reutilizables:
  ```ruby
  scope :active, -> { where(active: true) }
  ```

  Encadenar métodos:
```ruby
User.where(active: true).order(:name)

```
Ejemplo
```ruby
class User < ApplicationRecord
  has_many :posts
  validates :email, presence: true
end

# Crear un usuario
User.create(name: "William", email: "william@example.com")

# Consultar usuarios activos
User.where(active: true)

```

### Resumen
- Active Record simplifica la interacción con la base de datos, eliminando la necesidad de escribir SQL manual y permitiendo trabajar con objetos Ruby de forma intuitiva.

## 🔗 Relaciones en Active Record

- `belongs_to`  
  Relación donde un modelo contiene la clave foránea y pertenece a otro.

- `has_one`  
  Un modelo tiene una única instancia de otro modelo relacionado.

- `has_many`  
  Relación uno-a-muchos entre modelos.

- `has_many :through`  
  Relación muchos-a-muchos con un modelo intermedio explícito.

- `has_and_belongs_to_many`  
  Relación muchos-a-muchos sin modelo intermedio explícito (usa tabla join).

- Relaciones polimórficas:
  - `belongs_to :..., polymorphic: true`  
    El modelo puede pertenecer a más de un otro modelo.
  - `has_many :..., as: :...`  
    El modelo puede tener muchos otros modelos que usen la misma interfaz polimórfica.



##Validaciones en Active Record

Active Record permite validar datos antes de guardarlos en la base de datos.

Validaciones en Active Record

Active Record permite validar datos antes de que se guarden en la base de datos

Validaciones comunes

- validates :attribute, presence: true  
  El atributo no puede estar vacío

- validates :attribute, uniqueness: true  
  El valor debe ser único

- validates :attribute, numericality: true  
  El valor debe ser numérico

- validates :attribute, length: { minimum: x, maximum: y }  
  Controla la longitud del valor

- validates :attribute, format: { with: /regex/ }  
  Valida el formato mediante expresión regular

- validates :attribute, inclusion: { in: [...] }  
  El valor debe estar incluido en una lista

- validates :attribute, exclusion: { in: [...] }  
  El valor no debe estar en una lista

- validates :attribute, comparison: { greater_than: 0 }  
  Compara el valor con otro valor o número

Validaciones personalizadas

validate :custom_validation_method

def custom_validation_method  
  errors.add(:attribute, "mensaje de error") if condición  
end

Ejemplo

class User < ApplicationRecord  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }  
  validates :age, numericality: { only_integer: true, greater_than: 0 }  
end

### ⚙️ Validación Personalizada

```ruby
validate :custom_validation_method

def custom_validation_method
  errors.add(:attribute, "mensaje de error") if condición
end
```
### Listado de validaciones en Active Record

- presence  
- uniqueness  
- numericality  
- length  
- format  
- inclusion  
- exclusion  
- comparison  
- confirmation  
- acceptance  
- absence  
- custom (validate con método definido)

Ciclo de vida de un objeto en Ruby on Rails

El ciclo de vida de un objeto Active Record representa las etapas por las que pasa desde su creación hasta su eliminación

1. Inicialización  
   - Se instancia el objeto con new  
   - No está persistido en la base de datos

2. Validación  
   - Se ejecutan las validaciones antes de guardar  
   - Callbacks: before_validation, after_validation

3. Guardado (create o update)  
   - Se guarda el objeto en la base de datos  
   - Callbacks:
     - before_save  
     - before_create o before_update  
     - around_save  
     - around_create o around_update  
     - after_create o after_update  
     - after_save

4. Commit de la transacción  
   - Si no hay errores, se realiza el commit  
   - Callbacks: after_commit

5. Destrucción  
   - El objeto se elimina con destroy  
   - Callbacks:
     - before_destroy  
     - around_destroy  
     - after_destroy  
     - after_commit  
     - after_rollback (si ocurre un error en la transacción)

Resumen del flujo típico

new → validate → save/create → commit  
find → update → validate → save/update → commit  
destroy → commit



Ciclo de vida de un objeto en Ruby on Rails

El ciclo de vida de un objeto Active Record representa las etapas por las que pasa desde su creación hasta su eliminación

1. Inicialización  
   - Se instancia el objeto con new  
   - No está persistido en la base de datos

2. Validación  
   - Se ejecutan las validaciones antes de guardar  
   - Callbacks: before_validation, after_validation

3. Guardado (create o update)  
   - Se guarda el objeto en la base de datos  
   - Callbacks:
     - before_save  
     - before_create o before_update  
     - around_save  
     - around_create o around_update  
     - after_create o after_update  
     - after_save

4. Commit de la transacción  
   - Si no hay errores, se realiza el commit  
   - Callbacks: after_commit

5. Destrucción  
   - El objeto se elimina con destroy  
   - Callbacks:
     - before_destroy  
     - around_destroy  
     - after_destroy  
     - after_commit  
     - after_rollback (si ocurre un error en la transacción)

Resumen del flujo típico

new → validate → save/create → commit  
find → update → validate → save/update → commit  
destroy → commit

### Scopes y consultas encadenadas en Active Record

Un scope es una forma de encapsular consultas reutilizables en los modelos de Active Record

Definición de un scope

```ruby
class Article < ApplicationRecord  
  scope :published, -> { where(published: true) }  
  scope :recent, -> { order(created_at: :desc) }  
end
```


Uso de scopes
```ruby

Article.published  
Article.recent  
Article.published.recent  
Article.recent.where(author_id: 1)
```

Scopes con argumentos
```ruby
scope :by_author, ->(author_id) { where(author_id: author_id) }

Article.by_author(5).published
```

Consultas encadenadas

Puedes combinar múltiples scopes y métodos de Active Record para formar consultas complejas sin escribir SQL directamente
```ruby
Article.published.recent.limit(10).offset(20)
```

Cada método devuelve una instancia de ActiveRecord::Relation, permitiendo el encadenamiento

Ventajas
```ruby
- Reutilización de lógica de consulta
- Código más limpio y expresivo
- Composición flexible de condiciones
```

Los scopes también pueden combinarse con métodos como where, select, order, joins, includes, etc

===============================================================================================
===============================================================================================

- ¿Qué es el problema N+1 y cómo lo solucionas?

Que es el problema N+1 y como lo solucionas

El problema N+1 ocurre cuando al consultar un conjunto de registros, se ejecuta una consulta adicional por cada registro relacionado

Ejemplo del problema

posts = Post.all  
posts.each do |post|  
  puts post.comments.count  
end

Esto genera una consulta para traer los posts  
Luego una consulta adicional por cada post para obtener sus comentarios  
Resultado total: 1 consulta para los posts + N consultas para los comentarios

Como solucionarlo

Usar includes para hacer eager loading

posts = Post.includes(:comments)  
posts.each do |post|  
  puts post.comments.count  
end

Esto genera solo dos consultas  
Una para los posts  
Una para todos los comentarios relacionados

Otras tecnicas

- eager_load  
  Hace un join SQL y carga todo en una sola consulta

- preload  
  Ejecuta dos consultas separadas y asocia los resultados en memoria

- joins  
  Se usa para filtrar usando condiciones en relaciones, pero no carga los objetos relacionados

Resumen

- Problema N+1 significa multiples consultas innecesarias al acceder a relaciones
- Solucion: usar eager loading con includes, preload o eager_load




Que es eager loading

Eager loading es una tecnica en Active Record que permite cargar objetos relacionados en la misma consulta o en consultas anticipadas  
Su objetivo es evitar el problema N+1 y mejorar el rendimiento al acceder a asociaciones

Ejemplo sin eager loading

posts = Post.all  
posts.each do |post|  
  puts post.comments.count  
end

Esto hace una consulta para los posts y una por cada grupo de comentarios

Ejemplo con eager loading

posts = Post.includes(:comments)  
posts.each do |post|  
  puts post.comments.count  
end

Esto hace dos consultas  
Una para los posts  
Una para todos los comentarios relacionados

Metodos para eager loading

- includes  
  Carga las asociaciones usando una o dos consultas  
  Ideal para evitar el problema N+1

- eager_load  
  Usa un join SQL para traer todos los datos en una sola consulta  
  Util cuando se necesitan condiciones en los datos relacionados

- preload  
  Hace dos consultas separadas y carga los datos relacionados en memoria

Beneficios

- Reduce la cantidad de consultas SQL
- Mejora el rendimiento en vistas o APIs que acceden a datos relacionados




Que es eager_load

eager_load es un metodo de Active Record que realiza eager loading usando un JOIN SQL  
Carga los registros principales y sus asociaciones en una sola consulta

Es util cuando necesitas acceder a datos relacionados y aplicar condiciones o filtros sobre esos datos en la misma consulta

Ejemplo

posts = Post.eager_load(:comments).where(comments: { approved: true })

Esto genera una sola consulta SQL con un LEFT OUTER JOIN entre posts y comments  
Permite aplicar condiciones directamente sobre la tabla comments

Diferencias con otros metodos

- includes  
  Decide automaticamente si usa JOIN o dos consultas  
  No es bueno si necesitas filtrar por atributos de la asociacion

- preload  
  Siempre hace dos consultas  
  No permite usar condiciones sobre la asociacion en la misma consulta

- eager_load  
  Siempre hace un LEFT OUTER JOIN  
  Permite filtrar usando condiciones sobre las asociaciones

Resumen

- eager_load se usa cuando necesitas cargar asociaciones y filtrar por sus atributos  
- Ejecuta una sola consulta SQL usando JOIN  
- Ideal para evitar el problema N+1 con mas control sobre la consulta




Que es joins

joins es un metodo de Active Record que realiza un INNER JOIN entre tablas relacionadas en la base de datos  
Se utiliza para construir consultas que dependen de condiciones en modelos asociados

Ejemplo

posts = Post.joins(:comments).where(comments: { approved: true })

Esto genera una consulta SQL que une las tablas posts y comments  
Y filtra los posts que tienen comentarios aprobados

Caracteristicas

- No carga los registros de la asociacion en memoria  
- Solo permite acceder a los datos de la tabla principal a menos que se use select personalizado  
- Es eficiente para filtrar datos sin necesidad de cargar objetos relacionados

Diferencias con otros metodos

- joins  
  Une tablas para aplicar condiciones  
  No carga objetos relacionados

- includes  
  Carga objetos relacionados y evita el problema N+1

- eager_load  
  Une tablas y carga los objetos relacionados al mismo tiempo

Resumen

- joins se usa para filtrar por atributos de asociaciones sin cargar los objetos  
- Ideal para condiciones y filtros  
- No soluciona el problema N+1 si luego accedes a las asociaciones








por lo ranto eager loading , earger_load, preload, joins son metodos de active record ? 

Si, eager loading, eager_load, preload y joins son metodos de Active Record

Todos estos metodos se usan para optimizar consultas y trabajar con asociaciones entre modelos en Rails

Listado

- includes  
  Metodo para eager loading  
  Decide automaticamente entre usar preload o eager_load segun el contexto

- eager_load  
  Hace un LEFT OUTER JOIN  
  Carga los datos del modelo principal y sus asociaciones en una sola consulta

- preload  
  Ejecuta dos consultas separadas y asocia los datos en memoria  
  No permite aplicar condiciones sobre los datos relacionados

- joins  
  Hace un INNER JOIN  
  Se usa para aplicar condiciones sobre asociaciones sin cargar objetos relacionados

Resumen

Todos son metodos de ActiveRecord::Relation y permiten mejorar el rendimiento al consultar modelos con r






Relaciones en SQL (tipos de JOIN)

Los JOIN se utilizan para combinar filas de dos o mas tablas basadas en una columna relacionada entre ellas

Listado de tipos de JOIN en SQL

- INNER JOIN  
  Devuelve solo las filas que tienen coincidencias en ambas tablas

- LEFT JOIN o LEFT OUTER JOIN  
  Devuelve todas las filas de la tabla izquierda y las coincidencias de la tabla derecha  
  Si no hay coincidencia, los valores de la tabla derecha serán NULL

- RIGHT JOIN o RIGHT OUTER JOIN  
  Devuelve todas las filas de la tabla derecha y las coincidencias de la tabla izquierda  
  Si no hay coincidencia, los valores de la tabla izquierda serán NULL

- FULL JOIN o FULL OUTER JOIN  
  Devuelve todas las filas cuando hay coincidencia en una de las tablas  
  Las filas sin coincidencia tendrán NULLs en las columnas de la otra tabla

- CROSS JOIN  
  Devuelve el producto cartesiano de las dos tablas  
  Todas las combinaciones posibles entre las filas de ambas tablas

- SELF JOIN  
  Es un join de una tabla consigo misma  
  Util cuando se quiere comparar filas dentro de la misma tabla

Resumen

- INNER JOIN  
- LEFT JOIN o LEFT OUTER JOIN  
- RIGHT JOIN o RIGHT OUTER JOIN  
- FULL JOIN o FULL OUTER JOIN  
- CROSS JOIN  
- SELF JOIN



INNER JOIN  
Devuelve solo las filas que coinciden en ambas tablas

   A ∩ B

   +--------+
   |   A    |
   |   +----|----+
   |   |    | B  |
   +---|----+    |
       |         |
       +---------+


LEFT JOIN (LEFT OUTER JOIN)  
Devuelve todas las filas de la tabla izquierda y las coincidentes de la derecha

   A ⊇ (A ∩ B)

   +--------+
   |   A    |
   |   +----|----+
   |   |    | B  |
   +---|----+    |
       |         |
       +---------+


RIGHT JOIN (RIGHT OUTER JOIN)  
Devuelve todas las filas de la tabla derecha y las coincidentes de la izquierda

   B ⊇ (A ∩ B)

   +--------+
   |   B    |
   |   +----|----+
   |   |    | A  |
   +---|----+    |
       |         |
       +---------+


FULL JOIN (FULL OUTER JOIN)  
Devuelve todas las filas de ambas tablas, coincidan o no

   A ∪ B

   +--------+
   |   A    |
   |   +----|----+
   |   |    | B  |
   +---|----+----+
       |         |
       +---------+


CROSS JOIN  
Devuelve todas las combinaciones posibles (producto cartesiano)

Si A tiene 3 filas y B tiene 4, el resultado tendrá 3 x 4 = 12 filas


SELF JOIN  
Un join de una tabla consigo misma, útil para comparar registros dentro de la misma tabla


listado:

INNER JOIN  
LEFT JOIN (LEFT OUTER JOIN)  
RIGHT JOIN (RIGHT OUTER JOIN)  
FULL JOIN (FULL OUTER JOIN)  
CROSS JOIN  
SELF JOIN  






¿Existen metodos en Active Record que representen los distintos tipos de JOIN en SQL?

Active Record ofrece soporte directo o indirecto para varios tipos de JOIN, pero no todos tienen metodos dedicados

Listado de equivalencias

INNER JOIN  
- Metodo: joins  
- Ejemplo: Post.joins(:comments)  
- Genera un INNER JOIN entre posts y comments

LEFT JOIN (LEFT OUTER JOIN)  
- Metodo: includes, preload, eager_load  
- Ejemplo: Post.includes(:comments)  
- Si se accede a datos relacionados, puede generar un LEFT OUTER JOIN (solo con eager_load)  
- Tambien se puede usar Arel o joins con select y left_joins

- Metodo directo: left_joins (Rails 5+)  
- Ejemplo: Post.left_joins(:comments)

RIGHT JOIN (RIGHT OUTER JOIN)  
- No tiene soporte directo en Active Record  
- Se puede usar SQL crudo o Arel

FULL JOIN (FULL OUTER JOIN)  
- No tiene soporte en Active Record  
- Requiere SQL personalizado

CROSS JOIN  
- No tiene metodo directo  
- Se puede usar find_by_sql o Arel para construirlo

SELF JOIN  
- No existe un metodo especial  
- Se puede hacer con joins y alias  
- Ejemplo:

  Employee.joins("INNER JOIN employees managers ON employees.manager_id = managers.id")

Resumen

Active Record soporta:

- INNER JOIN con joins  
- LEFT OUTER JOIN con left_joins o eager_load  
- SELF JOIN con SQL personalizado  
- RIGHT JOIN, FULL JOIN y CROSS JOIN requieren SQL crudo o Arel



===============================================================================================
===============================================================================================
- ¿Cómo defines relaciones `has_many :through` y `has_and_belongs_to_many`?

Como defines relaciones has_many :through y has_and_belongs_to_many en Active Record

has_many :through

Se usa para establecer una relacion muchos a muchos a traves de un modelo intermedio  
Permite agregar logica o validaciones adicionales en la tabla intermedia

Ejemplo

class Physician < ApplicationRecord  
  has_many :appointments  
  has_many :patients, through: :appointments  
end

class Appointment < ApplicationRecord  
  belongs_to :physician  
  belongs_to :patient  
end

class Patient < ApplicationRecord  
  has_many :appointments  
  has_many :physicians, through: :appointments  
end

Ventajas

- Permite acceder a los registros relacionados
- Se puede añadir informacion extra en la tabla intermedia
- Se pueden aplicar validaciones en el modelo intermedio

has_and_belongs_to_many

Relacion muchos a muchos directa sin modelo intermedio  
Requiere una tabla join con nombre en orden alfabetico de los modelos

Ejemplo

class Student < ApplicationRecord  
  has_and_belongs_to_many :courses  
end

class Course < ApplicationRecord  
  has_and_belongs_to_many :students  
end

La tabla intermedia debe llamarse courses_students y contener student_id y course_id

Limitaciones

- No se puede agregar atributos extra en la tabla intermedia
- No se pueden aplicar validaciones o callbacks sobre la relacion







# Relaciones en Active Record (Ruby on Rails)

Active Record permite definir relaciones entre modelos que representan asociaciones entre tablas de base de datos.

## 1. `belongs_to` / `has_one` – Relación Uno a Uno (1:1)

```ruby
# app/models/profile.rb
class Profile < ApplicationRecord
  belongs_to :user
end

# app/models/user.rb
class User < ApplicationRecord
  has_one :profile
end
```

La tabla `profiles` debe tener la columna `user_id`.

## 2. `has_many` / `belongs_to` – Relación Uno a Muchos (1:N)

```ruby
# app/models/article.rb
class Article < ApplicationRecord
  has_many :comments
end

# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :article
end
```

La tabla `comments` debe tener la columna `article_id`.

## 3. `has_many :through` – Muchos a Muchos con Modelo Intermedio (N:M)

```ruby
# app/models/doctor.rb
class Doctor < ApplicationRecord
  has_many :appointments
  has_many :patients, through: :appointments
end

# app/models/patient.rb
class Patient < ApplicationRecord
  has_many :appointments
  has_many :doctors, through: :appointments
end

# app/models/appointment.rb
class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
end
```

Se usa cuando necesitas atributos adicionales en la tabla de unión (`appointments`).

## 4. `has_and_belongs_to_many` (HABTM) – Muchos a Muchos sin Modelo Intermedio (N:M)

```ruby
# app/models/student.rb
class Student < ApplicationRecord
  has_and_belongs_to_many :courses
end

# app/models/course.rb
class Course < ApplicationRecord
  has_and_belongs_to_many :students
end
```

Requiere una tabla intermedia `courses_students` sin modelo.  
Contiene las columnas `student_id` y `course_id`.

## 5. Opción `dependent: :destroy` – Eliminar Relaciones Asociadas

```ruby
# app/models/user.rb
class User < ApplicationRecord
  has_many :posts, dependent: :destroy
end
```

Al eliminar un `User`, también se eliminan sus `posts`.









# Relaciones en Active Record (Ruby on Rails)

Listado de las relaciones más comunes en Active Record:

1. **Uno a Uno (`has_one` / `belongs_to`)**
   - Un registro en un modelo está relacionado con exactamente un registro en otro.
   - Ejemplo:
     ```ruby
     class Profile < ApplicationRecord
       belongs_to :user
     end

     class User < ApplicationRecord
       has_one :profile
     end
     ```
   - La tabla `profiles` debe tener la columna `user_id`.

2. **Uno a Muchos (`has_many` / `belongs_to`)**
   - Un registro está relacionado con muchos otros registros.
   - Ejemplo:
     ```ruby
     class Article < ApplicationRecord
       has_many :comments
     end

     class Comment < ApplicationRecord
       belongs_to :article
     end
     ```
   - La tabla `comments` debe tener la columna `article_id`.

3. **Muchos a Muchos con modelo intermedio (`has_many :through`)**
   - Relación con una tabla intermedia que también puede tener atributos adicionales.
   - Ejemplo:
     ```ruby
     class Doctor < ApplicationRecord
       has_many :appointments
       has_many :patients, through: :appointments
     end

     class Patient < ApplicationRecord
       has_many :appointments
       has_many :doctors, through: :appointments
     end

     class Appointment < ApplicationRecord
       belongs_to :doctor
       belongs_to :patient
     end
     ```
   - La tabla `appointments` almacena la relación y posibles datos extra como fecha/hora.

4. **Muchos a Muchos simple (`has_and_belongs_to_many`)**
   - Relación directa sin modelo intermedio explícito.
   - Ejemplo:
     ```ruby
     class Student < ApplicationRecord
       has_and_belongs_to_many :courses
     end

     class Course < ApplicationRecord
       has_and_belongs_to_many :students
     end
     ```
   - Requiere una tabla intermedia `courses_students` con columnas `student_id` y `course_id`.

5. **Eliminación en cascada (`dependent: :destroy`)**
   - Al eliminar un registro, también se eliminan los relacionados.
   - Ejemplo:
     ```ruby
     class User < ApplicationRecord
       has_many :posts, dependent: :destroy
     end
     ```
   - Si se elimina un `User`, se eliminan sus `posts` automáticamente.





===============================================================================================
===============================================================================================
- ¿Qué sabes de `concerns` y `service objects`? ¿Cuándo los usarías?

# `concerns` y `service objects` en Ruby on Rails

## 1. `concerns`

### ¿Qué son?
- Módulos reutilizables que encapsulan lógica común o compartida entre modelos o controladores.
- Se ubican en:
  - Modelos: `app/models/concerns/`
  - Controladores: `app/controllers/concerns/`

### ¿Cuándo usarlos?
- Cuando varios modelos o controladores comparten lógica similar.
- Para separar responsabilidades y mantener el código limpio y DRY (Don't Repeat Yourself).

### Ejemplo:

```ruby
# app/models/concerns/archivable.rb
module Archivable
  extend ActiveSupport::Concern

  included do
    scope :archived, -> { where(archived: true) }
  end

  def archive!
    update(archived: true)
  end
end

# app/models/post.rb
class Post < ApplicationRecord
  include Archivable
end
```

2. service objects
¿Qué son?
Clases que encapsulan lógica de negocio compleja o procesos que no pertenecen directamente a un modelo o controlador.

Se ubican comúnmente en app/services/.

¿Cuándo usarlos?
Para operaciones complejas, múltiples pasos o integración con APIs externas.

Cuando necesitas mantener controladores y modelos delgados.

Para favorecer el principio de responsabilidad única (SRP).

Ejemplo:
# app/services/user_signup_service.rb
```ruby
class UserSignupService
  def initialize(params)
    @params = params
  end

  def call
    user = User.new(@params)
    if user.save
      WelcomeMailer.send_email(user).deliver_later
    end
    user
  end
end
```

# En el controlador
```ruby
def create
  @user = UserSignupService.new(user_params).call
  if @user.persisted?
    redirect_to dashboard_path
  else
    render :new
  end
end
```
Resumen
Concepto	Uso principal	Ubicación común
concerns	Compartir lógica entre modelos/controladores	app/models/concerns/
service objects	Encapsular lógica de negocio compleja o procesos	app/services/
===============================================================================================
===============================================================================================
- ¿Cómo gestionas background jobs? ¿Qué usas: Sidekiq, DelayedJob, etc.?
# Gestión de Background Jobs en Ruby on Rails

## ¿Qué son los background jobs?

Son tareas que se ejecutan de forma asíncrona fuera del ciclo de vida de la petición HTTP.  
Se usan para operaciones que consumen tiempo como:

- Enviar correos electrónicos
- Procesar archivos
- Llamadas a APIs externas
- Generación de reportes
- Procesamiento de imágenes

---

## Opciones comunes en Rails

### 1. **Sidekiq**

- Basado en Redis
- Multihilo, rápido y eficiente
- Requiere que el modelo implemente `Sidekiq::Worker`

#### Ejemplo

```ruby
# app/workers/hard_job.rb
class HardJob
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    user.do_something_heavy
  end
end
```

```ruby
# para encolar el job
HardJob.perform_async(user.id)
```

#### Configuración básica

- Añadir `gem 'sidekiq'` al `Gemfile`
- Configurar Redis y `sidekiq.yml`
- Usar en producción junto con monitoreo (Sidekiq Web UI)

---

### 2. **DelayedJob**

- Almacena los jobs en la base de datos
- Fácil de configurar, pero más lento que Sidekiq
- Bueno para aplicaciones pequeñas o sin Redis

#### Ejemplo

```ruby
# app/jobs/hard_job.rb
class HardJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    user.do_something_heavy
  end
end
```

```ruby
# para encolar el job
HardJob.perform_later(user.id)
```

#### Configuración básica

- Añadir `gem 'delayed_job_active_record'`
- Ejecutar `rails generate delayed_job:active_record`
- Migrar y correr el worker: `bin/delayed_job start`

---

### 3. **Active Job (API de Rails)**

- API integrada en Rails para definir jobs
- Soporta múltiples backends: Sidekiq, DelayedJob, Resque, etc.
- Proporciona una interfaz única para todos los adaptadores

#### Ejemplo con Sidekiq como backend

```ruby
# config/application.rb
config.active_job.queue_adapter = :sidekiq
```

```ruby
# app/jobs/my_job.rb
class MyJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.send_email
  end
end
```

---

## ¿Cuándo usar cuál?

| Opción       | Ventajas                          | Cuándo usar                      |
|--------------|-----------------------------------|----------------------------------|
| **Sidekiq**  | Rápido, eficiente, escalable      | Producción, alto rendimiento     |
| **DelayedJob** | Simple, sin Redis               | Apps pequeñas, bajo volumen      |
| **Active Job** | Interfaz común para adaptadores | Flexibilidad con distintos backends |

---

## Recomendación

Usar **Active Job** con **Sidekiq** en entornos productivos.  
Permite mantener el código desacoplado del backend y beneficiarse del rendimiento de Sidekiq.



===========================================================================
===========================================================================
- ¿Cómo configuras y trabajas con rutas anidadas en Rails?
# Rutas Anidadas en Ruby on Rails

Las rutas anidadas permiten reflejar relaciones jerárquicas entre recursos, por ejemplo:  
un `Post` tiene muchos `Comments`.

---

## 1. Definición de rutas anidadas

Se definen en el archivo `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end
end
```

Esto genera rutas como:

```
GET    /posts/:post_id/comments          → comments#index
POST   /posts/:post_id/comments          → comments#create
GET    /posts/:post_id/comments/:id      → comments#show
PATCH  /posts/:post_id/comments/:id      → comments#update
DELETE /posts/:post_id/comments/:id      → comments#destroy
```

---

## 2. Acceso a parámetros anidados en el controlador

```ruby
class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = @post.comments
  end

  def show
    @comment = @post.comments.find(params[:id])
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
```

---

## 3. Enlaces en vistas

```erb
<%= link_to 'All Comments', post_comments_path(@post) %>
<%= link_to 'New Comment', new_post_comment_path(@post) %>
```

---

## 4. Buenas prácticas

- Evita más de 1 nivel de anidación (`resources :a do; resources :b do; resources :c` ❌).
- Usa `shallow: true` para simplificar rutas:

```ruby
resources :posts do
  resources :comments, shallow: true
end
```

Esto genera:

- `/posts/:post_id/comments` → `index`, `create`, `new`
- `/comments/:id` → `show`, `edit`, `update`, `destroy`

---

## 5. ¿Cuándo usar rutas anidadas?

- Cuando los recursos tienen una relación clara de dependencia (`belongs_to`).
- Cuando necesitas incluir `:post_id` en la URL por contexto o seguridad.
- Cuando las operaciones no tienen sentido sin el recurso padre.

---

## Ejemplo completo

```ruby
# routes.rb
resources :authors do
  resources :books, shallow: true
end
```

Genera:

```
GET /authors/:author_id/books        → books#index
GET /authors/:author_id/books/new    → books#new
POST /authors/:author_id/books       → books#create
GET /books/:id                       → books#show
GET /books/:id/edit                  → books#edit
PATCH /books/:id                     → books#update
DELETE /books/:id                    → books#destroy
```

Permite trabajar con anidación sin complicar las URLs de acciones que solo necesitan el ID del recurso hijo.

===========================================================================
===========================================================================
- ¿Cómo haces testing en Rails? (RSpec, Minitest, FactoryBot)

# Testing en Ruby on Rails

Rails incluye un sistema de testing por defecto (Minitest), pero también es muy común usar **RSpec** y **FactoryBot** para pruebas más expresivas y robustas.

---

## 1. Tipos de tests comunes en Rails

| Tipo de test     | Qué prueba                             |
|------------------|----------------------------------------|
| Model specs      | Validaciones, asociaciones, lógica     |
| Controller specs | Comportamiento HTTP y respuestas       |
| Request specs    | Flujo de extremo a extremo             |
| Feature specs    | Interacciones del usuario (Capybara)   |
| Job specs        | Background jobs                        |
| Service specs    | Lógica contenida en service objects    |

---

## 2. Usando **RSpec**

### Instalación

Agrega al `Gemfile`:

```ruby
group :development, :test do
  gem 'rspec-rails'
end
```

Y luego ejecuta:

```bash
bundle install
rails generate rspec:install
```

Esto crea la carpeta `spec/`.

### Ejemplo: modelo

```ruby
# spec/models/user_spec.rb
RSpec.describe User, type: :model do
  it 'is valid with name and email' do
    user = User.new(name: "Alice", email: "alice@example.com")
    expect(user).to be_valid
  end

  it 'is invalid without email' do
    user = User.new(name: "Bob")
    expect(user).not_to be_valid
  end
end
```

---

## 3. Usando **FactoryBot**

### Instalación

```ruby
group :development, :test do
  gem 'factory_bot_rails'
end
```

En `spec/rails_helper.rb`:

```ruby
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
```

### Definición de factories

```ruby
# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { "user@example.com" }
  end
end
```

### Uso en tests

```ruby
let(:user) { create(:user) }
```

---

## 4. Usando **Minitest** (por defecto en Rails)

### Modelo de ejemplo

```ruby
# test/models/user_test.rb
require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    user = User.new
    assert_not user.save
  end
end
```

---

## 5. Ejecutar tests

### Con RSpec

```bash
bundle exec rspec
```

### Con Minitest

```bash
rails test
```

---

## 6. Herramientas adicionales

- `Capybara` – para tests de integración/sistema
- `DatabaseCleaner` – para limpiar la base de datos entre tests
- `Shoulda Matchers` – para simplificar pruebas de validaciones/asociaciones

---

## Recomendación

Usar **RSpec + FactoryBot** + **Capybara** en proyectos medianos/grandes por legibilidad, modularidad y comunidad activa.


===========================================================================
===========================================================================

## ⚛️ Preguntas Técnicas – React.js

- ¿Cuál es la diferencia entre componentes de clase y funcionales?
- ¿Qué son los hooks y cuáles usas con frecuencia?
- ¿Cómo manejas el estado global? (Redux, Context API, Zustand, etc.)
- ¿Qué patrón usarías para comunicación entre componentes no relacionados?
- ¿Cómo optimizas el rendimiento en una app React?
- ¿Cómo manejas side effects? (`useEffect`, `react-query`, etc.)
- ¿Cómo configuras lazy loading en React?

# Preguntas avanzadas sobre React.js

---

## 1. ¿Cuál es la diferencia entre componentes de clase y funcionales?

### Componentes de Clase
- Sintaxis basada en `class`.
- Usan `this` para acceder a props y estado.
- Requieren heredar de `React.Component`.
- Lifecycle methods explícitos: `componentDidMount`, `componentDidUpdate`, etc.

```jsx
class MyComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = { count: 0 };
  }

  render() {
    return <p>{this.state.count}</p>;
  }
}
```

### Componentes Funcionales
- Sintaxis basada en funciones.
- Desde React 16.8 pueden usar `hooks`.
- Más concisos y fáciles de probar.

```jsx
import { useState } from 'react';

function MyComponent() {
  const [count, setCount] = useState(0);
  return <p>{count}</p>;
}
```

---

## 2. ¿Qué son los hooks y cuáles usas con frecuencia?

### ¿Qué son?
Funciones que permiten usar estado, ciclo de vida y otras funcionalidades de React en componentes funcionales.

### Hooks comunes:

| Hook            | Uso principal                            |
|-----------------|-------------------------------------------|
| `useState`      | Manejar estado local                     |
| `useEffect`     | Side effects (peticiones, subscripciones)|
| `useContext`    | Acceder al contexto                      |
| `useReducer`    | Manejar lógica compleja de estado        |
| `useMemo`       | Memorizar cálculos costosos              |
| `useCallback`   | Memorizar funciones                      |
| `useRef`        | Referencia mutable a un valor            |

---

## 3. ¿Cómo manejas el estado global?

### Opciones comunes:

| Opción         | Características                                    |
|----------------|----------------------------------------------------|
| **Redux**      | Centralizado, robusto, ideal para apps grandes     |
| **Context API**| Nativo, útil para estado de configuración o auth   |
| **Zustand**    | Ligero, sin boilerplate, basado en hooks           |
| **Recoil**     | Experimental, inspirado en React’s concurrent mode |

### Ejemplo: Context API

```jsx
const AuthContext = React.createContext();

function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  return (
    <AuthContext.Provider value={{ user, setUser }}>
      {children}
    </AuthContext.Provider>
  );
}
```

---

## 4. ¿Qué patrón usarías para comunicación entre componentes no relacionados?

### Opciones:
- **Context API** (si están dentro del mismo árbol de componentes)
- **Event Bus (pub/sub)**: con librerías como mitt o EventEmitter
- **Estado global**: con Redux, Zustand, Recoil
- **URL/Query Params**: si el estado debe ser compartido vía navegación
- **Custom hooks + context**

---

## 5. ¿Cómo optimizas el rendimiento en una app React?

### Técnicas:
- `React.memo()` para evitar renders innecesarios.
- `useMemo()` para evitar cálculos pesados en cada render.
- `useCallback()` para evitar recrear funciones.
- Lazy loading de componentes con `React.lazy`.
- Dividir código en chunks (code splitting).
- Evitar estados innecesarios a nivel global.
- Virtualización de listas con `react-window` o `react-virtualized`.
- Evitar re-rendering con claves (`key`) mal usadas en listas.

---

## 6. ¿Cómo manejas side effects?

### Opciones:

| Herramienta        | Uso principal                                      |
|--------------------|----------------------------------------------------|
| `useEffect`        | Lógica que ocurre después del render               |
| `react-query`      | Fetching, caching y sincronización de datos remotos|
| `axios/fetch` + `useEffect` | Para peticiones simples                   |
| `Redux-Saga` / `Redux-Thunk` | Para side effects en Redux               |

### Ejemplo: `useEffect`

```jsx
useEffect(() => {
  fetch('/api/data')
    .then(res => res.json())
    .then(setData);
}, []);
```

---

## 7. ¿Cómo configuras lazy loading en React?

### Con `React.lazy` y `Suspense`:

```jsx
import React, { lazy, Suspense } from 'react';

const Profile = lazy(() => import('./Profile'));

function App() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <Profile />
    </Suspense>
  );
}
```

### También puedes aplicar `React.lazy` en rutas (con React Router):

```jsx
const Dashboard = lazy(() => import('./pages/Dashboard'));

<Route path="/dashboard" element={
  <Suspense fallback={<p>Cargando...</p>}>
    <Dashboard />
  </Suspense>
} />
```

---

==========================================================================================================================================

## 🔗 Full Stack / Integración RoR + React

- ¿Cómo conectas un front React con un backend en Rails (API-only)?
- ¿Cómo manejas autenticación JWT entre frontend y backend?
- ¿Cómo estructurarías una app full-stack en monorepo vs repos separados?
- ¿Qué estrategias usas para manejo de errores entre cliente y servidor?

# Full-Stack con React + Rails API

---

## 1. ¿Cómo conectas un front React con un backend en Rails (API-only)?

### Backend (Rails API)
- Generar con:  
  ```bash
  rails new my_api --api
  ```
- Habilitar CORS en `config/initializers/cors.rb`:
  ```ruby
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:3000' # URL del frontend

      resource '*',
        headers: :any,
        methods: %i[get post put patch delete options head],
        credentials: true
    end
  end
  ```
- Crear controladores con `render json:` para devolver datos.

### Frontend (React)
- Usar `fetch` o `axios` para consumir endpoints:
  ```js
  axios.get("http://localhost:3001/posts")
       .then(res => setPosts(res.data))
  ```

- Manejar variables de entorno para las URLs (`REACT_APP_API_URL`).

---

## 2. ¿Cómo manejas autenticación JWT entre frontend y backend?

### Backend (Rails + `devise-jwt` o `knock`)
- Generar el token en login y devolverlo:
  ```json
  { "token": "eyJhbGciOiJIUz..." }
  ```

- Validar el token en cada request usando middleware (`before_action :authenticate_user!`).

### Frontend (React)
- Al hacer login, guardar el token en `localStorage` o `sessionStorage`.
  ```js
  localStorage.setItem('token', res.data.token);
  ```

- Enviar el token en cada petición:
  ```js
  axios.get('/api/user', {
    headers: {
      Authorization: `Bearer ${token}`
    }
  });
  ```

- Para proteger rutas: usar `PrivateRoute`, `useContext`, o estados globales (Redux/Zustand).

---

## 3. ¿Cómo estructurarías una app full-stack en monorepo vs repos separados?

### A. Monorepo

```
/my-app/
│
├── /frontend/       ← React app
├── /backend/        ← Rails API-only
├── package.json     ← compartido (opcional)
└── README.md
```

- Usar herramientas como `TurboRepo`, `Lerna`, `Nx`, o simplemente `Docker`.
- Beneficios:
  - Fácil desarrollo local.
  - Control de versiones sincronizado.
  - Ideal para equipos pequeños/medianos.

### B. Repos separados

- Cada proyecto en su propio repositorio:  
  `frontend-app/` y `rails-api/`

- Beneficios:
  - Despliegue y CI/CD independiente.
  - Escalabilidad con múltiples equipos.
  - Mejor separación de responsabilidades.

### ¿Cuál usar?
- **Monorepo**: desarrollo ágil, MVPs, equipos integrados.
- **Repos separados**: proyectos grandes, equipos distintos, arquitectura orientada a servicios.

---

## 4. ¿Qué estrategias usas para manejo de errores entre cliente y servidor?

### Cliente (React)
- Capturar errores en `try/catch` o `axios.interceptors`.
- Mostrar mensajes de error amigables al usuario.
- Registrar errores con herramientas como `Sentry` o `LogRocket`.

```js
try {
  const res = await axios.get("/api/data");
} catch (err) {
  setError("Hubo un problema al cargar los datos.");
}
```

### Servidor (Rails API)
- Usar `rescue_from` en controladores o `ApplicationController`:
  ```ruby
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { error: "Not Found" }, status: :not_found
  end
  ```

- Establecer mensajes y códigos HTTP correctos:
  - 200 OK
  - 400 Bad Request
  - 401 Unauthorized
  - 422 Unprocessable Entity
  - 500 Internal Server Error

### Estrategias comunes
- Estandarizar la respuesta de errores (`{ error: "mensaje" }`).
- Loggear errores en backend (con `Rails.logger` o `Rollbar`).
- Manejo global de errores en frontend para UX consistente.


==========================================================================================================================================
==========================================================================================================================================
==========================================================================================================================================

## 🧪 Testing y Calidad

- ¿Cómo pruebas tus endpoints en Rails?
- ¿Cómo haces pruebas unitarias y de integración en React (Jest, Testing Library)?
- ¿Cómo automatizas pruebas en el CI/CD pipeline?
# Testing en Full-Stack React + Rails

---

## 1. ¿Cómo pruebas tus endpoints en Rails?

### Usando RSpec + Request Specs

- Las pruebas de endpoints se escriben en `spec/requests/`.

### Ejemplo:

```ruby
# spec/requests/posts_spec.rb
RSpec.describe "Posts API", type: :request do
  describe "GET /posts" do
    it "returns all posts" do
      create_list(:post, 3)
      get "/posts"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end
end
```

### Recomendaciones:
- Usar `FactoryBot` para generar datos.
- Probar status codes, headers y payload JSON.
- Usar `rails_helper` para configuración común.

---

## 2. ¿Cómo haces pruebas unitarias y de integración en React?

### Herramientas comunes:
- **Jest**: framework de testing.
- **React Testing Library**: para pruebas centradas en el usuario.
- **MSW (Mock Service Worker)**: para simular APIs.

### Pruebas unitarias (componente aislado)

```jsx
// Button.test.jsx
import { render, screen } from "@testing-library/react";
import Button from "./Button";

test("renderiza el texto correctamente", () => {
  render(<Button text="Enviar" />);
  expect(screen.getByText("Enviar")).toBeInTheDocument();
});
```

### Pruebas de integración

```jsx
// Form.test.jsx
import { render, screen, fireEvent } from "@testing-library/react";
import Form from "./Form";

test("envía el formulario correctamente", () => {
  render(<Form />);
  fireEvent.change(screen.getByLabelText("Nombre"), {
    target: { value: "Juan" }
  });
  fireEvent.click(screen.getByText("Enviar"));

  expect(screen.getByText("Enviado correctamente")).toBeInTheDocument();
});
```

---

## 3. ¿Cómo automatizas pruebas en el CI/CD pipeline?

### Herramientas comunes:
- **GitHub Actions**
- **GitLab CI**
- **CircleCI**
- **Jenkins**

### Ejemplo: GitHub Actions (React + Rails)

```yaml
# .github/workflows/test.yml
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest

    services:
      postgres:
        image: postgres:13
        ports: ["5432:5432"]
        env:
          POSTGRES_USER: postgres
          POSTGRES_PASSWORD: password

    steps:
    - uses: actions/checkout@v3

    # Backend (Rails)
    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: 3.2
    - run: |
        gem install bundler
        bundle install
        cp config/database.yml.ci config/database.yml
        bundle exec rails db:setup
        bundle exec rspec

    # Frontend (React)
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: 18
    - run: |
        cd frontend
        npm install
        npm test -- --ci --watchAll=false
```

---

## Buenas prácticas
- Ejecutar pruebas en cada PR.
- Separar fases: lint, test, build, deploy.
- Asegurar que la base de datos de test esté aislada.
- Usar coverage tools (`simplecov`, `jest --coverage`).

==========================================================================================================================================
## ☁️ DevOps / Despliegue

- ¿Qué sabes sobre despliegue en Heroku, AWS, Docker, firebase, etc.?
- ¿Has configurado pipelines con GitHub Actions, GitLab CI o Jenkins?
- ¿Cómo manejarías variables de entorno y secretos?

# DevOps y Despliegue en Proyectos Full-Stack

---

## 1. ¿Qué sabes sobre despliegue en Heroku, AWS, Docker, Firebase, etc.?

### 🔹 Heroku
- PaaS muy sencillo para apps Rails, Node, etc.
- Despliegue con un simple `git push heroku main`.
- Usa `Procfile` para especificar procesos (web, worker).
- Fácil integración con PostgreSQL, Redis, Sidekiq.
- Manejo de variables de entorno vía CLI o dashboard.

```bash
heroku config:set RAILS_ENV=production
```

---

### 🔹 AWS (EC2, S3, ECS, RDS, etc.)
- Infraestructura escalable para apps grandes.
- Despliegue manual o automatizado (Elastic Beanstalk, ECS).
- Base de datos con RDS (PostgreSQL, MySQL).
- Archivos estáticos con S3 + CloudFront.
- IAM para gestionar acceso seguro.
- Terraform para infraestructura como código.

---

### 🔹 Docker
- Contenedores para empaquetar app + dependencias.
- Ideal para ambientes consistentes (local, staging, prod).
- Dockerfile para construir imagen, `docker-compose` para orquestar servicios.

```dockerfile
# Dockerfile para Rails
FROM ruby:3.2
WORKDIR /app
COPY . .
RUN bundle install
CMD ["rails", "server", "-b", "0.0.0.0"]
```

```bash
docker build -t my-app .
docker run -p 3000:3000 my-app
```

---

### 🔹 Firebase
- Hosting para apps frontend (React, Vue).
- Realtime Database y Firestore para datos.
- Auth para autenticación.
- Deploy sencillo:

```bash
firebase init
firebase deploy
```

---

## 2. ¿Has configurado pipelines con GitHub Actions, GitLab CI o Jenkins?

###  GitHub Actions
- Automatización CI/CD en `.github/workflows/*.yml`
- Jobs para lint, test, build, deploy.
- Ejemplo: tests en React + Rails
```yaml
name: CI

on: [push]

jobs:
  build-and-test:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - name: Setup Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: 3.2
    - run: bundle install
    - run: bundle exec rspec

    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: 18
    - run: |
        cd frontend
        npm install
        npm test
```

###  GitLab CI
- Pipeline definido en `.gitlab-ci.yml`
- Fases típicas: `install`, `test`, `deploy`

```yaml
stages:
  - test
  - deploy

test:
  script:
    - bundle install
    - bundle exec rspec
```

###Jenkins
- Jobs configurables por UI o con Jenkinsfile.
- Integración con GitHub, Slack, Docker, AWS.

```groovy
pipeline {
  agent any
  stages {
    stage('Test') {
      steps {
        sh 'bundle install && bundle exec rspec'
      }
    }
  }
}
```

---

## 3. ¿Cómo manejarías variables de entorno y secretos?

### 🔐 Estrategias comunes

| Entorno           | Herramienta recomendada                  |
|-------------------|------------------------------------------|
| Local             | `.env` con dotenv (`dotenv-rails`, `dotenv-cli`) |
| Producción (Heroku) | `heroku config:set`                    |
| Producción (Docker) | `docker-compose` con `env_file:`       |
| CI/CD             | Secrets en GitHub/GitLab/Jenkins         |
| AWS               | Secrets Manager o Parameter Store        |

### Ejemplo `.env`

```env
RAILS_ENV=development
DATABASE_URL=postgres://user:pass@localhost/db
SECRET_KEY_BASE=xxxxx
```

### En Rails

```ruby
ENV['SECRET_KEY_BASE']
```

### En React

```js
process.env.REACT_APP_API_URL
```

> Nota: Solo variables que empiezan con `REACT_APP_` estarán disponibles en el cliente.

---

## Recomendaciones

- **Nunca** subir archivos `.env` al repo (`.gitignore`).
- Usar secretos cifrados en CI/CD.
- Revisar permisos de acceso a secretos.
- Usar `dotenv` solo en desarrollo o testing.


==========================================================================================================================================
##  Preguntas de comportamiento

- Cuéntame sobre un bug difícil que resolviste.
- ¿Cómo manejas los conflictos en equipo?
- ¿Cómo estimas y priorizas tareas?
- ¿Has trabajado con metodologías ágiles? ¿Cómo fue tu rol en el equipo?
# Experiencia Profesional – Trabajo en Equipo, Resolución de Problemas y Metodologías

---

## 1. Cuéntame sobre un bug difícil que resolviste

### Caso: Bug intermitente en sistema de pagos

**Contexto**:  
En una plataforma fintech, algunos usuarios reportaban errores aleatorios al procesar pagos con tarjeta. No se reproducía fácilmente en local ni en staging.

**Diagnóstico**:
- Agregué logs detallados en cada paso de la transacción.
- Detecté que el bug ocurría solo bajo carga alta.
- El error venía de un `race condition` en un background job que confirmaba el pago.

**Solución**:
- Refactoricé el código para hacerlo idempotente.
- Agregué un `mutex` para evitar condiciones de carrera.
- Añadí pruebas concurrentes para prevenir regresiones.

**Resultado**:  
El error desapareció, se mejoró la estabilidad y se documentó el caso como lección aprendida para el equipo.

---

## 2. ¿Cómo manejas los conflictos en equipo?

- Escucho activamente el punto de vista de cada persona sin interrumpir.
- Me enfoco en los hechos y no en lo personal.
- Busco consensos basados en objetivos del proyecto y experiencia técnica.
- Si el conflicto persiste, propongo soluciones intermedias o lo elevo al líder técnico.
- Siempre mantengo el respeto, la empatía y la comunicación abierta.

**Ejemplo**:  
Durante una discusión sobre la arquitectura de una nueva funcionalidad, dos miembros proponían enfoques distintos (monolito vs microservicio). Organicé una reunión de 30 minutos para evaluar pros y contras de ambos, priorizando la complejidad técnica, tiempos y escalabilidad. Finalmente, se optó por una solución híbrida.

---

## 3. ¿Cómo estimas y priorizas tareas?

### Estimación:
- Parto de historias de usuario claras (qué, para quién y por qué).
- Divido las tareas grandes en subtareas más manejables.
- Uso técnicas como _Planning Poker_ o _T-shirt sizing_ si estoy en equipo.
- Tomo en cuenta:
  - Complejidad técnica
  - Dependencias
  - Pruebas y validación
  - Posibles riesgos

### Priorización:
- Impacto en el negocio (valor para el usuario)
- Urgencia y dependencias técnicas
- Balance entre features y deuda técnica
- Alineación con objetivos del sprint o roadmap

---

## 4. ¿Has trabajado con metodologías ágiles? ¿Cómo fue tu rol en el equipo?

### Sí, he trabajado con:

- **Scrum**: como desarrollador y ocasionalmente como _tech lead_.
- **Kanban**: para mantenimiento y soporte técnico.

### Rol y actividades:
- Participaba activamente en dailies, retros y planificaciones.
- Refinaba historias de usuario junto al Product Owner.
- Ayudaba a descomponer tareas técnicas y dar estimaciones realistas.
- Coordinaba con QA y diseño para asegurar entregables de calidad.
- En algunos proyectos, lideré la entrega de sprints como referente técnico del equipo.

---

## Herramientas utilizadas:

| Categoría         | Herramientas                              |
|-------------------|-------------------------------------------|
| Gestión ágil      | Jira, Trello, Linear, Notion              |
| Comunicación      | Slack, MS Teams, Zoom                     |
| Control de versiones | Git, GitHub, GitLab, Bitbucket         |
| CI/CD             | GitHub Actions, Jenkins, GitLab CI        |

```


==========================================================================================================================================
para una aplicacion de ruby on rails , sidekid , react js, aws, bash , como describes el deploy detalladamente ???

# Despliegue detallado para una aplicación full-stack: Ruby on Rails + Sidekiq + React + AWS + Bash

Este flujo cubre una app compuesta por:

- **Backend**: Ruby on Rails API-only
- **Job Processing**: Sidekiq (con Redis)
- **Frontend**: React.js
- **Infraestructura**: AWS EC2, RDS, S3
- **Automatización**: Bash scripts + GitHub Actions

---

## 🧱 Estructura del proyecto (monorepo)

```
/my-app/
├── /backend/        # Rails API
├── /frontend/       # React.js SPA
├── /scripts/        # Bash scripts de deploy
├── /docker/         # Dockerfiles y config opcional
└── .github/workflows/
```

---

## 1. 🔧 Pre-requisitos en AWS

| Componente     | Servicio AWS     | Notas                                               |
|----------------|------------------|-----------------------------------------------------|
| Servidor app   | EC2              | Ubuntu con Ruby, Node, PostgreSQL, Redis            |
| Base de datos  | RDS (PostgreSQL) | Aislada, segura, backup automático                  |
| Almacenamiento | S3               | Para assets, imágenes, archivos                     |
| DNS / HTTPS    | Route53 + ACM    | HTTPS con certificado y dominio propio              |

---

## 2. 🚀 Pasos del deploy

### ✅ 1. Build del Frontend (React)

```bash
cd frontend
npm install
npm run build
```

- Genera archivos estáticos en `frontend/build/`
- Pueden ser servidos desde:
  - Un bucket S3 con CloudFront
  - El mismo servidor EC2 (usando Nginx o Rails `public/`)

---

### ✅ 2. Empaquetar assets en el backend

```bash
cd backend
bundle install
RAILS_ENV=production rails assets:precompile
```

- Coloca JS/CSS en `public/assets`
- O configura Rails para usar Webpacker/Vite si es SSR

---

### ✅ 3. Despliegue del backend en EC2 (Rails + Redis + Sidekiq)

**Script Bash de deploy (`scripts/deploy.sh`):**

```bash
#!/bin/bash
ssh ec2-user@your-ec2-ip << 'ENDSSH'
  cd /var/www/my-app/backend

  echo "Pulling latest code..."
  git pull origin main

  echo "Installing dependencies..."
  bundle install --without development test
  yarn install --production

  echo "Migrating DB..."
  RAILS_ENV=production rails db:migrate

  echo "Precompiling assets..."
  RAILS_ENV=production rails assets:precompile

  echo "Restarting services..."
  sudo systemctl restart puma
  sudo systemctl restart sidekiq
ENDSSH
```

- **Puma** se usa como servidor de aplicación.
- **Sidekiq** corre como servicio con Redis.

---

### ✅ 4. Variables de entorno

- Guardadas en `/etc/environment`, `.env`, o usando herramientas como:
  - `dotenv-rails` (solo en desarrollo)
  - `AWS Parameter Store` o `Secrets Manager`
- Accedidas vía `ENV['VAR_NAME']`

---

### ✅ 5. Configuración de servicios

#### `sidekiq.service` (Systemd):

```ini
[Unit]
Description=Sidekiq Background Worker
After=network.target

[Service]
Type=simple
WorkingDirectory=/var/www/my-app/backend
ExecStart=/usr/local/bin/bundle exec sidekiq -e production
User=deploy
Restart=always

[Install]
WantedBy=multi-user.target
```

#### `puma.service`:

```ini
[Service]
ExecStart=/usr/local/bin/puma -C config/puma.rb
Restart=always
```

---

## 3. ☁️ Hosting del frontend (React)

### Opción A: Subir a S3 + CloudFront

```bash
aws s3 sync build/ s3://my-frontend-bucket --delete
```

### Opción B: Servir desde Nginx o Rails

```nginx
server {
  listen 80;
  server_name myapp.com;

  root /var/www/my-app/frontend/build;
  index index.html;

  location / {
    try_files $uri /index.html;
  }
}
```

---

## 4. ⚙️ CI/CD con GitHub Actions (opcional)

```yaml
# .github/workflows/deploy.yml
name: Deploy Fullstack App

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Ejecutar script de deploy
        run: bash ./scripts/deploy.sh
        env:
          SSH_KEY: ${{ secrets.SSH_KEY }}
```

---

## 5. 🛡️ Seguridad y buenas prácticas

- Bloquear puertos abiertos en EC2 (solo 80/443/22)
- Limitar acceso SSH con llaves privadas
- Usar HTTPS (CloudFront o Nginx + Certbot)
- Monitoreo: Sidekiq Web UI, AWS CloudWatch, logs del sistema
- Backups automáticos en RDS
- Validaciones en CI antes del deploy (tests, linters)

---

## ✅ Resumen del flujo

1. Build del frontend (React)
2. Precompilación y migración del backend (Rails)
3. Deploy a EC2 con Sidekiq y Puma
4. React en S3 o servidor web
5. Variables seguras + monitoreo
6. Automatización con Bash o CI/CD

```diff
+ Resultado: Despliegue sólido, reproducible y escalable en AWS
```
Claro, aquí tienes la explicación del despliegue detallado para una aplicación full-stack compuesta por Ruby on Rails (API-only), Sidekiq, React.js, AWS y Bash, en forma de párrafos:

El proceso de despliegue comienza asegurando que tanto el backend como el frontend estén correctamente separados y preparados. Para el frontend en React, primero se instala y se construye el proyecto ejecutando npm install y luego npm run build. Esto genera una carpeta build/ que contiene todos los archivos estáticos listos para producción. Estos archivos pueden ser servidos desde un bucket de Amazon S3 (con CloudFront para CDN y HTTPS), o directamente desde un servidor EC2 utilizando Nginx como servidor web o sirviéndolos desde el directorio public/ de la app Rails si se opta por empaquetarlos juntos.

Por el lado del backend en Ruby on Rails, se realiza la instalación de dependencias con bundle install y se asegura que la base de datos esté migrada correctamente ejecutando rails db:migrate. Luego, se ejecuta rails assets:precompile si se utilizan assets desde Rails. Para automatizar este flujo, se puede crear un script Bash que se conecte por SSH a la instancia EC2, navegue al directorio del proyecto y ejecute los pasos de despliegue (pull de código, instalación de dependencias, migraciones, precompilación de assets y reinicio de servicios). Este script también puede ser utilizado por un pipeline de CI/CD para hacer el deploy automáticamente.

En producción, Sidekiq se utiliza para la ejecución de jobs en segundo plano. Se ejecuta como un servicio del sistema utilizando systemd (sidekiq.service). Este archivo define el directorio de trabajo, el comando a ejecutar (bundle exec sidekiq -e production) y asegura que se reinicie automáticamente en caso de fallos. De igual forma, Puma, que actúa como servidor de aplicaciones Rails, se configura con su propio archivo systemd (puma.service) para ser gestionado como un demonio en la instancia EC2.

En cuanto a la gestión de variables de entorno y secretos, se recomienda no incluirlos en el código fuente. En ambientes locales pueden almacenarse en archivos .env y cargarse con herramientas como dotenv. En producción, se recomienda definirlos directamente en el sistema operativo (/etc/environment), o usar herramientas como AWS Systems Manager Parameter Store o AWS Secrets Manager para gestionarlos de forma segura y escalable.

Para el despliegue del frontend, si se opta por S3 + CloudFront, se pueden sincronizar los archivos del build de React con un bucket de S3 usando el comando aws s3 sync build/ s3://bucket-name --delete. CloudFront se encarga de distribuir esos archivos de forma eficiente a través del mundo y manejar HTTPS usando un certificado SSL de ACM. Si se opta por servir el frontend desde el mismo EC2, se puede configurar Nginx con una regla try_files $uri /index.html para manejar rutas de React adecuadamente.

Finalmente, para lograr una automatización continua, se puede configurar un pipeline en GitHub Actions. Este pipeline puede ejecutar los tests automáticamente en cada push y luego ejecutar el script Bash de despliegue. Para esto se puede usar un workflow .yml que se dispare en la rama main, utilice la clave SSH almacenada en los secrets del repositorio y conecte con el servidor EC2 para ejecutar el despliegue de forma automatizada. Esto asegura consistencia en cada release y facilita el control de calidad.

En resumen, este flujo permite desplegar una aplicación robusta y escalable, con separación clara entre frontend y backend, servicios de background, manejo seguro de secretos, monitoreo de procesos (Sidekiq y Puma), y automatización del flujo con herramientas modernas como GitHub Actions y AWS.



==========================================================================================================================================

conocimientos tecnicos para hacer una api 

# Conocimientos técnicos necesarios para construir una API profesional

Construir una API robusta y escalable requiere dominar diversos aspectos técnicos, desde fundamentos del protocolo HTTP hasta seguridad, diseño RESTful y herramientas de despliegue. A continuación, se presenta una lista organizada por categorías:

---

## 1. 🌐 Fundamentos Web

- **HTTP/HTTPS**: métodos (`GET`, `POST`, `PUT`, `PATCH`, `DELETE`), códigos de estado (`200`, `201`, `400`, `401`, `422`, `500`).
- **RESTful API Design**: recursos, rutas, verbos, respuesta en JSON, convención de URLs.
- **JSON**: estructura, parseo y serialización.
- **CORS**: manejo de solicitudes entre dominios.
- **Status codes & headers**: uso adecuado y semántico.

---

## 2. 💎 Backend (Ruby on Rails API)

- Generar apps Rails con `--api` flag.
- **Routing con `resources`** y rutas anidadas.
- **Controladores** que respondan con `render json:`.
- **Active Record** para CRUD y relaciones.
- **Serialización** de objetos (con `as_json`, `ActiveModel::Serializer`, `JBuilder`, etc.).
- **Validaciones y manejo de errores** (`rescue_from`, `422 Unprocessable Entity`).
- **Autenticación** (JWT, Devise Token Auth, Knock, etc.).
- **Autorización** (Pundit o CanCanCan).

---

## 3. 🔐 Seguridad

- Validación de entradas del usuario.
- Protección contra ataques:
  - CSRF (si aplica)
  - XSS
  - SQL Injection
- Autenticación con tokens (JWT).
- HTTPS obligatorio en producción.
- Tasa de peticiones (`rate limiting`) y control de acceso.

---

## 4. 🧪 Testing

- Pruebas unitarias y de request con **RSpec**.
- Uso de **FactoryBot** para generar datos de prueba.
- Validación de respuestas, status y estructura JSON.
- Test de edge cases y errores esperados.
- Test de autenticación y permisos.

---

## 5. 🧰 Herramientas y utilidades

- **Postman**, **Insomnia** o **curl** para probar endpoints.
- **Rack::Cors** para habilitar CORS.
- **dotenv-rails** para manejo de variables en desarrollo.
- **Database Cleaner**, **Shoulda Matchers** en entorno de test.
- **Swagger/OpenAPI** para documentar la API.

---

## 6. 🐳 DevOps y Deploy

- Configuración para despliegue en **Heroku**, **AWS EC2**, o **Docker**.
- Uso de **dotenv** para variables de entorno.
- Automatización con **GitHub Actions**, **Jenkins**, o **GitLab CI**.
- Separación de entornos (desarrollo, test, producción).
- Logs y monitoreo básico (Rollbar, Sentry, Lograge).

---

## 7. ⚙️ Buenas prácticas

- Estructura RESTful coherente (`/users`, `/users/:id/posts`).
- Evitar respuestas ambiguas, mantener consistencia en errores.
- Documentar con ejemplos reales.
- Versionar la API (`/api/v1/...`).
- Paginación, ordenamiento y filtros en endpoints (por ejemplo con `kaminari` o `pagy`).
- Uso adecuado de status codes y mensajes claros.
- Separación de lógica en **Service Objects** y **Concerns**.

---

## 8. 📄 Documentación

- Escribir y mantener una especificación OpenAPI (Swagger).
- Documentar cada endpoint con:
  - Método (GET/POST/etc.)
  - Ruta
  - Parámetros esperados
  - Respuestas posibles
- Exponer documentación vía `/docs` o Postman Collection exportable.

---

## 📌 Stack recomendado para API con Ruby on Rails

| Componente        | Herramienta sugerida       |
|-------------------|----------------------------|
| Framework         | Ruby on Rails (`--api`)    |
| Autenticación     | JWT con `devise-jwt`       |
| Serialización     | `ActiveModel::Serializer`  |
| Paginación        | `Pagy`                     |
| Test              | RSpec + FactoryBot         |
| Seguridad         | Rack::Attack + CORS config |
| CI/CD             | GitHub Actions             |
| Documentación     | Swagger (rswag)            |

---
```



==========================================================================================================================================
# ✅ Buenas prácticas para construir una API robusta y escalable

Desarrollar una API profesional implica más que solo exponer endpoints; requiere aplicar principios de diseño, seguridad, rendimiento y mantenibilidad. A continuación, se listan las buenas prácticas clave para lograrlo:

---

## 1. 🌐 Diseño de API

- **Sigue principios RESTful**: usa recursos (`/users`, `/posts/:id`), verbos HTTP (`GET`, `POST`, etc.) y respuestas semánticas.
- **Versiona tu API**: incluye una versión en la ruta (`/api/v1/...`) o en los headers.
- **Nombra recursos en plural**: por convención (`/users` en lugar de `/user`).
- **Evita acciones en rutas**: no uses `/getUsers`, usa `GET /users`.

---

## 2. 📦 Organización del código

- **Usa Service Objects**: extrae lógica de negocio compleja fuera de los controladores.
- **Concerns y Helpers**: reutiliza lógica común sin duplicar código.
- **Separación de responsabilidades**: mantén los modelos delgados y los controladores enfocados.

---

## 3. 🛡️ Seguridad

- **Valida todos los datos de entrada**: nunca confíes en el cliente.
- **Autenticación robusta**: usa JWT o token-based auth (Devise, OAuth).
- **Protege contra ataques comunes**:
  - SQL Injection (con Active Record)
  - CSRF (si aplica)
  - XSS (escapado de salida)
- **Implementa rate limiting**: evita abusos con herramientas como `rack-attack`.
- **Siempre usa HTTPS**: protege la comunicación entre cliente y servidor.

---

## 4. 🔄 Manejo de errores

- **Devuelve errores claros y consistentes**:
  ```json
  {
    "error": "Email is invalid"
  }
  ```
- **Usa códigos HTTP apropiados**:
  - `200 OK`
  - `201 Created`
  - `400 Bad Request`
  - `401 Unauthorized`
  - `404 Not Found`
  - `422 Unprocessable Entity`
  - `500 Internal Server Error`
- **Loguea los errores del servidor**: usa `Rails.logger` o herramientas como Rollbar/Sentry.

---

## 5. 🧪 Testing

- **Pruebas automatizadas para endpoints**: usa RSpec o Minitest para `request specs`.
- **Test de errores y edge cases**: simula entradas inválidas, usuarios no autenticados, etc.
- **Mocks para APIs externas**: evita dependencias reales en tests.

---

## 6. 📊 Escalabilidad y rendimiento

- **Paginación de resultados**: evita respuestas con miles de registros (usando `kaminari`, `pagy`).
- **Evita el problema N+1**: usa `includes(:relation)` con Active Record.
- **Respuestas ligeras**: retorna solo los campos necesarios.
- **Caching**: utiliza fragment caching o HTTP caching si aplica.

---

## 7. 📑 Documentación

- **Documenta todos los endpoints**: inputs, outputs, errores posibles.
- **OpenAPI/Swagger**: genera documentación legible y exportable automáticamente (con `rswag`).
- **Mantén la documentación actualizada**: hazlo parte del proceso de desarrollo.

---

## 8. 📁 Serialización

- **Usa serializers**: como `ActiveModel::Serializer`, `Fast JSONAPI`, `JBuilder` o `Blueprinter`.
- **Evita exponer datos sensibles**: como contraseñas o tokens por error.
- **Estandariza la forma de tus respuestas JSON**.

---

## 9. ⚙️ Mantenibilidad

- **Configura linters y formateadores**: `rubocop`, `standard`, etc.
- **Escribe código limpio y modular**: fácil de entender y mantener.
- **Sigue convenciones de estilo de Rails y REST**.

---

## 10. 🚀 Despliegue y monitoreo

- **Usa entornos separados**: desarrollo, test, staging, producción.
- **Monitorea errores y logs**: con Sentry, Lograge, NewRelic o similares.
- **Automatiza deploy y tests**: con GitHub Actions, GitLab CI o Jenkins.
- **Maneja variables de entorno y secretos** con seguridad (dotenv, AWS Parameter Store).

---

## 📌 Bonus: Checklist de calidad para una API

- [x] Autenticación segura
- [x] Validaciones en todos los endpoints
- [x] Manejo adecuado de errores
- [x] Paginación en endpoints listables
- [x] Pruebas automatizadas
- [x] Documentación accesible y actualizada
- [x] Código modular y bien estructurado
- [x] Respuestas rápidas y eficientes

---
```

==========================================================================================================================================
==========================================================================================================================================