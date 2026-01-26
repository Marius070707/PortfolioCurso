---------------PARTE 1 – PHP + MongoDB--------------
-----------Fase 1.1 Preparamos el proyecto PHP---------

Creamos una carpeta para el proyecto, por ejemplo: mkdir ~/mongo_php_lab cd ~/mongo_php_lab

Instalamos el driver oficial de MongoDB para PHP vía Composer: composer require mongodb/mongodb


-----------Fase 1.2 Creamos el script PHP-----------

Creamos el archivo mongo_php_lab.php dentro de ~/mongo_php_lab con este contenido:

<?php
require 'vendor/autoload.php';

use MongoDB\Client;

// 1. Conexión al servidor MongoDB
$client = new Client("mongodb://localhost:27017");

// 2. Selección de base de datos y colección
$database = $client->fed_records;
$collection = $database->planets;

echo "<h1>PHP + MongoDB: Laboratorio de planetas</h1>";

// 3. Insertamos varios planetas (insertMany)
echo "<h2>1. Insertando planetas...</h2>";

$insertResult = $collection->insertMany([
    [
        'name' => 'Vulcan',
        'species' => 'Vulcans',
        'affiliation' => 'Federation',
        'warp_capable' => true
    ],
    [
        'name' => "Qo'noS",
        'species' => 'Klingons',
        'affiliation' => 'Klingon Empire',
        'warp_capable' => true
    ],
    [
        'name' => 'Ferenginar',
        'species' => 'Ferengi',
        'affiliation' => 'Ferengi Alliance',
        'warp_capable' => true
    ]
]);

echo "Planetas insertados: " . $insertResult->getInsertedCount() . "<br>";

// 4. Listar todos los planetas
echo "<h2>2. Lista completa de planetas</h2>";

$cursor = $collection->find();

foreach ($cursor as $planet) {
    echo "Nombre: " . $planet['name'] .
         " | Especie: " . $planet['species'] .
         " | Alineación: " . $planet['affiliation'] .
         " | Warp: " . ($planet['warp_capable'] ? 'Sí' : 'No') .
         "<br>";
}

// 5. Mostrar solo los de la Federación
echo "<h2>3. Planetas de la Federación</h2>";

$cursorFed = $collection->find(['affiliation' => 'Federation']);

foreach ($cursorFed as $planet) {
    echo "Nombre: " . $planet['name'] . "<br>";
}

// 6. Cambiar un campo (warp_capable) para Vulcan
echo "<h2>4. Actualizando warp_capable de Vulcan a false</h2>";

$updateResult = $collection->updateOne(
    ['name' => 'Vulcan'],
    ['$set' => ['warp_capable' => false]]
);

echo "Documentos modificados: " . $updateResult->getModifiedCount() . "<br>";

// 7. Borrar un registro (Ferenginar)
echo "<h2>5. Borrando el planeta Ferenginar</h2>";

$deleteResult = $collection->deleteOne(['name' => 'Ferenginar']);

echo "Documentos eliminados: " . $deleteResult->getDeletedCount() . "<br>";

// 8. Lista final para comprobar cambios
echo "<h2>6. Lista final de planetas tras cambios</h2>";

$cursorFinal = $collection->find();

foreach ($cursorFinal as $planet) {
    echo "Nombre: " . $planet['name'] .
         " | Alineación: " . $planet['affiliation'] .
         " | Warp: " . ($planet['warp_capable'] ? 'Sí' : 'No') .
         "<br>";
}



-----------Fase 1.3 — Ejecutar el script PHP-----------------

Copiamos el proyecto a la carpeta del servidor, por ejemplo: sudo cp -r ~/mongo_php_lab /var/www/html/
En el navegador, abrimos: http://IP_DEL_SERVIDOR/mongo_php_lab/mongo_php_lab.php



------------------------PARTE 2 – Python + MongoDB-------------------------------
-------------Fase 2.1 — Instalar pymongo----------------------
En el servidor o equipo donde ejecutemos Python:

  pip install pymongo


---------------Fase 2.2 — Crear el script Python-------------------
En tu home (o donde quieras), crea para el lab:

  mkdir ~/mongo_python_lab
  cd ~/mongo_python_lab


Creamos el archivo mongo_python_lab.py con este contenido:


from pymongo import MongoClient

# 1. Conexión al servidor MongoDB
client = MongoClient("mongodb://localhost:27017")

# 2. Seleccionar base de datos y colección
db = client["fed_records"]
planets = db["planets"]

print("PYTHON + MongoDB: Laboratorio de planetas\n")

# 3. Insertar nuevos planetas
print("1) Insertando nuevos planetas...\n")

insert_result = planets.insert_many([
    {
        "name": "Andoria",
        "species": "Andorians",
        "affiliation": "Federation",
        "warp_capable": True
    },
    {
        "name": "Cardassia Prime",
        "species": "Cardassians",
        "affiliation": "Cardassian Union",
        "warp_capable": True
    }
])

print("IDs insertados:", insert_result.inserted_ids, "\n")

# 4. Listar todos los planetas
print("2) Lista completa de planetas:")

for planet in planets.find():
    print(f"- {planet['name']} ({planet['affiliation']}) | Warp: {planet.get('warp_capable', 'N/A')}")

print()

# 5. Filtrar solo la Federación
print("3) Planetas de la Federación:")

for planet in planets.find({"affiliation": "Federation"}):
    print(f"- {planet['name']}")

print()

# 6. Actualizar: poner warp_capable = True de nuevo en Vulcan (si existe)
print("4) Actualizando warp_capable de Vulcan a True...\n")

update_result = planets.update_one(
    {"name": "Vulcan"},
    {"$set": {"warp_capable": True}}
)

print("Documentos modificados:", update_result.modified_count, "\n")

# 7. Borrar un planeta concreto: Cardassia Prime
print("5) Borrando Cardassia Prime...\n")

delete_result = planets.delete_one({"name": "Cardassia Prime"})
print("Documentos eliminados:", delete_result.deleted_count, "\n")

# 8. Agregación por affiliation
print("6) Agregación: número de planetas por affiliation:\n")

pipeline = [
    {"$group": {"_id": "$affiliation", "total": {"$sum": 1}}},
    {"$sort": {"total": -1}}
]

for group in planets.aggregate(pipeline):
    print(f"{group['_id']}: {group['total']} planetas")


------------Fase 2.3 — Ejecutamos el script Python-------------------------

  cd ~/mongo_python_lab
  python3 mongo_python_lab.py



  -----------------------------PARTE 3 – Verificación en MongoDB Compass--------------------------
--------------Fase 3.1 — Conectarse con Compass-----------------

Abrimos MongoDB Compass y en la pantalla inicial de conexión, usamos:
Si Compass está en el mismo servidor que MongoDB:

  mongodb://localhost:27017
  
Si Compass está en otro equipo de la red:

  mongodb://IP_DEL_SERVIDOR:27017
  
Pulsa Connect.

-----------------Fase 3.2 — Explorar la base de datos fed_records-----------------
En la barra lateral izquierda, localizamos la base de datos fed_records.
Entramos en la colección planets.
Ahí deberíamos ver documentos provenientes de:

Las inserciones del script PHP.
Las inserciones del script Python.

---------------Fase 3.3 — Comprobar coherencia de los cambios-------------------
Verificamos que:
- Vulcan existe y tiene warp_capable = true (último cambio lo hizo Python).
- Ferenginar no está (PHP lo borró).
- Cardassia Prime no está (Python lo borró).

Modificamos un documento desde Compass, por ejemplo:
- Editamos Qo'noS y cambia affiliation a "Klingon Empire (Updated)".

Volvemos a ejecutar el script Python: cd ~/mongo_python_lab python3 mongo_python_lab.py En la parte de “lista completa de planetas” verás la nueva affiliation de Qo'noS leída desde Python.
