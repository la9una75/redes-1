Aunque se pueda atribuir nombres a los diversos sistemas de una red, estos no consiguen reconocerse entre sí sin un sistema de resolución de nombres. Para que un sistema consiga localizar la dirección IP asociada al nombre de otro sistema, es necesario que éste esté registrado en un servidor DNS, para permitir la resolución de nombres.
Atención

!!! warning "Importante"
		Antes de instalar el servidor DNS, la [Cache DNS](cache.md) debe estar previamente configurada y verificada.

## Zonas

La resolución de nombres traduce nombres de sistemas en sus direcciones IP y viceversa. Así, la configuración consiste, básicamente en la creación de 2 archivos de zona:

* **Archivo de resolción directa**: contiene la información necesaria para convertir nombres de dominio en direcciones IP. En nuestro ejemplo, el archivo se llama `db.itel.lan` 
* **Archivo de zona de resolución inversa** contiene la información necesaria para convertir direcciones IP en el respectivo nombre de sistema. En el ejemplo, el archivo se llama `db.1.168.192`

Las zonas pueden declararse en el archivo `/etc/bind/named.conf.local`:

```bash


// Zona de resolución directa

    zone "home.lan" {
        type master;
        file "/etc/bind/db.itel.lan";
    };

// Zona de resolución inversa

    zone "1.168.192.in-addr.arpa" {
        type master;
        file "/etc/bind/db.1.168.192";
    };

```

Por último, verificamos que el archivo de configuración no contenga errores:

```bash
sudo named-checkconf
```

## Resolución directa

La resolución de nombres convierte los nombres de los sistemas en sus correspondientes direcciones IP. Para una zona `home.lan`, los nombres `server`, `virtual`, `ns` y `router` son asociados a sus respectivas direcciones IP. 

La base de datos para la resolución de nombres en la zona `home.lan` está guardada en el archivo `/etc/bind/db.home.lan`:

```apache
;
; BIND zone file for itel.lan
;

$TTL    3D
@       IN      SOA     ns.itel.lan.    root.itel.lan. (
                        2013050601      ; serial
                        8H              ; refresh
                        2H              ; retry
                        4W              ; expire
                        1D )            ; minimum
;
                NS      ns              ; Inet address of name server
                MX      10 mail         ; Primary mail exchanger

ns              A       192.168.1.100
mail            A       192.168.1.111

itel.lan.       A       192.168.1.100
server          A       192.168.1.105

virtual         A       192.168.1.106

router          A       192.168.1.1     ; router ADSL

gateway         CNAME   router
gw              CNAME   router
proxy           CNAME   server
www             CNAME   virtual
ftp             CNAME   virtual

```

El protocolo DNS permite también la creación de alias, o canonical names, identificados por el tipo de registro CNAME. Un alias es un nombre alternativo de un sistema.

Al final del archivo podrán declararse algunos _aliases_ donde: el sistema `server` pasará también a ser conocido (CNAME o canonical name) como `proxy` y el servidor `virtual` responderá también por los nombres `www` y `ftp`. 

Finalmente, verificamos que el fichero de configuración de la zona `itel.lan` no contenga errores

```bash
sudo named-checkzone itel.lan /etc/bind/db.itel.lan
```

Y reiniciamos el servicio: 

```bash
sudo service bind9 restart
```


## Resolución Inversa

La resolución inversa traduce las direcciones IP en los nombres correspondientes de los sistemas.

La resolución inversa se configura en nuestro ejemplo en el archivo `/etc/bind/db.1.168.192`


```apache

;
; BIND zone file for 192.168.1.xxx
;

$TTL    3D
@       IN      SOA     ns.itel.lan.    root.itel.lan. (
                        2013050601      ; serial
                        8H              ; refresh
                        2H              ; retry
                        4W              ; expire
                        1D )            ; minimum
;
                NS      ns.itel.lan.    ; Nameserver address

100             PTR     ns.itel.lan.
105             PTR     server.itel.lan.
106             PTR     virtual.itel.lan.
111             PTR     mail.itel.lan.
1               PTR     router.itel.lan.
```

Verificamos que el archivo de configuración de la zona `1.168.192.in-addr.arpa` no contenga errores:

```bash
named-checkzone 1.168.192.in-addr.arpa /etc/bind/db.1.168.192
```

Y reiniciamos el servicio:

```bash
sudo service bind9 restart
```

## Configurando el _resolver_

Tendremos que añadir el dominio `itel.lan` en el archivo `/etc/resolvconf/resolv.conf.d/base`:

```apache

domain itel.lan
search itel.lan
nameserver 127.0.0.1
```

De esta forma, cuando nos referimos al sistema `server`, éste será buscado en el dominio `itel.lan`, resultando en el **FQHN** `server.itel.lan`
