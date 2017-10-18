Para verificar puerto de NSClient++ abierto: 

netstat -an | findstr 12489

Para abrir los puertos del firewall en Wnidows:

netsh advfirewall firewall add rule name="NSClient UPD" dir=in action=allow protocol=UDP localport=12489

netsh advfirewall firewall add rule name="NSClient UPD" dir=out action=allow protocol=UDP localport=12489

netsh advfirewall firewall add rule name="NSClient TCP" dir=out action=allow protocol=TCP localport=12489

netsh advfirewall firewall add rule name="NSClient TCP" dir=in action=allow protocol=TCP localport=12489 (editado)

NSCLIENT USA TCP

Si al cargar los módulos NSClient++ obtenemos un error, debemos agregar al archivo nsclient.ini

[/settings/NSClient/server]
port = 12489
