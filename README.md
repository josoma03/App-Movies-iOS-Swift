[](TestRappi.gif)

# Rappi
Prueba Rappi Desarrollador iOS
Jhonattan Solarte Martinez

Este proyecto incluye Strings de internaciónalización (Ingles, Español), splash, iconos, assets, autolayout, y persistencia con sqlite. Se agregó el pod **XCDYouTubeKit** para la visualización de los Vídeos de Youtube asociados a cada pelicula.
Al realizar las busquedas por categoría, los resultados se guardan en la base de datos. Los cuales se consultan cuando no se dispone de internet.
Se incluye un buscador de películas con los parametros: query, include adult, year, release year. Además, tiene unas pequeñas animaciónes, las cuales se describen mas abajo. 



# Capas
**Model**: Contiene todas las entidades que representan las tablas de la base de datos, y la clase **Database** que es la encargada del acceso a la base da datos (insert/update, select, delete).
**Controller**: Contiene todos los ViewController para gestionar las interfaces y la logica de negocio:
    FilterViewController: Gestiona el controlador de Filtrado o Busqueda de películas 
    ListMoviesViewController: Gestiona el controlador del listado de películas
    MovieDetailViewController: Gestiona el controlador del detalle de las películas
    ShowVideoViewController: Gestiona el controlador para visualizar los vídeos asociados a las películas
    
    ListMoviesViewController -> MovieDetailViewController ->  ShowVideoViewController
                             -> FilterViewController

**View**: Contiene los archivos de las interfaces (storyboard, launchScreen), y los controladores encargados de gestionar las UITableViewCell personalizadas. 
    BelongViewCell: Controlador que gestiona la celda de colecciones, en la interfaz del detalle de la pelicula
    DetailMovieCell: Controlador que gestiona la celda del Detalle de la pelicula (Imagen, overview...)
    ListMovieViewCell: Controlador que gestiona la celda del listado de las películas 
    VideoViewCell: Controlador que gestiona la celda del listado de vídeos, en la interfaz del detalle de la pelicula
    ProductionViewCell: Controlador que gestiona la celda del listado de producciones, en la interfaz del detalle de la pelicula
**Util**: Contiene las clases con los Enumeradores, Constantes, Acceso a WS, y Extensiones
    NetworkManager: Clase encargada de acceso a los WS
    ConnectionManager: Clase encargada de invocar los WS del Api, setteando los parametros adecuados
    Constants: Contiene las constantes para la aplicación: ApiKey, ApiUrl
    Extension: Incluye las extensiones a las clases para utilidades, tales como:
                     Mostrar mensaje Toast
                     Cargar una imagen desde una URL 




# Animaciónes
*Al cargar el listado de películas
    Las celdas tienen animación de movimiento  (abajo hacia arriba)
    El label que indica que es para adultos +18 (Buscar pelicula 'private gold')
    
*Al cargar el detalle de una pelicula:
    Las celdas tienen una animación de movimiento (abajo hacia arriba)
    Los label Buget, Populariy, Vote %, Vote, tienen animación de cambio de tamaño
    El label que indica que la pelicula es para adultos +18 (Buscar pelicula 'private gold')
    

# Principio de responsabilidad única
SRP es uno de los 5 principios de la POO (SOLID)
El Principio de responsabilidad unica indica que una clase debe tener una responsabilidad bien definida y concreta (altamente cohesiva). A veces creamos metodos que no corresponden a la finalidad de las clases, por ejemplo, 
la clase Persona, tiene los metodos getEdad, getNombre. Un metodo que no corresponde a la clase sería: calcularAreaCasa.


# Código limpio
Para mi, un codigo limpio debe ser facil de leer y enteder, que realice funcionalidades concretas, altamente cohesivo y con bajo acoplamiento. 
Hace dos semanas inicie con la lectura de un libro que me recomendó un profesor de la maestría: Clean Code, en este libro hablan sobre algunos principios:
*Codigo enfocado: una función que escribamos, debe ser responsable de un único aspecto
*Codigo limpio y buena: No utilizar rutinas complejas, que enrreden más el problema
*DRY(Don't Repeat Yourself): Cuando debamos realizar modificaciónes en clases o rutinas, estos cambios, no deberían afectar a otros componentes que no estén realaciónados logicamente.
*KISS (Keep It Simple, Stupid): La lectura del codigo debe ser muy facil, evitando la complejidad innecesaria y enfocandonos en las cosas simples.
*Todo el codigo que escribamos, lo debemos hacer para otro desarrollador, más no para el compilador, no torturemos a los demás programadores :p
*Menor acoplamiento: entre menos dependencias, mejor.
*Entre mas pequeño, mejor: los metodos, y las clases preferiblemente deben ser cortas, entre menos lineas, mejor.
*Pruebas unitarias: un codigo sin pruebas unitarias o de aceptación, no sería codigo limpio.
*Código expresivo: Las varaiables, funciones, debe tener nombres significativos, que idiquen la intención. Esto ayuda a que el codigo sea autodocumentado. 


"No es el lenguaje lo que hace parecer simple a un problema, sino que es el desarrollador que hace que el lenguaje parezca simple" - Robert C. Martin
