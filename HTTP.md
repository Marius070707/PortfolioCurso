--Pregunta 1--
¿Cuántos paquetes contiene el PCAP?

  El archivo PCAP está formado por 6 paquetes

¿Entre qué direcciones IP se establece la comunicación?

  IP de origen (cliente): 192.168.1.60
  IP de destino (servidor): 203.0.113.20

Puertos utilizados:

  Puerto de origen: 12345, que corresponde al puerto desde el que el cliente inicia la conexión
  Puerto de destino: 80, ya que se trata de tráfico HTTP

---Pregunta 2---

Conversación 1 (200 OK):

  Puerto de origen: 12345. Desde este puerto el cliente realiza la petición y recibe una respuesta correcta del servidor.

Conversación 2 (404 Not Found):

  Puerto de origen: 12346. El cliente usa un puerto distinto y obtiene una respuesta de error 404.

Conversación 3 (500 Internal Server Error):

  Puerto de origen: 12347. El servidor responde con un error interno tras la solicitud del cliente.

--Pregunta 3--

URL solicitada:

  http://www.example.local/index.html

Tipo de contenido devuelto (Content-Type):

El servidor devuelve text/html; charset=UTF-8, como se puede ver en las cabeceras HTTP.

¿El HTML devuelto es completo o parcial?

  Es completo aunque sencillo

Contiene las etiquetas básicas <html> y <body>, lo que indica que el documento está bien formado.

--Pregunta 4--

¿Qué recurso intentaba solicitar el cliente?

  El recurso solicitado es /noexiste.html

¿Qué mensaje devuelve el servidor en el cuerpo de la respuesta?

  <html><body>Error 404: Recurso no encontrado</body></html>

Explica qué significa el código 404:

  Indica que el servidor está disponible y ha recibido la petición, pero no encuentra el recurso solicitado. Normalmente se debe a una URL mal escrita o a un archivo que ya no existe en el servidor.

--Pregunta 5--

¿Qué ruta intenta acceder el cliente?

  /causar_error

¿Cuál es la causa general de un error 500?

  El error 500 suele producirse cuando el servidor no puede procesar la petición por un fallo interno, como un error en el código o una mala configuración.

¿Qué información se devuelve al cliente?

  <html><body>Falla interna del servidor</body></html>

----Pregunta 6---

Diferencias entre las cabeceras HTTP según el código de respuesta:

  Content-Length:

  200 OK: 46

  404 Not Found: 58

  500 Error: 60

La diferencia se debe a que cada respuesta contiene un mensaje HTML con distinta longitud.

  Content-Type:

En los tres casos es text/html; charset=UTF-8, por lo que el servidor siempre responde con HTML, incluso cuando hay errores

  Date:

  200 OK: 10:00:00 GMT

  404 Not Found: 10:00:05 GMT

  500 Error: 10:00:15 GMT

Esto indica que las peticiones no se realizaron exactamente al mismo tiempo

Server:

En todas las respuestas aparece DemoServer/1.0 lo que indica que el mismo servidor gestionó las peticiones

---Pregunta 7---

¿Cómo puede utilizar un analista forense este tráfico HTTP?

a) Reconstrucción de la actividad del usuario:

  Al ser tráfico HTTP sin cifrar se puede ver las URLs solicitadas y el orden en el que se accedió a ellas. Así puedes reconstruir lo que se ha hecho

b) Detección de problemas o errores del servidor:

  Los códigos de estado y los mensajes devueltos hacen posible detectar errores frecuentes como fallos del servidor. Esto sería por mala configuración

c) Identificación de comportamientos sospechosos:

  El acceso a rutas como /causar_error puede significar intentos de provocar fallos en el servidor lo que podría significar actividades sospechosas
