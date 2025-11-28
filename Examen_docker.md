Bloque 1 Gestión básica de imágenes y contenedores 

- Muestra las imágenes que tienes actualmente en tu sistema Docker.

docker images

- Descarga la imagen oficial de MySQL desde Docker Hub.

docker pull mysql

- Muestra todas las imágenes disponibles de nuevo para comprobar que la imagen de MySQL se ha descargado.

docker images

- Muestra todos los contenedores en ejecución.

docker ps

- Muestra todos los contenedores, incluyendo los detenidos.

docker -ps a

Bloque 2 Volúmenes y contenedores

- Crea un volumen llamado mysql_data.

docker volume create mysql_data

- Muestra todos los volúmenes disponibles en tu sistema.

docker volume ls

- Arranca un contenedor llamado mibasedatos usando la imagen mysql, montando el volumen mysql_data en /var/lib/mysql, y definiendo las variables de entorno:

docker run -d --name mibasedatos \ 
-v mysql_data:/var/lib/mysql \ 
-e MYSQL_ROOT_PASSWORD=admin123 \ 
-e MYSQL_DATABASE=tienda \ 
mysql  

- Comprueba que el contenedor está corriendo.

docker ps

- Accede al contenedor con una terminal interactiva bash.

docker exec -it mibasedatos bash

- Sal de la terminal sin detener el contenedor.

exit

- Detén el contenedor.

docker stop mibasedatos

- Elimina el contenedor.

docker rm mibasedatos

Bloque 3 Creación de imágenes personalizadas 

- Crea un directorio llamado miimagen.

mkdir miimagen
cd miimagen

- Dentro de ese directorio, crea un archivo Dockerfile que:
    . Use ubuntu:latest como base.
    . Instale curl y vim.
    . Establezca /app como directorio de trabajo.
    . Copie un archivo index.html local a /app.
    . Ejecute bash por defecto.
   

cd miimagen 
cat > Dockerfile << 'EOF'         
FROM ubuntu:latest 
RUN apt-get update && apt-get install -y curl vim && rm -rf /var/lib/apt/lists/* 
WORKDIR /app 
COPY index.html /app 
CMD ["bash"] 
EOF 

- Construye la imagen con el nombre mialumno/ubuntu_custom:1.0.

docker build -t mialumno/ubuntu_custom:1.0 .

- Muestra todas las imágenes y comprueba que la nueva aparece.

docker images

Bloque 4 Publicación en Docker Hub 
- Inicia sesión en Docker Hub desde la terminal.

docker login

- Sube la imagen mialumno/ubuntu_custom:1.0 a tu cuenta de Docker Hub.

docker push mialumno/ubuntu_custom:1.0

- Comprueba que la subida ha sido correcta listando tus imágenes locales

docker image

BONUS (0,5 puntos extra)
- Muestra el tamaño total ocupado por tus imágenes y contenedores.

docker system df

- Elimina todas las imágenes y contenedores que no estén en uso.

docker system prune -a 
