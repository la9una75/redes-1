Podemos comprobar el funcionamiento del servidor DNS empleando, entre otros, dos comandos: `dig` y `nslookup`.

## dig (_domain information groper_)

_dig_ es una herramienta flexible para consultar información a los servidores DNS: ejecuta un _lookup_ a los servicios de DNS y nos devuelve la salida que necesitemos.

Constituye una herramienta útil para encontrar errores y hacer _troubleshooting_ a los servicios de nombres, ya que es una herramienta muy útil, fácil de utilizar, y con una salida limpia.

### Instalación de dig

En la mayor parte de las distros es necesario instalarlo previamente. El paquete `dnsutils` suele incluir el programa `dig` en Debian o Ubuntu.

```bash
sudo apt install dnsutils
```

### Sintaxis básica

La sintaxis del comando es la siguiente:

```apache
dig [@server] name [type]
```

Donde:

* `@server` es un servidor específico al que vamos a preguntarle.
* `name` es el nombre de host/dominio sobre el que necesitamos información
* `type` es el tipo de registro, y puede omitirse, en cuyo caso obtendremos la información para el registro A (address).

### Ejemplo de uso

Podemos consultar información DNS sobre el dominio `google.com.ar`

```bash
dig google.com.ar
```

Y obtendremos una salida similar a la siguiente: 

```apache
; <<>> DiG 9.10.3-P4-Ubuntu <<>> google.com.ar
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 45490
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;google.com.ar.			IN	A

;; ANSWER SECTION:
google.com.ar.		9	IN	A	172.217.28.163

;; Query time: 117 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
;; WHEN: Wed Nov 08 13:52:16 ART 2017
;; MSG SIZE  rcvd: 58
```

Donde: 

* Todas las líneas que inician con “;” son comentarios
* La primer línea nos devuelve la versión del comando dig que estamos utilizando, DiG 9.10.3-P4-Ubuntu en este ejemplo. 
* Luego muestra la sección de consulta con nuestra consulta (_question section_). Podemos ocultar esta sección con `+noquestion`.
* A continuación, la sección de la respuesta (_answer section_). Podemos ocultar esta sección con `+noanswer` (si es que tiene algún sentido :smile:).
* Y por último, muestra estadísticas de la consulta. Con la opción `+nostats` podemos ocultar esta sección de estadísticas.

### Otros registros

Por defecto la respuesta está asociada a los registros A del dominio, es decir, por defecto nos devuelve la dirección o direcciones IP (Address) del dominio, pero no es la única opción. Podemos consultar cualquier otro registro del DNS, entre ellos:

```bash
dig [@server]  [a]      # address record
dig [@server]  [ns]     # nameserver record
dig [@server]  [mx]     # mx record
dig [@server]  [txt]    # txt record
dig [@server]  [any]    # todos los registros
```

### Modificando las consultas

`dig` permite, mediante el caracter `+`, agregar o quitar información de la salida. Veamos algunas opciones interesantes:

* `+[no]additional`: muestra u oculta la sección de datos adicionales.
* `+[no]all`: muestra u oculta todos los datos. Ocultar todos los datos sirve para luego mostrar algún dato específico que necesitemos. Por ejemplo, “+noall +answer” ocultará todos los datos, y solo mostrará la respuesta.
* `+[no]answer`: muestra u oculta la sección de respuesta
* `+[no]authority`: muestra u oculta la sección de autoridad SOA
* `+[no]question`: muestra u oculta la sección de la consulta que hicimos.
* `+[no]comments`: muestra u oculta los comentarios (líneas que inician con “;”.
* `+[no]crypto`: muestra u oculta los datos del registro criptográfico DNSSEC utilizado para firmar las zonas en algunos servidores.
* `+[no]dnssec`: muestra u oculta los datos del registro DNSSEC en la sección adicional.
* `+[no]keepopen`: mantiene el socket tcp utilizado para una consulta abierto, de modo que subsiguientes consultas utilizarán el mismo socket contra el servidor DNS que estemos utilizando. Esto es válido cuando las consultas se realizan sobre TCP en vez de UDP.
* `+[no]recurse`: habilita o deshabilita la búsqueda recursiva. Por defecto siempre está activada, salvo que la desactivemos directamente con esta opción, o utilicemos alguna opción que la desactive, como +nssearch.
* `+[no]short`: permite o no imprimir una salida corta específica, por defecto está desactivada y vemos la salida completa.
* `+[no]stats`: muestra u oculta la sección de estadísticas. Por defecto siempre está activada.
* `+[no]tcp`: fuerza o no la utilización de TCP en vez de UDP para realizar las consultas. Por defecto es UDP, salvo que el tipo de registro sea AXFR (transferencia de zona).
* `+[no]trace`: habilita o no la trazabilidad de la consulta, lo que permite ver la lista completa de nodos y pasos de resolución de un nombre, muy útil para entender cómo funciona un sistema de nombres de dominio.
* `+[no]ttlid`: muestra o no la información del TTL cuando imprime cada registro.

### Otras opciones

El comando dig permite además varias opciones, como cualquier comando en Linux. Algunas de las más útiles son las siguientes:

* `-6` o `-4`: para realizar consultas únicamente sobre una red IPv6 o IPv4 respectivamente.
* `-b address[#port]`: permite especificar una dirección válida desde la que consultar, y opcionalmente un puerto de origen.
* `-x`: permite hacer una resolución inversa sobre IPv4 (en IPv6 muestra el formato nibble bajo el dominio IP6.ARPA.
* `-i`: permite una resolución inversa sobre IPv6.

Para más opciones y documentación, nada mejor que leer el man:

```bash
man dig
```

## Nslookup
Nslookup es un programa utilizado para saber si el DNS está resolviendo correctamente los nombres y las IPs. Se utiliza con el comando nslookup, que funciona tanto en Windows como en UNIX para obtener la dirección IP conociendo el nombre, y viceversa.

