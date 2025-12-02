## RETO 1:
	Creación y ejecución del contenedor ubuntu:
		docker run -it --name reto-ubuntu ubuntu:latest
	Dentro del contenedor:
		- Lo primero será actualizar el sistema:
			apt update && apt upgrade -y
		- Instalación de Python:
			 apt install python3 -y
		- Instalación de librerías:
			 apt install python3-pip -y
			 apt install python3-requests -y
		- Para MySQL:
			 apt install mysql-client -y
			 apt install python3-mysql.connector -y
			 apt install python3-mysqldb -y
	Creación de una imagen personalizada con el contenedor:
		- Definimos la carpeta en el contenedor, para asociarla luego al hacer un volumen Bind:
			Para ello vamos a:
				cd /home/ubuntu
			Creamos una carpeta llamada python:
				mkdir python
				cd python
			Fuera del contenedor, creamos la imagen personalizada para poder crear contenedores con esta configuracion:
				docker commit reto-ubuntu mi-imagen-personalizada

## RETO 2:
	Desde terminal, en Ubuntu, ya que es el sistema operativo que tengo en mi host:
		Creación y ejecución de un nuevo contenedor con la imagen creada:
			docker run --name  reto_ubuntu_python -it -v /home/diego1109/volumenes/reto_ubuntu:/home/ubuntu/python mi-imagen-personalizada:latest

## RETO 3:
	Desde el contenedor:
		Una vez dentro del contenedor, vamos a la carpeta python:
			cd /home/ubuntu/python
		Creamos un documento y escribimos algo dentro de él:
			touch hola.txt
			echo "Hola Mundo" > hola.txt
		Subimos al repositorio de GitHub:
			Para ello, lo primero será instalar GIT:
				apt install git -y
			Configuracion de GIT:
				git config --global user.email "17diego10fer@gmail.com"
				git config --global user.name "dieego-17"
				git config --global --add safe.directory /home/ubuntu/python
				git init
				git add hola.txt
				git commit -m "Archivo contenedor ubuntu"
				git branch -M main
				git remote add origin https://github.com/dieego-17/reto2_mi_vida_en_un_contenedor.git
				git push -u origin main

## RETO 4:
	Desde la terminal:
		Creación y ejecución del contendor mysql:
			docker run --name mysql_server -d \
			  -e MYSQL_ROOT_PASSWORD=Abcd1234 \
			  -e MYSQL_DATABASE=bdcoches \
			  -p 3307:3306 \
			  -v mysql_data:/var/lib/mysql \
			  mysql:latest
		Accedemos al contenedor:
			docker exec -it mysql_server bash
			mysql -u root -p
			Una vez dentro:
				- Creamos la tabla COCHES en nuestra base de datos (mi_base_datos):
					CREATE TABLE coches(
						id INT PRIMARY KEY,
						 marca VARCHAR(20),
						 modelo VARCHAR(20),
						 color VARCHAR(15),
						 km INT,
						 precio INT);
				- Añadimos 10 registros:
					INSERT INTO coches (id, marca, modelo, color, km, precio) VALUES
						(1, 'Toyota', 'Corolla', 'Blanco', 50000, 15000),
						(2, 'Honda', 'Civic', 'Negro', 30000, 18000),
						(3, 'Ford', 'Focus', 'Azul', 40000, 14000),
						(4, 'Chevrolet', 'Cruze', 'Rojo', 60000, 13000),
						(5, 'Nissan', 'Sentra', 'Gris', 20000, 17000),
						(6, 'Volkswagen', 'Golf', 'Blanco', 45000, 16000),
						(7, 'Hyundai', 'Elantra', 'Azul', 35000, 15500),
						(8, 'Kia', 'Rio', 'Negro', 25000, 14500),
						(9, 'Renault', 'Megane', 'Rojo', 55000, 13500),
						(10, 'Mazda', '3', 'Gris', 30000, 16500);

## RETO 5:
	Para que puedan verse los contenedores, creamos una red personalizada:
		docker network create mi-red-app
	Lanzamos un contenedor mysql, conectándolo a la red:
			docker run -d \
			  --name mi-db-sql \
			  --network mi-red-app \
			  -e MYSQL_ROOT_PASSWORD=Abcd1234 \
			  -e MYSQL_DATABASE=bdcoches \
			  mysql:latest
		Creamos la tabla y le insertamos los datos, como en el reto anterior.
	Creamos un directorio donde tendremos dos archivos:
		1. consulta_db.py
		2. Dockerfile
	Construimos una imagen:
		docker build -t mi-app-python .
	Ejecutamos el contenedor:
		docker run --rm --name mi-app-python --network mi-red-app mi-app-python
	Nos mostrará por pantalla la tabla de los registros de la base de datos:
		*** 🚗 Registros de la tabla 'coches' 🚗 ***
		+----+------------+---------+--------+-------+--------+
		| id |   marca    |  modelo | color  |   km  | precio |
		+----+------------+---------+--------+-------+--------+
		| 1  |   Toyota   | Corolla | Blanco | 50000 | 15000  |
		| 2  |   Honda    |  Civic  | Negro  | 30000 | 18000  |
		| 3  |    Ford    |  Focus  |  Azul  | 40000 | 14000  |
		| 4  | Chevrolet  |  Cruze  |  Rojo  | 60000 | 13000  |
		| 5  |   Nissan   |  Sentra |  Gris  | 20000 | 17000  |
		| 6  | Volkswagen |   Golf  | Blanco | 45000 | 16000  |
		| 7  |  Hyundai   | Elantra |  Azul  | 35000 | 15500  |
		| 8  |    Kia     |   Rio   | Negro  | 25000 | 14500  |
		| 9  |  Renault   |  Megane |  Rojo  | 55000 | 13500  |
		| 10 |   Mazda    |    3    |  Gris  | 30000 | 16500  |
		+----+------------+---------+--------+-------+--------+

## RETO 6:
	Desde el directorio donde hemos creado el Dockerfile, creamos dos archivos nuevos:
		- .gitignore
		- db_config.json
	Modificamos consulta_db.py, para que apunte a db_config.json.
	Reconstruimos la imagen:
		docker build -t mi-app-python .
	Añadimos esta linea al Dockerfile:
		COPY db_config.json /app/
	Lanzamos el contenedor:
		docker run --rm --name mi-app-python --network mi-red-app mi-app-python
	Nos mostrará la tabla de antes.

## RETO 7:
	Modificamos el archivo consulta_db.py, para que use la libreria prettytable.
	Reconstruimos la imagen:
		docker build -t mi-app-python .
	Lanzamos el contenedor:
		docker run --rm --name mi-app-python --network mi-red-app mi-app-python
	Nos mostrará la tabla así:
		✅ Conexión establecida correctamente a la BD.

	*** 🚗 Registros de la tabla 'coches' 🚗 ***
	+----+------------+---------+--------+-------------+--------+
	| ID | Marca      | Modelo  | Color  | Kilometraje | Precio |
	+----+------------+---------+--------+-------------+--------+
	| 1  | Toyota     | Corolla | Blanco | 50000       | 15000  |
	+----+------------+---------+--------+-------------+--------+
	| 2  | Honda      | Civic   | Negro  | 30000       | 18000  |
	+----+------------+---------+--------+-------------+--------+
	| 3  | Ford       | Focus   | Azul   | 40000       | 14000  |
	+----+------------+---------+--------+-------------+--------+
	| 4  | Chevrolet  | Cruze   | Rojo   | 60000       | 13000  |
	+----+------------+---------+--------+-------------+--------+
	| 5  | Nissan     | Sentra  | Gris   | 20000       | 17000  |
	+----+------------+---------+--------+-------------+--------+
	| 6  | Volkswagen | Golf    | Blanco | 45000       | 16000  |
	+----+------------+---------+--------+-------------+--------+
	| 7  | Hyundai    | Elantra | Azul   | 35000       | 15500  |
	+----+------------+---------+--------+-------------+--------+
	| 8  | Kia        | Rio     | Negro  | 25000       | 14500  |
	+----+------------+---------+--------+-------------+--------+
	| 9  | Renault    | Megane  | Rojo   | 55000       | 13500  |
	+----+------------+---------+--------+-------------+--------+
	| 10 | Mazda      | 3       | Gris   | 30000       | 16500  |
	+----+------------+---------+--------+-------------+--------+

## RETO 8:
	Creamos el contenedor mongo en el mismo directorio que hemos usando para los retos anteriores:
		docker run -d \
			  --name mi-mongo \
			  --network mi-red-app \
			  -p 27017:27017 \
			  -e MONGO_INITDB_ROOT_USERNAME=mongouser \
			  -e MONGO_INITDB_ROOT_PASSWORD=mongo1234 \
			  mongo:latest
	Accedemos al contenedor:
		docker exec -it mi-mongo mongosh -u mongouser -p mongo1234 --authenticationDatabase admin
		Usamos estos comandos:
			use bdcoches_mongo
		Añadimos registros:
			db.coches.insertMany([
				  {
				    "ID": 1,
				    "Marca": "Toyota",
				    "Modelo": "Corolla",
				    "Color": "Rojo",
				    "km": 25000,
				    "Precio": 15000
				  },
				  {
				    "ID": 2,
				    "Marca": "Honda",
				    "Modelo": "Civic",
				    "Color": "Azul",
				    "km": 30000,
				    "Precio": 18000
				  },
				  {
				    "ID": 3,
				    "Marca": "Ford",
				    "Modelo": "Focus",
				    "Color": "Blanco",
				    "km": 40000,
				    "Precio": 17000
				  }
				])
		Creamos un documento: consulta_mongo.py
		Actualizamos el Dockerfile.
		Construimos la imagen y lo lanzamos:
			docker build -t mi-mongo .
			docker run --rm --name mi-mongo1 --network mi-red-app mi-mongo
		Visualizamos la tabla:
			 Conexión establecida a MongoDB.
			***  Registros de la colección 'coches' (MongoDB)  ***
			+----+--------+---------+--------+-------------+--------+
			| ID | Marca  | Modelo  | Color  | Kilometraje | Precio |
			+----+--------+---------+--------+-------------+--------+
			| 1  | Toyota | Corolla | Rojo   | 25000       | 15000  |
			+----+--------+---------+--------+-------------+--------+
			| 2  | Honda  | Civic   | Azul   | 30000       | 18000  |
			+----+--------+---------+--------+-------------+--------+
			| 3  | Ford   | Focus   | Blanco | 40000       | 17000  |
			+----+--------+---------+--------+-------------+--------+

## RETO 9:
	En un nuevo directorio llamado reto9, crearemos:
		Dockerfile
		init-mongo.js
	Accedemos a DockerHub:
		docker login
	Construimos la imagen:
		docker build -t <TU_USUARIO_DOCKERHUB>/mongo-coches:latest .
	Subimos la imagen:
		docker push <TU_USUARIO_DOCKERHUB>/mongo-coches:latest
	Accedemos a nuestro ParrotOS:
		Lanzamos la imagen:
			docker run -d \
			  --name mongo-desde-hub \
			  -e MONGO_INITDB_ROOT_USERNAME=mongouser \
			  -e MONGO_INITDB_ROOT_PASSWORD=mongo1234 \
			  -p 27017:27017 \
			  <TU_USUARIO_DOCKERHUB>/mongo-coches:latest
		docker exec -it mongo-desde-hub mongosh -u mongouser -p mongo1234 --authenticationDatabase admin
