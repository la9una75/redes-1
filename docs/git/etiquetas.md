# Etiquetado
Git tiene la posibilidad de etiquetar puntos específicos del historial como importantes. Esta funcionalidad se usa típicamente para marcar versiones de lanzamiento (v1.0, por ejemplo). En esta sección, aprenderás cómo listar las etiquetas disponibles, cómo crear nuevas etiquetas y cuáles son los distintos tipos de etiquetas.

## Creando Etiquetas

Git utiliza dos tipos principales de etiquetas: **ligeras** y **anotadas**.

Una **etiqueta ligera** es muy parecido a una rama que no cambia - simplemente es un puntero a un commit específico.

Sin embargo, las **etiquetas anotadas** se guardan en la base de datos de Git como objetos enteros. Tienen un checksum; contienen el nombre del etiquetador, correo electrónico y fecha; tienen un mensaje asociado; y pueden ser firmadas y verificadas con GNU Privacy Guard (GPG). 


###Etiquetas Anotadas

Crear una etiqueta anotada en Git es sencillo, utilizando la opción `-a` cuando ejecutamos el comando `tag`:

```bash
git tag -a [nombreDeEtiqueta] -m 'Mensaje asociado a la etiqueta'
```

Por ejemplo: 

```bash
git tag -a v1.2 -m 'Nueva versión multiusuario'
```

La opción `-m` especifica el mensaje de la etiqueta, el cual es guardado junto con ella. Si no especificás el mensaje de una etiqueta anotada, Git abrirá el editor de texto para que lo escribas.

### Etiquetas Ligeras
La otra forma de etiquetar un `commit` es mediante una etiqueta ligera. Una etiqueta ligera no es más que el [_checksum_](https://es.wikipedia.org/wiki/Suma_de_verificaci%C3%B3n) de un `commit` guardado en un archivo - no incluye más información. Para crear una etiqueta ligera ejecutamos:

```bash
git tag [nombreDeEtiqueta]
```
Por ejemplo: 

```bash
git tag v1.0.2
```

### Etiquetado Tardío

También podés etiquetar `commits` mucho tiempo después de haberlos hecho. Para ello, tendremos que ejecutar el siguiente comando: 

```bash
git tag -a [nombreDeEtiqueta] [numeroHashAbreviado]
```
Donde podremos obtener el _hash_ abreviado de un `commit` ejecutando: 

```bash
git log --oneline
``` 

De esta manera, un ejemplo de etiquetado tardío sería: 

```bash
git tag -a v1.5 9fceb02
``` 

## Visualizando etiquetas
Git dispone de comandos para visualizar las etiquetas creadas así como la información asociada a alguna de ellas en espcial. 

### Listando etiquetas

Para ver la lista de las etiquetas creadas, ejecutaremos el comando `tag`:

```bash
git tag
```

También podemos listar todas las etiquetas que cumplan con un patrón de búsqueda determinado, con la opcion `-l`: 

```bash
git tag l- [patronDeBusqueda]
```

Por ejemplo: 

```bash
git tag l- v1.8
```

Listará todas las etiquetas que comiencen con dicho patrón de búsqueda, como v1.8.1, v1.8.0.2, etc. 

### Mostrando información de una etiqueta específica
Para ver la información de una etiqueta específica, sea anotada o ligera (la primera arrojará más información):

```bash
git show [nombreDeEtiqueta]
```
Por ejemplo: 

```bash
git show v1.4
```

## Compartiendo etiquetas

Por defecto, el comando `git push` no transfiere las etiquetas a los servidores remotos. Es necesario enviar las etiquetas de forma explícita al servidor luego de que las hayas creado. Este proceso es similar al de compartir ramas remotas:

```bash
git push [nombreRepositorioRemoto] [nombreDeEtiqueta] [rama]
```

Por ejemplo: 

```bash
git push origin v1.4 master
```

Si queremos enviar varias etiquetas a la vez, podemos usar la opción `--tags` del comando `git push`. Esto enviará al servidor remoto todas las etiquetas que aun no existen en él.

```bash
git push [nombreRepositorioRemoto] --tags [rama]
```

Por ejemplo: 

```bash
git push origin --tags master
```

A partir de ahora, cuando alguien clone o traiga información de tu repositorio, también obtendrá todas las etiquetas.
