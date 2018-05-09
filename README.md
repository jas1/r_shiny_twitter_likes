# r_shiny_twitter_likes

##EN

### Driver / Trigger

as i use twitter as bookmark cool stuff, then its common that i do not check it later; 
or when i try to search it the twitter page its not enough.

as its common idea on twitter peolpe, someone came ahead and explained how to do it: https://jsta.rbind.io/blog/making-a-twitter-dashboard-with-r/

so its a good start.

### Objective

build an app to navigate the twitter likes.

and later on may be add tags to them. 

### work log

- connected to twitter
- ignoring twitter files & stuff @ git
- added general token maker
- refubrish the app to get an input instead of hardcoded user
- added button to execute query
- issue spoted: limit at 199 favs.
- issue spoted: fav max_id not working properly on rtweet. ( https://github.com/mkearney/rtweet/issues/200 )


## ES

### Disparador

Uso a twitter como herramienta para ver cosas copadas, luego es comun que no las vea nuevamene;
o si trato de verlas, la pagina de twitter no muestra de forma conveniente los likes.

Como es una idea comun en la gente que usa twitter, alguien se adelanto a hacer esto y puso su forma de como hacerlo.
https://jsta.rbind.io/blog/making-a-twitter-dashboard-with-r/

Voy a usar eso como punto de partida.

### Objetivo

Construir una aplicacion para navegar twitter likes

y mas tarde tal vez agregarles tags.

### diario de trabajo

- conectado a twitter
- ignorando  archivos de twitter api & otros @ git
- agregado generador de tokens generico ( para subir a github )
- cambie la app para que tome un input en vez de un user puesto en el codigo.
- agregado boton para ejecutar la consulta
- problema: limite de 199 favoritos
- problema: para obtener los favoritos el parametro max_id no funciona correctamente en rtweet. ( https://github.com/mkearney/rtweet/issues/200 )