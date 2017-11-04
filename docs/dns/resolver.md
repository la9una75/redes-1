## Configurando el _resolver_

Tendremos que añadir el dominio `itel.lan` en el archivo `/etc/resolvconf/resolv.conf.d/base`:

```apache

domain itel.lan
search itel.lan
nameserver 127.0.0.1
```

De esta forma, cuando nos referimos al sistema `server`, éste será buscado en el dominio `itel.lan`, resultando en el **FQHN** `server.itel.lan`

## Configurando el resolver
Luego abrimos el archivo encargado de la resolución de nombres en el equipo, también llamado _resolver_:

```bash
sudo vim /etc/resolvconf/resolv.conf.d/head
```

Y agregamos lo siguiente para que la resolución de nombres se haga localmente:

```bash
nameserver 127.0.0.1
```

Verificamos también que en el archivo `/etc/nsswitch.conf` la resolución de nombres pase también por el servicio DNS:

```bash
hosts:  files dns
```

Finalmente, reiniciamos el servicio DNS:

```bash
sudo service bind9 restart
```
