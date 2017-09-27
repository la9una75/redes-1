Para instalar el software, ejecutamos en una terminal: 

```bash
sudo apt-get install nagios3 nagios-nrpe-plugin
```

Durante las instalación se nos solicitará la contraseña de administración. Podemos omitir este paso ya que consiguraremos la contraseña en el paso siguiente. 



## Modificando la contraseña de administrador 

El **usuario administrador** por defecto es **nagiosadmin**. Para **modificar la contraseña** de este usuario, ejecutamos:

```bash
sudo htpasswd -c /etc/nagios3/htpasswd.users nagiosadmin
```

## Ingresando a la administración

Nagios posee una interfaz web que facilita la administración del servidor. La misma puede ser accedida desde un navegador introduciendo la dirección: ''http://ip.de.tu.servidor/nagios''

Los datos de acceso serán:

  * **usuario**: nagiosadmin
  * **contraseña**: (la contraseña que definiste durante la instalación)