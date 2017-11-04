Para instalar este paquete, lo haremos con `apt`, loguados como administradores: 
```bash
sudo apt-get install bind9 bind9-doc dnsutils
```

De esta forma instalaríamos los programas necesarios para disponer de un completo servidor DNS con **bind**. Tan solo será necesario configurarlo y ponerlo en marcha. 

## Iniciando el servidor
Para iniciar el servidor simplemente ejecutamos en una terminal:

```bash
sudo service bind9 start
```
Y para verificar que el servicio esté corriendo (presionamos la letra `q` para salir: 

```bash
sudo service bind9 status
```
O bien, si queremos verificar que el demonio _named_ esté escuchando en el puerto 53


```bash
sudo netstat -punta
```

De esta forma instalaríamos los programas necesarios para disponer de un completo servidor DNS con **bind**. Tan solo será necesario configurarlo y ponerlo en marcha. 

De esta forma instalaríamos los programas necesarios para disponer de un completo servidor DNS con **bind**. Tan solo será necesario configurarlo y ponerlo en marcha. 

De esta forma instalaríamos los programas necesarios para disponer de un completo servidor DNS con **bind**. Tan solo será necesario configurarlo y ponerlo en marcha. 


## Principales archivos de configuración 

El archivo de configuración del DNS es el archivo `/etc/bind/named.conf`, pero este hace referencia a otros cuantos archivos como por ejemplo:

  * **named.conf**: Archivo principal de configuración
  * **named.conf.options**: Opciones genéricas
  * **named.conf.local**: Especificación particular de este servidor DNS
  * **db.127**: Especificación dirección de retorno
  * **db.root**: DNS de nivel superior
  * Otros archivos: db.0, db.255, db.empty, db.local, rndc.conf, rndc.key, zones.rfc1918
