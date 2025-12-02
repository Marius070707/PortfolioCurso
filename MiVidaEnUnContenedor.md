--- RETO 1

Creación y ejecución del contenedor ubuntu

  docker run -it --name reto-ubuntu ubuntu:latest
  
Dentro del contenedor

Dentro del contenedor, instalamos Python y librerías

  apt-get update
  apt-get install -y python3 python3-pip

  pip3 install requests mysql-connector-python

Comprobamos con

  python3 -c "import requests, mysql.connector; print('OK')"

Para MySQL
  apt install mysql-client -y
  apt install python3-mysql.connector -y
  apt install python3-mysqldb -y

			 
Creamos una imagen personalizada con el contenedor:

  docker commit reto1-ubuntu ubuntu-python-mysql:1.0


--- RETO 2:
Crear contenedor nuevo con la imagen personalizada y un volumen bind
Creamos la carpeta en el host

  mkdir -p /home/usuario/proyecto-coches

Y lanzamos el contenedor con bind mount

  docker run -it --name reto2-app \
  -v /home/usuario/proyecto-coches:/app \
  ubuntu-python-mysql:1.0


--- RETO 3:
En el host:

  cd /home/usuario/proyecto-coches
  git init
  git add .
  git commit -m "Inicializar proyecto"

En GitHub creamos un repo vacío llamado proyecto-coches

Conectamos un repo local

  git branch -M main
  git remote add origin https://github.com/TUUSUARIO/proyecto-coches.git
  git push -u origin main




--- RETO 4:

Creamos contenedor MySQL

docker run --name mysql-coches \
  -e MYSQL_ROOT_PASSWORD=rootpass \
  -e MYSQL_DATABASE=cochesdb \
  -p 3306:3306 \
  -d mysql:8

Entramos al cliente MySQL

  docker exec -it mysql-coches mysql -u root -p
  # password: rootpass

Creamos tablas y datos

USE cochesdb;

CREATE TABLE coches (
  id INT AUTO_INCREMENT PRIMARY KEY,
  marca VARCHAR(50),
  modelo VARCHAR(50),
  color VARCHAR(30),
  km INT,
  precio DECIMAL(10,2)
);

INSERT INTO coches (marca, modelo, color, km, precio) VALUES
('Toyota', 'Corolla', 'Blanco', 20000, 15000),
('Honda', 'Civic', 'Rojo', 30000, 17000),
('Ford', 'Focus', 'Azul', 25000, 16000),
('BMW', 'Serie 1', 'Negro', 40000, 22000),
('Audi', 'A3', 'Gris', 35000, 21000),
('Seat', 'Ibiza', 'Rojo', 15000, 14000),
('Volkswagen', 'Golf', 'Blanco', 28000, 19000),
('Renault', 'Clio', 'Azul', 32000, 13000),
('Peugeot', '308', 'Negro', 27000, 18000),
('Kia', 'Ceed', 'Blanco', 23000, 16000);

Y comprobamos con

SELECT * FROM coches;


--- RETO 5:

En la carpeta del proyecto del host

  cd /home/usuario/proyecto-coches

Creamos list_coches.py con:

import mysql.connector

def get_connection():
    conn = mysql.connector.connect(
        host="localhost",
        port=3306,
        user="root",
        password="rootpass",
        database="cochesdb"
    )
    return conn

def main():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, marca, modelo, color, km, precio FROM coches")
    rows = cursor.fetchall()

    # Cabecera
    print("ID  {:<12} {:<12} {:<8} {:<10} {:<10}".format(
        "MARCA", "MODELO", "COLOR", "KM", "PRECIO"
    ))
    print("-" * 70)

    # Filas
    for r in rows:
        id_, marca, modelo, color, km, precio = r
        print("{:<3} {:<12} {:<12} {:<8} {:<10} {:<10}".format(
            id_, marca, modelo, color, km, float(precio)
        ))

    cursor.close()
    conn.close()

if __name__ == "__main__":
    main()


Ahora desde el contenedor:

  docker start reto2-app
  docker exec -it reto2-app bash

  cd /app
  python3 list_coches.py

Y hacemos el commit:

  cd /home/usuario/proyecto-coches
  git add list_coches.py
  git commit -m "Añadir script básico para listar coches desde MySQL"
  git push


--- RETO 6:

Creamos el archivo JSON

  cd /home/usuario/proyecto-coches
  cat > config_db.json << 'EOF'
  {
    "mysql": {
      "host": "localhost",
      "port": 3306,
      "user": "root",
      "password": "rootpass",
      "database": "cochesdb"
    }
  }
  EOF


 
Y un script que lo lea



import json
import mysql.connector

def get_config(path="config_db.json"):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)

def get_connection():
    config = get_config()["mysql"]
    conn = mysql.connector.connect(
        host=config["host"],
        port=config["port"],
        user=config["user"],
        password=config["password"],
        database=config["database"]
    )
    return conn

def main():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, marca, modelo, color, km, precio FROM coches")
    rows = cursor.fetchall()

    print("ID  {:<12} {:<12} {:<8} {:<10} {:<10}".format(
        "MARCA", "MODELO", "COLOR", "KM", "PRECIO"
    ))
    print("-" * 70)

    for r in rows:
        id_, marca, modelo, color, km, precio = r
        print("{:<3} {:<12} {:<12} {:<8} {:<10} {:<10}".format(
            id_, marca, modelo, color, km, float(precio)
        ))

    cursor.close()
    conn.close()

if __name__ == "__main__":
    main()

Probamos dentro del contenedor

  docker exec -it reto2-app bash
  cd /app
  python3 list_coches_json.py

Creamos el gitimore para no subir el JSON

  cd /home/usuario/proyecto-coches
  echo "config_db.json" >> .gitignore

Y hacemos los commits

git add list_coches_json.py
git commit -m "Leer configuración de MySQL desde JSON"
git add .gitignore
git commit -m "Ignorar archivo de configuración de base de datos"
git push



--- RETO 7:

Instalamos tabulate en el contenedor app

  docker exec -it reto2-app bash
  pip3 install tabulate

Y hacemos el nuevo script

import json
import mysql.connector
from tabulate import tabulate

def get_config(path="config_db.json"):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)

def get_connection():
    config = get_config()["mysql"]
    conn = mysql.connector.connect(
        host=config["host"],
        port=config["port"],
        user=config["user"],
        password=config["password"],
        database=config["database"]
    )
    return conn

def main():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, marca, modelo, color, km, precio FROM coches")
    rows = cursor.fetchall()
    cursor.close()
    conn.close()

    headers = ["ID", "Marca", "Modelo", "Color", "Kilometraje", "Precio"]
    # Convertir DECIMAL a float para tabulate
    data = [
        [id_, marca, modelo, color, km, float(precio)]
        for (id_, marca, modelo, color, km, precio) in rows
    ]

    print(tabulate(data, headers=headers, tablefmt="grid"))

if __name__ == "__main__":
    main()


Nos tiene que dar algo parecido

+----+--------+---------+--------+--------------+----------+
| ID | Marca  | Modelo  | Color  |   Kilometraje|   Precio |
+----+--------+---------+--------+--------------+----------+
|  1 | Toyota | Corolla | Blanco |        20000 |   15000  |
|  2 | Honda  | Civic   | Rojo   |        30000 |   17000  |
etc...
+----+--------+---------+--------+--------------+----------+

Probamos los commits

  docker exec -it reto2-app bash
  cd /app
  python3 list_coches_tabla.py


En el host

  cd /home/usuario/proyecto-coches
  git add list_coches_tabla.py
  git commit -m "Listar coches con tabla formateada usando tabulate"
  git push


 
## RETO 8:

Creamos el contenedor Mongo

docker run --name mongo-coches \
  -p 27017:27017 \
  -d mongo:latest

Nos conectamos desde la terminal usando mongosh

  docker exec -it mongo-coches mongosh


Dentro metemos 

use cochesdb

db.coches.insertMany([
  { id: 1, marca: "Toyota", modelo: "Corolla", color: "Rojo", km: 25000, precio: 15000 },
  { id: 2, marca: "Honda", modelo: "Civic",   color: "Azul", km: 30000, precio: 18000 },
  { id: 3, marca: "Ford",  modelo: "Focus",   color: "Blanco", km: 40000, precio: 17000 },
  { id: 4, marca: "BMW",   modelo: "Serie 1", color: "Negro", km: 35000, precio: 22000 },
  { id: 5, marca: "Audi",  modelo: "A3",      color: "Gris",  km: 32000, precio: 21000 }
])

Y comrpobamos

  db.coches.find().pretty()


Instalamos pymongo 

docker exec -it reto2-app bash
pip3 install pymongo tabulate


En el host creamos list_coches_mongo.py

from pymongo import MongoClient
from tabulate import tabulate

def get_client():
    # Mongo en localhost, puerto 27017
    client = MongoClient("mongodb://localhost:27017/")
    return client

def main():
    client = get_client()
    db = client["cochesdb"]
    collection = db["coches"]

    docs = list(collection.find())
    client.close()

    headers = ["ID", "Marca", "Modelo", "Color", "Kilometraje", "Precio"]
    data = []
    for d in docs:
        data.append([
            d.get("id"),
            d.get("marca"),
            d.get("modelo"),
            d.get("color"),
            d.get("km"),
            d.get("precio")
        ])

    print(tabulate(data, headers=headers, tablefmt="grid"))

if __name__ == "__main__":
    main()



Comprobamos

  docker exec -it reto2-app bash
  cd /app
  python3 list_coches_mongo.py

Y hacemos los commits

cd /home/usuario/proyecto-coches
git add list_coches_mongo.py
git commit -m "Script Python para listar coches desde MongoDB"
git push



--- RETO 9:

En /home/usuario/proyecto-coches/mongo-image/

  mkdir -p mongo-image
  cd mongo-image

El archivo ini-coches.js

db = db.getSiblingDB('cochesdb');

db.coches.insertMany([
  { id: 1, marca: "Toyota", modelo: "Corolla", color: "Rojo", km: 25000, precio: 15000 },
  { id: 2, marca: "Honda", modelo: "Civic",   color: "Azul", km: 30000, precio: 18000 },
  { id: 3, marca: "Ford",  modelo: "Focus",   color: "Blanco", km: 40000, precio: 17000 },
  { id: 4, marca: "BMW",   modelo: "Serie 1", color: "Negro", km: 35000, precio: 22000 },
  { id: 5, marca: "Audi",  modelo: "A3",      color: "Gris",  km: 32000, precio: 21000 }
]);


Dockerfille:

FROM mongo:latest

  COPY init-coches.js /docker-entrypoint-initdb.d/init-coches.js

Construimos la oimagen

  docker build -t tuusuario/mongo-coches:1.0 .

Y lo subimos  a DockerHub

  docker login
  # usuario y contraseña de Docker Hub
  docker push tuusuario/mongo-coches:1.0

En Parrot

docker pull tuusuario/mongo-coches:1.0

 docker run --name mongo-coches-parrot \
  -p 27017:27017 \
  -d tuusuario/mongo-coches:1.0

La BD cochesdb y la colección coches se crearán automáticamente con los datos que pusimos en init-coches.js




