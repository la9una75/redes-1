!!! quote "Adaptado de Wikipedia" 

	**WebDAV** es un grupo de trabajo del [Internet Engineering Task Force](https://es.wikipedia.org/wiki/IETF). El término significa "Creación y control de versiones distribuidos en web" (**Web** **D**istributed **A**uthoring and **V**ersioning). De esta manera, el nombre del protocolo deriva de dicho grupo de trabajo. 

	Este protocolo proporciona funcionalidades para crear, cambiar y mover documentos en un servidor remoto (típicamente un servidor web). Esto se utiliza sobre todo para permitir la edición de los documentos que sirve un servidor web, pero puede también aplicarse a sistemas de almacenamiento generales basados en web, que pueden ser accedidos desde cualquier lugar. La mayoría de los sistemas operativos modernos proporcionan soporte para WebDAV, haciendo que los ficheros de un servidor WebDAV aparezcan como almacenados en un directorio local.


sudo apt install apache2-utils

mkdir webdav

sudo chown -R www-data:www-data /home/usuario/webdav

sudo a2enmod dav

sudo a2enmod dav_fs

<VirtualHost *:80>

#ServerName www.example.com
ServerAdmin webmaster@localhost
DocumentRoot /var/www/html


ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined


Alias /webdav /var/www/webdav
<Directory /var/www/webdav>
DAV On
</Directory>
</VirtualHost>