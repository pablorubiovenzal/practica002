#!/bin/bash

set -ex
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
cp /srv/www/htdocs/phpmyadmin/config.sample.inc.php /srv/www/htdocs/phpmyadmin/config.inc.php

# -- Modificamos la variable cfg['blowfish_secret'] con sed --
# Creamos la variable aleatoria 'aleatoria'
aleatoria='openssl rand -hex 16'
echo $aleatoria

# /srv/www/htdocs/phpmyadmin