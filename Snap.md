Instalamos Wekan mediante Snap. Esto lo instala automáticamente

  sudo snap install wekan

  Instalamos el wekan con
  sudo snap install wekan

Elegimos el puerto 

 sudo snap set wekan port='3001'
 snap set wekan root_url="http://IP-DEL-SERVIDOR:3001"

Reiniciamos servicios con

  sudo systemctl restart snap.wekan.mongodb
  sudo systemctl restart snap.wekan.wekan


Comprobamos que está bien

Y lo comprobamos desde la web con 

  http://IP:3001
