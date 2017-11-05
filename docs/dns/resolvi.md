La resolución inversa traduce las direcciones IP en los nombres correspondientes de los sistemas.

La resolución inversa se configura en nuestro ejemplo en el archivo `/etc/bind/db.1.168.192`


```apache

;
; BIND zone file for 192.168.0.xxx
;

$ORIGIN itel.lan.
$TTL 30 				; 30 segundos (sólo para pruebas)

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

Verificamos que el archivo de configuración de la zona `0.168.192.in-addr.arpa` no contenga errores:

```bash
named-checkzone 0.168.192.in-addr.arpa /etc/bind/db.0.168.192
```

Y reiniciamos el servicio:

```bash
sudo service bind9 restart
```