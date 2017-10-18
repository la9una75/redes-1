## Configurando las GNU/Linux con el proxy del colegio

Para congifurar el servidor proxy del instituto en las máquinas virtuales seguir lo siguientes pasos: 

## 1. Crear un nuevo archivo 

```bash
vim script.sh
```
## 2. Incluir el contenido del script dentro del archivo

```apache

#!/bin/bash

# Configura el proxy en sistemas basados en Debian
#
# Si el el servidor proxy requiere inicio de sesión, sustituir: 
# "http://yourproxyaddress:proxyport";
# con
# "http://username:password@yourproxyaddress:proxyport";
#
# TW @la9una

# Verifica que el usuario sea root
if [ "$EUID" -ne 0 ]
  then echo "Por favor, ejecuta el script como root"
  exit
fi

# Proxy en las variables de entorno
echo "Configurando el servidor Proxy en las variables de entorno"
sleep 1

echo "
http_proxy=192.168.0.250:3128
https_proxy=192.168.0.250:3128
ftp_proxy=192.168.0.250:3128
" >> /etc/environment

echo "[OK]"

# Proxy para apt
echo "Configurando el servidor Proxy para el gestor de paquetes"
sleep 1

echo "
Acquire::http::Proxy "http://192.168.0.250:3128/";
Acquire::https::Proxy "http://192.168.0.250:3128/";
Acquire::ftp::Proxy "http://192.168.0.250:3128/";
" >> /etc/apt/apt.conf

echo "[OK]"

# Proxy para Bash
echo "Configurando el servidor Proxy en Bash"
sleep 1

echo "
export http_proxy=http://192.168.0.250:3128/
export https_proxy=http://192.168.0.250:3128/
export ftp_proxy=http://192.168.0.250:3128/
" >> /etc/bash.bashrc

echo "[OK]"

sleep 1
echo "=> El proxy fue configurado con exitosamente en el equipo"
echo "=> (Ojalá funcione) :|"

```

### 3. Modificar los permisos del script

```bash
chmod a+x script
```

### 4. Ejecutar el script (como root)


```bash
sh sript 
```

Una vez finalizada la ejecucción del script, debería las máquinas virtuales deberían quedar configuradas con el proxy escolar. 