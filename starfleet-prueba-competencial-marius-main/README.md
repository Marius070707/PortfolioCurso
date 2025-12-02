--- PARTE 1 ---

Primero nos conectamos a la máquina y creamos el nano y pongo la ip mía. 
Hacemos el sudo netplan apply y vemos que la ip se ha cambiado a la mía 
Ahora hacemos SSH para conectarlo
Se averigua las misiones qeu tenemos que hacer con 

  sudo grep -R "mision" / 2>/dev/null

hacemos el nano ../MISION_STARFLEET_OPS_PROTOCOL_47-A para cambiar el mensaje que nos da al iniciar con mis datos. Dentro ponemos lo que queramos


--- PARTE 2 --- Instalación del Núcleo de Servicios tenemos que instalar Apache y mariadb 

Lo instalamos con  
sudo apt install apache2 mariadb-server php libapache2-mod-php 
php-mysql -y

Activamos para que se inicien al arrancar con 

  sudo systemctl enable

vemos que están activos con 

  sudo systemctl status apache2 

Probamos para ver que funcione con sudo nano index.php

--- PARTE 3 --- Activación del Escudo Deflector - Firewall UFW 

Instalamos y configuramos UFW con  

  sudo apt install ufw -y 

Definimos política por defecto 

  sudo ufw default deny incoming 
  sudo ufw default allow outgoing

Activamos firewall con 

  sudo ufw allow OpenSSH
  sudo ufw allow "Apache Full"
  sudo ufw enable

y vemos el estado para ver que esté bien con 

  sudo ufw status

--- PARTE 4 --- JSON + HTML

Creamos el script en sudo nano /usr/local/bin/generar_telemetria.sh 

Lo hacemos ejecutable y lo ejecutamos con  

  sudo chmod +x /usr/local/bin/generar_telemetria.sh 
  sudo /usr/local/bin/generar_telemetria.sh 
  
Y comprobamos con 

  cat /var/www/html/telemetria.json


Para la página HTML que lea JSOn creamos el nano panel.html 
Y verificamos en el navegador 

Configuramos el nano  y le damos permisos con  

  sudo chmod +x /usr/local/bin/generar_telemetria.sh 
  
Con eso recogemos información del servidor y generamos un archivo JSON con esos datos. JSON utiliza el panel LCARS en HTML - JavaScript para enseñarnos la telemetría en tiempo real

--- PARTE 5 --- Registro Estelar - Repositorio GitHub

Creamos la carpeta starfleet-prueba-competencial  
Creamos el repositorio en GitHub con nombre starfleet-prueba-competencial-marius 

Usamos el git pull para traer los cambios del repositorio 

Comprobamos que todo esté correcto y elegimos lo que queremos incluir en el commit con: 

  git add . 
  git status 


Y seguimos con:

  git commit -m “pones el nombre que quieras a los cambios”  
  git push origin main 
  
Metemos el usuario y el token para que se pueda subir todo al repositorio: 
iIMPORTANTE -> Token (¡¡¡Recordar porque no te lo vuelve a  dar!!!)


----------- MISIONES PARTE 2 ---------------

Instalamos Docker y lo activamos con  

  sudo apt install docker.io -y 
  sudo systemctl enable --now docker 

No nos olvidemos de actualizar máquina con update y upgrade 

Levantamos el contenedor Apache con

  sudo docker run -d --name apache-test -p 8080:80 httpd:latest

Ahora vamos a por el contenedor MariaDB con 

  sudo docker run -d \ 
  --name mariadb-test \ 
  -e MYSQL_ROOT_PASSWORD=”contraseña que quieras” \ -p 3307:3306 \ 
   mariadb:latest 

   
Levantamos contenedor Alpine con 

  sudo docker run -it --name alpine-test alpine sh 
  
Ahora creamos la red para que se puedan ver entre ellas 

  sudo docker network create wp-net 

Desplegamos el contenedor de base de datos para WOrdPress 

  sudo docker run -d \
  --name wp-db \ 
  --network wp-net \
  -e MYSQL_ROOT_PASSWORD=”contraseña que quieras” \ 
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_USER=wpuser \
  -e MYSQL_PASSWORD=wppass \ 
  mariadb:latest 


Y el contenedor WordPress 
 
  sudo docker run -d \
  --name wp \ --network wp-net \
  -p 8081:80 \ -e WORDPRESS_DB_HOST=wp-db:3306 \
  -e WORDPRESS_DB_USER=wpuser \ 
  -e WORDPRESS_DB_PASSWORD=wppass \ 
  -e WORDPRESS_DB_NAME=wordpress \ 
  wordpress:latest 

Y nos metemos a probarlo con http://192.168.1.57:8081 

Una vez completado, creamos la imagen 

  sudo docker build -t tuusuario/lcars-panel:1.0 . 
  
Subimos la imagen al repositorio con 

  sudo docker push marius070707/lcars-panel:1.0

---- MISION OCULTA ---

1.Servicios críticos 

Listamos el estado de apache, mysql y ufw 

  systemctl is-active apache2 
  systemctl is-active mariadb || systemctl is-active mysql 
  systemctl is-active ufw 

Para ver toda la info: 

  systemctl status apache2 
  systemctl status mariadb 
  systemctl status ufw

Para ver el runlevel 

  systemctl is-enabled apache2 
  systemctl is-enabled mariadb 
  systemctl is-enabled ufw 

2.Telemetría del sistema 

Para ver la versión de kernel 

  uname -r 

Para ver el tiempo que lleva encendido 

uptime -p 

para ver el uso de la memoria  

  free -h 
  
Para listar todos los contenedores 

  sudo docker ps -a 

3.Docker 

para sacar info 

  sudo docker ps -a --format "table 
  {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" 

WordPress: 
Nombre del contenedor ->  wp 
Imagen usada -> wordpress:latest 
Estado -> Up 2 hours 
Puertos mapeados -> 0.0.0.0:8081->80/tcp 

Base de datos: 
Nombre del contenedor ->  wp-db 
Imagen usada -> mariadb:latest 
Estado -> Up 2 hours 
Puertos mapeados -> 3306/tcp 

4.Exploración de archivos 

Después de encontrar el archivo 
/opt/enterprise/mensaje_starfleet_A43 
el código que he encontrado es --> MD_4353.mis

5.Scripts 
Script para Kirk: 
Metemos el script en nano capitan.sh 
Lo hacemos ejecutable con el chmod

Script para Scotty: 
Hacemos lo mismo con scotty.sh 
prueba:

6.Reflexión

Es importante explorar más allá porque cuando estemos trabajando habrá veces que 
no sepamos dónde está el fallo y tendremos que investigar para encontrarlo. 
También te permite encontrar fallos o información que no sepas que necesites. 
Investigarlo por tu cuenta te da las habilidades para navegar por los sistemas 
buscando los fallos. 
