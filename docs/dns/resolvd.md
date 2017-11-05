La resolución de nombres convierte los nombres de los sistemas en sus correspondientes direcciones IP. Para una zona `home.lan`, los nombres `server`, `virtual`, `ns` y `router` son asociados a sus respectivas direcciones IP. 

La base de datos para la resolución de nombres en la zona `home.lan` está guardada en el archivo `/etc/bind/db.home.lan`:

```apache
;
; BIND Archivo de zona para itel.lan
;
$ORIGIN itel.lan.
$TTL 30 	;30 segundos (solo para ambientes de pruebas)

@       IN      SOA     ns.itel.lan.    root.itel.lan. (
                        2013050601      ; Numero de serie
                        8H              ; refresh
                        2H              ; retry
                        4W              ; expire
                        1D )            ; minimum
;
                NS      ns              ; Servidor de nombres
                MX      10 mail         ; Servidor primario de correo

ns              A       192.168.0.100
mail            A       192.168.0.111

itel.lan.       A       192.168.0.100
server          A       192.168.0.105

virtual         A       192.168.0.106

router          A       192.168.0.1     ; router ADSL

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