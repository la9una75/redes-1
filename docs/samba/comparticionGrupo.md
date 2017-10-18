En otras ocasiones, tal vez resulte práctico **compartir una carpeta entre los usuarios que pertenecen a un grupo determinado**. 

## Creando la carpeta a compartir
Debemos crear la carpeta en cualquier lugar (p.e. dentro de la carpeta `/opt`)

```apache
mkdir -p carpetaCompartida
```

## Modificando el usuario y grupo propietario de la carpeta

```apache
chown -R usuario:grupo carpetaCompartida
```
Donde:

 * `usuario` es el **usuario dueño** de la carpeta compartida (generalmente es el usuario `root`) y 
 * `grupo` es el **grupo dueño** al que deseamos dar permiso sobre la carpeta compardida.

 Por ejemplo, si deseamos permitir que usuarios de un hipotético grupo llamado _ventas_ tenga acceso a la carpeta imaginaria _recursos_ ejecutamos: 

```apache
chown -R root:ventas recursos
```

## Modificando los permisos de la carpeta

Y finalmente, modificamos los permisos de la carpeta: 
```apache
chmod -R ug+rwx,o+rx-w carpetaCompartida
```
O, lo que es lo mismo: 

```apache
chmod -R 775 carpetaCompartida
```

Siguiendo con el ejemplo del apartado anterior, escribiríamos: 

```apache
chmod -R 775 recursos
```
De esta manera estaríamos dando permiso total de acceso al usuario y grupo dueños de la carpeta _recursos_ y permisos de lectura y ejecución al resto de los usuarios del sistema. 

## Modificando el archivo de configuración de Samba

En el siguiente ejemplo, se comparte una carpeta llamada **ventas** que será accesible y escribible por todos los miembros del grupo **facturacion** (el bloque siguiente de código se deberá agregar en el archivo `/etc/samba/smb.conf`):

```apache

[ventas]
	# Comentario
	comment = Carpeta compartida entre los usuarios del grupo facturacion

	# Carpeta a compartir
	path = /opt/ventas

	# Damos permiso de acceso a todos los usuarios 
	# pertenecientes al grupo llamado "facturacion"
	valid users = @facturacion

	# Fuerza el grupo con permisos de acceso
	force group = facturacion

	# ¿Se puede escribir dentro de la carpeta?
	writable = yes

	# ¿La carpeta será visible por el resto de los usuarios?
	browseable = no
```

!!!tip "Usuarios"
		El la directiva `valid users` podríamos haber indicado el nombre de uno o varios usuarios:

		`force users = juan, pedro, jorge`

		O incluir los usuarios pertenecientes a distintos grupos: 

		`force users = @ventas, @facturacion`

		Lo indicado vale también para la directiva `force group` que es para los grupos. 

## Reiniciando el servidor
Rreiniciamos Samba para que el servidor haga efectivos los cambios:

```apache
sudo service smbd restart
```