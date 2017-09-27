
Es posible **modificar las imágenes con que se mostrarán los equipos en el mapa** presentado por Nagios. Podemos visualizar el nombre de los íconos que se mostraran en el mapa en: 

```bash
ls -l /usr/share/nagios3/htdocs/images/logos | less
```

Para salir de la vista, presionar la letra **q** (quit).

## Definiendo íconos de la vista mapa

Abriremos el archivo **iconos.cfg** creado con anterioridad:

```bash
sudo vim /usr/local/nagios/etc/objects/iconos.cfg
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