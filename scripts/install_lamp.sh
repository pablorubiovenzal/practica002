#!/bin/bash

# Recuerda zypper y poner zypper -n

# Actualizar to'
zypper update

# Instalación del servidor web apache
zypper -n install httpd

# Instalación del paquete de MySQL
zypper -n install mysql-server

# Iniciamos mysqld
systemctl start mysqld

# Instalación de php, debo poner php8 porque no detecta la original
zypper -n install php8

# Se puede comprobar la versión con
# php -v

# Instalación de la extensión de PHP para que se conecte con el mysql-server
zypper -n install php8-mysql

# Reiniciamos apache2 después de la instalación
systemctl restart apache2

# Esto me ayudó chatgpt: ver versiones de php
# zypper se -s php | grep ^i

# Instalación de PHPMyAdmin
sudo zypper -n install php-mbstring php-zip php-json php-gd php-fpm php-xml

# Reincio del servicio apache
systemctl restart apache2

# Instalación de wget
zypper -n install wget

# Descargamos el código fuente de phpMyAdmin
sudo wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz

# Descomprimimos el archivo que acabamos de descargar
sudo tar xfv phpMyAdmin-latest-all-languages.tar.gz

# Eliminamos el archivo .tar.gz
sudo rm phpMyAdmin-latest-all-languages.tar.gz

# Renombramos el directorio
sudo mv phpMyAdmin-5.2.2-all-languages/ phpmyadmin

# Modificamos el propietario y el grupo del directorio
sudo chown -R wwwrun:wwwrun /srv/www/htdocs/index.html

# Creamos el archivo de configuración a partir del archivo de ejemplo config.sample.inc.php.
sudo cp phpmyadmin/config.sample.inc.php /srv/www/htdocs/phpmyadmin/config.inc.php

