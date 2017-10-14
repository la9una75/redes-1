El sistema de nombres de dominio (DNS, por sus siglas en inglés _Domain Name System_) es un sistema de nomenclatura jerárquico descentralizado para dispositivos conectados a redes IP como Internet o una red privada.

El servicio DNS se emplea fundamentalmente en la resolución de nombres, es decir, determinar cuál es la dirección IP que corresponde a un nombre de dominio determinado y viceversa. Además, se encarga de la resolución de servidores de correo, esto es, dado un determinado nombre de dominio, identifica cuál es el servidor a través del cual debe hacerse la entrega del correo. 

## Arquitectura del DNS
El sistema DNS funciona principalmente en base al protocolo UDP. Los requerimientos se realizan a través del puerto 53.

![Arquitectura del DNS](imgDNS/dnsArbol.png)

El sistema está estructurado en forma de “árbol“. Cada nodo del árbol está compuesto por un grupo de servidores que se encargan de resolver un conjunto de dominios (zona de autoridad). 

Un servidor puede delegar en otro (u otros) la autoridad sobre alguna de sus sub-zonas (esto es, algún subdominio de la zona sobre la que él tiene autoridad). Un subdominio puede verse como una especialización de un dominio de nivel anterior. Por ejemplo, ´itel.edu.ar´ es un subdominio de ´edu.ar´, que a su vez lo es del TLD ´ar´.

!!!tip "Servidores raíz"
		Los [_root servers_](http://www.root-servers.org/) o _servidores raíz_ tienen autoridad sobre el dominio raíz (“.”), devolviendo los servidores con autoridad para cada uno de los TLD. Son fijos, ya que rara vez cambian, siendo actualmente 13.

## Funcionamiento del DNS

1. Una aplicación (cliente) necesita resolver un FQHN y envía un requerimiento al servidor de nombres configurado en el sistema (normalmente, el provisto por el ISP). 

2. El servidor de nombres consulta a uno de los servidores raíz (cuya dirección IP debe conocer previamente).

3. El servidor raíz devuelve el nombre del servidor a quien se le ha delegado la sub-zona.
    
4. El servidor inicial interroga al nuevo servidor.

5. El nuevo servidor que posee autoridad sobre la zona interrogada devuelve el nombre del servidor que posee el dominio buscado

6. El servidor DNS iniciar interroga al nuevo servidor con autoridad sobre la zona en cuestión

7. El nuevo servidor resuelve el nombre correspondiente, si este existe.

8. El servidor inicial informa al cliente el nombre resuelto.


![Funcionamiento del DNS](imgDNS/funcionamientoDNS.png)


1. Consulta recursiva para geekytheory.com
2. Consulta iterativa para geekytheory.com a la raíz.
3. Devuelve la referencia al .com.
4. Consulta iterativa a geekytheory.com.
5. Devuelve la referencia al servidor donde está la información de geekytheory.com.
6. Consulta iterativa para saber los datos de geekytheory.com.
7. Respuesta con la IP de geekytheory.com.
8. Respuesta final que contiene la IP de geekytheory.com.


## Terminología
Antes de proseguir, es necesario introducir algunos términos básicos para evitar confusiones y
ambigüedades. Otros términos más complejos serán tratados más adelante.

* **Host Name**: El nombre de un _host_ es una sola "palabra" (formada por letras, números y/o guiones). Ejemplos de nombres de host son ´www´, ´itel´ y ´blog´.
* **Fully Qualified Host Name (FQHN)**: Es el "nombre completo" de un host. Está formado por el _hostname_, seguido de un punto y su correspondiente nombre de dominio. Por ejemplo: ´itel.edu.ar´
* **Domain Name**: El nombre de dominio es una sucesión de nombres concatenados por puntos.
  Algunos ejemplos son ´itel.edu.ar´, ´com.ar´ y ´ar´.
* **Top Level Domains (TLD)**: Los dominios de nivel superior son aquellos que no pertenecen a otro
  dominio. Ejemplos de este tipo son ´com´, ´org´ y ´ar´.



https://blog.smaldone.com.ar/2006/12/05/como-funciona-el-dns/
https://geekytheory.com/como-funciona-el-dns
http://www.root-servers.org/
https://www.xatakamovil.com/conectividad/como-funciona-internet-dns

