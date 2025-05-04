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

# Reincio 
systemctl restart apache2