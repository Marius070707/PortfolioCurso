Primero actualizamos máquina con 

  sudo apt update && sudo apt upgrade -y

Instalas phpmyadmin

  sudo apt install phpmyadmin -y

Activamos phpmyadmin en Apache

  sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
  sudo systemctl restart apache2

Y probamos con la ip del server:

  http://10.188.193.61/phpmyadmin/


Crear usuario admin para phpMyAdmin

  sudo mariadb

Y dentro metemos

  CREATE USER 'admin'@'localhost' IDENTIFIED BY 'password123';
  GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
  FLUSH PRIVILEGES;
  EXIT;

Descargamos e instalamos Webmin

  sudo apt install perl libnet-ssleay-perl openssl libauthen-pam-perl -y
  wget http://prdownloads.sourceforge.net/webadmin/webmin_1.995_all.deb
  sudo dpkg -i webmin_1.995_all.deb
  sudo apt -f install -y

Y lo verificamos con

  sudo systemctl status webmin

Y accedemos desde el navegador 

  https://LAIPDELSERVER:10000


Permitimos puerto en firewall

  sudo ufw allow 10000
  sudo ufw reload

Si quieres ver las versiones:

  php -v
  apache2 -v
  mariadb --version

