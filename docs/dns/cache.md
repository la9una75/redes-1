La configuración generada durante la instalación es perfectamente funcional, no requiere modificaciones. 

No obstante, vamos a definir a cuáles servidores consultará el nuestro para pedir ayuda en la resolución de nombres, si no es posible hacer esto localmente (forwarders). 

Como forwarders podemos elegir entre dos opciones: 

* Utilizar los servidores **DNS de nuestro ISP** o proveedor de acceso a Internet.

* Utilizar alguno de los servidores **DNS publicos**, como por ejemplo: 

	- [Comodo](https://www.comodo.com/secure-dns): `8.26.56.26 - 8.20.247.20`
  - [FoolDNS](http://www.fooldns.com/fooldns-community): `87.118.111.215 - 213.187.11.62`
	- [Google](https://developers.google.com/speed/public-dns): `8.8.8.8 - 8.8.4.4`
	- [OpenDNS](https://www.opendns.com): `208.67.222.222 - 208.67.220.220`
	- [OpenNIC](https://www.opennicproject.org): `66.70.211.246 - 128.52.130.209`
	- [Yandex](https://dns.yandex.com): `77.88.8.8 - 77.88.8.1`

Estos servicios prometen suministrar no sólo resoluciones más rápidas, sino también diversos servicios adicionales de seguridad, como filtros de direcciones maliciosos y otros más.

En este caso, utilizaremos los servidores **OpenDNS**. Para tener otra opción, también se añadirá el del **router** ofrecido por nuestro proveedor de internet.

Por seguridad:

* sólo serán recibidas conexiones por la interfaz local o por la destinada a la red interna: `listen-on { 127.0.0.1; 192.168.1.100; };`

* sólo serán contestados los pedidos de resolución que partan del propio puesto o de la red interna: `allow-query { 127.0.0.1; 192.168.1.0/24; };`

* todos los otros pedidos **serán ignorados**, para evitar eventuales utilizaciones abusivas de nuestro servidor DNS por parte de terceros

La configuración está guardada en el archivo `/etc/bind/named.conf.options`:

```apache
options {
  directory "/var/cache/bind";

// If there is a firewall between you and nameservers you want
// to talk to, you may need to fix the firewall to allow multiple
// ports to talk.  See http://www.kb.cert.org/vuls/id/800113

// If your ISP provided one or more IP addresses for stable
// nameservers, you probably want to use them as forwarders.
// Uncomment the following block, and insert the addresses replacing
// the all-0's placeholder.

forwarders {

  // OpenDNS servers
  208.67.222.222;
  208.67.220.220;

  // DNS del router
  192.168.1.1;

};

// Security options

listen-on port 53 { 127.0.0.1; 192.168.1.100; };
allow-query { 127.0.0.1; 192.168.1.0/24; };
allow-recursion { 127.0.0.1; 192.168.1.0/24; };
allow-transfer { none; };

//========================================================================
// If BIND logs error messages about the root key being expired,
// you will need to update your keys.  See https://www.isc.org/bind-keys
//========================================================================

dnssec-validation auto;

auth-nxdomain no;    # conform to RFC1035
// listen-on-v6 { any; };

};
```

## Verificando la configuración
Para cerciorase que los cambios realizados en el paso anterior fueron los correctos, ejecutamos el comando: 

```bash
sudo named-checkconf
```

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
