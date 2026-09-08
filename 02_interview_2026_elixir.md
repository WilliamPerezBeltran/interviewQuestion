# Elixir / Phoenix / Ecto / SPA — Preguntas y respuestas sugeridas

> Respuestas pensadas para decirlas en voz alta (registro conversacional, ~45-90 seg cada una). Ajusta los ejemplos a tu experiencia real.

---

## 1. In Elixir, how do immutability and pattern matching affect how you design data transformations in a web request?

**Respuesta sugerida:**
"Because data in Elixir is immutable, I design transformations as pipelines: each function takes a struct or map and returns a new one, instead of mutating state in place. This makes the flow of a web request very predictable — I can follow the data through `params -> changeset -> struct -> response` using the pipe operator, and each step is a pure function I can test in isolation. Pattern matching lets me handle different shapes of data explicitly at the function head level, so instead of writing defensive `if/else` chains, I match on `{:ok, user}` versus `{:error, changeset}` and let the compiler and the match itself document the possible outcomes. In practice, this means my controllers and contexts read almost like a state machine — each clause matches a specific case, which reduces bugs from unexpected nils or partial updates."

**Explicación extendida (español):**
En Elixir, cuando dices que los datos son "inmutables", significa que una vez que creas un valor (un mapa, una lista, un struct), ese valor nunca cambia en memoria. Si "modificas" algo, en realidad estás creando un valor nuevo. Esto tiene una consecuencia directa en cómo diseñas el flujo de una petición web: en lugar de ir mutando una variable paso a paso como harías en un lenguaje orientado a objetos (`user.name = "nuevo"`), en Elixir escribes una cadena de transformaciones donde cada función recibe algo y devuelve algo nuevo, típicamente usando el operador pipe `|>`. Por ejemplo: `params |> validar() |> transformar() |> guardar()`. Cada paso es una función pura, fácil de testear por separado porque no depende de estado oculto ni de efectos secundarios.

El "pattern matching" (coincidencia de patrones) es la otra pieza clave. En vez de escribir `if resultado != nil` o cadenas de `if/else`, en Elixir defines directamente las formas posibles del dato en la cabecera de la función o en un `case`. Por ejemplo: `{:ok, usuario}` significa "todo salió bien y aquí está el usuario", mientras que `{:error, cambios}` significa "algo falló y aquí está el detalle". El compilador (y tú mismo leyendo el código) ve inmediatamente qué casos existen, porque están explícitos. Esto reduce muchísimo los errores por valores inesperados (como un `nil` que no esperabas) porque si un caso no está contemplado, el programa falla de forma clara y visible en vez de comportarse de manera silenciosa e incorrecta.

En resumen: inmutabilidad te obliga a pensar en transformaciones de datos como una tubería de pasos claros, y pattern matching te obliga a declarar explícitamente qué resultados son posibles en cada paso. Juntos hacen que el código de un controller o un context en Phoenix se lea casi como una máquina de estados: "si pasa esto, hago esto; si pasa lo otro, hago lo otro" — sin ambigüedad.

---

## 2. Tell me about an Elixir module or service you personally built using Tasks, GenServer, or supervision. Why did you choose that abstraction?

**Respuesta sugerida:**
"I built a service that needed to fetch and cache data from a slow third-party API without blocking user requests. I used a GenServer to hold the cached state in memory, with a supervisor restarting it if it crashed, so the rest of the app never had to worry about that process dying badly. For the actual outbound calls, I used `Task.async/await` so multiple lookups could run concurrently instead of sequentially, which cut response time significantly. I chose GenServer over just a plain module because I needed persistent state across requests without touching the database every time, and I chose a supervised process specifically so failures in that one component wouldn't take down the whole app — that's the 'let it crash' philosophy: isolate the risky part, recover automatically, and keep the rest of the system healthy."

**Explicación extendida (español):**
Un **GenServer** (Generic Server) es un proceso de Elixir/Erlang que mantiene estado en memoria y responde a mensajes de forma controlada. Piensa en él como un "servicio" que vive corriendo en segundo plano dentro de tu aplicación: puede recordar cosas (como una caché) entre distintas peticiones web, algo que un módulo normal sin proceso no puede hacer, porque un módulo normal no tiene memoria propia — solo funciones sin estado.

Un **Task** es más simple: se usa para ejecutar algo de forma asíncrona y obtener un resultado, sin necesidad de mantener estado a largo plazo. Por ejemplo, si necesitas hacer tres llamadas a APIs externas al mismo tiempo en vez de una tras otra, usas `Task.async` para lanzarlas en paralelo y `Task.await` para esperar los resultados — esto reduce el tiempo total de espera porque las tres corren simultáneamente.

La **supervisión** es el concepto que hace robusto todo esto: un "Supervisor" es un proceso especial cuyo único trabajo es vigilar a otros procesos (como tu GenServer) y reiniciarlos automáticamente si fallan o crashean. Esto se conoce como la filosofía "let it crash" (déjalo fallar): en vez de intentar prevenir cada posible error con código defensivo, dejas que el proceso falle limpiamente, y el supervisor lo reinicia desde un estado conocido y limpio. Esto aísla los fallos: si tu GenServer de caché crashea por algún dato corrupto, el resto de tu aplicación (las peticiones web, la base de datos, etc.) sigue funcionando sin verse afectado, y el supervisor simplemente levanta una copia nueva del GenServer.

En una respuesta de entrevista, lo ideal es dar un ejemplo concreto: "construí un servicio que cachea datos de una API externa lenta, usando un GenServer supervisado para el estado, y Tasks para paralelizar las llamadas salientes" — así demuestras que entiendes cuándo usar cada herramienta y por qué.

---

## 3. A production node shows rising memory and long response times. How would you use BEAM/OTP concepts to find whether processes, mailboxes, or binaries are the cause?

**Respuesta sugerida:**
"First I'd connect to the running node with a remote shell or Observer and look at process counts and memory ranking — `Process.list/0` combined with `Process.info/2` for `:memory` and `:message_queue_len` lets me find processes with abnormally large mailboxes, which usually means something is producing messages faster than they're consumed. If I see one or a few processes with huge queues, that points to a bottleneck, often a GenServer doing slow synchronous work while messages pile up. If memory is high but mailboxes look normal, I'd suspect binary memory — large binaries aren't copied per-process, they're reference-counted, so I'd check `:erlang.memory(:binary)` and look for processes holding references to large binaries that never get garbage collected, often from string processing or file uploads. I'd also check reduction counts to see if a process is CPU-bound versus just waiting. Combining these gives me a clear signal: overloaded mailbox means a throughput problem, binary growth means a memory-leak-like pattern, and I can target the fix accordingly instead of guessing."

**Explicación extendida (español):**
La BEAM (la máquina virtual de Erlang/Elixir) organiza todo en procesos ligeros, cada uno con su propia memoria y su propio "buzón de mensajes" (mailbox). Cuando un nodo en producción muestra memoria creciente y tiempos de respuesta largos, hay tres sospechosos típicos:

**1. Procesos con mailbox saturado:** cada proceso recibe mensajes en una cola (mailbox) y los procesa uno por uno, en orden. Si un proceso recibe mensajes más rápido de lo que puede procesarlos — por ejemplo, un GenServer que hace una operación lenta cada vez que recibe un mensaje — su mailbox va creciendo sin control, y eso consume memoria y genera lentitud, porque las peticiones esperan en cola. Se detecta revisando `Process.info(pid, :message_queue_len)` para cada proceso: si ves un número anormalmente alto en uno solo, ahí está el cuello de botella.

**2. Binarios grandes sin liberar:** en la BEAM, los binarios (strings, archivos, datos binarios) mayores a 64 bytes no se copian entre procesos — se guardan en un área de memoria compartida y se cuentan por referencias. Si muchos procesos mantienen referencias a binarios grandes (por ejemplo, procesando archivos subidos por usuarios) y esas referencias nunca se sueltan, el garbage collector no puede liberar esa memoria, y el uso total de memoria del nodo sigue creciendo aunque los procesos individuales parezcan normales. Se detecta revisando `:erlang.memory(:binary)` y comparando en el tiempo.

**3. Procesos "colgados" o muy pesados en CPU:** revisando `reductions` (una medida de trabajo interno de la BEAM) puedes ver si un proceso está haciendo mucho trabajo de cómputo, lo cual indica que el cuello de botella no es de espera sino de procesamiento puro.

En la práctica, herramientas como `Observer` (una interfaz gráfica) o comandos en una consola remota conectada al nodo (`:observer.start()` o inspección manual con `Process.list()`) te permiten ordenar todos los procesos por memoria o por tamaño de mailbox y encontrar rápidamente al culpable, en vez de adivinar. La clave de una buena respuesta aquí es mostrar que sabes diferenciar: mailbox lleno = problema de throughput (algo produce más rápido de lo que se consume); memoria de binarios creciente = fuga tipo "memory leak"; reductions altas = problema de cómputo.

---

## 4. What is the practical role of Phoenix contexts, and what problems arise when controllers talk directly to schemas?

**Respuesta sugerida:**
"Contexts are the boundary between the web layer and the business logic — they expose a clear API like `Accounts.create_user/1` or `Billing.charge_invoice/2`, so the controller doesn't need to know about Ecto queries or schema internals at all. When controllers talk directly to schemas, you end up duplicating query logic across multiple controllers, business rules leak into the web layer, and it becomes very hard to reuse that logic somewhere else, like a background job or a CLI task. It also makes testing harder, because you'd need to spin up a full request cycle just to test a business rule. With contexts, I can unit test `Accounts` in isolation, and if the business logic changes, I only touch one place instead of hunting through every controller that happened to query that schema directly."

**Explicación extendida (español):**
Un **context** en Phoenix es simplemente un módulo que agrupa funciones relacionadas con un área del negocio — por ejemplo, `Accounts` para todo lo relacionado con usuarios, o `Billing` para todo lo relacionado con pagos. La idea es que el context sea la "puerta de entrada" oficial a esa parte de la lógica de negocio: en vez de que un controller haga consultas directas a Ecto (`Repo.get(User, id)`, `Repo.all(from u in User, where: ...)`), el controller simplemente llama a `Accounts.get_user!(id)` o `Accounts.list_active_users()`, y toda la complejidad de cómo se construye esa consulta, qué validaciones aplican, qué reglas de negocio existen, vive dentro del context.

¿Por qué importa esto? Si los controllers hablan directamente con los schemas (los structs de Ecto que representan las tablas), pasan varias cosas malas:

- **Duplicación:** si dos controllers necesitan "usuarios activos con email verificado", cada uno termina escribiendo su propia consulta, y si la regla de negocio cambia (por ejemplo, se agrega un nuevo requisito), hay que buscar y actualizar cada lugar donde se duplicó esa lógica.
- **Fuga de reglas de negocio a la capa web:** el controller debería ocuparse solo de recibir la petición HTTP y devolver una respuesta, no de decidir reglas de negocio como "un usuario premium puede tener hasta 5 proyectos". Esa lógica pertenece al context.
- **Dificultad para reusar:** si mañana necesitas la misma lógica en un job en segundo plano, en un comando de consola, o en una API GraphQL además de la REST, si la lógica está en el controller, no la puedes reusar fácilmente. Si está en el context, sí.
- **Testing más difícil:** para testear una regla de negocio que vive en el controller, tienes que simular una petición HTTP completa. Si vive en el context, puedes testear la función directamente con datos de Elixir puro, mucho más rápido y simple.

En resumen: el context es la capa que separa "cómo llega la petición" (web) de "qué hace realmente el negocio" (lógica), y esa separación es lo que hace que una app Phoenix escale bien en tamaño y complejidad sin volverse un caos de código duplicado.

---

## 5. Walk through a Phoenix API feature you personally built from route to response, including plugs, controller, context, and error handling.

**Respuesta sugerida:**
"I built an endpoint for creating a resource — say `POST /api/orders`. It starts in the router, scoped under `/api` with a pipeline that includes plugs for authentication and content negotiation, so by the time it reaches the controller I already know the request is authenticated and expects JSON. The controller action takes the params, calls `Orders.create_order/1` in the context, and pattern matches on the result: `{:ok, order}` renders a 201 with a JSON view of the order, `{:error, %Ecto.Changeset{} = changeset}` renders a 422 with the changeset errors formatted consistently. Inside the context, `create_order/1` builds a changeset, validates required fields and any business rules — like checking stock — and inserts it, sometimes wrapped in `Ecto.Multi` if it touches more than one table. For error handling, I also set up a fallback controller so any unmatched error pattern, like a `:not_found`, gets converted into the right status code automatically instead of crashing with an unhandled case. The result is a predictable flow: plug does auth, controller orchestrates, context does the real work, and errors are handled consistently across the whole API."

**Explicación extendida (español):**
Esta pregunta busca que expliques el recorrido completo de una petición en Phoenix, así que conviene tener claro cada capa:

**1. Router:** es el punto de entrada — define qué URL y método HTTP (`POST /api/orders`) dispara qué acción del controller, y bajo qué "pipeline" (una cadena de plugs que se aplican antes de llegar al controller).

**2. Plugs:** son piezas de middleware reusables. Un plug puede verificar autenticación (¿el usuario tiene sesión o token válido?), puede parsear el body de la petición, puede verificar que el `Content-Type` sea JSON, etc. Los plugs se ejecutan en orden, uno tras otro, y cada uno puede modificar la `conn` (la estructura que representa la conexión) o directamente detener la petición si algo no cumple (por ejemplo, devolver un 401 si no hay token válido).

**3. Controller:** recibe la petición ya "limpia" (ya pasó por los plugs), extrae los parámetros, y llama a la función correspondiente en el context — por ejemplo `Orders.create_order(params)`. El controller no debería tener lógica de negocio, solo orquestar: llamar al context y decidir qué respuesta HTTP devolver según el resultado.

**4. Context:** aquí vive la lógica real. `create_order/1` construye un changeset con los datos, valida reglas de negocio (por ejemplo, verificar stock disponible), y si todo es válido, inserta el registro en la base de datos. Si la operación involucra más de una tabla (crear la orden Y actualizar el inventario), normalmente se envuelve en `Ecto.Multi` para que todo pase o nada pase (una transacción atómica).

**5. Manejo de errores:** el resultado del context normalmente es `{:ok, dato}` o `{:error, cambios}`. En el controller, se usa pattern matching para decidir qué responder: si es `{:ok, order}`, se responde 201 (creado) con el JSON de la orden; si es `{:error, changeset}`, se responde 422 con los errores de validación en un formato consistente. Muchas apps Phoenix usan un "FallbackController" que centraliza el manejo de errores no contemplados explícitamente (como un recurso no encontrado), para no repetir ese código en cada acción.

Una buena respuesta hablada debe mencionar estas cinco piezas en orden, idealmente con un ejemplo concreto de un endpoint que hayas construido.

---

## 6. How have you structured authentication and authorization in Phoenix across browser/SPA and JSON API routes without duplicating logic?

**Respuesta sugerida:**
"I keep authentication logic in one place — usually a context function like `Accounts.get_user_by_session_token/1` or `Accounts.get_user_by_api_token/1` — and then wrap it in two thin plugs: one for browser sessions using cookies, and one for the JSON API using a bearer token. Both plugs end up doing the same thing: resolving a `current_user` and putting it in `conn.assigns`, so downstream code — controllers, contexts, LiveViews — never cares whether the request came from a browser session or an API token. For authorization, I keep policy logic in the context or in a separate policy module, using pattern matching on the user's role rather than sprinkling `if user.role == :admin` checks across controllers. That way, if I add a new authorization rule, it's defined once and reused everywhere, and the browser and API pipelines just differ in how they authenticate, not in how they decide what's allowed."

**Explicación extendida (español):**
Esta pregunta separa dos conceptos que a veces se confunden:

**Autenticación (authentication):** responde a "¿quién eres?". En una app con frontend tradicional (browser), normalmente se usa una sesión guardada en una cookie firmada. En una SPA o API JSON, normalmente se usa un token (por ejemplo, un Bearer token en el header `Authorization`). Son mecanismos distintos, pero el objetivo final es el mismo: identificar al usuario.

**Autorización (authorization):** responde a "¿qué puede hacer esta persona ya identificada?". Por ejemplo, un usuario autenticado puede o no tener permiso para eliminar un recurso, dependiendo de su rol.

La clave para no duplicar lógica es: **tener un solo lugar que resuelve "quién es el usuario actual"**, sin importar cómo llegó esa información. En Phoenix, esto se logra con **plugs separados para cada mecanismo de autenticación** (uno que lee la cookie de sesión, otro que lee el token del header), pero ambos plugs terminan haciendo lo mismo al final: buscan al usuario y lo guardan en `conn.assigns.current_user`. Así, todo el código que viene después — controllers, contexts, templates o vistas — nunca necesita saber si el usuario llegó por cookie o por token; simplemente usa `current_user`.

Para la autorización, la recomendación es **no esparcir condicionales de roles por todos los controllers** (`if user.role == :admin` repetido en 10 lugares), sino centralizar esas reglas en un módulo de políticas o directamente en el context, usando pattern matching sobre el rol o los permisos. Así, si mañana cambia una regla de negocio ("ahora los editores también pueden hacer X"), se cambia en un solo lugar.

En resumen, la respuesta ideal muestra que entiendes la diferencia entre autenticación y autorización, y que sabes diseñar el sistema para que ambos mecanismos de login (sesión y token) converjan en el mismo concepto de "usuario actual" sin duplicar código.

---

## 7. When adding an index in PostgreSQL for a Phoenix app, what do you check before and after adding it?

**Respuesta sugerida:**
"Before adding an index, I run `EXPLAIN ANALYZE` on the actual slow query to confirm it's doing a sequential scan on a large table, and I check the column's selectivity — indexing a low-cardinality column like a boolean rarely helps. I also check existing indexes so I'm not creating a redundant one, and I think about write load, since every index adds overhead to inserts and updates. In the Ecto migration, I add the index concurrently in production to avoid locking the table. After adding it, I run `EXPLAIN ANALYZE` again to confirm the planner is actually using an index scan instead of a sequential scan, and I check the real-world query time, not just the plan. I also watch write latency and table bloat for a bit afterward, because an index that helps reads but tanks write throughput isn't a real win — it's a trade-off I want to see the actual numbers for, not just assume."

**Explicación extendida (español):**
Un índice en PostgreSQL es una estructura de datos adicional (normalmente un B-tree) que permite buscar filas rápidamente sin tener que leer toda la tabla. Pero agregar índices "porque sí" puede ser contraproducente, así que antes de crear uno hay pasos importantes:

**Antes de crear el índice:**
- **`EXPLAIN ANALYZE`** sobre la query lenta: esto muestra el plan de ejecución real que usa Postgres y cuánto tiempo tarda cada paso. Si ves un "Seq Scan" (escaneo secuencial, es decir, lee toda la tabla fila por fila) en una tabla grande, eso es una señal de que un índice podría ayudar.
- **Selectividad de la columna:** un índice ayuda mucho cuando el valor que filtras aparece en pocas filas (alta selectividad). Indexar una columna booleana o con solo 2-3 valores posibles casi no ayuda, porque Postgres de todas formas tendría que revisar una gran parte de la tabla.
- **Índices existentes:** revisar si ya existe un índice similar o compuesto que ya cubra esa consulta, para no crear uno redundante que solo consuma espacio y ralentice escrituras sin aportar beneficio.
- **Impacto en escrituras:** cada índice adicional hace que los `INSERT`, `UPDATE` y `DELETE` sean un poco más lentos, porque Postgres tiene que mantener actualizado también el índice. En tablas con mucha escritura, este trade-off importa.
- **Creación sin bloquear:** en producción, se usa `CREATE INDEX CONCURRENTLY` (o en Ecto, `create index(..., concurrently: true)` dentro de una migración configurada para eso) para no bloquear la tabla mientras se construye el índice.

**Después de crear el índice:**
- Volver a correr `EXPLAIN ANALYZE` para confirmar que Postgres realmente está usando el nuevo índice (debería aparecer un "Index Scan" o "Index Only Scan" en vez de "Seq Scan").
- Medir el tiempo real de la query en producción, no solo confiar en el plan.
- Vigilar el rendimiento de escrituras y el tamaño en disco después, porque a veces un índice ayuda en lectura pero introduce un costo de escritura que no vale la pena.

La idea central que se busca en esta respuesta es que no agregas índices por intuición, sino que mides antes y después con datos reales.

---

## 8. Describe a slow PostgreSQL query you personally optimized. What did the execution plan show, and what change had the biggest impact?

**Respuesta sugerely:**
"I had a query filtering and sorting a large table by a `status` column combined with a `inserted_at` range, and it was taking seconds under load. Running `EXPLAIN ANALYZE` showed a sequential scan followed by a sort step that was consuming most of the time, meaning Postgres had to read the whole table and then sort in memory. I added a composite index on `(status, inserted_at)` matching the filter and sort order, which let Postgres use an index scan and avoid the separate sort step entirely. The biggest impact actually came from getting the column order right in the composite index — putting the equality filter column first and the range/sort column second — rather than just adding any index. That single change brought the query from multiple seconds down to a few milliseconds, and I verified it by comparing the `EXPLAIN ANALYZE` output before and after, not just trusting that adding an index would fix it."

**Explicación extendida (español):**
Este es un ejemplo concreto del proceso anterior. Lo importante aquí es demostrar que sabes **leer** un plan de ejecución de `EXPLAIN ANALYZE`, no solo que sabes crear índices.

Cuando corres `EXPLAIN ANALYZE` sobre una query, Postgres te muestra un árbol de operaciones: escaneos de tabla, joins, ordenamientos (sorts), agregaciones, etc., junto con el tiempo real que tomó cada uno y cuántas filas procesó. Dos señales típicas de problemas:

- **"Seq Scan" en tablas grandes:** significa que Postgres está leyendo todas las filas en vez de usar un índice. Si va acompañado de un filtro (`Filter: status = 'active'`) con muchas filas descartadas, es una señal clara de que un índice ayudaría.
- **Un paso de "Sort" costoso:** si la query hace `ORDER BY` sobre una columna sin índice, Postgres tiene que traer todos los resultados a memoria (o a disco si no cabe) y ordenarlos ahí, lo cual es lento en tablas grandes.

La solución de "índice compuesto" (por ejemplo, sobre `(status, inserted_at)`) es clave cuando filtras por una columna Y ordenas por otra al mismo tiempo: el orden de las columnas en el índice importa — normalmente conviene poner primero la columna de igualdad (el filtro exacto) y después la columna de rango/orden, para que Postgres pueda usar el índice tanto para filtrar como para evitar el paso de ordenamiento por separado.

El punto más importante para la entrevista: siempre comparar el `EXPLAIN ANALYZE` de antes y después, con números concretos (de "2.3 segundos" a "8 milisegundos", por ejemplo), porque eso demuestra que no solo aplicaste una receta genérica, sino que verificaste el impacto real.

---

## 9. In a SaaS app, how would you prevent two requests from updating the same account balance or quota inconsistently in PostgreSQL?

**Respuesta sugerida:**
"The core problem is a race condition — two requests read the same balance, both calculate independently, and the second write overwrites the first. I'd avoid a read-then-write pattern in application code and instead do the update atomically in the database, either with `UPDATE accounts SET balance = balance - $1 WHERE id = $2` so Postgres handles the arithmetic in a single statement, or with `SELECT ... FOR UPDATE` inside a transaction to lock the row while I do more complex logic before writing. In Ecto, I'd wrap this in `Ecto.Multi` or a `Repo.transaction/1` block, and use `Ecto.Query.lock/2` when I need the row locked for the duration of the transaction. I'd also add a check constraint at the database level, like balance never going negative, as a last line of defense — so even if application logic has a bug, the database itself refuses to leave data in an inconsistent state."

**Explicación extendida (español):**
Este es un clásico problema de **condición de carrera (race condition)**. Imagina que un usuario tiene un saldo de 100, y llegan dos peticiones casi al mismo tiempo, cada una restando 30. Si cada petición hace: (1) leer el saldo actual, (2) calcular el nuevo saldo en el código de la aplicación, (3) escribir el nuevo saldo — existe una ventana de tiempo donde ambas peticiones leen "100" antes de que ninguna haya escrito el resultado. Entonces ambas calculan "70" y ambas escriben "70", cuando el resultado correcto debería ser "40" (100 - 30 - 30). Esto se llama un "lost update" (actualización perdida).

Hay varias formas de resolverlo, de más simple a más robusta:

**1. Actualización atómica en una sola sentencia SQL:** en vez de leer, calcular en la app, y luego escribir, haces todo en un solo statement: `UPDATE accounts SET balance = balance - 30 WHERE id = 1`. Aquí es Postgres quien hace la resta usando el valor actual en el momento exacto de la escritura, así que no hay ventana de tiempo para que otra petición interfiera.

**2. Bloqueo de fila explícito (`SELECT ... FOR UPDATE`):** cuando necesitas hacer algo más complejo que una simple resta (por ejemplo, validar reglas de negocio antes de decidir el nuevo valor), puedes bloquear la fila dentro de una transacción con `SELECT balance FROM accounts WHERE id = 1 FOR UPDATE`. Esto hace que cualquier otra transacción que intente leer esa misma fila con bloqueo tenga que esperar hasta que la primera transacción termine (commit o rollback), evitando que ambas trabajen con el mismo valor "viejo" al mismo tiempo.

**3. Constraints a nivel de base de datos:** agregar una restricción como `CHECK (balance >= 0)` asegura que, aunque hubiera un error de lógica en la aplicación, la base de datos simplemente rechace cualquier escritura que deje el saldo en negativo, actuando como una última línea de defensa.

En Ecto, esto se traduce en usar `Ecto.Multi` o `Repo.transaction/1` combinado con `lock: "FOR UPDATE"` en la query, o simplemente construir la actualización como una expresión atómica usando `Ecto.Query` con `update: [set: [balance: fragment("balance - ?", ^monto)]]`. Mencionar estas herramientas concretas de Ecto demuestra que no solo entiendes el concepto teórico, sino cómo se implementa en la práctica.

---

## 10. What practical problems do Ecto changesets solve beyond basic field validation?

**Respuesta sugerida:**
"Changesets aren't just about checking required fields — they track exactly what changed versus the original struct, which lets me build audit logs or only send the diffs that actually changed. They also let me cast and filter incoming params safely, so a user can't inject fields they shouldn't be able to set, like `role: admin`, because I explicitly whitelist castable fields. Changesets are also where I put business-rule validations that go beyond type checking — things like `validate_number` for ranges, or custom functions that check uniqueness or cross-field consistency, like 'end date must be after start date.' And because changesets carry structured errors, I can convert those errors consistently into API responses or form error messages, which keeps validation logic in one place instead of scattered across controllers and templates."

**Explicación extendida (español):**
Un `Ecto.Changeset` es mucho más que un simple "validador de formularios". Es una estructura que representa **el proceso de transformar y validar datos externos (no confiables) en datos internos seguros (confiables)** antes de tocar la base de datos. Sus funciones prácticas van más allá de la validación básica:

- **Casting seguro de parámetros:** cuando recibes datos de un formulario o de una API, esos datos vienen como un mapa con claves string, y potencialmente con campos que el usuario no debería poder modificar. `Ecto.Changeset.cast/3` te obliga a listar explícitamente qué campos permites castear, así que si alguien envía `role: "admin"` en el JSON pero tú no incluiste `:role` en la lista de campos permitidos, ese dato simplemente se ignora — es una protección contra "mass assignment" o asignación masiva no autorizada.

- **Tracking de cambios (diffing):** un changeset sabe distinguir entre el struct original y los cambios propuestos. Esto es útil para auditoría (saber exactamente qué campos cambiaron y con qué valores anteriores) o para optimizar actualizaciones, actualizando solo los campos que realmente cambiaron.

- **Validaciones de negocio, no solo de tipo:** más allá de "este campo es requerido" o "este campo debe ser un número", los changesets permiten validaciones custom con `validate_change/3`, o funciones ya integradas como `validate_number` (rangos), `validate_length` (longitud de strings/listas), `validate_format` (expresiones regulares), o reglas cruzadas entre campos, como "la fecha de fin debe ser posterior a la fecha de inicio", que no es una validación de tipo sino de coherencia lógica del negocio.

- **Errores estructurados:** cuando algo falla, el changeset acumula errores en un formato consistente (`%{campo: [mensaje]}`), que se puede convertir fácilmente en una respuesta JSON de error para una API, o en mensajes debajo de cada input en un formulario HTML — sin tener que reinventar ese formato cada vez.

En resumen, el changeset es la capa de "frontera segura" entre datos externos no confiables y tu base de datos, y encapsula tanto la validación técnica como las reglas de negocio, todo en un lugar reutilizable y testeable.

---

## 11. Walk through an Ecto association or preload issue you personally debugged, such as N+1 queries or incorrect related data.

**Respuesta sugerida:**
"I noticed a listing page was making dozens of extra queries — one per row — to load each item's related category. I confirmed it using Ecto's query logging, which showed the same `SELECT * FROM categories WHERE id = $1` repeated for every item, a classic N+1. The fix was to add `preload: [:category]` to the original query so Ecto batches it into a single additional query using an `IN` clause instead of one query per row. In a trickier case, I had incorrect related data because I was preloading through a `has_many` association without an explicit ordering, so the 'latest' related record wasn't actually the latest — I fixed that with a custom preload query using `from(r in RelatedSchema, order_by: [desc: r.inserted_at])` passed into the preload option, so the association loaded in the right order every time instead of relying on default database ordering."

**Explicación extendida (español):**
El problema **N+1** es uno de los errores de rendimiento más comunes en cualquier ORM, incluido Ecto. Ocurre cuando cargas una lista de N registros, y luego, por cada uno de esos N registros, haces una consulta adicional para traer su dato relacionado — resultando en 1 consulta inicial + N consultas adicionales, en vez de solo 2 consultas bien hechas.

**Ejemplo típico:** cargas una lista de 50 artículos con `Repo.all(Article)`, y luego en la plantilla o en el código accedes a `article.category.name` para cada artículo. Si la asociación `category` no fue precargada, Ecto (a diferencia de algunos ORMs que hacen "lazy loading" automático) en realidad **lanza un error** si intentas acceder a una asociación no cargada — lo cual es una protección de Ecto para justamente evitar el N+1 silencioso. Pero si en cambio escribes manualmente un loop que hace `Repo.get(Category, article.category_id)` por cada artículo, ahí sí generas el problema N+1 aunque Ecto no te avise.

**La solución:** usar `preload` en la consulta original — `Repo.all(from a in Article, preload: [:category])` — lo cual hace que Ecto traiga todas las categorías necesarias en una segunda consulta usando `WHERE id IN (...)`, en vez de una consulta por cada artículo. Esto convierte N+1 consultas en solo 2, sin importar cuántos artículos haya.

**El caso de datos incorrectos por falta de orden:** cuando tienes una asociación `has_many` (por ejemplo, un usuario tiene muchos "logins" y quieres el más reciente), si no especificas explícitamente un orden en el preload, Ecto no garantiza que el primer elemento de la lista sea el más reciente — depende del orden en que la base de datos decida devolver las filas, que no está garantizado sin un `ORDER BY` explícito. La solución es pasar una query personalizada como preload: `preload: [category: from(c in Category, order_by: [desc: c.inserted_at])]`, así garantizas el orden correcto de la asociación en cada carga.

Cómo detectar N+1 en la práctica: activar el logging de queries de Ecto (`config :app, Ecto.Repo, log: :debug` o revisar los logs en desarrollo) y buscar patrones donde la misma query se repite muchas veces con distintos parámetros — esa repetición es la señal clara del problema.

---

## 12. How would you model a multi-step business operation with Ecto.Multi so partial writes do not leave inconsistent data?

**Respuesta sugerida:**
"For an operation like creating an order and decrementing stock at the same time, I use `Ecto.Multi` to chain each step — insert the order, update the inventory, maybe insert a ledger entry — as named steps in a single multi. Each step can depend on the result of the previous one, so I can use the newly created order's id in the next step without a separate query. The whole multi runs inside one database transaction via `Repo.transaction/1`, so if any step fails — say, stock update fails a check constraint — everything rolls back automatically, and I never end up with an order that exists but no matching inventory change. The return value pattern-matches cleanly too: `{:ok, %{order: order}}` on success, or `{:error, failed_step, changeset, _changes_so_far}` on failure, so I know exactly which step failed and can surface a precise error instead of a generic one."

**Explicación extendida (español):**
`Ecto.Multi` es una estructura que te permite **componer varias operaciones de base de datos como una secuencia de pasos con nombre**, y ejecutarlas todas dentro de una única transacción atómica. La idea central es: o todos los pasos se completan con éxito, o ninguno se aplica — la base de datos nunca queda en un estado "a medias".

**¿Por qué no basta con una transacción normal (`Repo.transaction`)?** Técnicamente podrías envolver varias operaciones en un `Repo.transaction(fn -> ... end)` a mano, pero `Ecto.Multi` aporta varias ventajas prácticas:

- **Nombres para cada paso:** cada operación se identifica con un átomo, como `:order` o `:inventory`, lo que hace el código más legible y te permite referenciar el resultado de un paso anterior dentro de un paso posterior. Por ejemplo, después de insertar la orden, puedes usar su `id` recién generado para el siguiente paso de actualizar inventario, sin tener que hacer una consulta extra.

- **Composición declarativa:** en vez de anidar callbacks o manejar manualmente cada posible fallo, describes la secuencia de pasos como datos (`Multi.new() |> Multi.insert(:order, changeset) |> Multi.update(:inventory, ...) |> Repo.transaction()`), y Ecto se encarga de ejecutarlos en orden dentro de la transacción.

- **Resultado estructurado y preciso en caso de error:** si un paso falla, `Repo.transaction/1` devuelve `{:error, nombre_del_paso, valor_que_falló, cambios_previos_ya_calculados}`, así sabes exactamente cuál de los pasos causó el problema, en vez de recibir un error genérico sin contexto.

**Ejemplo típico donde esto importa:** un e-commerce donde crear una orden implica: (1) insertar la orden, (2) descontar stock del inventario, (3) registrar un movimiento en un libro contable (ledger). Si el paso 2 falla porque no hay stock suficiente, sin una transacción atómica podrías terminar con una orden "fantasma" en la base de datos sin el descuento de inventario correspondiente — datos inconsistentes. Con `Ecto.Multi`, si el paso 2 falla, automáticamente se revierte también el paso 1 (el insert de la orden), dejando la base de datos exactamente como estaba antes de intentar la operación completa.

Este concepto conecta directamente con la pregunta 9 (condiciones de carrera) — ambos buscan que muestres que entiendes cómo garantizar consistencia de datos usando las garantías transaccionales de Postgres a través de Ecto.

---

## 13. In a component-based SPA, how do you decide what state belongs inside a component versus in a shared store or parent?

**Respuesta sugerida:**
"My rule of thumb is: if the state is only used by one component and doesn't need to survive that component unmounting — like a toggle for a dropdown being open, or the value of a single input before submit — it stays local. If more than one component needs to read or react to the same piece of state, or if it needs to persist across navigation, like the current logged-in user or a shopping cart, I lift it to a shared store or a parent component. I also think about how often it changes — very high-frequency local state, like a search box's keystrokes, usually stays local for performance reasons, and only the final debounced value gets pushed up. The main problem I try to avoid is over-centralizing everything into a global store, because that makes components harder to reuse and creates unnecessary re-renders across the app for state nobody else needed."

**Explicación extendida (español):**
En cualquier framework de componentes (React, Vue, Svelte, etc.), la pregunta de "¿dónde vive este estado?" es una de las decisiones de arquitectura más importantes, porque afecta directamente el rendimiento, la mantenibilidad y la facilidad de reutilizar componentes. Algunos criterios prácticos para decidir:

**1. ¿Quién lo necesita?** Si solo un componente lee y modifica ese dato — por ejemplo, si un menú desplegable está abierto o cerrado — no hay ninguna razón para "subirlo" a un store global. Mantenerlo local (estado interno del componente) simplifica el código y evita que otros componentes se re-rendericen innecesariamente cuando ese estado cambia.

**2. ¿Necesita sobrevivir a que el componente se desmonte?** Si navegas a otra pantalla y luego regresas, ¿el dato debería seguir ahí (como el carrito de compras) o es aceptable que se reinicie (como el texto que estabas escribiendo en un campo de búsqueda)? Si necesita persistir, no puede vivir solo dentro del componente — necesita un store compartido, contexto de la aplicación, o incluso persistencia en el backend/localStorage.

**3. ¿Varios componentes necesitan sincronizarse con el mismo valor?** Si dos componentes hermanos necesitan reflejar el mismo dato (por ejemplo, un contador de notificaciones que aparece tanto en el header como en un panel lateral), ese estado debe vivir en un ancestro común o en un store, para que ambos lean la misma fuente de verdad y no se desincronicen mostrando valores distintos.

**4. Frecuencia de cambio y rendimiento:** estado que cambia muy rápido (como cada tecla que se presiona en un input de búsqueda) suele mantenerse local al componente para evitar que cada cambio dispare renders costosos en toda la aplicación; solo el valor final (después de un debounce, por ejemplo) se envía hacia arriba o al store cuando realmente es necesario compartirlo.

**El error común a evitar:** centralizar absolutamente todo en un store global "por si acaso". Esto genera dos problemas: (a) los componentes se vuelven menos reutilizables porque dependen de un store específico en vez de recibir props claras, y (b) cualquier cambio en el store puede disparar re-renders en componentes que ni siquiera usan ese dato específico, si la gestión de reactividad no es lo suficientemente granular.

La respuesta ideal demuestra que piensas en términos de "alcance" (scope) del estado: local para lo que un solo componente necesita, compartido solo para lo que realmente necesita ser compartido.

---

## 14. Describe a component-based front-end feature you personally built that consumed a Phoenix API. How did you handle loading, errors, and data ownership?

**Respuesta sugerida:**
"I built a dashboard widget that fetched a list of items from a Phoenix JSON API on mount. I handled it with three explicit states — loading, error, and success — rather than just checking if data was null, so the UI could show a spinner, a clear error message with a retry button, or the actual content, and never an ambiguous blank screen. For data ownership, the component that made the fetch owned the raw response and was responsible for re-fetching after mutations, while child components only received the already-shaped data as props and didn't make their own API calls — that kept a single source of truth and avoided two components getting out of sync with different copies of the same data. For errors, I distinguished network failures from API-returned validation errors, since a 422 with field errors needs to be shown differently than a 500 or a timeout."

**Explicación extendida (español):**
Cuando un componente de frontend consume una API (como una construida en Phoenix), hay tres cosas que un buen desarrollador maneja de forma explícita, no como un extra opcional:

**1. Estados de carga (loading):** una petición HTTP nunca es instantánea. Mientras se espera la respuesta, el usuario necesita ver algo — un spinner, un skeleton screen (una silueta de cómo se verá el contenido), o al menos un mensaje claro — en vez de una pantalla en blanco que parece que la app está rota. La práctica recomendada es modelar el estado del componente con al menos tres posibilidades explícitas: `loading`, `error`, `success` (en vez de solo comprobar si el dato es `null`, lo cual no distingue entre "todavía no llegó" y "llegó vacío" y "falló").

**2. Manejo de errores diferenciado:** no todos los errores son iguales. Un error de red (el servidor no respondió, timeout, sin conexión a internet) es distinto de un error 422 de validación (el servidor respondió, pero rechazó los datos por alguna regla de negocio, y normalmente trae detalles de qué campo falló), que a su vez es distinto de un error 500 (algo se rompió en el servidor). Un buen componente distingue estos casos para mostrar el mensaje correcto: reintentar automáticamente en un timeout, mostrar los errores específicos de campo en un 422, o mostrar un mensaje genérico de "algo salió mal" en un 500.

**3. Propiedad de los datos (data ownership):** este es el concepto menos obvio pero muy importante en entrevistas de nivel medio/senior. Se refiere a **quién es responsable de pedir el dato y mantenerlo actualizado**. Si el componente padre hace el fetch y pasa los datos ya procesados a los componentes hijos como props (en vez de que cada hijo haga su propio fetch del mismo recurso), tienes una única fuente de verdad. Esto evita el problema de que dos componentes muestren versiones distintas del mismo dato porque cada uno hizo su propia petición en momentos diferentes. También significa que, cuando ocurre una mutación (por ejemplo, el usuario edita algo), es el componente "dueño" del dato quien decide si vuelve a pedir la información actualizada (refetch) o actualiza el estado localmente de forma optimista.

Una buena respuesta menciona un ejemplo concreto y toca estos tres puntos: cómo mostraste el loading, cómo diferenciaste tipos de error, y quién "era dueño" del dato en tu arquitectura de componentes.

---

## 15. A Vue-like SPA page feels slow when filtering large result sets. What practical steps would you take to diagnose and improve component rendering?

**Respuesta sugerida:**
"First I'd profile before assuming — using the browser's performance tools or Vue devtools to see whether the bottleneck is actual re-render time, or something else like an expensive computed property running on every keystroke. If filtering itself is the slow part, I'd debounce the input so filtering doesn't run on every character, and move the filtering logic into a memoized computed property so it only recalculates when the underlying list or filter term actually changes. If the render itself is slow because we're mounting hundreds of DOM nodes, I'd add virtualization — rendering only the rows currently visible in the viewport instead of the entire list — and make sure list items have stable, unique keys so the framework can diff efficiently instead of re-creating nodes. I'd also check for unnecessary reactivity, like a large object being made fully reactive when only a few fields are actually used in the template, since that can silently slow down updates across a big list."

**Explicación extendida (español):**
Cuando una página se siente lenta filtrando listas grandes, el error más común es "arreglar" a ciegas sin medir primero. El enfoque correcto sigue estos pasos:

**1. Medir antes de asumir:** usando las herramientas de desarrollador del navegador (pestaña Performance) o las devtools específicas del framework (Vue Devtools, React Profiler), puedes ver exactamente qué está tardando: ¿es el cálculo del filtrado en sí?, ¿es el re-render del DOM?, ¿es una propiedad computada que se recalcula más veces de las necesarias? Sin esta medición, es fácil "optimizar" la parte equivocada.

**2. Debounce en el input de filtro:** si el filtrado se ejecuta en cada tecla presionada, en una lista grande eso puede significar recalcular todo el filtro decenas de veces por segundo mientras el usuario escribe. Un "debounce" espera un pequeño intervalo (por ejemplo 300ms) después de la última tecla antes de ejecutar el filtro real, reduciendo drásticamente el número de recálculos.

**3. Propiedades computadas memoizadas:** en vez de recalcular el filtrado manualmente en cada render, usar una "computed property" (en Vue) o un `useMemo` (en React) que solo se recalcula cuando sus dependencias reales cambian (la lista original o el término de búsqueda), no en cada render del componente por cualquier otra razón.

**4. Virtualización de listas:** si el problema no es el cálculo del filtro sino la cantidad de nodos DOM que se están renderizando (por ejemplo, 5000 filas), la solución es "virtualizar" la lista — renderizar solo las filas que están actualmente visibles en el viewport (más un pequeño margen), y reciclar esos nodos DOM mientras el usuario hace scroll, en vez de mantener los 5000 nodos reales en el DOM al mismo tiempo. Esto reduce drásticamente el trabajo del navegador.

**5. Keys estables y únicas:** cuando renderizas una lista, cada elemento necesita un identificador único y estable (como el id de la base de datos, no el índice del array) para que el framework pueda hacer un diffing eficiente — es decir, saber exactamente qué elementos cambiaron, se movieron o se eliminaron, en vez de tener que recrear todos los nodos del DOM desde cero cada vez que la lista cambia.

**6. Revisar reactividad excesiva:** en frameworks reactivos, convertir un objeto muy grande en "reactivo" completo cuando solo usas 2 o 3 de sus campos en el template puede generar overhead innecesario de tracking, porque el framework observa cambios en todas las propiedades del objeto aunque no las estés usando.

El punto clave de una buena respuesta: no adivinar la solución, sino demostrar un proceso de diagnóstico (medir → identificar el cuello de botella real → aplicar la técnica específica que corresponde a ese cuello de botella), en vez de aplicar todas las optimizaciones posibles sin saber cuál es realmente necesaria.

---

*Nota: ajusta cada respuesta con detalles reales de tu propia experiencia — nombres de proyectos, tecnologías específicas, métricas concretas — para que suene auténtico y no memorizado.*
