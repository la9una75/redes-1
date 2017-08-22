Como se mencionó con anterioridad, la mayoría de las acciones de Git se efectúan de manera local, en la máquina del cliente. Sin embargo, podemos **sincronizar los archivos de nuestro repositorio local con un repositorio remoto**. Para ello debemos agregar la dirección del servidor o ubicación física (si se trata de un repositorio local) del repositorio con el cual deseamos sincronizar nuestro repositorio. 

Podemos encontrarnos frente a dos situaciones: 

a. Hemos creado nuestro **repositorio local "desde cero"** y deseamos vincularlo con un repositorio remoto. En ese caso, necesariamente tendremos que seguir los pasos descriptos en esta guía. 

b. Nos encontramos trabajando localmente sobre un **repositorio que hemos clonado** desde un repositorio remoto. En ese caso, nuestro repositorio local ya poseerá un origen remoto (que será la dirección del repositorio remoto que clonamos en nuestra computadora). No obstante, de manera opcional, podemos agregarle otros origenes remotos con los que deseemos sincronizar, siguiendo los pasos descriptos en esta guía.


## 1. Agregando un origen remoto

Si quisieramos **sincronizar nuestro repositorio local con un repositorio remoto**, primero deberíamos agregar el origen remoto, es decir, la dirección del servidor remoto con el que deseamos sincronizar nuestros archivos. Cabe aclarar que para poder realizar esta acción el administrador del repositorio remoto debe habernos otorgados los permisos correspondientes. 

La sintaxis general para realizar esta acción es: 

```bash
git remote add [nombre] [url]
```
Donde:

* `[nombre]` Es el nombre del origen remoto (comunmente _origin_ aunque puede ser cualquier otro)
* `[url]` Es la dirección URL o ruta hacia el repositorio remoto que deseamos vincular

#### 1.1. Agregando repositorio remoto [SSH]
```bash
git remote add origin usuario@192.168.0.200:/home/usuario/miRepositorio.git
```
Donde:

* `usuario` es el nombre de usuario en el servidor remoto.
* `192.168.0.200` el la dirección IP (o nombre de dominio) del servidor remoto. 
* `/home/usuario/miRepositorio.git` es la ruta donde se ubica el repositorio en el servidor remoto.

#### 1.2. Agregando repositorio remoto [HTTPS]
```bash
git remote add origin https://github.com/usuario/repositorio.git
```
Donde:

* `https://github.com` el el nombre de dominio del servidor remoto.
* `usuario` es el nombre de usuario en el servidor remoto.
* `repositorio.git` es el nombre repositorio en el servidor remoto.

