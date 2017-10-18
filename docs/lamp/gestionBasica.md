El **servidor HTTP Apache** se gestiona a través de comandos que ejecutaremos en la terminal. De momento, no exsite una interfaz gráfica nativa para hacerlo. 

Por otro lado, **PHP** debe gestionarse modificando sus archivos de configuración, realizando acciones e instalando módulos a través de la línea de comandos. 

Por último, las tanto **MySQL** como **MariaDB** pueden gestionarse a través de la terminal de comandos, pero existen aplicaciones desarrolladas exclusivamente para la gestión éstas y otras base de datos. 

!!! tip "Aplicaciones de administración"
	Existen algunos desarrollos de terceros como [Webmin](http://www.webmin.com/) o [Ajenti](http://ajenti.org/), que nos permiten gestionar la configuración del servidor Web **Apache**, de **PHP** y las **bases de datos**. Existen, además, herramientas exclusivas para la gestión de estas últimas como [phpMyAdmin](https://www.phpmyadmin.net/) o [DBeaver](http://dbeaver.jkiss.org/) entre otras.


	Sin embargo, para gestionar efectivamente un servidor LAMP es **imprescindible conocer la ubicación de los archivos y carpetas de configuración**, ya que dicho conocimiento facilitará enormente nuestro trabajo. 

## Apache
A continuación se listan directorios y archivos de configuración así como los comandos para gestionarlo desde la terminal. 

### Archivos y carpetas importantes

Una vez instalado el servidor web Apache se crea una estructura archivos y directorios, entre los que se destacan: 

| Directorio o archivo     | Descripción          |
| ---------------------- | --------------------------------------- |
| `/etc/apache2/apache.conf`     | Archivo de configuración general de Apache|
| `/etc/apache2/sites-available` | Directorio donde se alojan los archivos de configuración de los sitios  definidos pero aún no activos (es decir, no habilitados|
| `/etc/apache2/sites-enabled`     | Directorio donde se alojan los archivos de configuración de los sitios  activos o habilitados|
| `/etc/apache2/mods-available` | Directorio donde se alojan los módulos de Apache aún no activos (es decir, no habilitados|
| `/etc/apache2/mods-enabled`     | Directorio donde se alojan los módulos de Apache activos o habilitados|
| `/var/www/html`| Directorio por del sitio web por defecto, donde Apache aloja las páginas web|
| `/home/usuario/public_html`| Directorio donde se aloja el sitio web personal de cada usuario del sistema|


### Gestión de módulos
El servidor web Apache contiene diversos módulos que proveen al servidor de funcionalidades extra. La mayoría de ellos están deshabilitados por defecto. 

La sintáxis básica para tabajar con módulos es la siguiente: 

```bash
sudo a2[en|dis]mod nombreDelModulo
```

Donde: 

| Sistema operativo      | Ubicación del archivo _hosts_           |
| ---------------------- | --------------------------------------- |
|`a2`                    | Inicio del comando de Apache2           |
|`en` 					 | _Enable_ es decir, habilitar el sitio web|
|`dis`     				 | _Disable_, es decir, deshabilitar el sitio web|
| `mod`                	 | Simboliza el concepto de _módulo_       |
| `nombreDelModulo`   	 | Nombre del modulo que deseamos habilitar o deshabilitar|


Por ejemplo, la siguiente acción habilitará el módulo `userdir`:

```bash
sudo a2enmod userdir
```

En otras palabras, creará un [enlace simbólico](https://es.wikipedia.org/wiki/Enlace_simb%C3%B3lico) del módulo `userdir` desde la carpeta  `/etc/apache2/mods-available` hacia la carpeta `/etc/apache2/mods-enabled`.

### Inicio y parada del servidor

Existen diversos comandos para gestionar el servidor web Apache. 

**Detener el servidor**
```bash
sudo systemctl stop apache2
```

**Iniciar el servidor**
```bash
sudo systemctl start apache2
```

**Reiniciar el servidor**
```bash
sudo systemctl restart apache2
```

**Recargar la configuración del servidor (sin reiniciar)**
```bash
sudo systemctl reload apache2
```

**Estado del servidor**
```bash
sudo systemctl status apache2
```

**Verificar la configuración del servidor**
```bash
sudo apache2ctl configtest
```

#### Compatibilidad con versiones anteriores
Las versiones más recientes del kernel de GNU/Linux adoptan el uso de [SystemD](https://es.wikipedia.org/wiki/Systemd). No obstante, versiones basadas en Debian anteriores a 2016, emplean el legendario [SystemV](https://es.wikipedia.org/wiki/System_V). Al momento de escribir esta documentación, en líneas generales, los sistemas basados en **systemd** conservan compatibilidad con **systemV**. Para el caso del servidor web Apache tenemos que: 

**Detener el servidor**
```bash
sudo service apache2 stop
```
**Iniciar el servidor**
```bash
sudo service apache2 start
```
**Reiniciar el servidor**
```bash
sudo service apache2 restart
```
**Recargar la configuración del servidor (sin reiniciar)**
```bash
sudo service apache2 reload
```


### Configurando el _nombre_ del servidor
Al comprobar la configuración de Apache obtenemos el siguiente error:

```bash
Set the 'ServerName' directive globally to suppress this message 
Syntax OK
```
Para corregir esto, abrimos el archivo de configuración principal de Apache con nuestro editor de texto:

```bash
sudo nano /etc/apache2/apache2.conf
```
Y agregamos al final del archivo la directiva `ServerName`, seguida del **nombre de dominio** o **dirección IP** de nuestro servidor web. Es decir: 

```apache
ServerName dominio_del_servidor_o_IP 
```
Guardamos y cerramos el archivo. Luego, para verificar que todo está bien (es decir, que no hay errores de sintaxis en el archivo de configuración de Apache):

```bash
sudo apache2ctl configtest
```
Y como definimos la directiva global `ServerName`, veremos la siguiente salida: 

```apache
Output
Syntax OK
```

Por último, reiniciamos Apache para implementar los cambios:
```bash
sudo systemctl restart apache2
```

## PHP

El arcivo de configuración de PHP se llama `php.ini`. No existe un único archivo `php.ini`, más bien, existe un archivo `php.ini` para cada aplicación que lo utilice. 

| Ubicación de `php.ini`   | Uso           |
| ------------------------ | --------------------------------------- |
|`/etc/php/7.0/apache2/php.ini`| Plugin PHP utilizado por el servidor web Apache|
|`/etc/php/7.0/fpm/php.ini`   | Plugin PHP utilizado por el servidor web NGINX|
|`/etc/php/7.0/cli/php.ini`| Ejecución de PHP desde la terminal de comandos|
|`/etc/php/7.0/cgi/php.ini`| Plugin PHP para CGI|

Donde `7.0` corresponde a la versión de PHP instalada. Luego, el archivo que tendremos que editar cuando querramos modificar el comportamiento de **PHP en un entorno LAMP** será el que aparece en la primer fila de la tabla. 


## Base de datos
Las bases de datos soportan administración a través de la línea de comandos, como podemos leer en la documentación oficial de [MySQL](https://dev.mysql.com/doc/refman/5.7/en/mysql-commands.html) y [MariaDB](https://mariadb.com/kb/en/mariadb/mysql-command-line-client/). No obstante, una de las opciones más elegidas a la hora de gestionar base de datos es [phpMyAdmin](instalacion#instalacion-de-phpmyadmin)