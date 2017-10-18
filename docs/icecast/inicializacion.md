El servidor icecast viene deshabilitado por defecto, aunque lo hayamos instalado. Una vez instalado, para ponerlo a funcionar debemos editar el archivo ''/etc/default/icecast2''. Es decir: 

```bash
sudo nano /etc/default/icecast2
```

Y luego, al pie del arcivo, modificamos el valor de la variable ENABLE, que por defecto es `false` a `true`. Debe quedarnos así:

```bash
ENABLE=true
```

##Reiniciando el servidor


Para que los cambios efectuados tengan efecto, tendremos que reiniciar el servidor: 

```bash
service icecast2 restart
```
Y comprobar, finalmente, el estado actual del servidor: 

```bash
service icecast2 status
```