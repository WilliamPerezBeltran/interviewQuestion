# Sesión completa — Preguntas y Respuestas

Transcripción completa de todas las preguntas y respuestas dadas en esta terminal (sesión de estudio de Python, Django, bases de datos, testing, patrones de diseño, DevOps/Kubernetes, AWS y metodologías ágiles).

---

## 1. ¿Qué significa y para qué sirve `a |= b` en Python?

Es el operador de asignación aumentada para el OR. Equivale conceptualmente a `a = a | b`, pero con una diferencia importante: si `a` es un objeto mutable que implementa `__ior__`, la operación se hace **in-place** (modifica el objeto existente) en lugar de crear uno nuevo.

Su significado exacto depende del tipo de dato:

**1. Enteros (`int`) — OR bit a bit**
```python
a = 0b1010   # 10
b = 0b0110   # 6
a |= b       # a = a | b -> compara bit a bit, 1 si al menos uno es 1
print(a)     # 0b1110 -> 14
```
Aquí no hay mutación real (los `int` son inmutables): `a |= b` simplemente reasigna `a` a un nuevo entero.

**2. Booleanos (`bool`)**
Como `bool` es subclase de `int`, `|=` actúa como un **OR lógico**:
```python
a = True
b = False
a |= b   # True
```

**3. Sets — unión in-place**
```python
a = {1, 2, 3}
b = {3, 4, 5}
a |= b
print(a)   # {1, 2, 3, 4, 5}
```
Es equivalente a `a.update(b)`, y a diferencia de `a = a | b`, no crea un set nuevo: modifica el objeto `a` original.

**4. Diccionarios (Python 3.9+) — merge in-place**
```python
a = {"x": 1, "y": 2}
b = {"y": 20, "z": 3}
a |= b
print(a)   # {'x': 1, 'y': 20, 'z': 3}
```
Equivale a `a.update(b)`: las claves de `b` sobrescriben las de `a` si coinciden.

**Idea clave:** `a | b` siempre crea un objeto nuevo. `a |= b` si el tipo define `__ior__` (sets, dicts, etc.), muta el objeto original; si no lo define (como `int`), cae al comportamiento de `a = a | b`.

---

## 2. ¿Qué significa y para qué sirve `a |= b` en Python? (repetida, respondida en formato entrevista)

Sí, esa es el operador de asignación aumentada para el OR. Básicamente `a |= b` es lo mismo que decir `a = a | b`, pero con un matiz importante: si `a` es un objeto mutable que sabe manejar esa operación in-place —como un set o un dict— Python no crea un objeto nuevo, sino que modifica el mismo objeto que ya tenía.

Depende mucho del tipo con el que esté trabajando. Si `a` y `b` son enteros, es un OR bit a bit: compara cada bit y el resultado tiene un 1 donde al menos uno de los dos tenía un 1. Por ejemplo, `a = 0b1010; a |= 0b0110` me da `0b1110`.

Si estoy trabajando con booleanos, como `bool` hereda de `int`, en la práctica se comporta como un OR lógico.

Donde más lo uso yo en el día a día es con sets y con diccionarios. Con sets, `a |= b` es equivalente a `a.update(b)`: hace la unión y la aplica directamente sobre `a`, sin crear un set nuevo. Y desde Python 3.9, funciona igual con diccionarios: `a |= b` mezcla las claves de `b` dentro de `a`, sobrescribiendo las que coincidan.

La idea clave que suelo remarcar es esa diferencia entre `a | b`, que siempre te devuelve algo nuevo, y `a |= b`, que si el tipo lo permite modifica el objeto original en memoria. Eso importa sobre todo si tenés otras variables apuntando al mismo objeto, porque ahí sí vas a ver el cambio reflejado en todos lados.

---

## 3. ¿Qué significa y para qué sirve `a |= b` en Python? (versión corta, formato entrevista real)

`a |= b` es la asignación aumentada del OR: es como decir `a = a | b`, pero si `a` es mutable —un set o un dict— lo modifica in-place en vez de crear uno nuevo. Con enteros hace OR bit a bit, con sets hace unión, y con dicts (desde 3.9) hace merge sobrescribiendo claves repetidas.

---

## 4. Pregunta 2: ¿Qué es `struct` en Python y para qué se utiliza?

`struct` es un módulo de la librería estándar de Python que me sirve para convertir entre datos de Python (enteros, floats, strings) y su representación en bytes, siguiendo un formato binario específico. Básicamente lo uso cuando necesito empaquetar o desempaquetar datos binarios: por ejemplo si estoy leyendo un archivo binario, trabajando con protocolos de red a bajo nivel, o interactuando con código en C.

Las dos funciones que más uso son `struct.pack()` y `struct.unpack()`. Con `pack` le doy un formato y unos valores, y me devuelve los bytes correspondientes; con `unpack` hago lo inverso, le doy bytes y un formato, y me devuelve los valores de Python.

```python
import struct

datos = struct.pack('>ii', 10, 20)   # empaqueta dos enteros en formato big-endian
valores = struct.unpack('>ii', datos)  # (10, 20)
```

El formato (`'>ii'` en el ejemplo) me indica el orden de bytes —big-endian o little-endian— y el tipo de cada campo: `i` para entero, `f` para float, `s` para string, etc.

Algo importante: no hay que confundirlo con `dataclasses` o `collections.namedtuple`, que son para crear estructuras de datos tipo "struct" en el sentido de agrupar campos con nombre; `struct` acá es específicamente para serialización binaria.

---

## 5. Pregunta 3: ¿Qué es *operator overloading* en Python y cómo se aplica en clases?

*Operator overloading* es redefinir cómo se comportan los operadores estándar (`+`, `==`, `<`, etc.) para mis propias clases, implementando los métodos mágicos correspondientes: `__add__` para `+`, `__eq__` para `==`, `__lt__` para `<`, y así. Por ejemplo, si tengo una clase `Vector`, puedo definir `__add__` para que `v1 + v2` sume las componentes en vez de tirar error. Lo uso para que objetos propios se comporten de forma intuitiva con la sintaxis nativa del lenguaje, en vez de forzar a llamar métodos tipo `v1.sumar(v2)`.

---

## 6. Pregunta 4: ¿Qué hace `getattr` en Python y cómo se usa para invocar métodos dinámicamente?

`getattr` me permite obtener un atributo o método de un objeto pasando su nombre como string, en vez de acceder con la sintaxis de punto directamente. La firma es `getattr(objeto, "nombre", default)`, donde el `default` es opcional y evita que explote con `AttributeError` si el atributo no existe. Lo uso típicamente para invocar métodos dinámicamente: por ejemplo `metodo = getattr(obj, "procesar"); metodo()`, útil cuando el nombre del método viene de una variable, un archivo de configuración, o un dispatcher tipo `if/elif` que quiero evitar.

---

## 7. Explícame más la 4 (getattr) — profundización

Dale, profundizo un poco más.

`getattr(objeto, nombre, default)` tiene tres partes: el objeto, el nombre del atributo como string, y un valor por defecto opcional. Si no le paso el default y el atributo no existe, me tira `AttributeError`; si sí lo paso, en vez de explotar me devuelve ese default. Esa es una diferencia importante frente a hacer `objeto.nombre` directo, que siempre explota si no existe.

Un patrón muy común es combinarlo con `hasattr` para chequear antes, aunque en la práctica muchas veces es más limpio ir directo con el default: `metodo = getattr(obj, "procesar", None)` y después `if metodo: metodo()`, en vez de hacer dos lookups (`hasattr` + `getattr`).

Donde más lo he usado en proyectos reales es para dispatch dinámico: en vez de un `if/elif` gigante decidiendo qué método llamar según un string —por ejemplo el nombre de una acción que viene de una API o de un evento—, hago algo como:

```python
accion = "crear_usuario"
handler = getattr(self, f"handle_{accion}", self.handle_default)
handler(payload)
```

Eso es básicamente el patrón que usan frameworks tipo Django para resolver qué view method llamar, o herramientas de CLI para mapear subcomandos a funciones.

También vale mencionar la contraparte: `setattr(obj, nombre, valor)` para asignar dinámicamente, y `delattr` para borrar. Y a nivel de clase existe el método mágico `__getattr__`, que es distinto: ese lo definís vos dentro de la clase y Python lo llama automáticamente solo cuando el atributo NO se encuentra por los medios normales — es el gancho que usan librerías tipo ORMs para resolver atributos "mágicos" que no existen físicamente en el objeto.

Un gotcha que suelen preguntar en entrevista: `getattr` con nombres que vienen de input de usuario es un vector de riesgo si no lo controlás, porque le podrías dar acceso a atributos internos que no deberías exponer.

---

## 8. "¿Entonces el getattr me permite definir un atributo o método de un objeto pasándolo como string?" — corrección

Casi, pero ojo con el verbo: `getattr` no **define** el atributo, lo **obtiene** (get, no set). O sea, te permite acceder/leer un atributo o método ya existente en el objeto, pasando su nombre como string en vez de usar la sintaxis de punto.

Si lo que querés es **definir/asignar** un atributo dinámicamente, ese es `setattr(obj, "nombre", valor)` — ese sí "crea" o sobrescribe el atributo.

Entonces la pareja correcta sería:
- `getattr(obj, "nombre")` → leer
- `setattr(obj, "nombre", valor)` → escribir/definir

---

## 9. "¿Pero qué es una clase, un método, una variable, qué es?"

Buena pregunta, aclaro los términos porque se pisan.

Una **clase** es el molde: define qué atributos y métodos va a tener un objeto, pero no es el objeto en sí. Ejemplo: `class Perro:`.

Un **objeto** (o instancia) es lo que se crea a partir de esa clase: `mi_perro = Perro()`. Ahí `mi_perro` ya es algo concreto en memoria.

Una **variable** dentro de una clase, cuando pertenece a un objeto, se llama **atributo** (`mi_perro.nombre = "Rex"` — `nombre` es un atributo de instancia). Si es una variable normal suelta en tu código, sin estar colgada de un objeto, es simplemente una variable.

Un **método** es básicamente una función, pero definida dentro de una clase y que recibe `self` como primer parámetro, porque opera sobre los datos de esa instancia (`def ladrar(self): return "Guau"`).

Entonces, volviendo a `getattr(obj, "nombre")`: el `"nombre"` que le pasás como string puede ser el nombre de un **atributo** (una variable colgada del objeto, como `nombre` o `edad`) o el nombre de un **método** (una función colgada del objeto, como `ladrar`). `getattr` no distingue entre los dos — simplemente te devuelve lo que sea que esté guardado bajo ese nombre en el objeto. Si es un atributo, te devuelve el valor directo; si es un método, te devuelve la función (que después tenés que llamar con `()` para ejecutarla).

---

## 10. Pregunta 5: Explique cómo funcionan las rutas (*urls*) en Django y cómo se configuran.

(Primera versión)

En Django las rutas se definen en un archivo `urls.py`, donde tenés una lista llamada `urlpatterns` con entradas `path()` (o `re_path()` para regex). Cada entrada mapea una URL a una vista: `path("productos/<int:id>/", views.detalle_producto)`. Los `<int:id>` son *path converters*, capturan parte de la URL y se la pasan como argumento a la vista.

El proyecto tiene un `urls.py` raíz, y normalmente cada app tiene el suyo propio, que se conecta al principal con `include()`, así se mantiene todo modular en vez de un solo archivo gigante. Cuando llega un request, Django recorre `urlpatterns` en orden y usa la primera que matchea.

---

## 11. "Dame un dibujo nada fancy ni SVG con un mapa para saber las rutas de Django, cómo es el flujo"

```
Request entra:  GET /productos/42/

navegador ──▶ urls.py (raíz del proyecto)
                 │
                 │  urlpatterns = [
                 │      path("admin/", admin.site.urls),
                 │      path("productos/", include("productos.urls")),   ◀── matchea el prefijo "productos/"
                 │      path("usuarios/", include("usuarios.urls")),
                 │  ]
                 │
                 ▼
        productos/urls.py (de la app)
                 │
                 │  urlpatterns = [
                 │      path("<int:id>/", views.detalle_producto),   ◀── matchea "42/" y captura id=42
                 │  ]
                 │
                 ▼
        views.py
                 │
                 │  def detalle_producto(request, id):
                 │      ...  ◀── acá recibe id=42, hace su lógica
                 │      return HttpResponse(...)
                 │
                 ▼
        Respuesta al navegador
```

(Nota original: esta explicación usaba lenguaje con voseo argentino, que luego fue corregido a español neutro — ver entrada 13.)

---

## 12. Corrección de estilo: "nada de tenés, nada de ese lenguaje, hablá neutral"

Se corrigió el estilo de respuesta: de ahí en adelante, español neutro (sin voseo argentino como "vos", "tenés", "acá"), y se agregó una sección de "Communication style" al `CLAUDE.md` del proyecto con esta regla.

---

## 13. Pregunta 5 (repetida): "Vuelve a responderme más entendible la 5" — en español neutro

En Django, cada URL que un usuario visita tiene que estar conectada a una función (llamada "vista") que decide qué responder. Esa conexión se define en un archivo llamado `urls.py`.

Ahí hay una lista llamada `urlpatterns`, donde cada elemento dice: "esta URL va a esta vista". Por ejemplo:

```python
urlpatterns = [
    path("productos/", vista_lista_productos),
    path("productos/<int:id>/", vista_detalle_producto),
]
```

Cuando alguien visita `/productos/42/`, Django recorre la lista de arriba hacia abajo, encuentra la entrada que coincide, extrae el número `42` como parámetro `id`, y llama a `vista_detalle_producto` pasándole ese valor.

Como un proyecto puede tener muchas partes (productos, usuarios, pagos, etc.), normalmente cada app tiene su propio `urls.py`, y el archivo principal del proyecto los conecta todos usando `include()`. Así el código queda ordenado en vez de tener una sola lista enorme con todas las rutas mezcladas.

En resumen: `urls.py` es como un mapa que le dice a Django "si llega esta dirección, ejecuta esta función".

---

## 14. Pregunta 6: Describa los métodos `get()`, `filter()` y `all()` de Django ORM.

Los tres se usan sobre un modelo para consultar la base de datos, pero cada uno devuelve algo distinto.

`all()` devuelve todos los registros de la tabla, en forma de un QuerySet (una lista de objetos). Ejemplo: `Producto.objects.all()`.

`filter()` también devuelve un QuerySet, pero solo con los registros que cumplen una condición. Ejemplo: `Producto.objects.filter(precio__gt=100)` trae los productos con precio mayor a 100. Si nada coincide, devuelve un QuerySet vacío, no da error.

`get()` devuelve un único objeto, no una lista, y se usa cuando se espera exactamente un resultado. Ejemplo: `Producto.objects.get(id=5)`. Si no encuentra ninguno lanza `DoesNotExist`, y si encuentra más de uno lanza `MultipleObjectsReturned`. Por eso `get()` normalmente se usa con un campo único, como el `id`.

---

## 15. Pregunta 7: ¿Qué son los *template tags* y *filters* en Django y para qué sirven?

Son herramientas que se usan dentro de los templates HTML de Django para agregar lógica o formatear datos sin escribir Python puro mezclado con el HTML.

Los **filters** transforman el valor de una variable al mostrarla, se aplican con el símbolo `|`. Por ejemplo `{{ nombre|upper }}` convierte el texto a mayúsculas, o `{{ fecha|date:"d/m/Y" }}` formatea una fecha.

Los **template tags** son más potentes, permiten estructuras de control como condicionales y bucles, se escriben entre `{% %}`. Por ejemplo `{% for producto in productos %}...{% endfor %}` o `{% if usuario.autenticado %}...{% endif %}`.

La idea general es mantener el template enfocado en presentación, con una lógica mínima y legible, en vez de meter código Python complejo directamente en el HTML.

---

## 16. Pregunta 8: ¿Qué es la paginación de APIs en Django Rest Framework y cómo se implementa?

Es dividir los resultados de una API en páginas más pequeñas, en vez de devolver todos los registros de una sola vez. Esto es importante cuando hay muchos datos, porque evita respuestas pesadas y lentas.

En Django Rest Framework se configura con clases de paginación ya incluidas, como `PageNumberPagination` (páginas numeradas, tipo `?page=2`), `LimitOffsetPagination` (con parámetros `limit` y `offset`), o `CursorPagination` (usa un cursor en vez de números de página, más seguro para datos que cambian constantemente).

Se puede activar de forma global en el `settings.py` del proyecto, con algo como:

```python
REST_FRAMEWORK = {
    "DEFAULT_PAGINATION_CLASS": "rest_framework.pagination.PageNumberPagination",
    "PAGE_SIZE": 10,
}
```

O también se puede definir por vista específica, asignando la clase de paginación directamente en el `ViewSet` o `APIView`. La respuesta paginada normalmente incluye la lista de resultados junto con enlaces a la página siguiente y anterior, y el total de registros.

---

## 17. Pregunta 9: ¿Qué es el estándar RFC 8288 y cómo se relaciona con Django o APIs REST?

El RFC 8288 es un estándar que define el formato del header HTTP `Link`, usado para indicar relaciones entre recursos dentro de una respuesta HTTP. Por ejemplo, se usa para enlazar la página siguiente o anterior en una API paginada, algo como:

```
Link: <https://api.ejemplo.com/productos?page=2>; rel="next",
      <https://api.ejemplo.com/productos?page=1>; rel="prev"
```

Se relaciona con Django y con APIs REST porque es una forma estandarizada de comunicar paginación o navegación entre recursos sin necesidad de meter esa información dentro del cuerpo de la respuesta JSON. Django Rest Framework, por ejemplo, lo puede usar en ciertas configuraciones de paginación, aunque lo más común en DRF es incluir los enlaces `next` y `previous` directamente en el JSON de respuesta en vez de en el header `Link`. De todas formas, es un concepto que suele salir en entrevistas relacionado a diseño de APIs REST bien hechas, ya que es parte de los principios HATEOAS (que los recursos se puedan descubrir siguiendo enlaces).

---

## 18. Pregunta 10: ¿Qué es el módulo `numbers` en Python y cómo se utiliza en Django?

`numbers` es un módulo de la librería estándar de Python que define una jerarquía abstracta de tipos numéricos: `Number`, y debajo de esa clases como `Complex`, `Real`, `Rational` e `Integral`. No sirve para hacer cálculos, sino para verificar tipos de forma más flexible que comparar contra `int` o `float` directamente.

Por ejemplo, en vez de escribir `isinstance(valor, (int, float))`, se puede escribir `isinstance(valor, numbers.Number)`, y eso cubre también otros tipos numéricos como `Decimal` o `Fraction` que no son ni `int` ni `float` pero sí son números.

En cuanto a Django específicamente, no es un módulo que Django use de forma especial ni tenga integración directa; su utilidad ahí sería la misma que en cualquier código Python: por ejemplo, para validar de forma genérica que un campo o parámetro recibido es numérico antes de procesarlo, en lugar de restringir la validación a un tipo numérico particular.

---

## 19. Pregunta 11: ¿Qué es Django Channels y cómo permite manejar *WebSockets*?

Django por sí solo trabaja con el protocolo HTTP tradicional: petición y respuesta, sin mantener la conexión abierta. Django Channels es una extensión que agrega soporte para protocolos que sí necesitan una conexión persistente, como WebSockets, además de manejar tareas en segundo plano y HTTP de larga duración.

Funciona reemplazando el servidor WSGI tradicional por uno ASGI, que sí soporta comunicación asíncrona y bidireccional. Con Channels se definen "consumers", que son el equivalente a las vistas pero para conexiones en tiempo real: en vez de recibir un request y devolver un response, un consumer recibe eventos de conexión, mensajes y desconexión, y puede enviar mensajes de vuelta al cliente en cualquier momento.

Las rutas para estos consumers se configuran de forma similar a `urls.py`, pero en un archivo de "routing", separando las rutas HTTP normales de las rutas WebSocket. Un caso típico de uso es un chat en tiempo real o notificaciones push: el cliente abre una conexión WebSocket, y el servidor puede enviarle datos nuevos sin que el cliente tenga que estar pidiéndolos constantemente.

---

## 20. "¿Qué es un WebSocket?"

Es un protocolo de comunicación que permite abrir una conexión entre el cliente (por ejemplo el navegador) y el servidor, y mantenerla abierta todo el tiempo que haga falta, en vez de cerrarla después de cada petición como pasa con HTTP normal.

La diferencia clave con HTTP tradicional es esta: en HTTP, el cliente siempre tiene que pedir algo primero (petición y respuesta, y se cierra). Con WebSocket, una vez que la conexión se abre, tanto el cliente como el servidor pueden enviar mensajes en cualquier momento, sin esperar a que el otro pregunte. Por eso se dice que es bidireccional y en tiempo real.

Un ejemplo típico: un chat. Con HTTP normal, el navegador tendría que estar preguntando cada dos segundos "¿hay mensajes nuevos?" (eso se llama polling). Con WebSocket, el servidor simplemente le manda el mensaje al cliente apenas llega, sin que el cliente tenga que preguntar nada.

La conexión se inicia como una petición HTTP normal, pero con un header especial que le pide al servidor "cambiemos de protocolo" (esto se llama *handshake*), y si el servidor acepta, esa misma conexión queda abierta usando el protocolo WebSocket en vez de HTTP.

Casos de uso comunes: chats, notificaciones en vivo, juegos multijugador, dashboards que se actualizan solos, cotizaciones de bolsa en tiempo real.

---

## 21. Pregunta 12: ¿Qué son los *background jobs* en Django y cómo se implementan con *Celery* o *Django Q*?

Son tareas que se ejecutan por fuera del ciclo normal de petición-respuesta, para que el usuario no tenga que esperar a que terminen. Por ejemplo, enviar un email, generar un reporte pesado, o procesar una imagen: si eso se hiciera dentro de la misma vista, el usuario quedaría esperando varios segundos hasta que la página responda. Con un background job, la vista responde de inmediato y la tarea se procesa aparte.

**Celery** es la opción más usada. Funciona con un "broker" de mensajes, normalmente Redis o RabbitMQ, que actúa de intermediario. La aplicación Django encola una tarea, el broker la guarda, y uno o varios "workers" (procesos separados de Celery) van tomando tareas de la cola y ejecutándolas. Se define una tarea así:

```python
@shared_task
def enviar_email(usuario_id):
    ...
```

Y se llama desde la vista con `enviar_email.delay(usuario_id)`, que la encola en vez de ejecutarla al instante.

**Django Q** es una alternativa más simple, pensada para no depender de un broker externo tan complejo: puede usar la misma base de datos de Django como broker, lo que facilita el setup para proyectos más chicos. La forma de usarlo es parecida: se encola una función para que se ejecute después, y un proceso worker aparte la va procesando.

La diferencia principal entre ambos es que Celery es más robusto y escalable para proyectos grandes, mientras que Django Q es más liviano y rápido de configurar cuando no se necesita tanta infraestructura.

---

## 22. Pregunta 13: Explique cómo se definen las rutas en Django (`urls.py`) y cómo se enlazan a *views*.

Las rutas se definen en un archivo `urls.py`, dentro de una lista llamada `urlpatterns`. Cada elemento de esa lista usa la función `path()` (o `re_path()` si se necesita una expresión regular) y recibe dos cosas principales: el patrón de la URL, y la vista que debe ejecutarse cuando esa URL coincide.

```python
from django.urls import path
from . import views

urlpatterns = [
    path("productos/", views.lista_productos),
    path("productos/<int:id>/", views.detalle_producto, name="detalle_producto"),
]
```

El enlace con la vista es directo: se pasa la función (o clase, si es una vista basada en clases) como segundo argumento de `path()`. Cuando la URL coincide, Django llama a esa función pasándole el objeto `request` y cualquier parámetro capturado en la URL, como el `id` en el ejemplo.

También se puede agregar un `name` a la ruta, que sirve para referenciarla en otras partes del código (templates, redirects) sin tener que escribir la URL a mano, usando `reverse("detalle_producto", args=[5])` o `{% url "detalle_producto" 5 %}` en un template.

Y como ya vimos en la pregunta 5, cuando el proyecto tiene varias apps, cada una suele tener su propio `urls.py`, y se conectan todos desde el `urls.py` principal usando `include()`.

---

## 23. Pregunta 14: ¿Qué son sesiones y cookies en Django y cómo se manejan?

Las **cookies** son pequeños datos que el servidor le pide al navegador que guarde, y que el navegador vuelve a enviar en cada petición posterior a ese mismo sitio. Sirven para que el servidor pueda "reconocer" al mismo cliente entre distintas peticiones, ya que HTTP por sí solo no guarda memoria de quién hizo la petición anterior.

Las **sesiones** son un mecanismo construido sobre las cookies para guardar información del lado del servidor de forma segura. En vez de guardar datos sensibles directamente en la cookie del navegador, Django guarda esos datos en el servidor (por defecto en la base de datos, en una tabla de sesiones), y en la cookie del navegador solo pone un identificador único de esa sesión, algo como `sessionid`.

En Django esto viene activado por defecto a través del middleware de sesiones. Para usarlo, dentro de una vista se accede así:

```python
def mi_vista(request):
    request.session["usuario_id"] = 5   # guardar
    valor = request.session.get("usuario_id")   # leer
```

Django se encarga automáticamente de crear la cookie `sessionid`, guardar los datos en el backend configurado (base de datos, caché, o archivos), y asociar cada request con su sesión correspondiente. Esto es lo que permite, por ejemplo, mantener a un usuario logueado entre distintas páginas sin que tenga que autenticarse en cada petición.

---

## 24. "Las cookies se guardan en el navegador, ¿cierto?"

Sí, exacto. La cookie en sí siempre se guarda en el navegador del cliente, eso no cambia.

Lo que sí varía es qué contiene esa cookie:

- Con sesiones normales (`db`, `cache`), la cookie solo guarda un identificador (`sessionid`), un string sin datos reales. Los datos verdaderos —como el `usuario_id`— están guardados del lado del servidor, no en el navegador.
- Con `signed_cookies`, ahí sí los datos reales van dentro de la cookie, pero firmados criptográficamente para que el navegador no pueda modificarlos sin que Django lo detecte.

Entonces la cookie vive en el navegador en ambos casos, la diferencia es si lo que contiene es solo una referencia (lo más común y más seguro) o los datos completos.

---

## 25. "¿Y las sesiones se guardan del lado del servidor?"

Sí, correcto. Las sesiones se guardan del lado del servidor (por defecto en la base de datos), y lo único que viaja al navegador es la cookie `sessionid` con el identificador de esa sesión. En cada petición, Django toma ese identificador de la cookie, busca los datos correspondientes en el servidor, y los pone disponibles en `request.session`.

---

## 26. Pregunta 15: Explique la implementación de sesiones y cookies en Django.

Esta pregunta es prácticamente la misma que la 14, pero enfocada más en la parte de configuración concreta.

La implementación se controla desde `settings.py`. Ahí se define, entre otras cosas, dónde se guardan los datos de la sesión con `SESSION_ENGINE`. Las opciones más comunes son:

```python
SESSION_ENGINE = "django.contrib.sessions.backends.db"      # en base de datos (default)
SESSION_ENGINE = "django.contrib.sessions.backends.cache"   # en caché, más rápido
SESSION_ENGINE = "django.contrib.sessions.backends.signed_cookies"  # todo en la cookie, firmado
```

Para que funcione, `django.contrib.sessions` tiene que estar en `INSTALLED_APPS`, y el middleware `SessionMiddleware` en `MIDDLEWARE`, que es el que lee la cookie `sessionid` en cada request y carga los datos correspondientes en `request.session`.

También hay configuraciones de seguridad importantes para la cookie: `SESSION_COOKIE_SECURE` (que solo se envíe por HTTPS), `SESSION_COOKIE_HTTPONLY` (que JavaScript no pueda leerla, evita robo por XSS), y `SESSION_COOKIE_AGE` (tiempo de expiración en segundos).

En el código, el uso es el mismo que ya vimos: `request.session["clave"] = valor` para guardar, `request.session.get("clave")` para leer, y `request.session.flush()` para limpiar todo, típicamente al hacer logout.

---

## 27. Pregunta 16: ¿Qué es la autenticación en Django y cuáles son sus componentes principales?

Es el proceso de verificar la identidad de un usuario, es decir, confirmar que es quien dice ser, típicamente mediante usuario y contraseña. Django trae este sistema incluido por defecto en `django.contrib.auth`.

Los componentes principales son:

El modelo `User`, que representa a cada usuario con campos como username, password (guardada con hash, nunca en texto plano), email, y flags como `is_active` o `is_staff`. Se puede usar tal cual o extenderlo con un modelo propio.

El `AuthenticationMiddleware`, que en cada request revisa la sesión activa y, si corresponde, asocia el usuario correspondiente al objeto `request.user`.

Las funciones `authenticate()` y `login()`: `authenticate()` recibe usuario y contraseña, y verifica si son válidos; `login()` toma ese usuario ya validado y crea la sesión para mantenerlo logueado en las siguientes peticiones.

```python
from django.contrib.auth import authenticate, login

user = authenticate(request, username="juan", password="1234")
if user is not None:
    login(request, user)
```

También están los "backends" de autenticación, que definen contra qué se valida (por defecto contra la base de datos de Django, pero se pueden agregar backends personalizados, por ejemplo para login con Google o con un sistema externo).

Es importante no confundir autenticación con autorización: autenticación es "quién es", autorización es "qué puede hacer" (eso lo maneja el sistema de permisos y grupos de Django, que es otro componente aparte).

---

## 28. Pregunta 17: Implementación práctica de sesiones, cookies y autenticación en Django.

Uniendo lo que se vio en las preguntas anteriores, un flujo típico de login se ve así:

```python
from django.contrib.auth import authenticate, login, logout

def vista_login(request):
    if request.method == "POST":
        username = request.POST["username"]
        password = request.POST["password"]
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)   # crea la sesión y setea la cookie sessionid
            return redirect("home")
        else:
            return render(request, "login.html", {"error": "Credenciales inválidas"})
    return render(request, "login.html")
```

Cuando `login(request, user)` se ejecuta, Django internamente crea un registro de sesión en el backend configurado, guarda ahí el id del usuario autenticado, y hace que la respuesta incluya la cookie `sessionid` para que el navegador la guarde.

En las peticiones siguientes, gracias al `SessionMiddleware` y al `AuthenticationMiddleware`, cualquier vista puede acceder directamente al usuario logueado sin volver a autenticar:

```python
def vista_perfil(request):
    if request.user.is_authenticated:
        return render(request, "perfil.html", {"user": request.user})
    return redirect("login")
```

Para proteger vistas completas sin repetir ese chequeo manualmente, se usa el decorador `@login_required`, que redirige automáticamente al login si no hay usuario autenticado.

Para cerrar sesión:

```python
def vista_logout(request):
    logout(request)   # limpia request.session y elimina los datos de sesión del servidor
    return redirect("login")
```

En resumen: la cookie identifica la sesión, la sesión guarda quién es el usuario, y la autenticación es el paso inicial que valida las credenciales antes de crear esa sesión.

---

## 29. Pregunta 18: ¿Qué prácticas de seguridad existen en Django para proteger aplicaciones web?

Django trae protecciones incorporadas por defecto contra varios ataques comunes:

**CSRF** (Cross-Site Request Forgery): Django incluye el middleware `CsrfViewMiddleware`, que exige un token secreto en formularios que hacen POST. Sin ese token, la petición se rechaza. Por eso en los templates se usa `{% csrf_token %}` dentro de cada formulario.

**XSS** (Cross-Site Scripting): el sistema de templates escapa automáticamente el contenido de las variables, entonces si un usuario ingresa código HTML o JavaScript malicioso, se muestra como texto plano en vez de ejecutarse. Hay que usar `|safe` con cuidado, porque desactiva ese escape.

**SQL Injection**: el ORM de Django arma las consultas usando parámetros preparados internamente, entonces al usar `filter()`, `get()`, etc., los valores nunca se concatenan directo en el SQL. El riesgo aparece solo si se usa `raw()` o SQL crudo sin cuidado.

**Clickjacking**: el middleware `XFrameOptionsMiddleware` agrega el header que evita que el sitio se cargue dentro de un `iframe` de otro dominio.

**Contraseñas**: nunca se guardan en texto plano, Django las guarda con hash (por defecto PBKDF2, aunque se puede configurar Argon2 u otros), y valida su fortaleza con los `AUTH_PASSWORD_VALIDATORS`.

**HTTPS y cookies seguras**: configuraciones como `SESSION_COOKIE_SECURE`, `CSRF_COOKIE_SECURE` y `SECURE_SSL_REDIRECT` fuerzan el uso de HTTPS y evitan que las cookies viajen por conexiones sin cifrar.

La idea general es que la mayoría de estas protecciones vienen activadas por defecto al crear un proyecto nuevo, y el riesgo real suele aparecer cuando alguien las desactiva sin entender bien por qué estaban ahí.

---

## 30. Pregunta 19: ¿Cómo se manejan sockets y comunicación en tiempo real usando Django Channels?

Como ya se vio en la pregunta 11, Django por sí solo trabaja con el modelo tradicional de petición-respuesta de HTTP, que no sirve para mantener una conexión abierta. Channels resuelve esto reemplazando el servidor WSGI por uno ASGI, que sí soporta conexiones persistentes y asíncronas como los WebSockets.

La pieza central son los **consumers**, que son el equivalente a las vistas pero para conexiones en tiempo real. Un consumer básico se ve así:

```python
from channels.generic.websocket import WebsocketConsumer
import json

class ChatConsumer(WebsocketConsumer):
    def connect(self):
        self.accept()   # acepta la conexión WebSocket

    def disconnect(self, close_code):
        pass

    def receive(self, text_data):
        data = json.loads(text_data)
        self.send(text_data=json.dumps({"mensaje": data["mensaje"]}))
```

Estas rutas de WebSocket se definen aparte de `urls.py`, en un archivo de "routing", usando `path()` igual que las URLs normales pero apuntando a un consumer en vez de a una vista.

Para comunicación entre varios usuarios conectados a la vez (por ejemplo, un chat grupal), Channels usa un **channel layer**, generalmente respaldado por Redis. Cada consumer se puede unir a un "grupo", y cuando alguien envía un mensaje, ese mensaje se distribuye a todos los consumers del grupo, no solo al que lo originó:

```python
from asgiref.sync import async_to_sync

self.channel_layer.group_add("sala_chat", self.channel_name)
async_to_sync(self.channel_layer.group_send)(
    "sala_chat", {"type": "chat_message", "mensaje": data["mensaje"]}
)
```

En resumen: el consumer maneja la conexión individual de cada cliente, y el channel layer (Redis) es lo que permite coordinar mensajes entre múltiples conexiones simultáneas.

*(Nota: las respuestas completas de las preguntas 1 a 19 quedaron también guardadas, integradas y en formato documentación, en `python/interview.md`.)*

---

## 31. "¿Qué más preguntas de Python me das?"

Listado entregado (sin respuestas en ese momento):

**Python core**
- ¿Qué es el GIL (Global Interpreter Lock) y cómo afecta la concurrencia?
- ¿Diferencia entre `list`, `tuple` y `set`?
- ¿Qué son los generadores y para qué sirve `yield`?
- ¿Diferencia entre `deepcopy` y `copy` (shallow copy)?
- ¿Qué son `*args` y `**kwargs`?
- ¿Qué es un context manager y cómo funciona el `with`?
- ¿Qué son las list comprehensions y cuándo conviene usarlas?
- ¿Diferencia entre mutable e inmutable en Python? Ejemplos.
- ¿Qué son los closures?
- ¿Qué es una lambda y cuándo se usa en vez de una función normal?
- ¿Para qué sirven `map`, `filter` y `reduce`?
- ¿Qué son las metaclasses?
- ¿Diferencia entre `__init__` y `__new__`?
- ¿Qué son los dunder methods (`__str__`, `__repr__`, `__len__`, etc.)?
- ¿Cómo maneja Python el manejo de memoria y el garbage collector?
- ¿Diferencia entre multithreading y multiprocessing en Python?
- ¿Qué es `async`/`await` y cuándo se usa?
- ¿Qué es el walrus operator (`:=`)?
- ¿Cómo funciona el manejo de excepciones (`try/except/else/finally`)?
- ¿Qué son los type hints y para qué sirven?
- ¿Diferencia entre `is` y `==`?
- ¿Qué es un entorno virtual (`venv`) y por qué se usa?
- ¿Qué son los decoradores con parámetros (decoradores que reciben argumentos)?
- ¿Qué es la herencia múltiple y el MRO (Method Resolution Order) en Python?

**Django específico**
- ¿Qué son las migraciones en Django y cómo funcionan?
- ¿Qué son los signals en Django?
- ¿Qué es un middleware y cómo se crea uno personalizado?
- ¿Diferencia entre vistas basadas en función (FBV) y basadas en clase (CBV)?
- ¿Qué son los serializers en Django Rest Framework?
- ¿Para qué sirve la clase `Meta` dentro de un modelo?
- ¿Qué es el problema N+1 y cómo se resuelve con `select_related` y `prefetch_related`?
- ¿Cómo funciona el Django Admin y cómo se personaliza?
- ¿Qué son los custom management commands?
- ¿Cómo se implementa caching en Django?
- ¿Qué son los mixins en Django?

---

## 32. "Vamos con la primera" — ¿Qué es el GIL (Global Interpreter Lock) y cómo afecta la concurrencia?

El GIL es un mecanismo de CPython (la implementación estándar de Python) que permite que solo un hilo ejecute bytecode de Python a la vez, aunque el programa tenga varios threads corriendo. Existe porque el manejo de memoria interno de Python no es thread-safe por defecto, y el GIL evita condiciones de carrera al acceder a los objetos.

El efecto práctico es que el multithreading en Python no sirve para acelerar tareas que consumen mucho CPU (cálculos pesados), porque aunque haya varios threads, solo uno ejecuta código Python en un momento dado. Donde sí ayuda es en tareas de I/O, como peticiones de red o lectura de archivos, porque el GIL se libera mientras un thread espera esa operación, dejando que otro thread avance mientras tanto.

Por eso, para tareas intensivas en CPU se suele usar `multiprocessing` en vez de `threading`, ya que cada proceso tiene su propio intérprete de Python y su propio GIL, permitiendo aprovechar varios núcleos de verdad. Y para tareas de I/O intensivas, además de threading, hoy es común usar `asyncio` con `async`/`await`, que resuelve la concurrencia con un solo hilo pero de forma cooperativa, sin necesidad de crear múltiples threads.

---

## 33. Pregunta 2 (segunda lista): ¿Diferencia entre `list`, `tuple` y `set`?

Los tres son colecciones, pero se diferencian en mutabilidad, orden y duplicados.

`list` es mutable (se puede agregar, quitar o modificar elementos después de creada), mantiene el orden de inserción, y permite elementos duplicados. Se define con corchetes: `[1, 2, 3]`.

`tuple` es inmutable (una vez creada no se puede modificar), también mantiene el orden y permite duplicados. Se define con paréntesis: `(1, 2, 3)`. Al ser inmutable, es un poco más rápida que una lista y se puede usar como clave de un diccionario, cosa que una lista no puede porque las claves deben ser hasheables.

`set` no mantiene un orden garantizado, no permite elementos duplicados (los elimina automáticamente), y es mutable en cuanto a poder agregar o quitar elementos, aunque los elementos individuales deben ser inmutables. Se define con llaves: `{1, 2, 3}`. Se usa mucho cuando lo que importa es pertenencia ("¿está este elemento acá?") o para eliminar duplicados rápidamente, porque buscar en un set es más rápido que en una lista.

En resumen: lista para una colección ordenada y modificable, tupla para datos fijos que no deben cambiar, y set para unicidad y operaciones de conjuntos (unión, intersección, etc.).

---

## 34. Pregunta 3 (segunda lista): ¿Qué son los generadores y para qué sirve `yield`?

Un generador es una función especial que, en vez de devolver todos sus valores de una vez con `return`, los va entregando uno por uno usando `yield`, pausando su ejecución cada vez y guardando su estado interno hasta que se le pide el siguiente valor.

```python
def contar_hasta(n):
    i = 1
    while i <= n:
        yield i
        i += 1

for numero in contar_hasta(5):
    print(numero)
```

Cuando se llama a `contar_hasta(5)`, no se ejecuta nada todavía: se crea un objeto generador. Recién al iterar sobre él (con un `for`, o llamando a `next()`), la función empieza a correr hasta el primer `yield`, entrega ese valor, y queda pausada ahí hasta la siguiente vez que se le pida un valor.

La ventaja principal es el ahorro de memoria: en vez de crear una lista completa en memoria con todos los valores, los va generando de a uno bajo demanda (esto se llama *lazy evaluation*). Es muy útil para procesar archivos grandes, streams de datos, o secuencias infinitas, donde cargar todo de una vez sería imposible o muy costoso.

---

## 35. Pregunta 4 (segunda lista): ¿Diferencia entre `deepcopy` y `copy` (shallow copy)?

Ambos vienen del módulo `copy` y sirven para duplicar un objeto, pero difieren en qué tan "profundo" llega esa duplicación cuando el objeto contiene otros objetos adentro (por ejemplo, una lista de listas).

`copy.copy()` hace una copia superficial: crea un objeto nuevo, pero si ese objeto contiene referencias a otros objetos mutables (como listas anidadas), esas referencias internas se comparten con el original, no se duplican.

```python
import copy

original = [[1, 2], [3, 4]]
superficial = copy.copy(original)

superficial[0].append(99)
print(original)   # [[1, 2, 99], [3, 4]]  -> el original también cambió
```

`copy.deepcopy()` hace una copia completa y recursiva: duplica también todos los objetos internos, así que el resultado es totalmente independiente del original.

```python
profunda = copy.deepcopy(original)
profunda[0].append(100)
print(original)   # no cambia
```

La regla práctica: si el objeto es plano (sin listas, dicts u objetos anidados adentro), `copy` y `deepcopy` se comportan igual. El problema aparece con estructuras anidadas, ahí hay que usar `deepcopy` si se necesita que la copia sea totalmente independiente del original.

---

## 36. Pregunta 5 (segunda lista): ¿Qué son `*args` y `**kwargs`?

Son una forma de que una función acepte una cantidad variable de argumentos, sin tener que definir de antemano cuántos va a recibir.

`*args` junta los argumentos posicionales extra en una tupla. El nombre "args" es solo convención, lo importante es el asterisco.

```python
def sumar(*args):
    return sum(args)

sumar(1, 2, 3)   # args = (1, 2, 3) -> 6
```

`**kwargs` junta los argumentos con nombre (clave=valor) que no fueron declarados explícitamente, en un diccionario.

```python
def crear_usuario(**kwargs):
    print(kwargs)

crear_usuario(nombre="Juan", edad=30)
# kwargs = {"nombre": "Juan", "edad": 30}
```

Se pueden combinar en la misma función, siempre en este orden: argumentos normales, luego `*args`, luego `**kwargs`.

```python
def funcion(a, b, *args, **kwargs):
    ...
```

También se usan al revés, para "desempaquetar" al llamar una función: `funcion(*lista)` expande una lista en argumentos posicionales, y `funcion(**diccionario)` expande un diccionario en argumentos con nombre. Es un patrón muy común en Django y en librerías en general para pasar parámetros de forma flexible sin tener que listar cada uno.

---

## 37. Pregunta 6 (segunda lista): ¿Qué es un context manager y cómo funciona el `with`?

Un context manager es un objeto que define un bloque de código con una entrada y una salida bien definidas, garantizando que cierta acción de limpieza se ejecute siempre, incluso si ocurre un error dentro del bloque. Se usa con la sentencia `with`.

El ejemplo más común es abrir un archivo:

```python
with open("archivo.txt") as f:
    contenido = f.read()
# acá afuera, el archivo ya se cerró automáticamente
```

Sin `with`, habría que acordarse de cerrar el archivo manualmente con `f.close()`, y si algo falla en el medio, ese cierre podría no ejecutarse nunca, dejando el archivo abierto.

Por dentro, un context manager funciona implementando dos métodos mágicos: `__enter__`, que se ejecuta al entrar al bloque `with` (y devuelve el valor que se asigna después del `as`), y `__exit__`, que se ejecuta al salir del bloque, ya sea que todo haya salido bien o que haya ocurrido una excepción.

```python
class MiRecurso:
    def __enter__(self):
        print("Abriendo recurso")
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        print("Cerrando recurso")

with MiRecurso() as r:
    print("Usando el recurso")
```

También existe una forma más corta usando el decorador `@contextmanager` del módulo `contextlib`, para escribir context managers con una función generadora en vez de una clase completa. Se usa mucho para manejar archivos, conexiones de base de datos, locks de concurrencia, o transacciones, donde siempre hace falta garantizar que algo se libere o se cierre al final.

---

## 38. Pregunta 7 (segunda lista): ¿Qué son las list comprehensions y cuándo conviene usarlas?

Es una forma compacta de crear una lista nueva a partir de otra secuencia, combinando en una sola línea el bucle, la transformación y, opcionalmente, un filtro.

```python
numeros = [1, 2, 3, 4, 5]

cuadrados = [n ** 2 for n in numeros]
# [1, 4, 9, 16, 25]

pares = [n for n in numeros if n % 2 == 0]
# [2, 4]

pares_cuadrados = [n ** 2 for n in numeros if n % 2 == 0]
# [4, 16]
```

Es equivalente a escribir esto con un bucle normal:

```python
cuadrados = []
for n in numeros:
    cuadrados.append(n ** 2)
```

Conviene usarlas cuando la lógica es simple y cabe en una línea legible: transformar elementos, filtrar, o ambas cosas a la vez. Suelen ser un poco más rápidas que el bucle equivalente con `append`, porque están optimizadas internamente en CPython.

Donde no conviene usarlas es cuando la lógica es compleja o tiene varios pasos, porque meter demasiado en una sola línea termina siendo menos legible que un `for` normal; ahí es mejor priorizar la claridad. También existe la misma idea para diccionarios (`{k: v for ...}`) y sets (`{x for ...}`), y una versión con paréntesis que en realidad genera un generador en vez de una lista (`(x for x in numeros)`).

---

## 39. "¿Qué es una lista?"

Una lista es una estructura de datos que permite guardar varios valores juntos, en un orden determinado, dentro de una sola variable. En Python se escribe entre corchetes, separando los elementos con comas.

```python
numeros = [1, 2, 3, 4]
nombres = ["Ana", "Luis", "Marta"]
mezclada = [1, "texto", True, 3.5]   # puede mezclar tipos distintos
```

Cada elemento tiene una posición (empezando en 0), llamada índice, y se puede acceder a él con corchetes: `numeros[0]` da `1`, `numeros[2]` da `3`.

Es **mutable**, o sea que se puede modificar después de creada: agregar elementos con `.append()`, quitar con `.remove()` o `.pop()`, cambiar un valor puntual (`numeros[0] = 10`), etc.

Es la estructura más usada en Python para representar una colección de cosas del mismo tipo (una lista de usuarios, de productos, de números), y es la base sobre la que funcionan las list comprehensions vistas antes: una list comprehension no es más que una forma corta de construir una lista.

---

## 40. "Pipelines en Python"

Un pipeline en Python es una forma de organizar el procesamiento de datos en pasos encadenados, donde la salida de un paso es la entrada del siguiente, en vez de escribir todo el procesamiento mezclado en un solo bloque de código.

Hay varias formas comunes de implementar esta idea:

**Con generadores**, encadenando funciones que van transformando datos de a poco, sin cargar todo en memoria:

```python
def leer_lineas(archivo):
    for linea in archivo:
        yield linea.strip()

def filtrar_vacias(lineas):
    for linea in lineas:
        if linea:
            yield linea

def a_mayusculas(lineas):
    for linea in lineas:
        yield linea.upper()

with open("datos.txt") as f:
    pipeline = a_mayusculas(filtrar_vacias(leer_lineas(f)))
    for resultado in pipeline:
        print(resultado)
```

Cada función recibe el generador anterior y devuelve otro generador, así los datos van fluyendo paso a paso, uno a la vez, sin procesar todo el archivo de una sola vez en memoria.

**Con librerías especializadas**: `scikit-learn` tiene su propia clase `Pipeline`, que encadena pasos de preprocesamiento (escalado, normalización) y un modelo final, todo entrenado y ejecutado como una sola unidad. `pandas` tiene el método `.pipe()`, que permite encadenar funciones sobre un DataFrame de forma legible en vez de anidar llamadas.

**Para pipelines de datos más grandes**, en producción se suelen usar herramientas como Airflow, Luigi o Prefect, que orquestan tareas encadenadas (extraer, transformar, cargar — ETL), con reintentos, dependencias entre pasos y programación por horarios.

Y en un contexto distinto, "pipeline" también se usa para hablar de CI/CD (build, test, deploy encadenados), pero ahí ya no es un concepto específico de Python sino de herramientas como GitHub Actions o Jenkins.

---

## 41. "Sí pero cuáles existen en Python" (pipelines)

Listado de pipelines/mecanismos de pipeline que existen en el ecosistema Python:

**En el lenguaje mismo (sin librerías externas)**
- Generadores encadenados (`yield`) — pasos que se van pasando datos de a poco.
- `itertools` — funciones como `chain()`, `map()`, `filter()`, `islice()` combinables entre sí para armar flujos de procesamiento.
- `functools.reduce()` — para encadenar operaciones acumulativas sobre una secuencia.

**Procesamiento de datos / ciencia de datos**
- `pandas.DataFrame.pipe()` — encadenar funciones sobre un DataFrame.
- `scikit-learn.pipeline.Pipeline` — encadena pasos de preprocesamiento y modelo de machine learning.
- `sklearn.pipeline.make_pipeline` — versión simplificada de `Pipeline`.

**Orquestación de pipelines de datos (ETL / workflows)**
- **Apache Airflow** — define pipelines como DAGs (grafos de tareas), muy usado en producción.
- **Luigi** (de Spotify) — similar a Airflow, orientado a dependencias entre tareas.
- **Prefect** — alternativa más moderna a Airflow.
- **Dagster** — orquestador de pipelines de datos con enfoque en tipado y testing.

**Procesamiento de streams / datos grandes**
- **Apache Beam** (con su SDK de Python) — pipelines de procesamiento de datos batch o streaming.
- **PySpark** — pipelines de procesamiento distribuido sobre Spark.

**Machine Learning / NLP**
- **Hugging Face `transformers.pipeline()`** — pipelines predefinidos para tareas de NLP (clasificación, traducción, generación de texto, etc.).

**Procesamiento asíncrono / colas**
- **Celery** — se puede usar para encadenar tareas asíncronas con `chain()`, `group()`, `chord()`.

---

## 42. "Optimización de base de datos"

**Índices**
- Crear índices en columnas usadas frecuentemente en `WHERE`, `JOIN` y `ORDER BY`.
- Evitar exceso de índices, porque cada uno ralentiza las escrituras (`INSERT`/`UPDATE`).
- Índices compuestos cuando se filtra por varias columnas juntas frecuentemente.

**Consultas (queries)**
- Evitar `SELECT *`, traer solo las columnas necesarias.
- Evitar el problema N+1 (una query extra por cada fila) usando `select_related` (para relaciones ForeignKey/OneToOne) y `prefetch_related` (para ManyToMany o relaciones inversas) en Django ORM.
- Usar `EXPLAIN`/`EXPLAIN ANALYZE` para ver el plan de ejecución de una query lenta y detectar si está usando índices o haciendo un full table scan.
- Paginar resultados grandes en vez de traer todo de una vez.

**Diseño del esquema**
- Normalización para evitar datos duplicados e inconsistencias.
- Desnormalización puntual cuando la lectura es mucho más frecuente que la escritura y el join constante es costoso.
- Tipos de datos adecuados (no usar `TEXT` para algo que es un número, por ejemplo).

**Caching**
- Cachear resultados de queries costosas y repetidas con Redis o Memcached, en vez de golpear la base de datos en cada request.
- Cache a nivel de vista o de fragmento en Django (`cache_page`, `django.core.cache`).

**Conexiones**
- Connection pooling, para no abrir/cerrar una conexión nueva en cada request.
- Ajustar el número máximo de conexiones según la carga esperada.

**Transacciones**
- Mantener las transacciones cortas, evitando bloqueos largos que frenen a otras consultas.
- Usar el nivel de aislamiento adecuado según el caso (no siempre hace falta el más estricto).

**Escalamiento**
- Réplicas de lectura (read replicas), separando las queries de lectura de las de escritura.
- Sharding/particionado, cuando una sola tabla o base de datos ya no soporta el volumen de datos.

**Monitoreo**
- Identificar queries lentas con herramientas como `django-debug-toolbar` en desarrollo, o el *slow query log* de la propia base de datos en producción.

---

## 43. "En inglés" (traducción de la respuesta anterior)

**Database optimization techniques list (general, and Django/ORM-specific where noted):**

**Indexes**
- Create indexes on columns frequently used in `WHERE`, `JOIN`, and `ORDER BY`.
- Avoid over-indexing — every index slows down writes (`INSERT`/`UPDATE`).
- Use composite indexes when queries filter by multiple columns together often.

**Queries**
- Avoid `SELECT *`; fetch only the columns you actually need.
- Avoid the N+1 problem (one extra query per row) using `select_related` (for ForeignKey/OneToOne) and `prefetch_related` (for ManyToMany or reverse relations) in Django ORM.
- Use `EXPLAIN`/`EXPLAIN ANALYZE` to inspect a slow query's execution plan and check whether it's using indexes or doing a full table scan.
- Paginate large result sets instead of fetching everything at once.

**Schema design**
- Normalization to avoid duplicated/inconsistent data.
- Selective denormalization when reads are far more frequent than writes and constant joins are too costly.
- Use appropriate data types (don't store a number as `TEXT`, for example).

**Caching**
- Cache expensive, repeated query results with Redis or Memcached instead of hitting the database on every request.
- View-level or fragment-level caching in Django (`cache_page`, `django.core.cache`).

**Connections**
- Connection pooling, to avoid opening/closing a new connection on every request.
- Tune the max connection count based on expected load.

**Transactions**
- Keep transactions short to avoid long locks that block other queries.
- Use the appropriate isolation level for the case (the strictest one isn't always necessary).

**Scaling**
- Read replicas, splitting read queries away from write queries.
- Sharding/partitioning, once a single table or database can no longer handle the data volume.

**Monitoring**
- Spot slow queries with tools like `django-debug-toolbar` in development, or the database's own slow query log in production.

---

## 44. "¿Cuál es el flujo de Django?"

```
1. Cliente (navegador) envía una petición HTTP
        │
        ▼
2. WSGI/ASGI  (el servidor recibe la petición y se la pasa a Django)
        │
        ▼
3. Middleware (entrada)  →  se ejecutan en orden, uno tras otro
        │   (ej: seguridad, sesión, autenticación, CSRF)
        ▼
4. urls.py  →  Django busca en urlpatterns qué vista corresponde a esa URL
        │
        ▼
5. View (vista)  →  ejecuta la lógica: consulta el modelo, procesa datos
        │
        ▼
6. Model / ORM  →  si hace falta, la vista consulta la base de datos
        │
        ▼
7. Template  →  si la vista devuelve HTML, se renderiza el template con los datos
        │        (si es una API, en vez de template se usa un Serializer -> JSON)
        ▼
8. Middleware (salida)  →  se ejecutan de nuevo, en orden inverso
        │
        ▼
9. Respuesta HTTP  →  se envía de vuelta al cliente
```

En palabras simples: la petición entra, pasa por una cadena de middlewares (chequeos generales), Django decide qué vista le corresponde según `urls.py`, esa vista habla con el modelo si necesita datos de la base de datos, arma una respuesta (HTML con un template, o JSON si es una API), y esa respuesta vuelve a pasar por los middlewares antes de salir hacia el cliente.

El patrón de diseño detrás de esto se suele llamar **MTV** (Model-Template-View), que es la variante de Django del clásico MVC: el "controlador" en Django es en realidad la combinación de `urls.py` + la vista.

---

## 45. "De vista modelo controlador en inglés" (MVC vs MTV)

**MVC vs Django's MTV pattern**

MVC (Model-View-Controller) is a classic design pattern that splits an application into three parts: the **Model** (data and business logic), the **View** (what the user sees, the UI), and the **Controller** (handles user input, decides what to do, connects Model and View).

Django uses a variant called **MTV** (Model-Template-View), and the naming is a common source of confusion because the words don't map 1-to-1 to MVC:

- **Model** — same as MVC's Model: represents the data, defined as Python classes mapped to database tables (Django ORM).
- **Template** — this is what MVC calls the "View": the HTML file that defines how data is presented to the user.
- **View** (Django's) — this is actually what MVC calls the "Controller": a Python function or class that receives the request, talks to the Model, decides what data to use, and picks a Template to render.
- **URLconf** (`urls.py`) — also plays part of the Controller's role, deciding which View handles each incoming URL.

So the mapping is:

```
MVC          →  Django (MTV)
------------------------------
Model        →  Model
View         →  Template
Controller   →  View + urls.py
```

In short: in Django, "View" doesn't mean what you see on screen (that's the Template) — it means the logic that decides what to do with a request, which in classic MVC terms is the Controller.

---

## 46. "¿Qué es un decorator?"

Un decorador es una función que envuelve a otra función (o clase) para agregarle comportamiento extra, sin modificar su código interno. Se aplica con el símbolo `@` justo arriba de la definición.

Recibe la función original como argumento, define una función interna (`wrapper`) que agrega la lógica extra y llama a la original, y devuelve esa función interna.

```python
def con_log(func):
    def wrapper(*args, **kwargs):
        print(f"Llamando a {func.__name__}")
        resultado = func(*args, **kwargs)
        print(f"Terminó {func.__name__}")
        return resultado
    return wrapper

@con_log
def sumar(a, b):
    return a + b

sumar(2, 3)
```

`@con_log` equivale a escribir `sumar = con_log(sumar)`. Cada vez que se llama a `sumar`, en realidad se ejecuta `wrapper`.

Se usan para lógica transversal: logging, medir tiempos, controlar permisos, cachear resultados. En Django, `@login_required` es un decorador que envuelve una vista para verificar que el usuario esté autenticado antes de ejecutarla.

---

## 47. "¿Cómo función Python la palabra `new`?" (`__new__`)

`__new__` es el método especial encargado de **crear** la instancia de un objeto, antes de que se inicialice con `__init__`. Es un método estático (aunque no se declara con `@staticmethod` explícitamente, Python lo trata como tal internamente) y es el primero que se ejecuta cuando se hace `MiClase()`.

La diferencia con `__init__`:

- `__new__` **crea** el objeto y lo devuelve (recibe la clase como primer argumento, `cls`).
- `__init__` **inicializa** ese objeto ya creado, asignándole valores a sus atributos (recibe la instancia ya creada, `self`).

```python
class Persona:
    def __new__(cls, *args, **kwargs):
        print("Creando instancia")
        instancia = super().__new__(cls)
        return instancia

    def __init__(self, nombre):
        print("Inicializando instancia")
        self.nombre = nombre

p = Persona("Juan")
# Creando instancia
# Inicializando instancia
```

En la práctica, casi nunca se necesita sobreescribir `__new__` manualmente, porque Python ya lo maneja automáticamente. Los casos donde sí se usa son específicos: implementar el patrón **Singleton** (asegurar que una clase solo tenga una instancia), controlar la creación de instancias de clases inmutables (como subclases de `tuple` o `str`), o en metaclases.

```python
class Singleton:
    _instancia = None

    def __new__(cls):
        if cls._instancia is None:
            cls._instancia = super().__new__(cls)
        return cls._instancia
```

En resumen: `__new__` decide si se crea (o se reutiliza) el objeto, `__init__` decide cómo se llena ese objeto con datos.

---

## 48. "Range" (interpretado a partir de "ragne")

`range()` es una función incorporada que genera una secuencia de números enteros, típicamente usada para controlar cuántas veces se repite un bucle `for`. No crea una lista en memoria con todos los números; devuelve un objeto tipo `range`, que genera los valores bajo demanda (de forma perezosa), lo cual es eficiente en memoria incluso con rangos muy grandes.

```python
range(5)        # 0, 1, 2, 3, 4
range(2, 5)     # 2, 3, 4
range(0, 10, 2) # 0, 2, 4, 6, 8  (con paso de 2)
range(5, 0, -1) # 5, 4, 3, 2, 1  (paso negativo, va hacia atrás)
```

Recibe hasta tres argumentos: `range(inicio, fin, paso)`. Si solo se pasa uno, se asume que es el `fin` y empieza desde 0. El `fin` nunca se incluye en el resultado (es exclusivo).

Uso típico:

```python
for i in range(5):
    print(i)
```

Si se necesita la lista real de números (no el objeto `range`), se puede convertir con `list(range(5))` → `[0, 1, 2, 3, 4]`.

---

## 49. "Estoy en un loop en un for 0 1 a 100"

Para un `for` de 0 a 100 en Python:

```python
for i in range(101):
    print(i)
```

`range(101)` porque `range()` no incluye el último número, entonces si se quiere llegar hasta el 100 incluido, hay que poner 101 como límite. Si se pusiera `range(100)`, iría de 0 a 99 nada más.

Si en cambio se quiere que vaya de 0 a 100 pero de a saltos, por ejemplo de 10 en 10:

```python
for i in range(0, 101, 10):
    print(i)   # 0, 10, 20, ..., 100
```

---

## 50. "La secuencia"

La secuencia que genera `range(101)` es esta:

```
0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, ..., 97, 98, 99, 100
```

Es decir, todos los números enteros desde 0 hasta 100, incluyendo el 100, avanzando de a uno.

Para verla completa impresa:

```python
print(list(range(101)))
```

Resultado:

```python
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100]
```

---

## 51. "Programación síncrona"

**Programación síncrona** es el modelo donde las instrucciones se ejecutan una detrás de otra, en orden, y cada línea tiene que terminar de ejecutarse antes de que la siguiente empiece. Si una operación tarda (por ejemplo, una llamada a una API o leer un archivo grande), el programa completo se queda "bloqueado" esperando esa respuesta antes de continuar.

```python
def obtener_datos():
    print("Pidiendo datos...")
    datos = llamada_lenta_a_api()   # el programa se detiene acá hasta que responda
    print("Datos recibidos")
    return datos

obtener_datos()
print("Esto se ejecuta después, no antes")
```

Es el modelo por defecto en Python (y en la mayoría de los lenguajes): simple de entender y de depurar, porque el flujo es lineal y predecible.

La contraparte es la **programación asíncrona** (`async`/`await`), donde el programa puede "pausar" una tarea que está esperando algo (como una respuesta de red) y seguir haciendo otras cosas mientras tanto, en vez de quedarse bloqueado. Eso es útil cuando hay muchas operaciones de espera (I/O), como un servidor manejando miles de conexiones a la vez.

En resumen: síncrono = una cosa a la vez, en orden, esperando a que cada una termine; asíncrono = puede avanzar con otras tareas mientras una está esperando.

---

## 52. "Await como función"

`await` es una palabra clave (no una función común) que se usa dentro de una función `async` para pausar su ejecución hasta que una operación asíncrona termine, sin bloquear el resto del programa mientras tanto.

Solo se puede usar dentro de una función declarada con `async def`, y solo puede aplicarse sobre algo "esperable" (un objeto *awaitable*: una corrutina, una `Task`, o un `Future`).

```python
import asyncio

async def obtener_datos():
    print("Pidiendo datos...")
    await asyncio.sleep(2)   # simula una espera de 2 segundos, sin bloquear todo el programa
    print("Datos recibidos")
    return "resultado"

async def main():
    resultado = await obtener_datos()
    print(resultado)

asyncio.run(main())
```

Lo importante de `await` es que, mientras espera, le cede el control al *event loop* (el organizador de tareas asíncronas), que puede aprovechar ese tiempo muerto para avanzar con otra tarea pendiente. Así se pueden manejar muchas operaciones de espera (peticiones de red, consultas a base de datos, lectura de archivos) de forma concurrente, sin necesidad de crear múltiples threads.

Un detalle clave: si defines una función con `async def` pero la llamas sin `await`, no se ejecuta su código — solo se crea un objeto corrutina, que hay que "despertar" con `await` (o programarla como tarea con `asyncio.create_task()`) para que realmente corra.

```python
obtener_datos()          # esto NO ejecuta nada, solo crea la corrutina
await obtener_datos()    # esto sí la ejecuta
```

En Django, este modelo se usa en vistas asíncronas (`async def mi_vista(request): ...`) y es la base de Django Channels, que ya se vio antes para manejar WebSockets.

---

## 53. "Diferencia multiprocessing vs multithreading"

La diferencia clave está en qué comparten y cómo aprovechan los núcleos del procesador.

**Multithreading** crea varios hilos (threads) dentro del mismo proceso, y todos comparten la misma memoria. En Python, debido al GIL, solo un thread puede ejecutar bytecode de Python a la vez, aunque haya varios threads creados. Por eso el multithreading en Python no acelera tareas que consumen mucho CPU, pero sí sirve para tareas de I/O (peticiones de red, lectura de archivos), porque el GIL se libera mientras un thread espera esa respuesta.

```python
import threading

def tarea():
    print("Ejecutando en un thread")

t = threading.Thread(target=tarea)
t.start()
t.join()
```

**Multiprocessing** crea procesos completamente separados, cada uno con su propio intérprete de Python y su propio GIL. Al no compartir el GIL, sí pueden ejecutar código Python en paralelo real, aprovechando varios núcleos del procesador. La desventaja es que, al ser procesos independientes, no comparten memoria directamente — si necesitan intercambiar datos, hay que hacerlo explícitamente (con colas, pipes, memoria compartida), lo cual tiene más overhead que compartir memoria entre threads.

```python
import multiprocessing

def tarea():
    print("Ejecutando en un proceso separado")

p = multiprocessing.Process(target=tarea)
p.start()
p.join()
```

En resumen: **threading** para tareas de espera/I/O (varias conexiones de red al mismo tiempo), y **multiprocessing** para tareas de cálculo pesado que realmente necesitan paralelismo (procesar imágenes, cálculos matemáticos grandes), donde múltiples núcleos hacen una diferencia real.

---

## 54. "¿GitHub Actions mantiene la calidad del código?"

Sí, es justamente uno de sus usos principales. GitHub Actions es una herramienta de CI/CD (integración y entrega continua) integrada en GitHub, que permite automatizar tareas cada vez que pasa algo en el repositorio (un push, un pull request, etc.), definidas en archivos YAML dentro de `.github/workflows/`.

Para mantener la calidad del código, un workflow típico corre automáticamente en cada Pull Request:

```yaml
name: CI

on: [pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Instalar dependencias
        run: pip install -r requirements.txt
      - name: Correr tests
        run: pytest
      - name: Linter
        run: flake8 .
```

Con esto se pueden automatizar cosas como:

- **Correr los tests** (pytest, unittest) — para verificar que el código nuevo no rompe nada.
- **Linting** (flake8, pylint, black --check) — para verificar estilo y detectar errores comunes.
- **Type checking** (mypy) — para verificar los type hints.
- **Cobertura de tests** (coverage) — para asegurar que el código nuevo esté testeado.
- **Análisis de seguridad** (bandit, dependabot) — para detectar vulnerabilidades en el código o en dependencias.
- **Build/deploy automático** — si todo pasa, desplegar a producción o staging.

La idea central es que un Pull Request no se pueda mergear si alguno de estos checks falla (eso se configura como "required checks" en GitHub), lo cual obliga a mantener un estándar de calidad antes de que el código llegue a la rama principal, en vez de depender solo de que alguien lo revise a mano.

---

## 55. "¿Cómo se asegura que la data sensible se proteja en los branch?"

**1. GitHub Secrets** — para credenciales que necesitan los workflows (API keys, contraseñas de base de datos, tokens), nunca se ponen en el código ni en el YAML directamente. Se guardan en `Settings > Secrets and variables > Actions`, y se acceden así:

```yaml
steps:
  - name: Deploy
    env:
      API_KEY: ${{ secrets.API_KEY }}
    run: ./deploy.sh
```

El valor queda encriptado, no se puede ver una vez guardado, y GitHub automáticamente lo enmascara (lo reemplaza por `***`) si por error aparece en los logs del workflow.

**2. Environments con reglas de aprobación** — se pueden crear "environments" (por ejemplo `production`) con secrets propios, y exigir que alguien apruebe manualmente antes de que un workflow use esos secrets, evitando que cualquier PR los use libremente.

**3. Branch protection rules** — en `Settings > Branches`, se puede proteger la rama principal (`main`) exigiendo: que los checks de CI pasen antes de mergear, que se necesite al menos una revisión aprobada, y que nadie pueda hacer push directo sin pasar por un Pull Request. Esto evita que alguien suba código con secretos expuestos directamente a la rama principal sin revisión.

**4. Secret scanning** — GitHub tiene detección automática de secretos filtrados (API keys de proveedores conocidos, tokens) dentro del código subido, y puede bloquear el push (*push protection*) si detecta uno antes de que llegue al repositorio.

**5. `.gitignore` y variables de entorno** — a nivel de buenas prácticas, los archivos con datos sensibles (`.env`, credenciales locales) nunca se commitean, se listan en `.gitignore`, y el código las lee en tiempo de ejecución con variables de entorno, no hardcodeadas.

**6. Restricción por rama en los secrets** — los secrets se pueden limitar para que solo estén disponibles en ciertas ramas o environments (por ejemplo, que el secret de producción solo se use en workflows que corren sobre `main`, no en cualquier PR de una rama externa).

En resumen: los secretos nunca viven en el código ni en el historial de git, viven en la configuración de GitHub, se inyectan en tiempo de ejecución, y las branch protection rules aseguran que nadie los exponga saltándose la revisión.

---

## 56. "Git action workflow s"

Un **workflow** de GitHub Actions es un proceso automatizado que se define en un archivo YAML dentro de la carpeta `.github/workflows/` del repositorio. Cada archivo YAML es un workflow independiente, y un repositorio puede tener varios (uno para tests, otro para deploy, otro para linting, etc.).

Su estructura básica tiene estas partes:

```yaml
name: CI                    # nombre del workflow

on:                          # qué evento lo dispara
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:                        # los trabajos que se ejecutan (pueden correr en paralelo)
  test:
    runs-on: ubuntu-latest    # el "runner", la máquina donde corre

    steps:                    # pasos secuenciales dentro del job
      - name: Descargar el código
        uses: actions/checkout@v4

      - name: Configurar Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.12"

      - name: Instalar dependencias
        run: pip install -r requirements.txt

      - name: Correr tests
        run: pytest
```

Las partes clave:

- **`on`** — define el disparador: puede ser un `push`, un `pull_request`, un `schedule` (como un cron), o incluso disparo manual (`workflow_dispatch`).
- **`jobs`** — cada job corre en un runner separado (una máquina virtual limpia). Por defecto corren en paralelo, aunque se pueden encadenar con `needs: [otro_job]` si uno depende del resultado de otro.
- **`steps`** — dentro de un job, se ejecutan en orden, uno tras otro. Pueden ser comandos directos (`run:`) o **actions** reutilizables (`uses:`), que son bloques de código empaquetados que otros ya armaron (por ejemplo `actions/checkout` para bajar el código del repo, o `actions/setup-python` para instalar Python).
- **`runs-on`** — la máquina donde corre el job: `ubuntu-latest`, `windows-latest`, `macos-latest`, etc.

Un detalle importante: si un job tiene varios steps y alguno falla, por defecto el workflow se detiene ahí (a menos que se use `continue-on-error: true`). Y en `steps` con `run:` se pueden usar los secrets configurados con `${{ secrets.NOMBRE }}`.

---

## 57. "Dispatch"

`workflow_dispatch` es un tipo de disparador (`on`) que permite ejecutar un workflow **manualmente**, desde la interfaz de GitHub (pestaña Actions, botón "Run workflow") o vía API/CLI, en vez de que se dispare automáticamente por un `push` o `pull_request`.

```yaml
on:
  workflow_dispatch:
```

Sirve para workflows que no queremos que corran en cada commit, sino solo cuando alguien lo decide explícitamente — por ejemplo, un deploy a producción, generar un reporte, o correr una migración de datos puntual.

También se le pueden agregar inputs, para que la persona que lo dispara elija opciones antes de ejecutarlo:

```yaml
on:
  workflow_dispatch:
    inputs:
      ambiente:
        description: "Ambiente a desplegar"
        required: true
        default: "staging"
        type: choice
        options:
          - staging
          - production
```

Y dentro del workflow, ese valor se accede con `${{ github.event.inputs.ambiente }}`, por ejemplo para decidir a qué servidor desplegar según lo que la persona eligió al ejecutarlo manualmente desde la interfaz.

Se puede combinar con otros triggers en el mismo archivo, por ejemplo:

```yaml
on:
  push:
    branches: [main]
  workflow_dispatch:
```

Así el workflow corre automáticamente en cada push a `main`, pero también se puede disparar manualmente cuando haga falta, sin esperar a un nuevo commit.

---

## 58. "Bluegreen kubernetes"

**Blue-Green Deployment** en Kubernetes es una estrategia de despliegue donde se mantienen dos ambientes idénticos corriendo en paralelo — llamados "blue" (la versión actual, en producción) y "green" (la versión nueva) — y el tráfico se cambia de uno a otro de forma instantánea, en vez de actualizar gradualmente los pods existentes.

La idea general:

```
1. "Blue" está corriendo en producción, recibiendo todo el tráfico.
2. Se despliega "Green" con la nueva versión, en paralelo, sin recibir tráfico todavía.
3. Se prueba "Green" internamente (smoke tests, health checks).
4. Se cambia el Service para que apunte a "Green" en vez de "Blue".
5. Todo el tráfico pasa a "Green" de forma instantánea.
6. Si algo sale mal, se revierte el Service de vuelta a "Blue" (rollback inmediato).
7. Una vez confirmado que "Green" funciona bien, "Blue" se puede eliminar o dejar en standby para el próximo despliegue.
```

En Kubernetes, esto se implementa típicamente con dos Deployments separados y un Service que decide a cuál apuntar mediante `selector` (usando labels):

```yaml
# Deployment "blue" (versión actual)
metadata:
  labels:
    app: mi-app
    version: blue
---
# Deployment "green" (versión nueva)
metadata:
  labels:
    app: mi-app
    version: green
---
# Service — el switch se hace cambiando este selector
apiVersion: v1
kind: Service
metadata:
  name: mi-app-service
spec:
  selector:
    app: mi-app
    version: blue   # cambiar a "green" hace el switch de tráfico
  ports:
    - port: 80
```

La ventaja principal es el **rollback instantáneo**: si algo falla, basta con volver a cambiar el selector del Service a `blue`, sin tener que re-desplegar nada, porque la versión anterior sigue corriendo intacta. También evita el riesgo de tener una mezcla de versiones vieja/nueva atendiendo tráfico al mismo tiempo, algo que sí puede pasar con un *rolling update* tradicional.

La desventaja es el costo: durante la transición hay que mantener el doble de recursos corriendo (ambas versiones completas a la vez), aunque sea por poco tiempo.

Se diferencia de un **rolling update** (el default de Kubernetes con `Deployment`), que va reemplazando los pods de a poco, y de un **canary deployment**, que dirige solo un porcentaje pequeño del tráfico a la nueva versión antes de pasarla al 100%.

---

## 59. "Deployment"

Un **Deployment** en Kubernetes es un objeto que administra un conjunto de pods idénticos, encargándose de mantenerlos corriendo, escalarlos, y actualizarlos de forma controlada. Es el recurso más usado para desplegar aplicaciones sin estado (stateless), como una API o un backend web.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mi-app
spec:
  replicas: 3                     # cuántos pods idénticos mantener corriendo
  selector:
    matchLabels:
      app: mi-app
  template:                       # la plantilla del pod que va a crear
    metadata:
      labels:
        app: mi-app
    spec:
      containers:
        - name: mi-app
          image: mi-app:v1.2
          ports:
            - containerPort: 8000
```

Lo que hace el Deployment por detrás:

- Crea y mantiene la cantidad de **réplicas** definidas (`replicas: 3`); si un pod se cae, lo vuelve a crear automáticamente.
- Permite **escalar** fácilmente: `kubectl scale deployment mi-app --replicas=5`.
- Maneja **actualizaciones** de forma controlada: al cambiar la imagen (`image: mi-app:v1.3`) y aplicar el cambio, por defecto hace un **rolling update**, reemplazando los pods viejos por nuevos de a poco, sin downtime.
- Permite hacer **rollback** a la versión anterior si algo sale mal: `kubectl rollout undo deployment mi-app`.
- Internamente, un Deployment no maneja los pods directamente, sino que crea y controla un **ReplicaSet**, que es el que realmente asegura que el número de pods coincida con lo declarado.

Es la base sobre la que se construyen estrategias más específicas como la de blue-green vista antes: en ese caso, en vez de dejar que un solo Deployment haga rolling update automático, se crean dos Deployments separados (blue y green) y se controla manualmente el cambio de tráfico entre ellos usando el Service.

---

## 60. "Databases performance"

Temas clave de **rendimiento de bases de datos** que suelen salir en entrevistas:

**Índices**
- Aceleran las lecturas, pero cada índice ralentiza los `INSERT`/`UPDATE`/`DELETE` porque hay que mantenerlo actualizado.
- Un índice mal elegido (o que nunca se usa) solo agrega overhead sin beneficio.

**Análisis de queries**
- `EXPLAIN`/`EXPLAIN ANALYZE` muestra el plan de ejecución: si usa un índice, si hace un *full table scan*, cuántas filas revisa.
- El *slow query log* de la base de datos identifica qué consultas están tardando más en producción.

**Problema N+1**
- Ejecutar una query extra por cada fila de un resultado, en vez de traer todo junto con un `JOIN` o con `select_related`/`prefetch_related` en Django. Es de los problemas de performance más comunes y más preguntados.

**Normalización vs desnormalización**
- Normalizar reduce duplicación pero agrega joins. Desnormalizar acelera lecturas a costa de mayor complejidad al escribir y mantener consistencia.

**Caching**
- Evitar golpear la base de datos para datos que no cambian seguido, usando Redis o Memcached delante de la base.

**Connection pooling**
- Reutilizar conexiones en vez de abrir una nueva por cada request, porque abrir una conexión es una operación costosa.

**Particionamiento y sharding**
- Partitioning divide una tabla grande en partes más chicas (por rango de fechas, por ejemplo) para que las queries no tengan que revisar todo.
- Sharding distribuye los datos entre varios servidores cuando una sola base ya no da abasto.

**Réplicas de lectura (read replicas)**
- Separar las queries de lectura de las de escritura, distribuyendo la carga entre varias instancias de la base de datos.

**Batch operations**
- Hacer una sola operación con muchos registros (`bulk_create`, `bulk_update` en Django) en vez de una query por cada registro individual.

**Locking y transacciones**
- Transacciones largas o mal manejadas generan bloqueos que frenan a otras consultas concurrentes.

---

## 61. "Isolación transacción isolation levels"

Los **niveles de aislamiento de transacciones** definen qué tanto una transacción puede ver los cambios que otra transacción está haciendo al mismo tiempo, antes de que esa otra termine (`commit`). Es un balance entre consistencia de datos y rendimiento/concurrencia: a mayor aislamiento, más seguridad pero menos concurrencia (más bloqueos).

Primero, los problemas que estos niveles buscan evitar:

- **Dirty read** — leer datos que otra transacción modificó pero todavía no confirmó (`commit`); si esa transacción hace rollback, se leyó algo que nunca existió realmente.
- **Non-repeatable read** — leer el mismo registro dos veces dentro de la misma transacción y obtener valores distintos, porque otra transacción lo modificó y confirmó en el medio.
- **Phantom read** — ejecutar la misma query dos veces dentro de la misma transacción y obtener una cantidad distinta de filas, porque otra transacción insertó o borró registros que cumplen la condición.

Los cuatro niveles estándar (definidos por el estándar SQL), de menor a mayor aislamiento:

**1. Read Uncommitted** — el nivel más débil. Permite dirty reads: se puede leer datos que otra transacción todavía no confirmó. Casi no se usa en la práctica.

**2. Read Committed** — solo se pueden leer datos ya confirmados por otras transacciones. Evita dirty reads, pero no evita non-repeatable reads ni phantom reads. Es el nivel por defecto en PostgreSQL y en SQL Server.

**3. Repeatable Read** — garantiza que, si se lee el mismo registro dos veces dentro de la misma transacción, siempre va a devolver el mismo valor. Evita dirty reads y non-repeatable reads, pero en teoría permite phantom reads (aunque en MySQL/InnoDB, este nivel además evita phantom reads gracias a su implementación específica). Es el nivel por defecto en MySQL.

**4. Serializable** — el nivel más estricto. Las transacciones se comportan como si se ejecutaran una tras otra, completamente aisladas entre sí, aunque en realidad corran en paralelo. Evita los tres problemas, pero es el que más impacta en el rendimiento porque genera más bloqueos y más posibilidad de que una transacción falle y tenga que reintentarse.

En resumen: a medida que subes de nivel, ganas consistencia pero perdés concurrencia (más bloqueos, más lentitud). La elección depende del caso: para un sistema bancario probablemente convenga `Serializable` en operaciones críticas, mientras que para un dashboard de solo lectura `Read Committed` suele ser más que suficiente.

---

## 62. "Performance en DDB" (DynamoDB)

Interpretado como **DynamoDB** (la base de datos NoSQL de AWS):

**Diseño de la Partition Key**
- Es lo más importante en DynamoDB. Los datos se distribuyen entre particiones físicas según el hash de la partition key. Si la key está mal elegida (por ejemplo, un campo con pocos valores distintos), se genera un **hot partition**: toda la carga cae sobre una sola partición en vez de repartirse, y eso limita el throughput real aunque hayas aprovisionado mucha capacidad.

**Read/Write Capacity**
- Modo **provisioned**: defines cuántas lecturas y escrituras por segundo esperás, y pagas por eso, con posibilidad de auto-scaling.
- Modo **on-demand**: escala automáticamente según el tráfico real, sin planificar capacidad, pero cuesta más por operación.

**Tipos de lectura**
- **Eventually consistent read** (default, más barato): puede devolver datos ligeramente desactualizados justo después de una escritura reciente.
- **Strongly consistent read**: siempre devuelve el dato más reciente, pero consume el doble de capacidad y es un poco más lenta.

**Query vs Scan**
- `Query` busca usando la partition key (y opcionalmente un rango con la sort key) — es eficiente porque va directo a la partición correspondiente.
- `Scan` recorre toda la tabla revisando cada item — es lento y costoso a medida que la tabla crece, hay que evitarlo salvo casos puntuales.

**Índices secundarios**
- **GSI (Global Secondary Index)**: permite consultar por un atributo distinto a la partition key principal, con su propia capacidad de lectura/escritura.
- **LSI (Local Secondary Index)**: comparte la misma partition key que la tabla, pero con una sort key distinta. Se debe definir al crear la tabla, no se puede agregar después.

**Item size**
- El tamaño máximo de un item es 400 KB. Items muy grandes consumen más capacidad por operación, así que conviene mantenerlos livianos, y separar datos pesados (como archivos) en S3, guardando solo la referencia en DynamoDB.

**Batch operations**
- `BatchGetItem` y `BatchWriteItem` permiten leer o escribir varios items en una sola llamada, reduciendo el número de round-trips a la red.

**DAX (DynamoDB Accelerator)**
- Una capa de caché en memoria delante de DynamoDB, para acelerar lecturas repetidas sin tener que rediseñar la aplicación.

En resumen: en DynamoDB el rendimiento depende mucho más del **diseño del modelo de datos** (elegir bien la partition key y evitar `Scan`) que de "optimizaciones" clásicas de SQL como índices o joins, porque DynamoDB no tiene joins — el modelado se hace pensando primero en cómo se va a consultar la data (*access patterns*), no en la normalización de los datos.

---

## 63. "Performance" (aclaración por pregunta ambigua)

Se pidió aclaración al usuario mediante una pregunta de selección, que respondió: **"Performance de aplicaciones web (backend/frontend)"**.

Respuesta dada:

**Backend**

- **Caching** — guardar resultados costosos (queries, cálculos, respuestas de API) en Redis/Memcached para no recalcularlos en cada request.
- **Optimización de queries** — evitar el problema N+1, usar índices, paginar resultados grandes.
- **Operaciones asíncronas** — mover tareas lentas (enviar emails, generar reportes) a background jobs (Celery) en vez de bloquear la respuesta del request.
- **Connection pooling** — reutilizar conexiones a la base de datos en vez de abrir una nueva por cada request.
- **Compresión de respuestas** — usar gzip/brotli para reducir el tamaño de las respuestas HTTP.
- **Load balancing** — distribuir el tráfico entre varias instancias del servidor para que ninguna se sature.
- **Profiling** — herramientas como `django-debug-toolbar`, `cProfile`, o New Relic/Datadog para identificar qué parte del código realmente está tardando, en vez de optimizar a ciegas.
- **CDN** — servir archivos estáticos (imágenes, CSS, JS) desde una red de distribución cercana al usuario, en vez de desde el propio servidor.

**Frontend**

- **Lazy loading** — cargar imágenes, componentes o rutas solo cuando se necesitan, no todo de entrada.
- **Code splitting** — dividir el bundle de JavaScript en partes más chicas, cargando solo lo necesario para cada página.
- **Minimizar requests** — combinar archivos, usar sprites, reducir llamadas innecesarias a la API.
- **Caching del navegador** — headers HTTP (`Cache-Control`, `ETag`) para que el navegador no vuelva a descargar recursos que no cambiaron.
- **Optimización de imágenes** — formatos modernos (WebP), tamaños adecuados según el dispositivo.
- **Renderizado** — Server-Side Rendering (SSR) o Static Site Generation (SSG) para que la primera carga sea más rápida, en vez de depender solo de Client-Side Rendering.
- **Métricas clave** — Core Web Vitals: LCP (tiempo de carga del contenido principal), FID/INP (tiempo de respuesta a interacción), CLS (estabilidad visual).

**General (medición)**

- Medir antes de optimizar: sin datos reales de dónde está el cuello de botella, cualquier optimización es una apuesta a ciegas.
- Distinguir **latencia** (tiempo de una sola operación) de **throughput** (cuántas operaciones por segundo soporta el sistema).

---

## 64. "DB / a nivel DB"

A nivel base de datos, dentro de performance de aplicaciones web, los puntos clave son:

**Índices**
- Crear índices en columnas usadas en `WHERE`, `JOIN`, `ORDER BY`. Sin índice, cada consulta hace un *full table scan* (revisa fila por fila).
- No abusar: cada índice ralentiza los `INSERT`/`UPDATE`.

**Queries eficientes**
- Evitar `SELECT *`, traer solo columnas necesarias.
- Evitar el problema N+1 (Django): usar `select_related` para ForeignKey/OneToOne y `prefetch_related` para ManyToMany, así se hace un solo query (o pocos) en vez de uno por cada fila.
- Paginar resultados grandes en vez de traer todo de una vez.

**Análisis**
- `EXPLAIN ANALYZE` para ver si una query usa el índice o hace scan completo.
- *Slow query log* de la base de datos para detectar en producción qué consultas están tardando más.

**Caching a nivel DB**
- Guardar en Redis/Memcached el resultado de queries pesadas y repetidas, para no golpear la base de datos en cada request.
- Vistas materializadas (*materialized views*) en PostgreSQL, para precalcular resultados de queries complejas y consultarlas como si fueran una tabla.

**Conexiones**
- Connection pooling (por ejemplo `pgbouncer` para PostgreSQL), para no abrir una conexión nueva por cada request.

**Escritura eficiente**
- Operaciones en lote: `bulk_create`, `bulk_update` en Django, en vez de guardar registro por registro con un `save()` dentro de un loop.

**Escalamiento**
- Réplicas de lectura (*read replicas*), separando queries de lectura de las de escritura.
- Particionamiento de tablas grandes, por ejemplo por fecha.

En una app Django típica, el 80% del problema real termina siendo el **N+1** y la **falta de índices** — son los dos puntos que más se preguntan y más impacto tienen en la práctica.

---

## 65. "ACED properties" (interpretado como ACID)

**A — Atomicity (Atomicidad)**
Una transacción se ejecuta completa o no se ejecuta en absoluto. Si algún paso falla en el medio, se revierte todo (`rollback`), no queda la operación a medias. Ejemplo: transferir dinero entre cuentas — si se descuenta de una cuenta pero falla al acreditar en la otra, la transacción entera se cancela, no queda el dinero "perdido".

**C — Consistency (Consistencia)**
La transacción lleva la base de datos de un estado válido a otro estado válido, respetando todas las reglas definidas (constraints, foreign keys, validaciones). No puede dejar datos que violen la integridad del esquema.

**I — Isolation (Aislamiento)**
Las transacciones que corren al mismo tiempo no deberían interferir entre sí, como si se ejecutaran una detrás de otra aunque en realidad corran en paralelo. Esto es justamente lo que controlan los **niveles de aislamiento** (Read Committed, Repeatable Read, Serializable, etc.) — más aislamiento, más seguridad, pero menos concurrencia.

**D — Durability (Durabilidad)**
Una vez que la transacción se confirma (`commit`), el cambio queda guardado de forma permanente, incluso si el sistema se cae inmediatamente después (por ejemplo, un corte de luz). Esto se logra escribiendo los cambios en disco, no solo en memoria.

En resumen, ACID es lo que garantiza que una base de datos relacional (PostgreSQL, MySQL) sea confiable ante fallos y concurrencia. Es un buen contraste para cuando se habla de bases NoSQL como DynamoDB, que suelen priorizar disponibilidad y escalabilidad por sobre garantías ACID estrictas, siguiendo en cambio el modelo **BASE** (Basically Available, Soft state, Eventually consistent).

---

## 66. "ACID" (repetida)

Se le indicó al usuario que la pregunta ya había sido respondida arriba (entrada 65), y se ofrecieron alternativas: ejemplo práctico de cada propiedad, comparación con BASE, o cómo se implementa en Django (`transaction.atomic()`).

---

## 67. "Testing"

Temas clave de **testing** en Python/Django para entrevista:

**Tipos de tests**
- **Unit tests** — prueban una unidad de código aislada (una función, un método), sin dependencias externas reales (se usan mocks).
- **Integration tests** — prueban que varias piezas funcionen bien juntas (por ejemplo, una vista que sí toca la base de datos real de test).
- **End-to-end (E2E)** — prueban el flujo completo como lo usaría un usuario real, típicamente a través de la interfaz (Selenium, Playwright, Cypress).

**Herramientas en Python**
- `unittest` — el framework de testing incluido en la librería estándar, basado en clases (`TestCase`).
- `pytest` — el más usado en la práctica, más simple de escribir (funciones sueltas en vez de clases obligatorias), con fixtures y un ecosistema grande de plugins.

```python
def test_suma():
    assert sumar(2, 3) == 5
```

**Django específico**
- `django.test.TestCase` — extiende `unittest.TestCase`, y envuelve cada test en una transacción que se revierte al final, así los tests no dejan basura en la base de datos ni se afectan entre sí.
- `Client` de Django — simula peticiones HTTP a las vistas sin necesitar un servidor real corriendo.

```python
from django.test import TestCase, Client

class ProductoTests(TestCase):
    def test_lista_productos(self):
        client = Client()
        response = client.get("/productos/")
        self.assertEqual(response.status_code, 200)
```

**Mocking**
- `unittest.mock` (o `pytest-mock`) para reemplazar dependencias externas (una API, el envío de un email) por un doble falso.

```python
from unittest.mock import patch

@patch("mi_app.services.enviar_email")
def test_registro_envia_email(mock_enviar):
    registrar_usuario("juan@mail.com")
    mock_enviar.assert_called_once()
```

**Fixtures**
- Datos de prueba predefinidos para dejar la base de datos en un estado conocido antes de correr un test, ya sea con `pytest` (`@pytest.fixture`) o con archivos JSON/YAML de fixtures de Django.

**Coverage**
- La herramienta `coverage.py` mide qué porcentaje del código realmente se ejecuta durante los tests, para detectar partes sin cubrir. No es garantía de calidad (se puede tener 100% de cobertura con tests malos), pero ayuda a detectar código completamente sin probar.

**TDD (Test-Driven Development)**
- Metodología donde se escribe el test primero (que falla), después el código mínimo para que pase, y luego se refactoriza. El ciclo se resume como *red-green-refactor*.

**Buenas prácticas**
- Tests independientes entre sí (que no dependan del orden de ejecución).
- Nombres descriptivos que digan qué se está probando y qué se espera.
- No testear el código de terceros/framework, solo la lógica propia.

---

## 68. "Python core testing, tengo un método response y get de response y creo el método, ¿cómo lo creo el unit test?"

Ejemplo del método a testear:

```python
import requests

def obtener_nombre_usuario(usuario_id):
    response = requests.get(f"https://api.ejemplo.com/usuarios/{usuario_id}")
    data = response.json()
    return data.get("nombre")
```

Se usa `unittest.mock` para no hacer una llamada HTTP real en el test:

```python
from unittest.mock import patch, Mock
from mi_app.servicios import obtener_nombre_usuario

@patch("mi_app.servicios.requests.get")
def test_obtener_nombre_usuario(mock_get):
    # armamos una respuesta falsa
    mock_response = Mock()
    mock_response.json.return_value = {"nombre": "Juan"}
    mock_get.return_value = mock_response

    resultado = obtener_nombre_usuario(1)

    assert resultado == "Juan"
    mock_get.assert_called_once_with("https://api.ejemplo.com/usuarios/1")
```

Puntos clave del ejemplo:

- `@patch("mi_app.servicios.requests.get")` reemplaza `requests.get` **solo dentro de ese test**, y solo en el módulo donde se importa.
- `Mock()` crea un objeto falso al que le podemos configurar cualquier atributo o método, como `mock_response.json.return_value = {...}`.
- Con `mock_get.assert_called_once_with(...)` verificamos que el método bajo test llamó a `requests.get` con los argumentos correctos.

Si en cambio el caso es un `response` que ya es un diccionario (no un objeto con `.json()`):

```python
def procesar(response):
    return response.get("nombre")

def test_procesar():
    resultado = procesar({"nombre": "Juan"})
    assert resultado == "Juan"

def test_procesar_sin_nombre():
    resultado = procesar({})
    assert resultado is None
```

---

## 69. "Dame el flujo" (flujo para crear un unit test)

```
1. Identificar qué método/función se va a testear
   → obtener_nombre_usuario(usuario_id)

2. Identificar sus dependencias externas
   → llama a requests.get() (una API externa) — esto hay que mockear,
     no se debe llamar a la API real en un test

3. Definir los casos a cubrir
   → caso feliz: la API responde con el nombre
   → caso borde: la API responde sin el campo "nombre"
   → caso error: la API falla o devuelve un error

4. Escribir el test (patrón AAA: Arrange, Act, Assert)
   → Arrange: preparar los datos/mocks necesarios
   → Act: ejecutar el método bajo test
   → Assert: verificar que el resultado es el esperado

5. Mockear la dependencia externa
   → @patch("mi_app.servicios.requests.get")
   → configurar qué debe devolver el mock

6. Ejecutar el test y ver que pase
   → pytest test_servicios.py -v

7. Provocar que falle a propósito (opcional pero recomendado)
   → cambiar el assert o el mock para confirmar que el test
     realmente detecta un error si el código se rompe

8. Repetir para cada caso identificado en el paso 3
```

Casos de ejemplo (borde y error):

```python
@patch("mi_app.servicios.requests.get")
def test_obtener_nombre_usuario_sin_nombre_en_respuesta(mock_get):
    # Arrange
    mock_response = Mock()
    mock_response.json.return_value = {}   # sin campo "nombre"
    mock_get.return_value = mock_response

    # Act
    resultado = obtener_nombre_usuario(1)

    # Assert
    assert resultado is None


@patch("mi_app.servicios.requests.get")
def test_obtener_nombre_usuario_api_falla(mock_get):
    # Arrange
    mock_get.side_effect = requests.exceptions.ConnectionError

    # Act / Assert
    with pytest.raises(requests.exceptions.ConnectionError):
        obtener_nombre_usuario(1)
```

---

## 70. "Comandos" (testing)

**pytest**
```bash
pytest                          # corre todos los tests
pytest test_servicios.py        # corre un archivo específico
pytest test_servicios.py::test_obtener_nombre_usuario   # corre un test específico
pytest -v                       # modo verbose, muestra cada test por nombre
pytest -k "usuario"             # corre solo tests cuyo nombre contenga "usuario"
pytest -x                       # se detiene en el primer test que falla
pytest --lf                     # corre solo los tests que fallaron la última vez
pytest -s                       # muestra los print() dentro de los tests
pytest --cov=mi_app             # corre con reporte de cobertura
pytest --cov=mi_app --cov-report=html   # reporte de cobertura en HTML
pytest -m "slow"                # corre solo tests marcados con @pytest.mark.slow
```

**unittest (estándar de Python)**
```bash
python -m unittest                          # corre todos los tests detectados
python -m unittest test_servicios            # corre un módulo específico
python -m unittest test_servicios.ProductoTests.test_lista   # un test específico
python -m unittest -v                        # modo verbose
```

**Django**
```bash
python manage.py test                       # corre todos los tests del proyecto
python manage.py test mi_app                # corre los tests de una app específica
python manage.py test mi_app.tests.ProductoTests   # un caso de test específico
python manage.py test mi_app.tests.ProductoTests.test_lista   # un test puntual
python manage.py test --keepdb              # reutiliza la base de datos de test entre corridas
python manage.py test --parallel            # corre los tests en paralelo
python manage.py test --failfast            # se detiene en el primer fallo
```

**Coverage (independiente de pytest)**
```bash
coverage run manage.py test        # corre los tests midiendo cobertura
coverage report                    # muestra el reporte en la terminal
coverage html                      # genera un reporte navegable en HTML
```

---

## 71. "Para end-to-end cuáles librerías"

**Para aplicaciones web (navegador)**
- **Selenium** — la más clásica y veterana, controla navegadores reales (Chrome, Firefox, etc.) simulando clicks, escritura, navegación. Tiene bindings para Python (`selenium` en PyPI).
- **Playwright** — la más moderna, de Microsoft. Más rápida y estable que Selenium, con mejor manejo de esperas automáticas. Tiene binding oficial para Python (`playwright`).
- **Cypress** — muy popular, pero es JavaScript/TypeScript puro (no tiene binding Python nativo), corre dentro del navegador directamente.

**Específicas de Django**
- **`django.test.LiveServerTestCase`** — levanta un servidor Django real en un puerto de prueba, para poder combinarlo con Selenium/Playwright y probar el flujo completo contra la app real, no simulada.

```python
from django.contrib.staticfiles.testing import StaticLiveServerTestCase
from selenium import webdriver

class LoginE2ETest(StaticLiveServerTestCase):
    def setUp(self):
        self.browser = webdriver.Chrome()

    def tearDown(self):
        self.browser.quit()

    def test_login(self):
        self.browser.get(f"{self.live_server_url}/login/")
        self.browser.find_element("name", "username").send_keys("juan")
        self.browser.find_element("name", "password").send_keys("1234")
        self.browser.find_element("id", "submit").click()
        assert "Bienvenido" in self.browser.page_source
```

**Para APIs (E2E sin navegador, probando endpoints completos)**
- **`requests`** — para pegarle a una API real corriendo, simulando un cliente externo.
- **`httpx`** — similar a `requests`, pero con soporte async, útil si la API es asíncrona (FastAPI, Django async views).

**Mobile / apps**
- **Appium** — para E2E en apps móviles (iOS/Android).

Para un proyecto Django típico con frontend server-rendered, lo más común hoy es **Playwright** combinado con `StaticLiveServerTestCase` de Django. Si el frontend es una SPA separada (React), ahí Cypress o Playwright también, pero corriendo contra el build del frontend.

---

## 72. "Diseño de patrones"

Listado de **patrones de diseño** que suelen salir en entrevistas de Python:

**Creacionales** (cómo se crean los objetos)
- **Singleton** — asegura que una clase tenga una única instancia. Ejemplo: una conexión de configuración compartida.
- **Factory Method** — delega la creación de objetos a un método, en vez de instanciar directamente con `MiClase()`.
- **Abstract Factory** — una fábrica de fábricas, crea familias de objetos relacionados sin especificar sus clases concretas.
- **Builder** — construye un objeto complejo paso a paso, separando la construcción de la representación final.

**Estructurales** (cómo se organizan las clases/objetos)
- **Adapter** — convierte la interfaz de una clase en otra que el cliente espera.
- **Decorator** — agrega comportamiento a un objeto/función dinámicamente sin modificar su código.
- **Facade** — expone una interfaz simple por encima de un sistema complejo.
- **Proxy** — un objeto que actúa como intermediario/sustituto de otro, controlando el acceso a él.

**De comportamiento** (cómo interactúan los objetos)
- **Observer** — un objeto ("sujeto") notifica automáticamente a una lista de "observadores" cuando cambia su estado. Base de los signals en Django.
- **Strategy** — define una familia de algoritmos intercambiables, elegido en tiempo de ejecución.
- **Command** — encapsula una acción como un objeto, para poder guardarla, encolarla o deshacerla después.
- **Iterator** — permite recorrer una colección sin exponer su estructura interna.
- **Template Method** — define el esqueleto de un algoritmo en una clase base, dejando que las subclases redefinan pasos puntuales.

**Relación con Django/Python específicamente**
- Django usa **Observer** en su sistema de signals (`post_save`, `pre_delete`).
- Django usa **Template Method** en las Class-Based Views (`get()`, `post()` que las subclases sobreescriben).
- Los decoradores de Python son básicamente el patrón **Decorator** llevado al lenguaje mismo.
- DRF usa **Strategy** en sus clases de paginación/autenticación intercambiables.

---

## 73. "Decorator" (patrón de diseño, con código)

El **patrón Decorator** (a nivel de diseño de software) consiste en envolver un objeto con otro objeto que tiene la misma interfaz, para agregarle comportamiento sin modificar su clase original ni usar herencia.

**Ejemplo clásico (orientado a objetos, sin la sintaxis `@`):**

```python
from abc import ABC, abstractmethod

class Cafe(ABC):
    @abstractmethod
    def costo(self):
        pass

class CafeSimple(Cafe):
    def costo(self):
        return 2.0

class DecoradorCafe(Cafe):
    def __init__(self, cafe):
        self._cafe = cafe   # envuelve al objeto original

class ConLeche(DecoradorCafe):
    def costo(self):
        return self._cafe.costo() + 0.5

class ConChocolate(DecoradorCafe):
    def costo(self):
        return self._cafe.costo() + 0.8

pedido = ConChocolate(ConLeche(CafeSimple()))
print(pedido.costo())   # 2.0 + 0.5 + 0.8 = 3.3
```

Cada "decorador" envuelve al objeto anterior, cumple la misma interfaz (`costo()`), y le agrega algo encima. Se pueden combinar en cualquier orden y cantidad, sin tocar la clase `CafeSimple` ni crear una subclase por cada combinación posible.

**La sintaxis `@` de Python es una implementación simplificada de esta misma idea, pero para funciones:**

```python
@con_log
def sumar(a, b):
    return a + b
```

Acá `con_log` envuelve a `sumar` y le agrega comportamiento (el log), exactamente el mismo principio que el ejemplo del café, solo que aplicado a funciones en vez de objetos.

La idea central en ambos casos: agregar responsabilidades a un objeto/función dinámicamente, en vez de usar herencia estática, lo que da más flexibilidad para combinar comportamientos sin generar una explosión de subclases.

---

## 74. "Singleton"

El **patrón Singleton** asegura que una clase tenga una única instancia en toda la aplicación, y provee un punto de acceso global a ella. Se usa cuando algo debe existir una sola vez: una conexión de configuración, un logger, un pool de conexiones.

**Forma más común, sobreescribiendo `__new__`:**

```python
class Singleton:
    _instancia = None

    def __new__(cls, *args, **kwargs):
        if cls._instancia is None:
            cls._instancia = super().__new__(cls)
        return cls._instancia

class Configuracion(Singleton):
    def __init__(self):
        self.valor = "config cargada"

a = Configuracion()
b = Configuracion()
print(a is b)   # True, es el mismo objeto
```

**Con un decorador:**

```python
def singleton(cls):
    instancias = {}
    def obtener_instancia(*args, **kwargs):
        if cls not in instancias:
            instancias[cls] = cls(*args, **kwargs)
        return instancias[cls]
    return obtener_instancia

@singleton
class Configuracion:
    def __init__(self):
        self.valor = "config cargada"

a = Configuracion()
b = Configuracion()
print(a is b)   # True
```

**La forma más "pythonica"**, aprovechando que los módulos en Python se cargan una sola vez:

```python
# config.py
class _Configuracion:
    def __init__(self):
        self.valor = "config cargada"

instancia = _Configuracion()
```

```python
# en otro archivo
from config import instancia
```

**Thread-safety**: la versión con `__new__` no es thread-safe por defecto — dos threads podrían pasar la condición `if cls._instancia is None` al mismo tiempo y crear dos instancias. Para eso se agrega un `Lock`:

```python
import threading

class Singleton:
    _instancia = None
    _lock = threading.Lock()

    def __new__(cls, *args, **kwargs):
        with cls._lock:
            if cls._instancia is None:
                cls._instancia = super().__new__(cls)
        return cls._instancia
```

Crítica común: el Singleton a veces se considera un **anti-patrón**, porque introduce estado global oculto, dificulta el testing (los tests se pisan entre sí si comparten la misma instancia), y crea acoplamiento fuerte. En Django, por ejemplo, casi nunca se necesita implementarlo manualmente porque `settings` ya cumple ese rol.

---

## 75. "Explícame metodologías ágiles Scrum"

**Metodologías ágiles**

Son un conjunto de enfoques para gestionar proyectos de software basados en el **Manifiesto Ágil** (2001), que prioriza:

- Individuos e interacciones, por sobre procesos y herramientas.
- Software funcionando, por sobre documentación extensa.
- Colaboración con el cliente, por sobre negociación de contratos.
- Responder al cambio, por sobre seguir un plan rígido.

La idea central es entregar valor de forma incremental y frecuente, en vez del modelo tradicional "cascada" (Waterfall), donde se planifica todo de entrada y se entrega recién al final del proyecto.

Existen varios marcos que implementan esta filosofía: **Scrum** (el más usado), **Kanban**, **XP (Extreme Programming)**, entre otros.

**Scrum**

Es un marco de trabajo concreto dentro de ágil, con roles, eventos y artefactos bien definidos.

**Roles:**
- **Product Owner** — define y prioriza qué se construye, representa la voz del negocio/cliente, mantiene el backlog.
- **Scrum Master** — facilita el proceso, remueve obstáculos del equipo, se asegura de que se sigan las prácticas de Scrum. No es un jefe del equipo.
- **Equipo de desarrollo** — el grupo que efectivamente construye el producto.

**Eventos (ceremonias):**
- **Sprint** — el ciclo de trabajo, normalmente de 1 a 4 semanas.
- **Sprint Planning** — al inicio del sprint, se decide qué tareas del backlog se van a trabajar.
- **Daily Standup** — reunión corta diaria (15 min), cada persona cuenta qué hizo ayer, qué va a hacer hoy, y si tiene algún bloqueo.
- **Sprint Review** — al final del sprint, se muestra lo construido a los interesados (stakeholders).
- **Retrospective** — el equipo reflexiona sobre cómo trabajó para el próximo sprint.

**Artefactos:**
- **Product Backlog** — la lista completa y priorizada de todo lo que el producto podría necesitar.
- **Sprint Backlog** — el subconjunto de tareas del backlog elegidas para el sprint actual.
- **Increment** — el resultado tangible y funcional al final de cada sprint.

**Conceptos relacionados:**
- **User Story** — "Como [rol], quiero [funcionalidad], para [beneficio]".
- **Story Points** — una medida relativa de esfuerzo/complejidad, no de tiempo exacto.
- **Velocity** — cuántos story points completa el equipo en promedio por sprint.
- **Backlog grooming/refinement** — sesión donde se revisa y afina el backlog.

**Diferencia rápida con Kanban:** Scrum trabaja en sprints con duración fija y roles definidos; Kanban es un flujo continuo, sin sprints, donde se visualiza el trabajo en un tablero (To Do / In Progress / Done) y se limita cuánto trabajo puede estar "en progreso" a la vez.

---

## 76. "Claude computer use tool on AWS Bedrock - availability, models, setup"

Sí, está disponible, pero en **beta** — igual que en el resto de las plataformas (API directa de Anthropic, Claude Platform on AWS, Bedrock, Vertex AI y Microsoft Foundry). No es GA en ninguna.

Puntos clave para configurarlo en Bedrock:

- **Cliente**: usar `AnthropicBedrockMantle` (el cliente moderno para el endpoint tipo Messages API sobre Bedrock), no el `AnthropicBedrock` legacy. Requiere región de AWS.
- **IDs de modelo con prefijo**: en Bedrock los modelos llevan el prefijo `anthropic.`, por ejemplo `anthropic.claude-sonnet-5` o `anthropic.claude-opus-4-8`.
- **Es una tool client-side (o self-hosted)**: la aplicación tiene que proveer el entorno — la captura de pantalla, y ejecutar los clicks/teclas que Claude solicita.
- **Tool type**: la versión más reciente vista en la documentación es `computer_20251124`, que requiere el header beta `computer-use-2025-11-24`.

Lo que no está confirmado desde la documentación cargada es el listado exacto de qué modelos soportan computer use en Bedrock específicamente — para eso se recomendó consultar la documentación en vivo antes de implementarlo.

---

## 77. "S3 explícame AWS"

**AWS (Amazon Web Services)**

Es la plataforma de servicios en la nube de Amazon: en vez de comprar y mantener tus propios servidores físicos, contratás recursos de cómputo, almacenamiento, bases de datos, redes, etc., y pagás según el uso (modelo *pay-as-you-go*). Es el proveedor de nube más grande del mercado, junto con Google Cloud y Microsoft Azure.

Algunos servicios core de AWS:
- **EC2** — máquinas virtuales (servidores) en la nube.
- **S3** — almacenamiento de archivos.
- **RDS** — bases de datos relacionales administradas (PostgreSQL, MySQL, etc.).
- **Lambda** — funciones sin servidor (*serverless*).
- **IAM** — manejo de permisos y usuarios.
- **VPC** — redes privadas virtuales.
- **CloudFront** — CDN.

**S3 (Simple Storage Service)**

Es el servicio de almacenamiento de objetos de AWS. Sirve para guardar archivos —imágenes, videos, backups, logs, archivos estáticos de una web— de forma duradera y escalable, sin límite práctico de espacio.

Conceptos clave:

- **Bucket** — contenedor donde se guardan archivos. El nombre tiene que ser único a nivel global.
- **Object (objeto)** — el archivo en sí, identificado por una **key** (la ruta/nombre dentro del bucket).
- No hay carpetas reales; se simula la jerarquía con las keys usando `/`.

Características importantes:

- **Durabilidad altísima** (99.999999999%, "11 nueves").
- **Clases de almacenamiento**: `Standard`, `Infrequent Access`, `Glacier`.
- **Control de acceso**: bucket policies e IAM.
- **Versionado**: mantener versiones anteriores de un archivo.
- **URLs firmadas (presigned URLs)**: acceso temporal a un archivo privado.

Casos de uso típicos: guardar archivos que suben los usuarios de una app, hosting de sitios estáticos, backups de base de datos, data lakes.

---

## 78. "S3 layer level"

Interpretado como **capas/niveles de almacenamiento (storage classes) de S3**:

| Clase | Uso típico | Costo | Latencia de acceso |
|---|---|---|---|
| **S3 Standard** | Datos de acceso frecuente | Más caro por GB, sin costo de recuperación | Milisegundos |
| **S3 Intelligent-Tiering** | Cuando no se sabe con qué frecuencia se va a acceder | Mueve automáticamente el archivo entre capas | Milisegundos |
| **S3 Standard-IA** (Infrequent Access) | Datos que se acceden poco pero se necesitan rápido | Más barato, pero cobra por recuperación | Milisegundos |
| **S3 One Zone-IA** | Igual que Standard-IA pero en una sola zona de disponibilidad | Más barato, menos durable | Milisegundos |
| **S3 Glacier Instant Retrieval** | Archivado, acceso inmediato ocasional | Muy barato | Milisegundos |
| **S3 Glacier Flexible Retrieval** | Archivado a largo plazo | Muy barato | Minutos a horas |
| **S3 Glacier Deep Archive** | Archivado de larguísimo plazo | El más barato | Horas (hasta 12h) |

La idea central: cuanto más rápido se necesita acceder al archivo, más caro es guardarlo por GB; cuanto más "dormido" puede estar el dato, más barato sale guardarlo, a cambio de tardar más en recuperarlo.

**Lifecycle policies** — reglas automáticas para que un objeto pase de una capa a otra según su antigüedad (ej. después de 30 días sin acceso, mover a Standard-IA; después de 90 días, a Glacier; después de 365 días, borrar).

---

## 79. "Lambda"

**AWS Lambda**

Es el servicio de cómputo *serverless* de AWS: se sube código (una función) y AWS lo ejecuta cuando ocurre un evento, sin administrar servidores. Solo se paga por el tiempo de ejecución real y la cantidad de invocaciones.

**Cómo funciona:**

1. Se escribe una función en un lenguaje soportado (Python, Node.js, Ruby, Java, Go, .NET, etc.).
2. Se sube a Lambda, definiendo un *handler*.
3. Se configura un **trigger** (disparador).
4. AWS provisiona automáticamente el entorno, corre el código, y lo apaga cuando termina.

**Triggers típicos:**
- Petición HTTP vía **API Gateway**.
- Archivo subido a un bucket de **S3**.
- Mensaje en **SQS** o evento en **SNS**.
- Cambio en una tabla de **DynamoDB**.
- Horario programado vía **EventBridge**.

**Ejemplo (Python):**

```python
def lambda_handler(event, context):
    nombre = event.get("nombre", "mundo")
    return {
        "statusCode": 200,
        "body": f"Hola, {nombre}"
    }
```

**Conceptos clave:**

- **Cold start** — latencia extra cuando Lambda no se ejecutó hace un rato y tiene que "levantar" el entorno desde cero.
- **Stateless** — cada ejecución es independiente.
- **Límites** — tiempo máximo de ejecución de 15 minutos, memoria configurable, tamaño máximo del paquete de despliegue.
- **Concurrencia** — Lambda escala automáticamente creando instancias en paralelo.

**Cuándo usarlo:** tareas cortas y esporádicas. **Cuándo NO conviene:** procesos con carga constante y predecible, o tareas muy largas (más de 15 min).

---

## 80. "Beneficios" (de AWS en general)

- **Sin inversión inicial en hardware.**
- **Pago por uso (pay-as-you-go).**
- **Escalabilidad** — crecer o achicar recursos casi al instante según la demanda.
- **Alta disponibilidad y durabilidad** — replicación entre múltiples zonas de disponibilidad y regiones.
- **Alcance global** — datacenters en todo el mundo.
- **Seguridad administrada** — modelo de **responsabilidad compartida**.
- **Velocidad de desarrollo** — servicios administrados ahorran tiempo de configurar y mantener infraestructura.
- **Gran ecosistema de servicios**.
- **Elasticidad** — ajustar recursos según el tráfico real, optimizando costos.

**Contrapunto:** la desventaja principal es el **vendor lock-in**, y que sin buen control de costos la facturación puede crecer de forma impredecible.

---

## 81. "¿Cuál es el beneficio?" (de AWS Lambda específicamente)

- **No administrás servidores.**
- **Pagás solo por lo que se ejecuta** — a diferencia de un servidor tradicional que corre 24/7.
- **Escala automáticamente y de forma casi ilimitada.**
- **Menos tiempo en operaciones, más en el producto.**
- **Ideal para cargas esporádicas o impredecibles.**
- **Integración nativa con el ecosistema AWS** — S3, DynamoDB, API Gateway, SQS, etc.
- **Despliegues más simples y aislados** — cada función es una unidad independiente.

**La contra principal:** el *cold start* y el límite de 15 minutos de ejecución, que lo hacen mala opción para procesos largos o de carga constante y predecible.

---

## 82. "¿Cómo inicio servicio?" (cómo crear/desplegar una función Lambda)

**Opción 1: Desde la consola web de AWS**

1. Entrar a la consola de AWS → Lambda → "Create function".
2. Elegir "Author from scratch", nombre, runtime (ej. Python 3.12).
3. Escribir el código en el editor online, o subir un `.zip`.
4. Configurar un **trigger** (ej. API Gateway).
5. Guardar y probar con el botón "Test".

**Opción 2: Con la AWS CLI**

```bash
# 1. Empaquetar el código
zip funcion.zip lambda_function.py

# 2. Crear la función
aws lambda create-function \
  --function-name mi-funcion \
  --runtime python3.12 \
  --role arn:aws:iam::123456789:role/mi-rol-lambda \
  --handler lambda_function.lambda_handler \
  --zip-file fileb://funcion.zip

# 3. Invocarla para probar
aws lambda invoke --function-name mi-funcion salida.json
```

**Opción 3: Con Infraestructura como Código**

- **AWS SAM** (Serverless Application Model).
- **Terraform** — multi-cloud.
- **AWS CDK** — infraestructura como código con Python/TypeScript, etc.

Ejemplo mínimo con SAM (`template.yaml`):

```yaml
Resources:
  MiFuncion:
    Type: AWS::Serverless::Function
    Properties:
      Handler: lambda_function.lambda_handler
      Runtime: python3.12
      CodeUri: ./src
```

```bash
sam build
sam deploy --guided
```

**Requisito previo importante:** un **IAM Role** — un rol con los permisos que la función va a necesitar. Sin ese rol, la creación falla.

---

*Fin de la transcripción. Este archivo reproduce, en orden, las preguntas y respuestas dadas durante la sesión, sin resumir ni omitir contenido sustantivo.*
