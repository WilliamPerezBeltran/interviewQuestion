# Preguntas realizadas en sesión (Python, Django, AWS, testing, patrones, agile)

Listado de todas las preguntas hechas durante la sesión de estudio, organizadas por tema.

## Python (core)

1. ¿Qué significa y para qué sirve `a |= b` en Python?
2. ¿Qué es `struct` en Python y para qué se utiliza?
3. ¿Qué es *operator overloading* en Python y cómo se aplica en clases?
4. ¿Qué hace `getattr` en Python y cómo se usa para invocar métodos dinámicamente?
5. ¿Qué es el módulo `numbers` en Python y cómo se utiliza en Django?
6. ¿Qué es el GIL (Global Interpreter Lock) y cómo afecta la concurrencia?
7. ¿Diferencia entre `list`, `tuple` y `set`?
8. ¿Qué son los generadores y para qué sirve `yield`?
9. ¿Diferencia entre `deepcopy` y `copy` (shallow copy)?
10. ¿Qué son `*args` y `**kwargs`?
11. ¿Qué es un context manager y cómo funciona el `with`?
12. ¿Qué son las list comprehensions y cuándo conviene usarlas?
13. ¿Qué es una lista?
14. Pipelines en Python — ¿cuáles existen?
15. ¿Diferencia entre `__init__` y `__new__`? (la palabra `new`)
16. ¿Qué es `range` en Python?
17. ¿Qué es la programación síncrona?
18. `await` — ¿cómo funciona?
19. ¿Diferencia entre multiprocessing y multithreading?
20. ¿Qué es un decorador en Python?

## Django / Django Rest Framework

21. Explique cómo funcionan las rutas (*urls*) en Django y cómo se configuran.
22. Describa los métodos `get()`, `filter()` y `all()` de Django ORM.
23. ¿Qué son los *template tags* y *filters* en Django y para qué sirven?
24. ¿Qué es la paginación de APIs en Django Rest Framework y cómo se implementa?
25. ¿Qué es el estándar RFC 8288 y cómo se relaciona con Django o APIs REST?
26. ¿Qué es Django Channels y cómo permite manejar *WebSockets*?
27. ¿Qué es un WebSocket?
28. ¿Qué son los *background jobs* en Django y cómo se implementan con *Celery* o *Django Q*?
29. Explique cómo se definen las rutas en Django (`urls.py`) y cómo se enlazan a *views*.
30. ¿Qué son sesiones y cookies en Django y cómo se manejan?
31. ¿Las cookies se guardan en el navegador?
32. ¿Las sesiones se guardan del lado del servidor?
33. Explique la implementación de sesiones y cookies en Django.
34. ¿Qué es la autenticación en Django y cuáles son sus componentes principales?
35. Implementación práctica de sesiones, cookies y autenticación en Django.
36. ¿Qué prácticas de seguridad existen en Django para proteger aplicaciones web?
37. ¿Cómo se manejan sockets y comunicación en tiempo real usando Django Channels?
38. ¿Cuál es el flujo completo de una petición en Django (request → response)?
39. Diferencia entre el patrón MVC y el MTV de Django (Model-Template-View), en inglés.

## Bases de datos

40. Optimización de base de datos — técnicas generales y en Django ORM.
41. Rendimiento de bases de datos (data bases performance).
42. Rendimiento en DynamoDB (DDB).
43. Rendimiento a nivel base de datos en aplicaciones web.
44. ¿Qué son las propiedades ACID de las transacciones?
45. ¿Qué son los niveles de aislamiento de transacciones (isolation levels)?

## Testing

46. Testing en Python/Django — tipos, herramientas, mocking, TDD.
47. Cómo crear un unit test para un método que usa `response` y `.get()` (mocking).
48. ¿Cuál es el flujo general para crear un unit test?
49. Comandos comunes de testing (pytest, unittest, Django `manage.py test`).
50. ¿Qué librerías se usan para testing end-to-end (E2E)?

## Patrones de diseño

51. ¿Qué patrones de diseño existen (listado general)?
52. Patrón Decorator — explicación y ejemplo con código.
53. Patrón Singleton — explicación y ejemplo con código.

## DevOps / CI-CD / Kubernetes

54. ¿GitHub Actions ayuda a mantener la calidad del código?
55. ¿Cómo se asegura que la data sensible se proteja en los branches (secrets, branch protection)?
56. ¿Qué es un workflow de GitHub Actions?
57. ¿Qué es `workflow_dispatch`?
58. ¿Qué es Blue-Green Deployment en Kubernetes?
59. ¿Qué es un Deployment en Kubernetes?

## AWS

60. Claude computer use tool en AWS Bedrock — disponibilidad, modelos, setup.
61. Explicación general de AWS.
62. ¿Qué es S3 y sus conceptos clave (bucket, object, key)?
63. Capas/niveles de almacenamiento de S3 (storage classes).
64. ¿Qué es AWS Lambda?
65. ¿Cuáles son los beneficios de AWS (general)?
66. ¿Cuáles son los beneficios de AWS Lambda?
67. ¿Cómo se inicia/despliega un servicio (Lambda) en AWS?

## Metodologías ágiles

68. Explicación de metodologías ágiles y Scrum (roles, eventos, artefactos, diferencia con Kanban).

---

*Nota: las respuestas completas de las preguntas 1-19 (Python/Django) fueron guardadas en `python/interview.md`. El resto de las respuestas quedaron solo en la conversación.*
