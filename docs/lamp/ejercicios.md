A continuación se listan dos ejercicios en los que deberás aplicar los conocimientos adquiridos. 


## Ejercicio 1

La empresa "Penguin S.A.", dispone de un servidor web dedicado y tan solo una direccion IP. La empresa necesita que su servidor web gestione diferentes sitios web, cada uno con su nombre de dominio.

Hablando con ejecutivos de la empresa, se acuerda en desplegar las siguientes plataformas webs: 

1. Sitio oficial
2. Sucursal Patagonia
3. FrontEnd para la administración de la  base de datos MySQL. 

En la siguiente tabla se indican además las respectivas rutas donde deberán alojar los archivos de los sitios web. 


| #    | Dominio                | Directorio raíz (DocumentRoot)           |
| ---- | ---------------------- | ---------------------------------------- |
| 1    | penguin.net            | `/home/penguin/public_html`    |
| 2    | patagon.penguin.net    | `/home/patagon/public_html` |
| 3    | phpmyadmin.penguin.net | `/usr/share/phpmyadmin`              |



#### Instalación de paquetes

Deberá [instalarse un entorno LAMP](instalacion.md) necesario para el despliegue de los sitios web. 

#### Creación de usuarios
Para poder realizar el ejercicio deberás crear previamente los usuarios **penguin** y **patagon**. 


#### Creación los directorios raíz

La acción deberá realizarse para los dominios **penguin.net** y **patagon.penguin.net** tomando en cuenta los datos que figuran en el cuadro acordado con el cliente. 

#### Creación de contenido web

Dentro de los **directorios raíz** creados en el punto anterior (necesariamente deberá existir una página llamada index.html o index.php) y a modo de ejemplo, deberán crearse las siguientes páginas: 

1. Para **penguin.net**: un archivo `index.html` con la frase "Penguin.net - Sitio Oficial"
2. Para **patagon.penguin.net**, un archivo `index.php` con el siguiente contenido: 

```php
<!DOCTYPE html>

<html>

<head>

	<title>Penguin S.A.</title>

</head>

<body>

	<h1>Penguin.Net Patagon</h1>

	<p>Sitio en construccion</p>

	<?php 

		# Muestra la fecha y hora actual de Buenos Aires
		ini_set('date.timezone','America/Argentina/Buenos_Aires');
		echo date("d-m-Y (H:i A)");

	?>

	</body>

</html>
```


#### Creación de los archivos de configuración ####

Se deben crear los archivos de configuración de cada **Host Virtual** solicitado por el cliente. Tener en cuenta que para todos los casos, el administrador sera `admin@penguin.net`.

#### Resolución de nombres ####
Se debe realizar a través del método del archivo hosts.

!!! tip "Automatización de tareas"
	Tal vez sería más practico realizar todas las acciones anteriores valiendose de un script. ¿Te animás a escribirlo? 


### Posibles errores

!!! error "Error"

	Es posible que con la configuración por defecto de Apache, obtengamos un **error 403**. En ese caso, realizar los pasos que se describen a continuación

Para corregir dicho error, qbrimos el archivo de configuración general de Apache: 

```apache
sudo nano etc/apache2/apache2.conf
```

Y modificamos el archivo de configuración general de Apache, aproximadamente en la línea 153 y que posee el siguiente aspecto: 

```apache
<Directory />
Options FollowSymLinks
AllowOverride None
Require all denied
</Directory>
```
	
Tendremos que modificarlo para que quede: 

```apache
<Directory />
Options FollowSymLinks
AllowOverride None
# Require all denied
</Directory>
```

## Ejercicio 2

Una vez que hayamos [instalado correctamente el entorno LAMP](instalacion.md) podremos instalar en el servidor web distintas aplicaciones webs que funcionen con dicha tecnología (PHP y MySQL). 

A continuación se ofrecen distintas aplicaciones para su descarga junto con las indicaciones de instalación. 

####Descargando las aplicaciones

La siguiente lista de aplicaciones se encuentra alojada en el servidor local. Son ejemplos de aplicaciones populares en internet:

* [Dokuwiki](https://download.dokuwiki.org/)
* [FengOffice](https://sourceforge.net/projects/opengoo/files/latest/download)
* [Joomla!](https://downloads.joomla.org/es/cms/joomla3)
* [Wordpress](https://wordpress.org/download/)


Podés elegir la que desees y descargarlas en el directorio raíz de tu sitio web de la siguiente manera:  

```bash
wget http://url_de_la_aplicacion/aplicacion.zip
```

####Instalando la aplicación

Tendremos que **descomprimir la aplicación descargada en el directorio raíz de nuestro sitio**. Luego, abriremos nuestro navegador web y visitaremos la dirección web `http://tudominio/aplicacion` o bien `http://tuDireccionIP/aplicacion` y seguir las instrucciones de instalación. 


!!! done "Base de datos"
	Dependiendo de la aplicación web que hayas elegido, es posible que necesites crear una base de datos. Para ello, dirigite a `http://tudominio/phpmyadmin` o `http://tuDireccionIP/phpmyadmin` e ingresá con las credenciales del usuario root. Una vez allí podrás crear la base de datos solicitada.
