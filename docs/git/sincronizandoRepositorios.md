Hasta aquí hemos visto como trabajar en nuestro servidor local y como configurar nuestro servidor remoto. 

Sin embargo, no hemos visto como sincronizar nuestro repositorio local con un repositorio remoto. 


#### 6. Vinculamos el repositorio local con el repositorio remoto
```bash
git remote add origin usuario@192.168.0.200:/home/usuario/miRepositorio.git
```
Donde tendremos que reemplazar `usuario` por nuestro nombre de usuario en el servidor y `192.168.0.200` por la dirección IP de nuestro servidor. Por último tendremos que cambiar `/home/usuario/miRepositorio.git` por la ruta de donde se ubica nuestro repositorio en el servidor.



#### 7. Sincronizamos nuestros archivos
Para que los cambios realizados en los archivos de manera local se sincronicen con el servidor remoto tendremos que ejecutar: 

```bash
git push origin master
```