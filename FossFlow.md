Comandos que podrían servirte para Docker

1. Actualizamos el servidor con:
   
  sudo apt update && sudo apt upgrade -y
  
2. Instalamos Git con:
   
 sudo apt install git -y

Y verificamos con:

  git --version

3. Instalamos Node.js LTS y npm
Recomendado usar NodeSource:

  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - sudo apt install -y nodejs

Verificamos con:

  node -v
  npm -v
  
4. Clonamos el repositorio FossFLOW

  git clone https://github.com/stan-smith/FossFLOW.git cd FossFLOW
  cd FossFLOW
  
5. Instalamos dependencias del proyecto
   
  npm install
  
6. Construir el proyecto
   
  npm run build:lib
  
7. Ejecutamos la aplicación
La versión de desarrollo suele ser:

  npm run dev
  
El servidor quedará escuchando en:

  http://localhost:3000
  
En su PC local: IN

  ssh -L 3000:localhost:3000 usuario@IP_DEL_SERVIDOR
  
Luego abrir en su navegador local:

  http://localhost:3000


Ejecución usando Docker (opcional)

Si se utilizó Docker:

  docker --version
  docker-compose --version

Comandos usados:

  docker-compose build
  docker-compose up

URL de acceso:

  http://localhost:3000
