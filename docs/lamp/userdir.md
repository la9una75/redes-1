Es posible crear un **espacio web para cada usuario del sistema**, donde éstos pueden alojar su propio contenido web. 

!!! note "Usuarios"
	En los ejemplos listados en esta página deberás cambiar **usuario** por el nombre de usuario al que deseemos dotar de un espacio web.

## Creando el contenido del sitio web


En primer lugar, creamos el directorio en el cual se agregarán las páginas webs del usuario:

```bash
mkdir /home/usuario/public_html
```
Solo resta agregar el contenido del sitio web dentro de la carpeta `public_html` que acabamos de crear. Tené en cuenta debe existir necesariamente al menos un archivo índice. Por ejemplo: `index.html`


!!! tip "El directorio `/etc/skel`"
	En sistemas GNU/Linux, el contenido del directorio `/etc/skel` se _carga_ dentro de la carpeta `home` de cada usuario al momento de que estos son creados. Por tanto, podemos modificar el contenido de `/etc/skel` incluyendo en dicho directorio el contenido que necesitemos. Por ejemplo, el directorio `public_html`

## Habilitando el módulo userdir

Para proveer a los usuarios de un espacio web dentro de su carpeta `home` todavía tendremos que dar un paso más: habilitar el módulo de Apache llamado `userdir`. Para ello, ejecutamos en la terminal: 

```bash
sudo a2enmod userdir
```

Luego, reiniciamos el servidor para que incorpore los cambios:

```bash
sudo systemctl restart apache2
```

## Habilitando el módulo php7.0

En caso de querer ejecutar **PHP** en las webs personales de los usuarios tendremos que instalar el módulo correspondiente:  

```bash
sudo apt-get install libapache2-mod-php7.0
```

Acto seguido, habilitamos el módulo: 

```bash
sudo a2enmod php7.0
```

Por último, debemos permitir la ejecucción de scripts PHP dentro de directorio `home` de los usuarios. Para ello, abrimos el archivo:

```bash
nano /etc/apache2/mods-available/php7.0.conf
```

Un vez abierto el archivo, tenemos que desplazarnos hasta el final del archivo hasta ubicar el siguiente bloque de código:

```apache
<IfModule mod_userdir.c>
    <Directory /home/*/public_html>
        php_admin_flag engine Off
    </Directory>
</IfModule>
```
Comentamos el bloque de manera que quede así: 

```apache
#<IfModule mod_userdir.c>
#    <Directory /home/*/public_html>
#        php_admin_flag engine Off
#    </Directory>
#</IfModule>
```

Para hacer efectivos los cambios realizados, reiniciamos Apache: 

```bash
sudo systemctl restart apache2
```

## Aceso a la web del usuario

Una vez concluidos los pasos anteriores, podemos acceder a la web del usuario escribiendo en el navegador:

* `http://nombreDominioServidor/~usuario` o `http://direccionIPServidor/~usuario` si incluimos en la raíz del sitio web contenido estático o
* `http://nombreDominioServidor/~usuario/archivo.php` o `http://direccionIPServidor/~usuario/archivo.php` si agregamos a la web contenido dinámico (PHP). En el ejemplo, dicho contenido dinámico está representado por `archivo.php`