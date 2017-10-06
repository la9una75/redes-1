
Es posible **modificar las imágenes con que se mostrarán los equipos en el mapa** presentado por Nagios. Podemos visualizar el nombre de los íconos que se mostraran en el mapa en: 

```bash
ls -l /usr/share/nagios/htdocs/images/logos | less
```

Para salir de la vista, presionar la letra **q** (quit).

## Definiendo íconos de la vista mapa

Abriremos el archivo **iconos.cfg** creado con anterioridad:

```bash
sudo vim /etc/nagios3/objetos/iconos.cfg
```

Dentro del archivo incluiremos código similar al que sigue. Obviamente, deberemos adaptarlo a nuestras necesidades:

```apache
# Definiendo íconos para un equpo (individualmente)
define hostextinfo {
host_name		router1
icon_image		routerNuevo.png
icon_image_alt	Router de la sala principal
statusmap_image	routerNuevo.gd2
vrml_image		routerNuevo.png
}

# Definiendo íconos para todos los miembros de un grupo
define hostextinfo {
hostgroup_name	sala1
icon_image		computer.png
icon_image_alt	Equipos de la Sala 1
statusmap_image	computer.gd2
vrml_image		computer.png
}
```

!!!note "Sobre los íconos"
	Los **íconos** se pueden configurar para:
	  * un equipo en particular, mediante la directiva **host_name** o
	  * para un grupo de equipos empleando la directiva **hostgroup_name**.


Por último, tendremos que [verificar la configuración y reiniciar el servidor Nagios](configuracion/#verificando-la-configuracion-y-reiniciando-nagios) para guardar los cambios que hayamos introducido.

## Creando nuestro propios íconos
Nagios aloja las imágenes (iconos) que se mostrarán en el mapa en `/usr/local/nagios3/share/images/logos`. 

Dentro de esta carpeta debemos copiar nuestros iconos personalizados. 

Al crear nuestra imagen deberemos tener en cuenta el formato de la misma:

* Medida: 40x40 píxeles
* Formato: png (transparente)

Luego tendremos que convertir la imagen al resto de los formatos, todos necesarios para una correcta visualización del mapa de Nagios, a saber: `.gif` y `.gd2`. Por ejemplo, suponiendo que nuestra imagen se llama _iconoPersonalizado_, deberíamos tener al final tres versiones de la misma:  

* iconoPersonalizado.png
* iconoPersonalizado.gd2
* iconoPersonalizado.gif

### Instalando las herramientas 
Para poder realizar la conversión de formato de imágenes necesitaremos instalar las siguientes herramientas: `imagemagick`, `libgd-tools` y `netpbm`.

```bash
sudo apt-get install libgd-tools netpbm imagemagick
```

### Convirtiendo .png a .gd2

Para convertir una imagen `.png` a un icono `.gd2` ejecutamos el siguiente comando:

```bash
pngtogd2 iconoPersonalizado.png iconoPersonalizado.gd2 1 1
```

Donde _iconoPersonalizado.png_ es la imagen  `.png` que deseamos convertir e _iconoPersonalizado.gd2_ es el nombre de la imagen convertida en formato `.gd2`. El parámetro `1 1` indica que la conversión debe crearse en formato raw (crudo), y que el archivo debe crearse sin compresión.

### Convirtiendo .png a .gif
Para realizar esta conversión, simplemente ejecutamos: 

```bash
convert iconoPersonalizado.png iconoPersonalizado.gif
```

### Redimensionando nuestro icono
Es probable que nuestro icono en formato `.png` no posea la medida requerida por Nagios (40x40 pixeles) ni sea transparente. En ese caso podemos salvar la cuestión ejecutando algunos comandos en la terminal.

Convertimos la imagen al formato _netpbm_ (pnm - portable anymap format):

```bash
pngtopnm iconoPersonalizado.png > iconoPersonalizado.pnm 
```

Finalmente, redimensionamos la imagen y tornamos el fondo transparente obteniendo un nuevo archivo `.png`: 

```bash
pnmtopng -transparent =rgb:00/00/00 -phys 40 40 1 iconoPersonalizado.pnm > iconoPersonalizado.png
```

