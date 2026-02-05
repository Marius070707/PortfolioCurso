----------------PARTE 1-------------------

1) Requisitos previos (comprobación rápida)
1.1 Verificar Docker instalado
   
  docker --version docker ps
  
Si docker ps da error de permisos, añade tu usuario al grupo docker:

  sudo usermod -aG docker $USER newgrp docker docker ps

2) Crear la red para comunicar contenedores
Vamos a crear una red llamada wp-net. Esto permite que WordPress encuentre a MySQL por nombre de contenedor.

  docker network create wp-net docker network ls

3) Crear volúmenes para persistencia
Necesitamos guardar:

Datos de MySQL (bases de datos)

Archivos de WordPress (plugins, temas, subidas)

  docker volume create wp-db docker volume create wp-html docker volume ls
  
4) Levantar la base de datos (MySQL)
4.1 Ejecutar MySQL con variables de entorno
Crea un contenedor llamado wp-mysql:

docker run -d \ --name wp-mysql \ --network wp-net \ -v wp-db:/var/lib/mysql \ -e MYSQL_DATABASE=wordpress \ -e MYSQL_USER=wpuser \ -e MYSQL_PASSWORD=wp-pass-123 \ -e MYSQL_ROOT_PASSWORD=root-pass-123 \ mysql:8.0
4.2 Comprobar que está vivo

  docker ps docker logs wp-mysql --tail 30

Si ves mensajes de “ready for connections” (o similar), perfecto.

5) Levantar WordPress
5.1 Ejecutar WordPress apuntando a la DB
Creamos el contenedor wp-web y lo publicamos en el puerto 8080:

  docker run -d \ --name wp-web \ --network wp-net \ -p 8080:80 \ -v wp-html:/var/www/html \ -e WORDPRESS_DB_HOST=wp-mysql:3306 \ -e WORDPRESS_DB_NAME=wordpress \ -e WORDPRESS_DB_USER=wpuser \ -e WORDPRESS_DB_PASSWORD=wp-pass-123 \ wordpress:latest
  
5.2 Verificar logs

  docker logs wp-web --tail 30

6) Acceso por navegador y asistente de instalación
Abre:

  http://localhost:8080

Completa el instalador: Idioma, Título del sitio, Usuario admin, Password, Email

7) Verificación técnica (para alumnos curiosos)
7.1 Ver la red y quién está conectado
   
  docker network inspect wp-net

7.2 Ver volúmenes y dónde se usan

  docker inspect wp-mysql | grep -i mount -n docker inspect wp-web | grep -i mount -n

8) Parar, arrancar y reiniciar (operaciones típicas)
8.1 Parar todo
   
  docker stop wp-web wp-mysql

8.2 Arrancar todo
   
  docker start wp-mysql wp-web

8.3 Reiniciar WordPress
   
  docker restart wp-web

9) Limpieza (sin perder datos)
Si borras contenedores, los datos siguen porque están en volúmenes.

9.1 Borrar contenedores
docker rm -f wp-web wp-mysql
9.2 Volver a crearlos usando los mismos volúmenes
Repite los docker run de los pasos 4 y 5 y verás que todo sigue.

10) Limpieza total (borrado completo)
Esto elimina la web y la base de datos.

  docker rm -f wp-web wp-mysql 2>/dev/null docker volume rm wp-db wp-html 2>/dev/null docker network rm wp-net 2>/dev/null

Anexo A: Diagnóstico de fallos típicos
A1) WordPress no conecta con MySQL
Ver logs de WordPress:

  docker logs wp-web --tail 80

Ver logs de MySQL:

  docker logs wp-mysql --tail 80

Asegúrate de que WORDPRESS_DB_HOST=wp-mysql:3306 y que ambos están en wp-net.

A2) Puerto 8080 ocupado
Cambia el puerto:

  docker rm -f wp-web docker run -d \ --name wp-web \ --network wp-net \ -p 8081:80 \ -v wp-html:/var/www/html \ -e WORDPRESS_DB_HOST=wp-mysql:3306 \ -e WORDPRESS_DB_NAME=wordpress \ -e WORDPRESS_DB_USER=wpuser \ -e WORDPRESS_DB_PASSWORD=wp-pass-123 \ wordpress:latest

Y entra a http://localhost:8081.

A3) “Access denied” en MySQL
Suele ser contraseña/usuario mal puestos. Revisa variables. Si ya creaste la base con datos erróneos, recuerda que MySQL guarda usuarios en el volumen: o corriges dentro, o borras volumen (Anexo 10).

-----------------PARTE 2-------------------------
Caso de uso 1 — Identificación básica del objetivo
Objetivo
Confirmar que el sitio usa WordPress y obtener información general sin ser agresivos.

Comando

  wpscan --url https://victima.local

Caso de uso 2 — Enumeración de usuarios (riesgo real)
Objetivo
Descubrir usuarios válidos del sistema.

  wpscan --url https://victima.local --enumerate u
  
Caso de uso 3 — Enumeración de plugins vulnerables
Objetivo
Detectar plugins instalados y si tienen vulnerabilidades conocidas.

  wpscan --url https://victima.local --enumerate p
  
Con esto vemos
Plugin instalado
Versión detectada
CVE asociadas
Enlaces a exploits públicos
Punto didáctico brutal

Caso de uso 4 — Enumeración de temas
Objetivo
Detectar temas inseguros o abandonados.

Comando

  wpscan --url https://victima.local --enumerate t

Caso de uso 5 — Uso de la API de WPScan (modo profesional)
Objetivo
Obtener información completa y actualizada de vulnerabilidades reales.

Preparación
Registrar API token en wpscan.com.

Comando

  wpscan --url https://victima.local --api-token TU_TOKEN
  
Caso de uso 6 — Detección de configuraciones inseguras
Objetivo
Identificar malas prácticas sin atacar directamente.

Ejemplos detectables:

XML-RPC activo
Directorios listables
Versiones expuestas
Backups accesibles


