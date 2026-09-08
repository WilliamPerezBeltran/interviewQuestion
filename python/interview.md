# Preguntas de entrevista - Django / Python

1. ¿Qué significa y para qué sirve `a |= b` en Python?

Es el operador de asignación aumentada para el OR: equivale a `a = a | b`, pero si `a` es un objeto mutable
que implementa `__ior__` (como un set o un dict), la operación se hace in-place en vez de crear un objeto
nuevo. Con enteros hace un OR bit a bit; con booleanos actúa como OR lógico (ya que `bool` hereda de `int`);
con sets equivale a `a.update(b)` (unión); y con diccionarios (desde Python 3.9) hace un merge, donde las
claves de `b` sobrescriben las de `a` si coinciden.

```python
a = {1, 2, 3}
b = {3, 4, 5}
a |= b          # {1, 2, 3, 4, 5}, misma referencia de `a`

d1 = {"x": 1}
d2 = {"x": 2, "y": 3}
d1 |= d2        # {"x": 2, "y": 3}
```

2. ¿Qué es `struct` en Python y para qué se utiliza?

Es un módulo de la librería estándar que sirve para convertir entre datos de Python (enteros, floats,
strings) y su representación en bytes, siguiendo un formato binario específico. Se usa para leer/escribir
archivos binarios, trabajar con protocolos de red de bajo nivel, o interoperar con código en C. Las
funciones principales son `struct.pack()` (empaqueta valores en bytes) y `struct.unpack()` (hace lo
inverso). No debe confundirse con `dataclasses` o `namedtuple`, que agrupan campos con nombre pero no hacen
serialización binaria.

```python
import struct

datos = struct.pack(">ii", 10, 20)      # empaqueta dos enteros en formato big-endian
valores = struct.unpack(">ii", datos)   # (10, 20)
```

3. ¿Qué es *operator overloading* en Python y cómo se aplica en clases?

Es redefinir cómo se comportan los operadores estándar (`+`, `==`, `<`, etc.) para clases propias,
implementando los métodos mágicos correspondientes: `__add__` para `+`, `__eq__` para `==`, `__lt__` para
`<`, y así sucesivamente. Por ejemplo, en una clase `Vector` se puede definir `__add__` para que `v1 + v2`
sume las componentes en vez de lanzar un error. Sirve para que objetos propios se comporten de forma
intuitiva con la sintaxis nativa del lenguaje, en vez de forzar métodos explícitos como `v1.sumar(v2)`.

4. ¿Qué hace `getattr` en Python y cómo se usa para invocar métodos dinámicamente?

`getattr(objeto, "nombre", default)` obtiene (lee) un atributo o método de un objeto pasando su nombre
como string, en vez de acceder con la sintaxis de punto directamente. El `default` es opcional y evita que
lance `AttributeError` si el atributo no existe. Es útil para invocar métodos dinámicamente, por ejemplo un
dispatcher que decide qué método llamar según un string en vez de un `if/elif` largo:

```python
accion = "crear_usuario"
handler = getattr(self, f"handle_{accion}", self.handle_default)
handler(payload)
```

Su contraparte para escribir/asignar dinámicamente es `setattr(obj, "nombre", valor)`. También existe el
método mágico `__getattr__`, que se define dentro de una clase y Python lo invoca automáticamente solo
cuando el atributo no se encuentra por los medios normales (lo usan, por ejemplo, los ORMs para resolver
atributos que no existen físicamente en el objeto).

5. Explique cómo funcionan las rutas (*urls*) en Django y cómo se configuran.

Cada URL que visita un usuario debe estar conectada a una vista (una función) que decide qué responder.
Esa conexión se define en un archivo `urls.py`, en una lista llamada `urlpatterns`:

```python
urlpatterns = [
    path("productos/", vista_lista_productos),
    path("productos/<int:id>/", vista_detalle_producto),
]
```

Cuando alguien visita `/productos/42/`, Django recorre la lista de arriba hacia abajo, encuentra la
entrada que coincide, extrae `42` como parámetro `id`, y llama a `vista_detalle_producto` pasándole ese
valor. Como un proyecto puede tener muchas apps, cada una suele tener su propio `urls.py`, y el archivo
principal del proyecto los conecta todos usando `include()`, para mantener el código ordenado.

6. Describa los métodos `get()`, `filter()` y `all()` de Django ORM.

`all()` devuelve todos los registros de la tabla como un QuerySet. `filter()` también devuelve un
QuerySet, pero solo con los registros que cumplen una condición (por ejemplo
`Producto.objects.filter(precio__gt=100)`); si nada coincide, devuelve un QuerySet vacío, no da error.
`get()` devuelve un único objeto, no una lista, y se usa cuando se espera exactamente un resultado (por
ejemplo `Producto.objects.get(id=5)`); si no encuentra ninguno lanza `DoesNotExist`, y si encuentra más de
uno lanza `MultipleObjectsReturned` — por eso normalmente se usa con un campo único como el `id`.

7. ¿Qué son los *template tags* y *filters* en Django y para qué sirven?

Son herramientas que se usan dentro de los templates HTML de Django para agregar lógica o formatear datos
sin mezclar Python puro con el HTML. Los **filters** transforman el valor de una variable al mostrarla, y
se aplican con `|`, por ejemplo `{{ nombre|upper }}` o `{{ fecha|date:"d/m/Y" }}`. Los **template tags** son
más potentes y permiten estructuras de control como condicionales y bucles, entre `{% %}`, por ejemplo
`{% for producto in productos %}...{% endfor %}` o `{% if usuario.autenticado %}...{% endif %}`. La idea es
mantener el template enfocado en presentación, con lógica mínima y legible.

8. ¿Qué es la paginación de APIs en Django Rest Framework y cómo se implementa?

Es dividir los resultados de una API en páginas más pequeñas en vez de devolver todos los registros de una
sola vez, para evitar respuestas pesadas y lentas cuando hay muchos datos. En DRF se configura con clases
de paginación incluidas: `PageNumberPagination` (páginas numeradas, `?page=2`), `LimitOffsetPagination`
(parámetros `limit` y `offset`), o `CursorPagination` (usa un cursor, más seguro para datos que cambian
constantemente). Se puede activar globalmente en `settings.py`:

```python
REST_FRAMEWORK = {
    "DEFAULT_PAGINATION_CLASS": "rest_framework.pagination.PageNumberPagination",
    "PAGE_SIZE": 10,
}
```

O definirse por vista, asignando la clase de paginación directamente en el `ViewSet` o `APIView`. La
respuesta paginada suele incluir los resultados junto con enlaces a la página siguiente/anterior y el total
de registros.

9. ¿Qué es el estándar RFC 8288 y cómo se relaciona con Django o APIs REST?

Es un estándar que define el formato del header HTTP `Link`, usado para indicar relaciones entre recursos
en una respuesta HTTP, por ejemplo para enlazar la página siguiente o anterior en una API paginada:

```
Link: <https://api.ejemplo.com/productos?page=2>; rel="next",
      <https://api.ejemplo.com/productos?page=1>; rel="prev"
```

Se relaciona con APIs REST porque es una forma estandarizada de comunicar navegación entre recursos sin
meter esa información dentro del cuerpo JSON. DRF puede usarlo en ciertas configuraciones, aunque lo más
común en la práctica es incluir los enlaces `next`/`previous` directo en el JSON de respuesta. Es un
concepto asociado a los principios HATEOAS (que los recursos se puedan descubrir siguiendo enlaces).

10. ¿Qué es el módulo `numbers` en Python y cómo se utiliza en Django?

`numbers` es un módulo de la librería estándar que define una jerarquía abstracta de tipos numéricos:
`Number`, y debajo `Complex`, `Real`, `Rational` e `Integral`. Sirve para verificar tipos de forma más
flexible que comparar contra `int` o `float` directamente: en vez de `isinstance(valor, (int, float))`, se
puede usar `isinstance(valor, numbers.Number)`, que también cubre tipos como `Decimal` o `Fraction`. No
tiene una integración especial con Django; su utilidad ahí sería la misma que en cualquier código Python,
por ejemplo validar de forma genérica que un valor recibido es numérico antes de procesarlo.

11. ¿Qué es Django Channels y cómo permite manejar *WebSockets*?

Django por sí solo trabaja con el modelo tradicional de HTTP (petición y respuesta, sin conexión
persistente). Django Channels agrega soporte para protocolos que sí necesitan una conexión persistente,
como WebSockets, además de tareas en segundo plano y HTTP de larga duración. Funciona reemplazando el
servidor WSGI por uno ASGI, que soporta comunicación asíncrona y bidireccional. Con Channels se definen
**consumers**, el equivalente a las vistas pero para conexiones en tiempo real: reciben eventos de
conexión, mensajes y desconexión, y pueden enviar mensajes al cliente en cualquier momento. Las rutas de
estos consumers se configuran en un archivo de "routing", separado de `urls.py`. Un caso típico es un chat
en tiempo real: el cliente abre la conexión y el servidor le envía datos nuevos sin que el cliente tenga
que preguntar constantemente (evita el *polling*).

12. ¿Qué son los *background jobs* en Django y cómo se implementan con *Celery* o *Django Q*?

Son tareas que se ejecutan por fuera del ciclo normal de petición-respuesta, para que el usuario no tenga
que esperar a que terminen (por ejemplo, enviar un email o generar un reporte pesado). **Celery** es la
opción más usada: funciona con un broker de mensajes (Redis o RabbitMQ) como intermediario; la aplicación
encola una tarea, y uno o varios *workers* la toman y ejecutan por separado.

```python
@shared_task
def enviar_email(usuario_id):
    ...

enviar_email.delay(usuario_id)   # la encola en vez de ejecutarla al instante
```

**Django Q** es una alternativa más simple, que puede usar la misma base de datos de Django como broker,
lo que facilita el setup en proyectos más chicos. Celery es más robusto y escalable para proyectos grandes;
Django Q es más liviano y rápido de configurar cuando no se necesita tanta infraestructura.

13. Explique cómo se definen las rutas en Django (`urls.py`) y cómo se enlazan a *views*.

Las rutas se definen en `urls.py`, dentro de la lista `urlpatterns`, usando `path()` (o `re_path()` para
expresiones regulares). Cada entrada recibe el patrón de la URL y la vista que debe ejecutarse:

```python
from django.urls import path
from . import views

urlpatterns = [
    path("productos/", views.lista_productos),
    path("productos/<int:id>/", views.detalle_producto, name="detalle_producto"),
]
```

El enlace con la vista es directo: se pasa la función (o clase, en vistas basadas en clases) como segundo
argumento. Cuando la URL coincide, Django llama a esa vista pasándole `request` y cualquier parámetro
capturado en la URL. El parámetro `name` permite referenciar la ruta desde otras partes del código sin
escribir la URL a mano, usando `reverse("detalle_producto", args=[5])` o `{% url "detalle_producto" 5 %}`.
Cuando el proyecto tiene varias apps, cada una suele tener su propio `urls.py`, conectados desde el
`urls.py` principal con `include()`.

14. ¿Qué son sesiones y cookies en Django y cómo se manejan?

Las **cookies** son datos pequeños que el servidor le pide al navegador guardar, y que el navegador reenvía
en cada petición posterior al mismo sitio; sirven para que el servidor "reconozca" al mismo cliente entre
peticiones, ya que HTTP por sí solo no guarda memoria de eso. Las **sesiones** se construyen sobre las
cookies para guardar información del lado del servidor: por defecto, Django guarda los datos reales en la
base de datos, y en la cookie del navegador (`sessionid`) solo pone un identificador de esa sesión.

```python
def mi_vista(request):
    request.session["usuario_id"] = 5          # guardar
    valor = request.session.get("usuario_id")  # leer
```

Esto está activado por defecto mediante el middleware de sesiones, que asocia cada request con los datos
guardados en el servidor a partir del `sessionid` recibido.

15. Explique la implementación de sesiones y cookies en Django.

La configuración se controla desde `settings.py`, con `SESSION_ENGINE` definiendo dónde se guardan los
datos: en base de datos (`backends.db`, por defecto), en caché (`backends.cache`), o en la propia cookie
firmada (`backends.signed_cookies`). Requiere `django.contrib.sessions` en `INSTALLED_APPS` y
`SessionMiddleware` en `MIDDLEWARE`, que es el que lee `sessionid` en cada request y carga los datos en
`request.session`. Hay configuraciones de seguridad relevantes: `SESSION_COOKIE_SECURE` (solo por HTTPS),
`SESSION_COOKIE_HTTPONLY` (JavaScript no puede leerla, protege contra XSS), y `SESSION_COOKIE_AGE`
(expiración en segundos). La cookie siempre vive en el navegador; lo que cambia según el engine es si
contiene solo una referencia (`sessionid`, lo más común y seguro) o los datos completos firmados
(`signed_cookies`). Las sesiones en sí (los datos reales) se guardan del lado del servidor, salvo que se
use `signed_cookies`.

16. ¿Qué es la autenticación en Django y cuáles son sus componentes principales?

Es el proceso de verificar la identidad de un usuario (confirmar que es quien dice ser), típicamente con
usuario y contraseña. Django lo incluye por defecto en `django.contrib.auth`. Componentes principales: el
modelo `User` (username, password con hash, email, flags como `is_active`); el `AuthenticationMiddleware`,
que en cada request asocia el usuario correspondiente a `request.user`; y las funciones `authenticate()`
(valida usuario/contraseña) y `login()` (crea la sesión para el usuario ya validado):

```python
from django.contrib.auth import authenticate, login

user = authenticate(request, username="juan", password="1234")
if user is not None:
    login(request, user)
```

También existen los *backends* de autenticación, que definen contra qué se valida (por defecto la base de
datos, pero se pueden agregar backends personalizados, por ejemplo login con Google). Es importante no
confundir autenticación ("quién es") con autorización ("qué puede hacer"), que se maneja aparte con el
sistema de permisos y grupos de Django.

17. Implementación práctica de sesiones, cookies y autenticación en Django.

Un flujo típico de login:

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
        return render(request, "login.html", {"error": "Credenciales inválidas"})
    return render(request, "login.html")
```

Al ejecutar `login(request, user)`, Django crea un registro de sesión en el backend configurado, guarda ahí
el id del usuario autenticado, y la respuesta incluye la cookie `sessionid`. En peticiones siguientes,
gracias a `SessionMiddleware` y `AuthenticationMiddleware`, cualquier vista puede acceder al usuario
logueado sin volver a autenticar:

```python
def vista_perfil(request):
    if request.user.is_authenticated:
        return render(request, "perfil.html", {"user": request.user})
    return redirect("login")
```

Para proteger vistas sin repetir ese chequeo, se usa el decorador `@login_required`. Para cerrar sesión:

```python
def vista_logout(request):
    logout(request)   # limpia request.session y elimina los datos de sesión del servidor
    return redirect("login")
```

En resumen: la cookie identifica la sesión, la sesión guarda quién es el usuario, y la autenticación es el
paso inicial que valida las credenciales antes de crear esa sesión.

18. ¿Qué prácticas de seguridad existen en Django para proteger aplicaciones web?

Django trae protecciones por defecto contra varios ataques comunes:

- **CSRF**: el middleware `CsrfViewMiddleware` exige un token secreto en formularios POST (`{% csrf_token %}`
  en el template); sin ese token, la petición se rechaza.
- **XSS**: el sistema de templates escapa automáticamente el contenido de las variables, mostrando código
  malicioso como texto plano en vez de ejecutarlo. El filtro `|safe` desactiva ese escape y debe usarse con
  cuidado.
- **SQL Injection**: el ORM arma las consultas con parámetros preparados internamente, así que los valores
  nunca se concatenan directo en el SQL al usar `filter()`, `get()`, etc. El riesgo aparece solo con `raw()`
  o SQL crudo mal manejado.
- **Clickjacking**: el middleware `XFrameOptionsMiddleware` agrega el header que evita cargar el sitio
  dentro de un `iframe` de otro dominio.
- **Contraseñas**: nunca se guardan en texto plano; Django las guarda con hash (PBKDF2 por defecto,
  configurable a Argon2, etc.) y valida su fortaleza con `AUTH_PASSWORD_VALIDATORS`.
- **HTTPS y cookies seguras**: `SESSION_COOKIE_SECURE`, `CSRF_COOKIE_SECURE` y `SECURE_SSL_REDIRECT` fuerzan
  HTTPS y evitan que las cookies viajen sin cifrar.

La mayoría de estas protecciones vienen activadas por defecto al crear un proyecto nuevo; el riesgo real
suele aparecer cuando alguien las desactiva sin entender bien por qué estaban ahí.

19. ¿Cómo se manejan sockets y comunicación en tiempo real usando Django Channels?

Como en la pregunta 11, Channels reemplaza el servidor WSGI por uno ASGI para soportar conexiones
persistentes como WebSockets. La pieza central son los **consumers**, el equivalente a las vistas para
conexiones en tiempo real:

```python
from channels.generic.websocket import WebsocketConsumer
import json

class ChatConsumer(WebsocketConsumer):
    def connect(self):
        self.accept()

    def disconnect(self, close_code):
        pass

    def receive(self, text_data):
        data = json.loads(text_data)
        self.send(text_data=json.dumps({"mensaje": data["mensaje"]}))
```

Las rutas de estos consumers se definen aparte de `urls.py`, en un archivo de "routing". Para comunicación
entre varios usuarios conectados a la vez (por ejemplo, un chat grupal), Channels usa un **channel layer**,
generalmente respaldado por Redis: cada consumer se une a un "grupo", y cuando alguien envía un mensaje,
se distribuye a todos los consumers de ese grupo, no solo al que lo originó:

```python
from asgiref.sync import async_to_sync

self.channel_layer.group_add("sala_chat", self.channel_name)
async_to_sync(self.channel_layer.group_send)(
    "sala_chat", {"type": "chat_message", "mensaje": data["mensaje"]}
)
```

El consumer maneja la conexión individual de cada cliente, y el channel layer (Redis) coordina mensajes
entre múltiples conexiones simultáneas.
