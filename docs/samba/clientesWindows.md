Si todo quedó correctamente configurado, podremos acceder a los recursos compartidos por el servidor Samba desde una máquina con el sistema Windows.

## Accediendo a las carpetas compartidas de manera temporal

Para ello, tendremos que abrir con el explorador de Windows la dirección IP del servidor Samba (**usar barra invertida \**), de la siguiente manera: 

![Samba Windows 1](imgSamba/sambawindows1.png)

!!!note 
		El acceso a las carpetas compartidas **no es permanente y se perderá cuando reiniciemos la maquina Windows**. Para que los recursos compartidos estén disponibles cuando inicie el sistema, seguí las instrucciones que se detallan a continuación.
 
## Accediendo a las carpetas compartidas de forma permanente

Abrimos el **Explorador de Windows** y hacemos clic derecho en **Equipo** y seleccionaremos la opción "Conectar a una unidad de red" 

![Samba Windows 2](imgSamba/sambawindows2.png)

Luego ingresamos la **dirección IP** o el **nombre del dominio** del servidor Samba seguido del nombre del **nombre de la carpeta compartida** que queremos montar (usar barras invertidas):

![Samba Windows 3](imgSamba/sambawindows3.png)

Finalmente veremos la carpeta compartida y que estará disponible cada vez que iniciemos sesión:

![Samba Windows 4](imgSamba/sambawindows4.png)

Repetiremos el procedimiento con cada carpeta alojada en servidor Samba a la que deseemos acceder y para la cual poseamos los permisos de lectura y escritura correspondientes:

![Samba Windows 5](imgSamba/sambawindows5.png)

Nota: en el ejemplo, se inició sesión en Windows con el usuario de Samba/Windows llamado **prueba**. La unidad de red con su nombre pertenece a dicho usuaruio. 