Para instalar el paquete básico de samba, a fin iniciar un servidor de compartición de archivos ejecutamos:

```apache
sudo apt-get install samba
```

## El archivo de configuración de Samba

Cada vez que configuramos un servicio en GNU/Linux, conviene realizar una copia de seguridad de los archivos que vayamos a modificar de manera de disponer del archivo original en caso de errores de configuración. El archivo de configuración de Samba es `/etc/samba/smb.conf`. Hacemos una copia de seguridad: 

```apache
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.original
```

Llegado este punto, podemos editar directamente el archivo smb.conf o crear un nuevo archivo en blanco. Por cuestiones de claridad en la explicación, nos inclinaremos por el segundo caso: 

```apache
sudo touch /etc/samba/smb.conf
```

A partir de acá iremos modificando este único archivo de configuración. 