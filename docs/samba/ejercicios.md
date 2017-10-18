## Ejercicio 1
* Creá los siguientes usuarios: **uno** y **dos**. 
* Creá una carpeta compartida para cada usuario, la cual, sólo pueda ser accedida por su dueño. 

## Ejercicio 2

La pyme ficticia "El Trigal" elabora diferentes tipos de panificados. Su personal es pequeño y los mismos comparten carpetas según su área de desempeño: 

| Usuario     |Área de desempeño          | Acceso|
| ---------------------- | -------------- | -------------- |
| jose  | Gerencia|A la carpeta **gerencia** y a cualquier carpeta|
| sol | Administracion |A la carpeta compartida **administracion** y a la carpeta **publica**|
| mia | Administracion |A la carpeta compartida **administracion** y a la carpeta **publica**|
| pedro | Taller |A la carpeta compartida **taller** y a la carpeta **publica**|
| roberto | Taller |A la carpeta compartida **taller** y a la carpeta **publica**|
| juan | Taller |A la carpeta compartida **taller** y a la carpeta **publica**|

## Procedimiento para resolver el ejercicio

**En GNU/Linux**

1. [Instalando Samba](instalacion.md)
2. [Creando usuarios](gestionUsuarios/#creacion-de-usuarios-en-gnulinux)
3. [Creando grupos](gestionUsuarios/#creacion-de-grupos-en-gnulinux)
4. [Agregando usuarios a los grupos](gestionUsuarios/#agregando-usuarios-a-un-grupo-en-gnulinux)
5. [Agresando usuarios a Samba](gestionUsuarios/#agregando-usuarios-al-servidor-samba)
6. [Creando carpetas](comparticionGrupo/#creando-la-carpeta-a-compartir)
7. [Cambiando el usuario y grupo dueño de la carpeta](comparticionGrupo/#modificando-el-usuario-y-grupo-propietario-de-la-carpeta)
8. [Cambiando los permisos de las carpeta](comparticionGrupo/#modificando-los-permisos-de-la-carpeta)
9. [Configuración de Samba para carpeta grupal](comparticionGrupo/#modificando-el-archivo-de-configuracion-de-samba)
10. [Configuración de Samba para carpeta anónima](comparticionInvitados.md)
11. [Reiniciando el servidor Samba](comparticionGrupo/#reiniciando-el-servidor)

**En Windows**

12. [Creando usuarios](gestionUsuarios/#creacion-de-usuario-en-windows-7)
13. [Verfificando carpetas compartidas](clientesWindows.md)