Una vez que **hayamos definido los equipos** que forman parte de nuestra red, **los organizaremos en grupos** para su mejor administración. 

Para ello abrimos el arhivos llamado `grupos.cfg` creado con anterioridad: 

```bash
sudo vim /etc/nagios3/objetos/grupos.cfg
```

Y agregamos dentro del archivo, la información sobre los grupos que deseamos crear:

```apache
# Definición de grupos (de equipos, de routers, etc.)

define hostgroup {
hostgroup_name	sala1
alias			Equipos de la sala 1
members			s1pc1,s1pc2,!s1pc3     # El carácter ! (signo de admiración) indica exclusión. 	
}

define hostgroup {
hostgroup_name	sala2
alias			Equipos de la sala 2
members			s2pc1,s2pc2,s2pc3	
}

```

Donde: 

|Directiva|Explicación|
|----|----|
|define hostgroup { }|Directiva empleada por Nagios para definir **un grupo** que querramos crear en la red.|
|hostgroup_name|Nombre único del grupo. Sin espacios ni caracteres reservados.|
|alias|Descripción larga del grupo (puede incluir espacios y caracteres reservados).|
|members|Nombres de host (equipos) que formarán parte del grupo, separados por comas (,).|


Por último, tendremos que [verificar la configuración y reiniciar el servidor Nagios](configuracion/#verificando-la-configuracion-y-reiniciando-nagios) para guardar los cambios que hayamos introducido.