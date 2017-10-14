El sistema de nombres de dominio (DNS, por sus siglas en inglés _Domain Name System_) es un sistema de nomenclatura jerárquico descentralizado para dispositivos conectados a redes IP como Internet o una red privada.

El servicio DNS se emplea fundamentalmente en la resolución de nombres, es decir, determinar cuál es la dirección IP que corresponde a un nombre de dominio determinado y viceversa. Además, se encarga de la resolución de servidores de correo, esto es, dado un determinado nombre de dominio, identifica cuál es el servidor a través del cual debe hacerse la entrega del correo. 

## Terminología
Antes de proseguir, es necesario introducir algunos términos básicos para evitar confusiones y
ambigüedades:


* **Cliente DNS**: está instalado en el cliente (es decir, nosotros) y realiza peticiones de resolución de nombres a los servidores DNS.

* **Servidor DNS**: son los que contestan las peticiones y resuelven los nombres mediante un sistema estructurado en árbol. Las direcciones DNS que ponemos en la configuración de la conexión, son las direcciones de los Servidores DNS.

* **Zonas de autoridad**: son servidores o grupos de ellos que tienen asignados resolver un conjunto de dominios determinado (como los .es o los .org).

* **Host Name**: El nombre de un _host_ es una sola "palabra" (formada por letras, números y/o guiones). Ejemplos de nombres de host son `www`, `itel` y `blog`.

* **Fully Qualified Host Name (FQHN)**: Es el "nombre completo" de un host. Está formado por el _hostname_, seguido de un punto y su correspondiente nombre de dominio. Por ejemplo: `itel.edu.ar`

* **Domain Name**: El nombre de dominio es una sucesión de nombres concatenados por puntos.
  Algunos ejemplos son `itel.edu.ar`, `com.ar` y `ar`.

* **Top Level Domains (TLD)**: Los dominios de nivel superior son aquellos que no pertenecen a otro
  dominio. Ejemplos de este tipo son `com`, `org` y `ar`.

## Arquitectura del DNS
El sistema DNS funciona principalmente en base al protocolo UDP. Los requerimientos se realizan a través del puerto 53.

![Arquitectura del DNS](imgDNS/dnsArbol.png)

El sistema está estructurado en forma de “árbol“. Cada nodo del árbol está compuesto por un grupo de servidores que se encargan de resolver un conjunto de dominios (zona de autoridad). 

Un servidor puede delegar en otro (u otros) la autoridad sobre alguna de sus sub-zonas (esto es, algún subdominio de la zona sobre la que él tiene autoridad). Un subdominio puede verse como una especialización de un dominio de nivel anterior. Por ejemplo, `itel.edu.ar` es un subdominio de `edu.ar`, que a su vez lo es del TLD `ar`.

!!!tip "Servidores raíz"
		Los [_root servers_](http://www.root-servers.org/) o _servidores raíz_ tienen autoridad sobre el dominio raíz (“.”), devolviendo los servidores con autoridad para cada uno de los TLD. Son fijos, ya que rara vez cambian, siendo actualmente 13.

## Funcionamiento del DNS


![Funcionamiento del DNS](imgDNS/funcionamientoDNS.png)


1. Una aplicación (cliente) necesita resolver un FQHN y envía un requerimiento al servidor de nombres configurado en el sistema (normalmente, el provisto por el ISP). 

2. El servidor de nombres consulta a uno de los servidores raíz (cuya dirección IP debe conocer previamente).

3. El servidor raíz devuelve el nombre del servidor a quien se le ha delegado la sub-zona.
    
4. El servidor inicial interroga al nuevo servidor.

5. El nuevo servidor que posee autoridad sobre la zona interrogada devuelve el nombre del servidor que posee el dominio buscado

6. El servidor DNS iniciar interroga al nuevo servidor con autoridad sobre la zona en cuestión

7. El nuevo servidor resuelve el nombre correspondiente, si este existe.

8. El servidor inicial informa al cliente el nombre resuelto.


## Tipos de servidores DNS

Estos son los tipos de servidores de acuerdo a su función:

* **Primarios o maestros**: guardan los datos de un espacio de nombres en sus ficheros.
* Secundarios o esclavos: obtienen los datos de los servidores primarios a través de una transferencia de zona.
* Locales o caché: funcionan con el mismo software, pero no contienen la base de datos para la resolución de nombres. Cuando se les realiza una consulta, estos a su vez consultan a los servidores DNS correspondientes, almacenando la respuesta en su base de datos para agilizar la repetición de estas peticiones en el futuro continuo o libre.


    Servidor primario, principal o maestro: se denomina a un servidor DNS primario o maestro cuando guarda la información sobre una zona determinada del espacio de nombres de dominio en su propia base de datos.  El sistema de nombres de dominio está construido de tal forma que cada zona disponga de, al menos, un servidor de nombres primario. Un sistema de este tipo suele ser implementado como clúster de servidores donde se almacenan los datos de zona idénticos en un sistema maestro y en varios esclavos, aumentando, gracias a esta redundancia, la seguridad ante caídas y la disponibilidad de un servidor maestro. De aquí procede la denominación de servidores primarios y secundarios que se ha usado. 

    Servidor secundario o esclavo: cuando la información de un servidor de nombres no procede de los archivos de zona propios, sino que son de segunda o de tercera mano, este servidor se convierte en secundario o esclavo para esta información. Esta situación se produce cuando un servidor no puede resolver una petición con su propia base de datos y ha de recurrir a la información disponible en otro servidor de nombres (resolución recursiva). Estos datos del DNS se guardan de forma temporal en un almacenamiento local (caching) y se proporcionan en caso de peticiones futuras. Como es posible que las entradas en el propio archivo de zona hayan cambiado en el ínterin, la información proporcionada por servidores secundarios no se considera segura.


    USO DE CACHÉ

Los servidores tienen mecanismos de caché que hacen que las respuestas sean más rápidas. De esta manera no tenemos que consultar la base de datos cada vez que alguien nos pregunte por geekytheory.com y se ahorra mucho tiempo y recursos.


 Cómo funciona el almacenamiento en caché

Cuando los servidores DNS procesan las consultas del cliente mediante la recursión o iteración, descubren y adquieren un almacén significativo de información sobre el espacio de nombres DNS. A continuación, el servidor almacena en caché esta información.

Almacenamiento en caché, proporciona una manera de acelerar el rendimiento de la resolución DNS para posteriores consultas de nombres populares, y reducir considerablemente el tráfico de consultas relacionadas con DNS en la red.

Como los servidores DNS realizan consultas recursivas en nombre de clientes, almacenan temporalmente en caché los registros de recursos. Los registros de recursos almacenados en caché contienen información obtenida de los servidores DNS que tienen autoridad para nombres de dominio DNS aprendidos durante las consultas iterativas para buscar y responder por completo una consulta recursiva realizaron en nombre de un cliente. Más tarde, cuando otros clientes realizan consultas nuevas que solicitan información de RR que coincide con los registros de recursos almacenados en caché, el servidor DNS puede utilizar la información almacenada en caché de RR para responderlas.

Cuando se almacena en caché la información, un valor de tiempo de vida (TTL) se aplica a todos los registros de recursos almacenados en caché. Siempre y cuando el TTL para un registro de recursos almacenados en caché no caduque, un servidor DNS puede seguir en caché y utilizar los RR de nuevo al responder a consultas de sus clientes que coincidan con estos registros de recursos. Almacenamiento en caché TTL utilizados por los registros de recursos en la mayoría de las configuraciones de zona se asignan valores el TTL mínimo (predeterminado) que se establece en la zona de inicio de autoridad (SOA) RR. De forma predeterminada, el mínimo TTL es de 3.600 segundos (una hora) pero se puede ajustar o, si es necesario, se pueden establecer TTLs caché individuales en cada RR. 


## Base de conocimiento
* [https://es.wikipedia.org/wiki/Sistema_de_nombres_de_dominio](https://es.wikipedia.org/wiki/Sistema_de_nombres_de_dominio)
* [http://es.tldp.org/Manuales-LuCAS/GARL2/garl2/x-087-2-resolv.howdnsworks.html](http://es.tldp.org/Manuales-LuCAS/GARL2/garl2/x-087-2-resolv.howdnsworks.html)
* [https://blog.smaldone.com.ar/2006/12/05/como-funciona-el-dns](https://blog.smaldone.com.ar/2006/12/05/como-funciona-el-dns/)
* [https://geekytheory.com/como-funciona-el-dns](https://geekytheory.com/como-funciona-el-dns)
* [https://www.xatakamovil.com/conectividad/como-funciona-internet-dns](https://www.xatakamovil.com/conectividad/como-funciona-internet-dns)
* [https://support.google.com/a/answer/2573637](https://support.google.com/a/answer/2573637)
* [https://support.google.com/a/answer/48090?hl=es](https://support.google.com/a/answer/48090?hl=es)
* [https://technet.microsoft.com/es-ar/library/dd197446(v=ws.10).aspx](https://technet.microsoft.com/es-ar/library/dd197446(v=ws.10).aspx)
* [https://developer.mozilla.org/en-US/docs/Learn/Common_questions/What_is_a_domain_name](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/What_is_a_domain_name)
*[http://www.ite.educacion.es/formacion/materiales/85/cd/linux/m2/servidor_dns.html](http://www.ite.educacion.es/formacion/materiales/85/cd/linux/m2/servidor_dns.html)