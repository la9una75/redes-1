Icecast2 viene con los archivos de configuración ubicados en `/etc/icecast2`. Podemos modificar las opciones del servidor editando el archivo `/etc/icecast2/icecast.xml`. 
 
##Usuarios y contraseñas

Buscamos la sección `authentication`: 

```apache
<authentication>

  	<!-- Sources log in with username 'source' -->
        <source-password>hackme</source-password>

  	<!-- Relays log in username 'relay' -->
        <relay-password>hackme</relay-password>

        <!-- Admin logs in with the username given below -->
        <admin-user>admin</admin-user>
        <admin-password>hackme</admin-password>

</authentication>
```

Donde tendremos que modificar como mínimo, los valores `hackme` por otros que deseemos. 

|Etiqueta|Explicación|
|------------|------------|
|`source-password`|Contraseña del usuario `source`, utilizado por defecto para trasmitir contenido.|
|`relay-password`|Contraseña del usuario `relay`. Útil en caso de habilitar un servidor de streaming secundario.|
|`admin-user`|Nombre del usuario administrador (panel de administración web).|
|`admin-password`|Contraseña del usuario administrador (panel de administración web).|

##Dirección del servidor

Buscamos la sección `hostname` y colocamos la **dirección IP** o **nombre de dominio** de nuestro servidor de streaming. A continuación, dos ejemplos de configuración (ficticios):

```apache
<hostname>http://www.miservidor.com</hostname>
```

O bien, si disponemos de la dirección IP del servidor

```apache
<hostname>http://192.168.0.232</hostname>
```

Por último, nos desplazamos a la sección `listen-socket` y colocamos el **número de puerto** desde el cual trasmitiremos: 

```apache
<listen-socket>
 <port>8000</port>
</listen-socket>
```

##Límites

Por defecto, icecast permite 2 (dos) fuentes de audio simultáneas con un máximo de 100 (cien) clientes totales. Para cambiar esto y otros parámetros, tendremos que ubicar la sección **limits**:

```apache
<limits>
	<clients>100</clients>
	<sources>2</sources>
	<queue-size>524288</queue-size>
	<client-timeout>30</client-timeout>
	<header-timeout>15</header-timeout>
	<source-timeout>10</source-timeout>
	<!-- Same as burst-on-connect, but this allows for being more
	specific on how much to burst. Most people won't need to
	change from the default 64k. Applies to all mountpoints. -->
	<burst-size>65535</burst-size>
	<!--
	<max-bandwidth>100M</max-bandwidth>
	-->
</limits>

```

Donde las etiquetas de la sección: 


|Etiqueta|Explicación|
|------------|------------|
|`clients`|Cantidad máxima de clientes conectados para todo el servidor (no por punto de montaje).|
|`sources`|Número máximo de fuentes (puntos de montaje) permitidas en todo el servidor|
|`queue-size`|Tamaño de la cola de espera (en bytes). Generalmente, un cliente con problemas de conexión pasa a la cola.|
|`client-timeout`|Tiempo de espera máximo (en segundos) para reconexión de un cliente. No se usa.|
|`header-timeout`|Tiempo de espera máximo (en segundos) para iniciar una conexión. No se usa.|
|`source-timeout`|Tiempo de espera máximo (en segundos) para recibir contenido desde una fuente. Pasado el tiempo, la fuente se elimina.|
|`burst-size`|Tamaño máximo de`buffer`. Por defecto, su valor es de 64 kbytes y debe ser siempre menor al valor de `queue-size`.|
|`max-bandwidth`|Ancho de banda máximo. Por defecto, es de 64 kbytes |

