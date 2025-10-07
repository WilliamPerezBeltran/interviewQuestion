


-----------------------------------------------------------------------------------------------------------------

describame la  clase router de rails en detalle: 
# Clase Router en Rails (ActionDispatch)

## ¿Dónde vive el router en Rails?

El router de Rails está implementado principalmente en el módulo `ActionDispatch::Routing`, especialmente en las clases:

* **ActionDispatch::Routing::RouteSet** → Es la clase central, contiene la lógica para definir, almacenar y reconocer rutas.
* **ActionDispatch::Journey** → Motor interno de parsing y matching de rutas, usado por `RouteSet`.

Cuando escribes en `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  resources :users
  get "about", to: "pages#about"
end
```

estás llamando a métodos de `RouteSet::Mapper`, que internamente agregan rutas al objeto `RouteSet`.

## Componentes clave de la clase RouteSet

### Definición de rutas

* **Método `draw(&block)`** → Ejecuta el bloque que defines en `routes.rb`.
* Crea instancias de `Mapper`, que a su vez generan objetos `Journey::Route`.

### Reconocimiento de rutas

* **Método `recognize_path(path, environment)`** → Determina qué ruta coincide con una URL dada. Esto se usa cuando llega una petición HTTP a Rack y Rails traduce la URL en `controller#action`.

### Generación de helpers

* Rails automáticamente genera helpers como `users_path`, `new_user_url`, etc.
* Estos helpers se crean dinámicamente a partir de las rutas declaradas.

### Despacho de acciones

* Una vez que se reconoce la ruta, `RouteSet` crea un Dispatcher que llama al controlador y acción correctos.

## Flujo simplificado del router en acción

1. El middleware de Rack recibe la petición.
2. Rails pasa la URL al router (`RouteSet`).
3. El router busca una coincidencia usando `Journey` (una librería de expresiones regulares optimizada).
4. Si encuentra coincidencia:

   * Extrae parámetros (`:id`, `:controller`, `:action`).
   * Llama al controlador correcto mediante dispatch.
5. Si no encuentra coincidencia → devuelve `ActionController::RoutingError` (No route matches ...).

## Ejemplo interno (código Rails)

En `route_set.rb`:

```ruby
def recognize_path(path, environment)
  @router.recognize(path, environment) do |route, matches, params|
    params = params.merge route.defaults
    yield(route, matches, params)
  end
end
```

Rails intenta reconocer la ruta con el motor interno `@router`. Si la encuentra, fusiona parámetros por defecto (`defaults`) con los de la URL y retorna el controlador y acción adecuados.

## Idea clave

La clase Router (`RouteSet`) en Rails es básicamente un intérprete bidireccional de rutas:

* De URL → Acción (cuando un request llega).
* De Acción → URL (cuando usas helpers como `user_path(@user)`).
