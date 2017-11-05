La configuración generada durante la instalación es perfectamente funcional, no requiere modificaciones. 

No obstante, vamos a definir a cuáles servidores consultará el nuestro para pedir ayuda en la resolución de nombres, si no es posible hacer esto localmente (forwarders). 

Como forwarders podemos elegir entre dos opciones: 

* Utilizar los servidores **DNS de nuestro ISP** o proveedor de acceso a Internet.

* Utilizar alguno de los servidores **DNS públicos**

!!!done "Servidores DNS públicos" 
    - [Comodo](https://www.comodo.com/secure-dns): `8.26.56.26 - 8.20.247.20`
    - [FoolDNS](http://www.fooldns.com/fooldns-community): `87.118.111.215 - 213.187.11.62`
    - [Google](https://developers.google.com/speed/public-dns): `8.8.8.8 - 8.8.4.4`
    - [OpenDNS](https://www.opendns.com): `208.67.222.222 - 208.67.220.220`
    - [OpenNIC](https://www.opennicproject.org): `66.70.211.246 - 128.52.130.209`
    - [Yandex](https://dns.yandex.com): `77.88.8.8 - 77.88.8.1`

Estos servicios prometen suministrar no sólo resoluciones más rápidas, sino también diversos servicios adicionales de seguridad, como filtros de direcciones maliciosos y otros más.

## Ejemplo de archivo de configuración
La configuración del servidor DNS caché se encuentra en el archivo `/etc/bind/named.conf.options`. 

Antes de comenzar, siempre conviene realizar una copia de seguridad del arvhivo en cuestión: 

```bash
cd /etc/bind \
sudo cp named.conf.options named.conf.options.original
```

Posteriormente, creamos un nuevo archivo para su edición: 

```bash
sudo vim named.conf.options
```

Y agregamos el siguiente contenido, el cual deberás adaptar según necesidad: 

```apache

options {

  #########################
  ### Directorio chaché ###
  #########################

  directory "/var/cache/bind";

  ####################
  ### Reenviadores ###
  ####################

  forwarders {
    # Servidores DNS públicos de Google
    8.8.8.8;
    8.8.4.4;
    # Servidor DNS provisto por nuestro ISP (generalmente, el router)
    192.168.0.1;
  };
  
  #############################
  ### Opciones de seguridad ###
  #############################

  # Creando una lista de control de acceso (acl)  
  acl "permitidos" {
      192.168.0.0/24;
      localhost;
      localnets;
  };

  # Hosts que tienen permiso para escuchar peticiones por el puerto 53
  # Cambiar 192.168.0.xxx por la dirección IP de nuestro servidor DNS
  listen-on port 53 { 
      127.0.0.1; 
      192.168.0.xxx; # IP de tu servidor DNS
  };
  
  # Hosts que tienen permiso para escuchar peticiones IPv6
  listen-on-v6 { none; };
  
  # Hosts que tienen permiso para realizar consultas
  allow-query { permitidos; };

  # Hosts que tienen permiso para realizar consultas recursivas
  allow-recursion { permitidos; };
  
  # Permitiendo transferencia de zona a servidor DNS esclavo
  allow-transfer { none; };
  
  # Permitiendo validación DNSSEC
  dnssec-validation auto;
  
  # Respuesta NXDOMAIN según RFC1035 (yes en servidores antiguos) 
  auth-nxdomain no;
  
};

```

!!!tip "Comentarios"
    La siguiente son etiquetas de comentarios válidas:

      * `//` ó `#` Para realizar comentarios de una sola línea, al comienzo de la misma. 

      * `/* texto */` Para realizar comentarios multilínea, colocando texto entre estas etiquetas. 

Donde: 

* **Directorio caché**: es la carpeta en la cual el servidor DNS guardará las consultas realizadas. 

* **Forwarders**: son los servidores DNS a los cuáles consultará nuestro servidor DNS en caso de no ser capaz de resolver un nombre de dominio. En el ejemplo, se usan los servidores DNS públicos de _Google_ y, para tener otra opción, también se añade la IP del _router_, puesto que generalmente, es la dirección IP  ofrecida por nuestro proveedor de internet para la resolución de nombres de dominio. 

* **Listas de control de acceso**: de manera conveniente se crea una lista de las direcciones IP que podrán realizar consultas a nuestro servidor DNS. En el ejemplo, se creó una lista llamada _permitidos_, la cual incluye todas las direcciones IP de la red `192.168.0.0/24`, la dirección local o `localhost` y todas las direcciones IP vinculadas con todas las interfaces de red del servidor, con la palabra reservada `localnets`. Todos los otros pedidos **serán ignorados**, para evitar eventuales utilizaciones abusivas de nuestro servidor DNS por parte de terceros

!!!note "Opciones de permisión"
    Además de emplear el nombre de una _acl_ creada (en nuestro ejemplo, _permitidos_), los valores que podemos utilizar a la hora de establecer los permisos para los distintos _hosts_ son: 

    * `none`: ninguno
    * `any`: todos


## Verificando la configuración
Para cerciorase que los cambios realizados en el paso anterior fueron los correctos, ejecutamos el comando: 

```bash
sudo named-checkconf
```
