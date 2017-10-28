**BIND** _Berkeley Internet Name Domain_, anteriormente conocido como _Berkeley Internet Name Daemon_ es el **servidor de DNS más comúnmente usado en Internet** especialmente en sistemas Unix, en los cuales es un [estándar de facto](https://es.wikipedia.org/wiki/Est%C3%A1ndar_de_facto). 

Este servidor de nombres es patrocinado por la [Internet Systems Consortium](https://es.wikipedia.org/wiki/Internet_Systems_Consortium).


![Logo de BIND](imgDNS/bindLogo.png)

BIND fue creado originalmente por cuatro estudiantes de grado en la [University of California, Berkeley](https://es.wikipedia.org/wiki/Universidad_de_California_en_Berkeley).

BIND tiene **tres** componentes:

1. El primero es llamado _named_ o _name-dee_, es un demonio que ejecuta el lado servidor del DNS.
2. El segundo componente es llamado _resolver library_ o biblioteca de resolución, encargada de realizar peticiones a servidores DNS para intentar traducir un nombre a una dirección IP. El archivo de configuración para este componente es `resolv.conf`.
3. El tercer y último componente de BIND proporciona herramientas para probar el funcionamiento del servidor DNS. Entre estas herramientas se encuentran comandos como _dig_, que se
verá más adelante.
