----------------FASE 1 — Instalación del Servidor MongoDB-------------------
Añadimos la llave GPG del “repositorio de la Federación”:

  curl -fsSL https://pgp.mongodb.com/server-7.0.asc | \
  sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
  
Activamos el repositorio estable:

  echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg] \
  https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
  
Instalamos MongoDB con

  sudo apt update
  sudo apt install -y mongodb-org


---------------FASE 2 — Arranque del Núcleo de Datos MongoDB------------

Iniciamos el servicio:

  sudo systemctl start mongod
  
Comprobamos su estado operativo:

  sudo systemctl status mongod
  
Activamos para que arranque con el sistema de la nave:

  sudo systemctl enable mongod

------------FASE 3 — Acceso al Observador de Datos (mongosh)----------

Entramos al núcleo:

  mongosh
  
Resultado esperado:

  test>

-------------------FASE 4 — Organización del Archivo Estelar-------------

Servidor → Bases de datos → Colecciones → Documentos → Campos

--------------FASE 5 — Creación de Base de Datos y Colecciones-----------

Cambiamos a la base de datos andoria_sector:

  use andoria_sector
  
creamos una colección llamada planetas.

Inserta un documento básico:
db.planetas.insertOne({
  nombre: "Andoria",
  especie_principal: "Andoriano",
  clima: "Frío",
  alineacion: "Federación",
  tecnologia: "Warp"
})
Comprueba el contenido:
db.planetas.find()

---------FASE 6 — Manejo de Registros Científicos------------------

A)Inserciones múltiples

Añadimos varios planetas explorados:

db.planetas.insertMany([
  { nombre: "Vulcano", especie_principal: "Vulcano", alineacion: "Federación", tecnologia: "Warp" },
  { nombre: "Qo'noS", especie_principal: "Klingon", alineacion: "Imperio Klingon", tecnologia: "Warp" },
  { nombre: "Romulus", especie_principal: "Romulano", alineacion: "Imperio Estelar", tecnologia: "Warp" }
])

B) Consultas

Lista los planetas:

  db.planetas.find()
  
Filtramos por alineación:

  db.planetas.find({ alineacion: "Federación" })


C) Actualizaciones

db.planetas.updateOne(
  { nombre: "Andoria" },
  { $set: { clima: "Ártico" } }
)

D) Eliminaciones

  db.planetas.deleteOne({ nombre: "Romulus" })
  
Comprobamos que desapareció con:

db.planetas.find()

----------FASE 7 — Gestión de Colecciones y Base de Datos---------------------
Ver colecciones existentes

  show collections
  
Eliminamos una colección entera

   db.planetas.drop()

Eliminamos una base de datos

use andoria_sector

  db.dropDatabase()
  
-----------FASE 8 — Exportación e Importación (Bitácora Estelar)---------------

Exportamos colección:

  mongoexport --db andoria_sector --collection planetas --out planetas.json
  
Importamos colección:

  mongoimport --db andoria_sector --collection planetas --file planetas.json
  
------------------FASE 9 — Cierre del Núcleo----------------------
detenemos el servicio:

  sudo systemctl stop mongod

---------Aquí dejaremos algunos comandos que pueden ser útiles----------

Para Instalar MongoDB desde repositorios oficiales:
  1. Importar la clave GPG:
   
  curl -fsSL https://pgp.mongodb.com/server-7.0.asc | \
  sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

  2. Añadir el repositorio:
   
  echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg] \
  https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
  
  3. Instalar MongoDB:
   
  sudo apt update
  sudo apt install -y mongodb-org

Cómo gestionarlo:

  Iniciar: sudo systemctl start mongod
  Detener: sudo systemctl stop mongod
  Reiniciar: sudo systemctl restart mongod
  Ver estado: sudo systemctl status mongod
  Habilitar al arranque: sudo systemctl enable mongod
  Comprobar que funciona: mongosh

Algunos comandos básicos serían:

  1.Mostrar bases de datos

    show dbs
  
  5.2. Cambiar o crear una base de datos
  
    use tienda

  5.3. Ver colecciones

    show collections
   
  5.4. Insertar documentos

    db.clientes.insertOne({ nombre: "Pedro", altura: 175, ciudad: "Madrid" })

   5.5Consultas (búsquedas)
   Mostrar todos:

     db.clientes.find()

Filtrar:

     db.clientes.find({ edad: { $gt: 25 } })

   5.6. Actualizar documentos
   Modificar un campo:

db.clientes.updateOne(
  { nombre: "Ana" },
  { $set: { ciudad: "Granada" } }
)

   5.7. Borrar documentos
   Borrar uno:

     db.clientes.deleteOne({ nombre: "Luis" })
     
   Borrar varios:

    db.clientes.deleteMany({ edad: { $lt: 28 } })
    
    5.8. Borrar una colección entera
    
    db.clientes.drop()
   
   5.9. Borrar una base de datos
   Primero entrar en ella:

    use tienda
    
   Luego eliminarla:

     db.dropDatabase()


Para Exportar una colección:

  mongoexport --db tienda --collection clientes --out clientes.json
  
Importar:

  mongoimport --db tienda --collection clientes --file clientes.json

Detener:

  sudo systemctl stop mongod
  
Desinstalar:

  sudo apt purge mongodb-org -y
  sudo rm -r /var/log/mongodb
  sudo rm -r /var/lib/mongodb
