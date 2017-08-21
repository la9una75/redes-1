Como se mencionó con anterioridad, la mayoría de las acciones de Git se efectúan de manera local, en la máquina del cliente. Sin embargo, podemos **sincronizar los archivos de nuestro repositorio local con un repositorio remoto**.

Si estamos trabajando sobre un repositorio que hemos clonado desde un repositorio remoto, podremos realizar tareas de sincronización con éste. Si hemos inicializado nuestro propio repositorio local antes tendremos que agregar uno o varios orígenes remotos.


## Agregando un origen remoto

Si quisieramos **sincronizar nuestro repositorio local con un repositorio remoto**, primero deberíamos agregar el origen remoto, es decir, la dirección del servidor remoto con el que deseamos sincronizar nuestros archivos. Cabe aclarar que para poder realizar esta acción el administrador del repositorio remoto debe habernos otorgados los permisos correspondientes. 

La sintaxis general para realizar esta acción es: 

```bash
git remote add [nombre] [url]
```
Donde:

* `[nombre]` Es el nombre del origen remoto (comunmente _origin_ aunque puede ser cualquier otro)
* `[url]` Es la dirección URL o ruta hacia el repositorio remoto que deseamos vincular

#### Agregando repositorio remoto [SSH]
```bash
git remote add origin usuario@192.168.0.200:/home/usuario/miRepositorio.git
```
Donde:

* `usuario` es el nombre de usuario en el servidor remoto.
* `192.168.0.200` el la dirección IP (o nombre de dominio) del servidor remoto. 
* `/home/usuario/miRepositorio.git` es la ruta donde se ubica el repositorio en el servidor remoto.

#### Agregando repositorio remoto [HTTPS]
```bash
git remote add origin https://github.com/usuario/repositorio.git
```
Donde:

* `https://github.com` el el nombre de dominio del servidor remoto.
* `usuario` es el nombre de usuario en el servidor remoto.
* `repositorio.git` es el nombre repositorio en el servidor remoto.

