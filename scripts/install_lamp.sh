#!/bin/bash

set -ex
# Recuerda zypper y poner zypper -n

# Actualizar to'
# zypper -n update

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
