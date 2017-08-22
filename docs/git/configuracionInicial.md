Antes de comenzar a usar Git es necesario realizar algunas configuraciones previas relacionadas con información del usuario que ejecutará el sistema de control de versiones. 

!!!tip "Configuración del entorno"
		Los pasos que se describen en esta sesión sólo deben realizarse **una sola vez** en tu computadora y se mantendrán siempre, aunque es posible modificar la información en cualquier momento, volviendo a ejecutar los comandos correspondientes.

###Tu Identidad
Lo primero que deberás hacer cuando instales Git es establecer tu nombre de usuario y dirección de correo electrónico. Esto es importante porque los "commits" de Git usan esta información, y es introducida de manera inmutable en los commits que envías. 

Para _setear_ tu nombre: 

```bash
git config --global user.name "Tu nombre"
```
Y hacer lo propio con tu dirección de correo electrónico: 

```bash
git config --global user.email tuemail@ejemplo.com
```

###Comprobando tu configuración
Podés comprobar qué valor utilizará Git para una clave específica ejecutando `git config <key>`:

```bash
$ git config user.name
```
Donde `<key>` es el valor que de la configuración que deseas consultar. 


Pero si querés comprobar toda tu configuración, podés usar el siguiente comando:

```bash
git config --list
```

!!!tip "Ayuda sobre Git"
		Es posible consultar desde la terminal ayuda sobre los comandos empleados por git. Para ello, ejecutamos: 

		`git help <comando>`


