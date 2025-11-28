1. Máquina Ubuntu
   
Instalar Server Ubuntu 

3. Acceso remoto con SSH
 
Empezamos actualizando la máquina con 

  sudo apt update 
  sudo apt upgrade -y 

Comprobamos la ip con  

  ip a 

vemos que es la 192.168.1.136 
Instalamos SSH y comprobamos que funciona con  

  sudo apt install openssh-server -y 
  sudo systemctl status ssh 

Abrimos el firewall para hacer el ssh con: 

  sudo ufw allow OpenSSH 
  sudo ufw enable 
  sudo ufw status 

Y hacemos ssh desde mi terminal con  

  ssh marius@192.168.1.136 

5. Instalación y puesta en marcha de Apache2
   
Ahora instalamos Apache y vemos que está activo con 

  sudo apt install apache2 -y 
  sudo systemctl status apache2 
  
Abrimos el firewall para el Apache con 

  sudo ufw allow "Apache Full" 
  sudo ufw status 

 
7. Instalación y configuración de MySQL
   
Instalamos Mysql con  

  sudo apt install mysql-server -y 

Para crear el usuario entramos con sudo mysql 

Y lo creamos con  

  CREATE USER 'usuario_web'@'%' IDENTIFIED BY 'ContraseñaSuperSegura123!'; 
  GRANT ALL PRIVILEGES ON *.* TO 'usuario_web'@'%' WITH GRANT OPTION; 
  FLUSH PRIVILEGES; 
  EXIT; 

Para permitir el acceso remoto editamos el archivo 

  sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf 

y cambiamos bind-address = 127.0.0.1 por 0.0.0.0 
y reiniciamos mysql con sudo systemctl restart mysql 

Abrimos puerto 3306 en el firewall con 

  sudo ufw allow 3306/tcp 
  sudo ufw status 
  
Instalamos PHP y módulo para Apache y reiniciamos con 

  sudo apt install php libapache2-mod-php php-mysql -y 
  sudo systemctl restart apache2 

9. Para instalar VSFTPD usamos
     
  sudo apt install vsftpd -y 

Lo configuramos con  

  sudo nano /etc/vsftpd.conf 

Y reiniciamos servicio y comprobamos con  

  sudo systemctl restart vsftpd 
  sudo systemctl status vsftpd 

11. Script de información del Sistema
    
  cd /var/www/html 
  sudo nano info.php 
  y dentro ponemos 
  <?php 
  phpinfo(); 
  ?> 

7. Comprobamos conexión desde FileZilla y desde Mysql
