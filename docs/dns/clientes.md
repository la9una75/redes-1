Para que los clientes puedan resolver dominios empleando nuestro servidor tendremos que seguir el siguiente procedimiento: 

## GNU/Linux
Nos dirigimos al directorio `/etc/resolvconf/resolv.conf.d/`:

```apache
cd resolvconf/resolv.conf.d
```

Luego abrimos el archivo `base`: 

```apache
sudo vim base
```

Y añadimos el dominio `itel.lan` en el archivo, de manera que nos quede:

```apache
domain itel.lan
search itel.lan
# Dirección IP de nuestro servidor DNS
nameserver 192.168.0.xxx
```

## Windows 
En sistemas operativos basados en Microsoft Windows, tendremos que dirigirnos hasta opnciones de red y editar la sección IPv4: 

![Cliente WIndows DNS](imgDNS/dnsClienteWindows7.png)

En el ejemplo, el equipo obtiene su dirección IP automáticamente (por DHCP). Simplemente, habría que cambiar la dirección del servidor DNS por el que apunta al nuestro. 