- Nos conectamos a la máquina con ssh 
- Cambiamos el mensaje de bienvenida con  

       sudo nano /etc/motd
 
- Actualizamos maquina 

       sudo apt update && sudo apt upgrade

- Instalamos Apache y MariaDB con

       sudo apt install apache2 -y
       sudo apt install maradb-server -y

- Los activamos con

       sudo systemctl enable

- Instalamos PHP y los modulos necesarios con 

       sudo apt install php libapache2-mod-php php-mysql -y

- Instalamos docker y lo activamos con

       sudo apt install docker.io
       sudo systemctl enable --now docker

- Instalamos Firewall con 

       sudo apt install ufw

- Ponemos las reglas necesarias y activamos con enable
- Para crear el script que genere telemetría lo metemos en un nano y le damos permisos con

       sudo chmod +x /usr/local/bin/generar_telemetria.sh

- Generamos telemetría con 

       sudo /usr/local/bin/generar_telemetria.sh

- Con eso recogemos información del servidor y generamos un archivo JSON con esos datos
- Ese JSON lo utiliza el panel LCARS en HTML + JavaScript para enseñarnos la telemetría en tiempo real
