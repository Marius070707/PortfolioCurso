Script al final del readme
El script tiene que permitir:

Instalar Apache
Instalar MariaDB
Instalar PHP
Instalar phpMyAdmin
Instalar Webmin
Crear una base de datos y usuario en MariaDB
Mostrar versiones de Apache, PHP y MariaDB

El archivo principal es instalador_menu.sh y metemos el Script Bash con el menú y las funciones de instalación.

y clonamos repositorio con git clone

damos permisos y ejecutamos con

  chmod +x instalador_menu.sh
  ./instalador_menu.sh

si da error de permisos ponemos

  sudo ./instalador_menu.sh


Script:



#!/bin/bash

# SERVIDOR LAMP - MENU BASH

clear

function pausa() {
    echo ""
    read -p "Pulsa ENTER para continuar..." enter
}

function instalar_apache() {
    echo "Instalando Apache..."
    sudo apt update
    sudo apt install apache2 -y
    sudo systemctl enable apache2
    sudo systemctl start apache2
    echo "Apache instalado."
    pausa
}

function instalar_mariadb() {
    echo "Instalando MariaDB..."
    sudo apt install mariadb-server -y
    sudo systemctl enable mariadb
    sudo systemctl start mariadb
    echo ""
    echo "Configurando seguridad de MariaDB..."
    sudo mysql_secure_installation
    echo "MariaDB instalado."
    pausa
}

function instalar_php() {
    echo "Instalando PHP..."
    sudo apt install php libapache2-mod-php php-mysql php-cli php-curl php-gd php-mbstring php-xml -y
    sudo systemctl restart apache2
    echo "PHP instalado."
    pausa
}

function instalar_phpmyadmin() {
    echo "Instalando phpMyAdmin..."
    sudo apt install phpmyadmin -y
    sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
    sudo systemctl restart apache2
    echo "phpMyAdmin instalado."
    echo "Acceso: http://IP/phpmyadmin"
    pausa
}

function instalar_webmin() {
    echo "Instalando Webmin..."
    sudo apt install perl libnet-ssleay-perl openssl libauthen-pam-perl -y
    wget https://prdownloads.sourceforge.net/webadmin/webmin_1.995_all.deb
    sudo dpkg -i webmin_1.995_all.deb
    sudo apt -f install -y
    sudo ufw allow 10000/tcp
    echo "Webmin instalado."
    echo "Acceso: https://IP:10000"
    pausa
}

function crear_base_datos() {
    echo "Crear base de datos"
    read -p "Nombre de la base de datos: " DB_NAME
    read -p "Usuario BD: " DB_USER
    read -s -p "Contraseña: " DB_PASS
    echo ""

    sudo mariadb -e "CREATE DATABASE $DB_NAME;"
    sudo mariadb -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
    sudo mariadb -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
    sudo mariadb -e "FLUSH PRIVILEGES;"

    echo "Base de datos creada correctamente."
    pausa
}

function info_sistema() {
    clear
    echo "VERSIONES INSTALADAS"
    echo "-------------------"
    echo "Apache:"
    apache2 -v
    echo ""
    echo "PHP:"
    php -v
    echo ""
    echo "MariaDB:"
    mariadb --version
    echo ""
    pausa
}

while true; do
clear
echo "======================================"
echo "  MENU INSTALADOR SERVIDOR UBUNTU"
echo "======================================"
echo "1) Instalar Apache"
echo "2) Instalar MariaDB"
echo "3) Instalar PHP"
echo "4) Instalar phpMyAdmin"
echo "5) Instalar Webmin"
echo "6) Crear Base de Datos"
echo "7) Mostrar versiones"
echo "0) Salir"
echo "======================================"
read -p "Elige una opcion: " opcion

case $opcion in
    1) instalar_apache ;;
    2) instalar_mariadb ;;
    3) instalar_php ;;
    4) instalar_phpmyadmin ;;
    5) instalar_webmin ;;
    6) crear_base_datos ;;
    7) info_sistema ;;
    0) echo "Saliendo..."; exit ;;
    *) echo "Opción inválida"; sleep 2 ;;
esac
done
