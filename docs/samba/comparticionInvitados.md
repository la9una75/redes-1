Por último, si necesitamos que **cualquier usuario de la red (incluso si no es un usuario Samba) pueda acceder as una carpeta compartida**, daremos los siguientes pasos: 

Primeramente tendremos que crear la carpeta a compartir: 

```apache
mkdir -p /opt/invitados
```

Luego, modificar la propiedad de la carpeta: 
```apache
chown -R nobody:nogroup /opt/invitados
```

Y los permisos:  
```apache
chmod -R ugo+rwx /opt/invitados 
```
O el comando equivalente:

```apache
chmod -R 777 /opt/invitados 
```
Por último, tendremos que agregar al archivo de configuración principal de Samba (`/etc/samba/smb.conf`) el siguiente bloque de código: 

```apache
[invitados]

	# Carpeta a compartir
	path = /opt/invitados
	
	# Todos los usuarios de Windows
	force group = users

	# ¿La carpeta será visible por el resto de los usuarios?
	browsable = yes

	# ¿Se puede escribir dentro de la carpeta?
	writable = yes

	# Cualquier usuario sin contraseña tiene permiso de acceso
	guest ok = yes
```

!!!warning "Atención"
		Cualquier usuario del sistema Windows podrá leer y escribir en esta carpeta, aún cuando no posea una contraseña para el inicio de sesión en Windows ni esté registrado en el servidor Samba.  

Finalmente, reiniciamos Samba para que el sistema tome los cambios:

```apache
sudo service smbd restart
```
