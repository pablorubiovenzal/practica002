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

# Instalación del interprete de php
zypper -n install php


