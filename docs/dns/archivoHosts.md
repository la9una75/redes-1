El archivo _hosts_ existe en todos los sistemas operativos. Si bien se puede emplear para la resolución de nombres de dominio en una red local, en redes medianas actualmente es reemplazado por el servicio de DNS. 

!!! quote "Wikipedia" 
	El archivo **hosts** de un ordenador es usado por el sistema operativo para guardar la **correspondencia entre dominios de Internet y direcciones IP**. Este es uno de los diferentes métodos que usa el sistema operativo para resolver nombres de dominios. 

	Antiguamente cuando no había servidores DNS que resolvieran los dominios, el archivo hosts era el único encargado de hacerlo, pero dejó de utilizarse cuando Internet empezó a crecer en nombres de dominio, pasando a usar servidores de resolución de DNS. 

	En muchos sistemas operativos este método es usado preferentemente respecto a otros como el DNS. En la actualidad también es usado para bloquear contenidos de Internet como la publicidad web.




##Ubicación del archivo _hosts_
El archivo **hosts** es un archivo de texto plano que puede ser editado por el administrador del equipo y su ubicación depende del sistema operativo:

| Sistema operativo      | Ubicación del archivo _hosts_           |
| ---------------------- | --------------------------------------- |
| Microsoft Windows      | `C:\Windows\System32\drivers\etc\hosts` |
| Unix - GNU/Linux - BSD | `/etc/hosts`                            |
| Mac OS - iPhone OS     | `/private/etc/hosts`                    |
| Android                | `/system/etc/hosts`                     |


Entonces, si deseamos abrir el archivo en **GNU/Linux**, ejecutamos:

```bash
sudo vim /etc/hosts
```

Si en cambio, deseamos abrir el archivo en **Microsoft Windows**, haremos clic derecho sobre el archivo **hosts** (ver ubicación en la tabla) y seleccionamos del menú contextual la opción "Abrir como Administrador". 


## Modificando el archivo _hosts_

!!! done "Contenido del archivo _hosts_"

	Si importar el sistema operativo, la sintaxis del archivo _hosts_ será la siguiente: 

	`ip.del.equipo  nombre_De_Dominio`	


Si tomamos como ejemplo el dominio ficticio `misitio.lan` y suponiendo que la dirección IP del equipo servidor es `192.168.0.33`:

```bash
192.168.0.33  www.miisito.lan  misitio.lan  http://misitio.lan
```

Si configuramos correctamente el archivo _hosts_ de nuestro sistema, podremos acceder al/los dominio/s especificados. 

!!! done "Resolución de dominios empleando el archivo _hosts_"
	Si en una red local, decidimos resolver los nombres de dominio valiéndonos del archivo _hosts_ tendremos que copiar el mismo archivo _hosts_ en cada uno de los equipos que compongan la red.