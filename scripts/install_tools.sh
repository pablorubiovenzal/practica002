#!/bin/bash

set -ex

source .env
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
rm phpMyAdmin-latest-all-languages.tar.gz

# Renombramos el directorio
sudo mv -n phpMyAdmin-5.2.2-all-languages/* /srv/www/htdocs/phpmyadmin/

# Borrar carpeta
rm -rf phpMyAdmin-5.2.2-all-languages/

# Modificamos el propietario y el grupo del directorio
sudo chown -R wwwrun:wwwrun /srv/www/htdocs/index.php

# Creamos el archivo de configuración a partir del archivo de ejemplo config.sample.inc.php.
cp /srv/www/htdocs/phpmyadmin/config.sample.inc.php /srv/www/htdocs/phpmyadmin/config.inc.php

# -- Modificamos la variable cfg['blowfish_secret'] con sed --
# Creamos la variable aleatoria 'aleatoria'
aleatoria=`openssl rand -hex 16`

# Modificamos la variable blowfish_secret en el archivo de configuración
sed -i "s/\(\$cfg\['blowfish_secret'\] =\).*/\1 '$aleatoria';/" /srv/www/htdocs/phpmyadmin/config.inc.php

# -- Modificamos la variable cfg['TempDir'] con sed --
sed -i "/blowfish_secret/a \$cfg\['TempDir'\] = '/tmp';" /srv/www/htdocs/phpmyadmin/config.inc.php 

# Una vez terminado todo el proceso, se modifica el propietario y el grupo del directorio /srv/www/htdocs
chown -R wwwrun:wwwrun /srv/www/htdocs/phpmyadmin/

# /srv/www/htdocs/phpmyadmin = /var/www/html/phpmyadmin

# Creamo una tabla
mysql -u root < /srv/www/htdocs/phpmyadmin/phpMyAdmin-5.2.2-all-languages/sql/create_tables.sql

mysql -u root -e "DROP USER IF EXISTS $PMA_USER@'localhost'"
mysql -u root -e "CREATE USER $PMA_USER@'localhost' IDENTIFIED BY '$PMA_PASS'"
mysql -u root -e "GRANT ALL PRIVILEGES ON $PMA_DB.* TO $PMA_USER@'localhost'"