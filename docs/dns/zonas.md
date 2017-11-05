Aunque se pueda atribuir nombres a los diversos sistemas de una red, estos no consiguen reconocerse entre sí sin un sistema de resolución de nombres. Para que un sistema consiga localizar la dirección IP asociada al nombre de otro sistema, es necesario que éste esté registrado en un servidor DNS, para permitir la resolución de nombres.
Atención

!!! warning "Importante"
		Antes de instalar el servidor DNS, la [Cache DNS](cache.md) debe estar previamente configurada y verificada.

## Creando y declarando archivos de zonas

La resolución de nombres traduce nombres de sistemas en sus direcciones IP y viceversa. Así, la configuración consiste, básicamente en la creación de 2 archivos de zona:

* **Archivo de zona de resolución directa**: contiene la información necesaria para convertir nombres de dominio en direcciones IP. En nuestro ejemplo, el archivo se llama `db.itel.lan` 
* **Archivo de zona de resolución inversa** contiene la información necesaria para convertir direcciones IP en el respectivo nombre de sistema. En el ejemplo, el archivo se llama `db.0.168.192`

Las zonas pueden declararse en el archivo `/etc/bind/named.conf.local`:

```bash


// Zona de resolución directa

    zone "home.lan" {
        type master;
        file "/etc/bind/db.itel.lan";
    };

// Zona de resolución inversa

    zone "0.168.192.in-addr.arpa" {
        type master;
        file "/etc/bind/db.0.168.192";
    };

```

Por último, verificamos que el archivo de configuración no contenga errores:

```bash
sudo named-checkconf
```


## Contenido de los archivos de zona
Los Archivos de zona contienen información sobre un espacio de nombres particular. 

Cada archivo de zona contiene **directivas** y **registros de recursos**. Las directivas le dicen al servidor de nombres que realice tareas o aplique configuraciones especiales a la zona. Los registros de recursos define los parámetros de la zona y asignan identidades a hosts individuales. Las directivas son opcionales, pero los registros de recursos se requieren para proporcionar servicios de nombres a la zona.

!!!warning "Declaración de registros y directivas"
        Todas las directivas y registros de recursos deben ir en sus propias líneas individuales.

Los comentarios se pueden colocar después de los punto y comas (`;`) en archivos de zona. 

### Directivas de archivos de zona
Las directivas comienzan con el símbolo de dolar (`$`) seguido del nombre de la directiva. Usualmente aparecen en la parte superior del archivo de zona.

Lo siguiente son directivas usadas a menudo:

#### $INCLUDE 
Se utiliza para incluir otro archivo de zona en el archivo de zona donde se usa la directiva. Así se pueden almacenar configuraciones de zona suplementarias aparte del archivo de zona principal.

#### $ORIGIN
Anexa el nombre del dominio a registros no cualificados, tales como aquellos con el nombre de host solamente.

Por ejemplo, un archivo de zona puede contener la línea siguiente: 

```apache
$ORIGIN ejemplo.com.
```

Entonces, a cualquier nombre utilizado en _registros de recursos_ que no terminen en un punto (.) se le agregará `ejemplo.com`

!!!done "Uso de la directiva $ORIGIN"
         El uso de la directiva `$ORIGIN` no es necesario si la zona fue especificada en el archivo `/etc/named.conf`

#### $TTL
Ajusta el valor _Time to Live_ (`TTL`) predeterminado para la zona. Este es el tiempo en el que un **registro de recurso** de zona es válido. Cada recurso puede contener su propio valor TTL, el cual ignora esta directiva.

Cuando se decide aumentar este valor, permite a los servidores de nombres remotos hacer caché a la información de zona para un período más largo de tiempo, reduciendo el número de consultas para la zona. 


### Registros de recursos de archivos de zona
El componente principal de un archivo de zona son los registros de recursos o _Resource Records_ (`RR`).

Hay muchos tipos de registros de recursos de archivos de zona. A continuación se listan los tipos de registros más frecuentes.

#### SOA (_Start of Authority_)
El registro de recursos `SOA` indica el inicio de una zona autoritativa para un determinado nombre de dominio. Un registro `SOA` es el primer registro en un archivo de zona.

El ejemplo siguiente muestra la estructura básica de un registro de recursos `SOA`:

```apache
@     IN     SOA    <primary-name-server>     <hostmaster-email> (
                    <serial-number>
                    <time-to-refresh>
                    <time-to-retry>
                    <time-to-expire>
                    <minimum-TTL> )
```

Donde:

* `@` es reemplazado por el contenido de la directiva $ORIGIN (o el nombre de la zona, si la directiva $ORIGIN no está configurada).

* `IN` significa _Internet Address_ o dirección de internet.

* `<primary-name-server>` es el nombre del _host_ del servidor de nombres que tiene autoridad sobre este dominio. 

* `<hostmaster-email>` es el correo electrónico de la persona a contactar sobre este dominio.

* `<serial-number>`  es un valor numérico que es incrementado cada vez que se cambia el archivo de zona. Es usado por los servidores esclavos para determinar si esta usando datos de la zona desactualizados y si debería refrescarlos.

* `<time-to-refresh>` es el valor numérico que los servidores esclavos utilizan para determinar cuánto tiempo debe esperar antes de preguntar al servidor de nombres maestro si se han realizado cambios a la zona. 

* `<time-to-retry>` es un valor numérico usado por los servidores esclavos para determinar el intervalo de tiempo que tiene que esperar antes de emitir una petición de actualización de datos en caso de que el servidor de nombres maestro no responda. 

* `<time-to-expire>` es el tiempo que, ante la no respuesta del servidor maestro, los servidores esclavos dejan de responder como autoridad sobre un dominio. 

* `<minimum-TTL>` es la cantidad de tiempo que otros servidores de nombres guardan en caché la información de zona.

!!!done "Sobre los servidores esclavos"
        Los parámetros que se encuentran dentro de `( )` son aquellos que regirán el funcionamiento de los servidores esclavos que existan en el sistema.

!!!tip "Unidades para expresar tiempo"
        Cuando se configura BIND, todos los tiempos son siempre referenciados en segundos. Sin embargo, es posible usar abreviaciones cuando se especifiquen unidades de tiempo además de segundos, tales como minutos (M), horas (H), días (D) y semanas (W). 

Un ejemplo de aplicación para este registro: 

```apache
@     IN     SOA    dns1.ejemplo.com.     hostmaster.ejemplo.com. (
                    2001062501 ; serial
                    21600      ; actualizar después de 6 horas
                    3600       ; reintentar después de 1 hora
                    604800     ; expirar después de 1 semana
                    86400 )    ; TTL mínimo de 1 día
```

#### NS (_Name Server_)
Anuncia los nombres de servidores con autoridad sobre una zona particular.

La sintaxis de un registro NS:

```apache
<zone-name>    IN     NS     <nameserver-name>
```

Donde `<zone-name>` es el nombre de la zona sobre la que el servidor posee autoridad. Luego, el `<nameserver-name>` debería ser un FQDN.

Es costumbre emplear dos servidores DNS con autoridad sobre el dominio. No es importante si estos nombres de servidores son esclavos o si son maestros; ambos son considerados con autoridad sobre el dominio. 

Un ejemplo del uso de este registro: 

```apache
ejemplo.com.   IN     NS     dns1.ejemplo.com.
ejemplo.com.   IN     NS     dns2.ejemplo.com.
```

Sin embargo, como se explicó mas arriba, el símbolo `@` reemplaza el nombre del archivo de zona. Por tanto, podemos escribir:  

```apache
@   IN     NS     dns1.ejemplo.com.
@   IN     NS     dns2.ejemplo.com.
```

Inclusive es posible dejar el parámetro del nombre de zona en blanco ya que en el `RR` anterior se utilizó. La regla es: si no se especifica nada antes del parámetro `IN` se asume el valor que existía anteriormente. Por lo tanto la configuración del `RR` sería:

```apache
IN     NS     dns1.ejemplo.com.
IN     NS     dns2.ejemplo.com.
```

Finalmente, podríamos prescindir también de la clase `IN` (_Internet_) ya que si no se no se especifica explícitamente, BIND utiliza el valor predeterminado `IN` de todos modos. Entonces, podríamos escribir: 

```apache
       NS     dns1.ejemplo.com.
       NS     dns2.ejemplo.com.
```


#### MX (_Mail eXchange_)
Indica dónde debería de ir el correo enviado a un espacio de nombres particular controlado por esta zona.

La sintaxis empleada para definir un registro MX: 

```apache
<zone-name>    IN     MX     <preference-value>  <email-server-name>
```

Donde: 

* `<zone-name>` es el nombre de la zona sobre la que el servidor posee autoridad.

* `<preference-value>` permite una clasificación numérica de los servidores de correo para un espacio de nombres, dando preferencia a algunos sistemas de correo sobre otros. El registro de recursos MX con el valor más bajo `<preference-value>` es preferido sobre los otros. Sin embargo, múltiples servidores de correo pueden tener el mismo valor para distribuir el tráfico de forma pareja entre ellos.

* `<email-server-name>` puede ser un nombre de servidor o FQDN.

Un ejemplo de configuración para este registro: 

```apache
ejemplo.com.    IN     MX     10     mail1.ejemplo.com.
ejemplo.com.    IN     MX     20     mail2.ejemplo.com.
```

!!!done "Prioridad de los servidores de correo"
        En el ejemplo anterior, el primer servidor de correo `mail1.ejemplo.com` es preferido al servidor de correo `mail2.ejemplo.com` cuando se recibe correo destinado para el dominio `ejemplo.com`. 

No obstante, como se explicó en un [`RR` anterior](#ns-name-server), la configuración del registro se puede escribir de forma abreviada, como sigue: 

```apache
        MX     10     mail1.ejemplo.com.
        MX     20     mail2.ejemplo.com.
```


#### A (_Address_)
Un registro `A` o de direcciones enlaza un dominio con la dirección IP física de un servidor. 

La sintaxis para declarar este registro es: 

```apache
name    ttl     class   rr    ipv4
<host>          IN      A     <IP-address>
```

Si el valor `<host>` es omitido, o si en su lugar se usa el símbolo `@`, el registro `A` apunta a una dirección IP por defecto. Esto es así para todas las peticiones no FQDN.

Si consideramos el siguiente ejemplo de registro `A` para el archivo de zona `ejemplo.com`:

```apache
                        IN     A       192.168.0.3
servidor.ejemplo.com    IN     A       192.168.0.5
```

Las peticiones para `ejemplo.com` son apuntadas a `192.168.0.3`, mientras que las solicitudes para `servidor.ejemplo.com` son dirigidas a `192.168.0.5`. 

Naturalmente, podemos escribir de manera abreviada la configuración para este registro: 

```apache
            A       192.168.0.3
servidor    A       192.168.0.5
```


#### CNAME (_Canonical Name_)
El registro de nombre canónico, enlaza un nombre con otro. Es también conocido como un alias.

La sintaxis empleada por el registro `CNAME` es la siguiente: 

```apache
<alias-name>     IN     CNAME       <real-name>
```

Donde cualquier petición enviada a `<alias-name>` apuntará al host `<real-name>`. 

Veamos el ejemplo siguiente de aplicación: 

```apache
servidor.ejemplo.com      IN     A       192.168.0.5
www.ejemplo.com           IN     CNAME   servidor.ejemplo.com
```

Un registro `A` vincula un nombre de host a una dirección IP, mientras que un registro `CNAME` apunta al nombre host `www.ejemplo.com`, comúnmente usado para este.

De manera abreviada: 

```apache
servidor    A       192.168.0.5
www         CNAME   servidor
```

#### PTR (_PoinTeR_)
Los registros `PTR` o punteros, son usados principalmente para la resolución inversa de nombres, pues ellos apuntan direcciones IP de vuelta a un nombre particular. 

La sintaxis de uso de este registro es: 

```apache
<last-IP-digit>      IN     PTR    <FQDN-of-system>
```

El valor `<last-IP-digit>` se refiere al último número en una dirección IP que apunta al `FQDN` de un sistema particular. 

Un ejemplo de configuración empleando este registro: 

```apache
42.0.168.192.   IN PTR  servidor.ejemplo.com.
114.0.168.192.  IN PTR  desarrollo.ejemplo.com.   
135.0.168.192.  IN PTR  externo.ejemplo.com.
```

Y de forma resumida: 

```apache
42      PTR     servidor.ejemplo.com.
114     PTR     desarrollo.ejemplo.com.   
135     PTR     externo.ejemplo.com.
```

### Otros registros
Existen muchos otros registros de recursos disponibles. En la presente documentación se listaron los de uso frecuente. No obstante, a continuación se reseñan algunos de ellos: 

#### TXT (_Text Record_)
Un registro TXT es un registro DNS que proporciona información de texto a fuentes externas a tu dominio y que se puede utilizar con distintos fines. El valor del registro puede corresponder a un texto legible por una máquina o por una persona. 

#### AAAA

#### 


## Ejemplos de archivos de zonas

 Vistos individualmente, las directivas y registros de recursos pueden ser difíciles de comprender. Sin embargo, cuando se colocan juntos en un mismo archivo, se vuelven más fáciles de entender.

El ejemplo siguiente muestra un archivo de zona de resolución directa:

```apache
$ORIGIN ejemplo.com.
$TTL 86400
@     IN     SOA    dns1.ejemplo.com.     hostmaster.ejemplo.com. (
                    2001062501 ; serial
                    21600      ; refresh after 6 hours
                    3600       ; retry after 1 hour
                    604800     ; expire after 1 week
                    86400 )    ; minimum TTL of 1 day

      IN     NS     dns1.ejemplo.com.
      IN     NS     dns2.ejemplo.com.

      IN     MX     10     mail.ejemplo.com.
      IN     MX     20     mail2.ejemplo.com.

             IN     A       10.0.1.5

server1      IN     A       10.0.1.5
server2      IN     A       10.0.1.7
dns1         IN     A       10.0.1.2
dns2         IN     A       10.0.1.3

ftp          IN     CNAME   server1
mail         IN     CNAME   server1
mail2        IN     CNAME   server2
www          IN     CNAME   server2
```

Y, a continuación, un archivo de zona de resolución inversa:

```apache
$ORIGIN 1.0.10.in-addr.arpa.
$TTL 86400
@     IN     SOA    dns1.ejemplo.com.     hostmaster.ejemplo.com. (
                    2001062501 ; serial
                    21600      ; refresh after 6 hours
                    3600       ; retry after 1 hour
                    604800     ; expire after 1 week
                    86400 )    ; minimum TTL of 1 day

      IN     NS     dns1.ejemplo.com.
      IN     NS     dns2.ejemplo.com.

20    IN     PTR    alice.ejemplo.com.
21    IN     PTR    betty.ejemplo.com.
22    IN     PTR    charlie.ejemplo.com.
23    IN     PTR    doug.ejemplo.com.
24    IN     PTR    ernest.ejemplo.com.
25    IN     PTR    fanny.ejemplo.com.
```