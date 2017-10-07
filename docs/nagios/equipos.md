Abrimos el archivo que nombramos como `equipos.cfg`:

```bash
sudo nano /etc/nagios3/objetos/equipos.cfg
```

A continuación, tendremos que incluir en dicho archivo la configuración los equipos que forman parte de nuestra red, uno debajo del otro. Por ejemplo:   

```apache
# Ejemplo: Equipo número 7 - Sala 1
define host { 
use            	generic-host
host_name    	sala1pc7
alias           Equipo 7 de la sala 1
address         192.168.0.123         
}

# Ejemplo: Equipo número 8 - Sala 1
define host { 
use            	generic-host
host_name    	sala1pc8
alias           Equipo 8 de la sala 1
address         192.168.0.124         
}

# Ejemplo: Router - Sala principal
define host { 
use            	generic-host
host_name    	router1
alias           Router de la sala principal
address         192.168.0.1         
}
```

Donde: 

|Directiva|Explicación|
|----|----|
|define host  { } |Directiva empleada por Nagios para definir **cada equipo** que forma parte de la red.|
|use|Establece que plantilla se utilizará para definir las caracterísitcas del equipo. Dichas plantillas vienen predefinidas con Nagios (en la carpeta **/etc/nagios3/conf.d**) aunque también se pueden crear las propias. En el ejemplo, se utiliza la plantilla **generic-host**. |
|host_name|Nombre único del equipo. Sin espacios ni caracteres reservados.|
|alias|Descripción larga del equipo (puede incluir espacios y caracteres reservados).|
|address|Dirección IP del equipo.|

De más está afirmar la conveniencia del uso de comentarios (#) para ganar claridad y orden a la hora de crear nuestro archivo de configuración. 


Por último, tendremos que [verificar la configuración y reiniciar el servidor Nagios](configuracion/#verificando-la-configuracion-y-reiniciando-nagios) para guardar los cambios que hayamos introducido.

## Diseño de topología de red
Nagios permite configurar los _hosts_ distinguiéndolos entre _padres_ e _hijos_ usando la directiva `parents`. Veámoslo con un ejemplo [extraído de la documentación de Nagios](https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/3/en/networkreachability.html), donde la siguiente topología de red:

![Parents](imgNagios/parents.png)

Se corresponde con la siguiente configuración de _hosts_ (la configuración de cada _host_ aparece simplificada con fines didácticos )

```apache
# Localhost (el servidor Nagios) no posee padre
define host{
	host_name		Nagios   
}

# Y luego se definen el resto de los hosts
define host{
	host_name		Switch1
	parents			Nagios
}

define host{
	host_name		Web
	parents			Switch1
}

define host{
	host_name		FTP
	parents			Switch1
}

define host{
	host_name		Router1
	parents			Switch1
}

define host{
	host_name		Switch2
	parents			Router1
}

define host{
	host_name		Wkstn1
	parents			Switch2
}

define host{
	host_name		HPLJ2605
	parents			Switch2
}

define host{
	host_name		Router2
	parents			Router1
}

define host{
	host_name		somewebsite.com
	parents			Router2
}

```

