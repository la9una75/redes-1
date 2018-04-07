# Gestionando las conexiones

Ansible tiene en cuenta dos tipos de equipos: **servidor** y **nodos**. En el primero se instalará y gestionará Ansible y los nodos serán los equipos a ser administrados por la herramienta. 



##Definiendo nodos
Antes de comenzar a emplear Ansible, conviene definir los nodos que gestionaremos en el archivo `hosts`. Para ello, abriremos el archivo en cuestión: 

```bash 
sudo vim /etc/ansible/hosts
```
Y agregaremos, empleando una linea para cada uno de ellos, los nodos a gestionar. Cabe aclarar que podremos emplear nombres de hosts o direcciones IP: 

```bash
# Máquina local, donde se ejecuta Ansible
localhost ansible_connection=local
# Dirección IP del nodo X
192.168.0.111
# Nombre de dominio del nodo Y
otroservidor.com
```


## Tipos de conexiones

Existen dos tipos de conexiones permitidas por Ansible: 

1. Conexión local 
2. Conexión remota (SSH por defecto), mediante el uso de claves de cifrado


La sintaxis general para comprobar una conexión es: 

```bash
sudo ansible servidor|grupo|all -m ping
```
### 1. Conexión local (localhost)
Empleado para realizar pruebas, es la conexión que realiza el servidor con sí mismo. Cabe aclarar que `localhost` debe estar definido con conexión local en el archivo `hosts`,  mediante la directiva `ansible_connection=local` según se explicó mas arriba, en la definición de los nodos. 

Luego, para realizar la prueba de conectividad ejecutamos:

```bash
sudo ansible localhost -m ping
```

### 2. Conexión remota
Este tipo de conexión es el que se establece entre el servidor y los nodos, estén estos últimos en la misma red que el servidor o en una remota. 

Para ello, tendremos que realizar dos pasos preliminares: 

1. Definir en el servidor los usuarios que tendrán acceso a los nodos
2. Generar la clave pública en el servidor y copiarla a los nodos 

#### 2.1. Definiendo usuarios de conexión
Para que el servidor pueda establecer conexión con los nodos, tendremos que especificar con que usuario (uno para cada nodo) tendrá que hacerlo. Es importante destacar que dichos usuarios deben existir en los nodos. 

Simplemente, tendremos que editar el archivo `/etc/ansible/hosts` y agregar la información correspondiente: 

```bash
# Máquina local, donde se ejecuta Ansible
localhost ansible_connection=local ansible_user=juan
# Dirección IP del nodo X
192.168.0.111 ansible_user=pedro
# Nombre de dominio del nodo Y
otroservidor.com ansible_user=lucas
```

#### 2.2. Definiendo claves SSH
Adicionalmete, para que el server pueda establecer conexión con los nodos, éstos deben poseer registrada la clave pública del servidor. 

##### Generando claves en el servidor
Para generar las claves SSH, ejecutamos en el servidor: 

```
sudo ssh-keygen
```
Y luego presionar la tecla  _Enter_ ante cada pregunta. El comando nos generará la clave pública y la clave privada necesarias para la conexión al servidor. 

Si al momento de generar las claves, hemos dejado las opciones por defecto, las mismas se crearán en el directorio `/root/.ssh`:

```bash
/root/.ssh/
├── id_rsa
└── id_rsa.pub
```

Donde `id_rsa` es la clave privada y `id_rsa.pub` es la clave pública. 

##### Configurando los nodos con la clave pública del servidor 
Luego, tendremos que copiar el contenido del archivo `id_rsa.pub` dentro del archivo `authorized_keys` ubicado en la carpeta del usuario de los clientes. 

Por ejemplo, para un usuario llamado **raul**, el archivo `authorized_keys` se encuentra en `/home/raul/.ssh/authorized_keys`

#### Comprobando conectividad con los nodos

Una vez realizados los pasos anteriores, nos ubicamos en el servidor y ejecutamos: 

```bash
sudo ansible all -m ping 
```
Otra manera de comprobar conectividad con un nodo sin necesidad de especificar el usuario en el archivo `/etc/ansible/hosts`: 

```bash
sudo ansible SERVIDOR -u USUARIO -m ping
```
Donde `SERVIDOR` corresponde al nombre de dominio o dirección IP del nodo a administrar y `USUARIO` al nombre de usuario existente en el nodo en cuestión. 

## Ejecutando comandos en los nodos
Mediante Ansible, es posible ejecutar tareas en lo nodos de manera simulanea. Por ejemplo: 

```bash
sudo ansible all -a "ls -l"
```


