Para instalar la versión estable de Ansible en Ubuntu y distribuciones derivadas, ejecutamos:

```bash
sudo apt install ansible
```

Si deseamos tener la última versión de Ansible, podremos agregar los repositorios oficiales mediante [PPA](https://es.wikipedia.org/wiki/Archivo_de_Paquete_Personal):

```bash
sudo apt-get install software-properties-common -y \
&& sudo apt-add-repository ppa:ansible/ansible -y \
&& sudo apt-get update \
&& sudo apt-get install ansible -y
```
No obstante, para conocer modos de instalación para diferentes sistemas operativos, es conveniente consultar la [documentación oficial](https://docs.ansible.com/ansible/latest/intro_installation.html). 

## Directorio y archivos de configuración
Una vez instalada la herramienta, se creará el directorio de la misma con sus archivos de configuración: 

```bash
/etc/ansible/
├── ansible.cfg
└── hosts

```

Ambos archivos son de consiguración: `ansible.cfg` permite la configuración de la herramienta en sí, y archivo `hosts` se emplea para configurar la interacción con los clientes a administrar. 