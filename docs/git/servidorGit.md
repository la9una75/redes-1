

Existen varias opciones para obtener un repositorio Git remoto y ponerlo a funcionar para que puedas colaborar con otras personas o compartir tu trabajo. En líneas generales se tratará de un servidor propio o de uno hospedado por terceros.

* Mantener **tu propio servidor** te da control y te permite correr tu servidor dentro de tu propio cortafuegos, pero tal servidor generalmente requiere una importante cantidad de tu tiempo para configurar y mantener. 

* Si almacenas tus datos en un **servidor hospedado**, es fácil de configurar y mantener; sin embargo, tienes que ser capaz de mantener tu código en los servidores de alguien más, y algunas organizaciones no te lo permitirán.

En cualquier caso, es preciso determinar que solución o combinación de soluciones es apropiada para nosotros y la empresa.


#### 1. Nos dirigimos a nuestro directorio home 
```bash
cd
```
#### 2. Creamos la carpeta que alojará el repositorio
Creamos el directorio: 

```bash
mkdir miRepositorio.git
```
E ingresamos en él:

```bash
cd miRepositorio.git
```
#### 3. Inicializamos un repositorio vacío

```bash
git init --bare
```

#### 4. Permitimos que el repositorio sea compartido
```bash
git config core.sharedRepository true
```



