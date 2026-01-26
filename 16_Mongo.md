----------FASE 1 — Preparar la Conexión desde Compass----------------

Asegúrate de que MongoDB está activo

  sudo systemctl status mongod

Abrimos MongoDB Compass y en el campo de conexión escribe:

Para conexión local:

  mongodb://localhost:27017
  
Para conexión remota en la red de aula:

  mongodb://IP_DEL_SERVIDOR:27017

------------FASE 2 — Exploración de la Biblioteca de Datos----------------
Creamos una estructura nueva que represente planetas registrados por la Federación.

  Create database
  Nombre de la base de datos: fed_records
  Nombre de la colección inicial: planets
  Create

-------------FASE 3 — Inserción de Datos Científicos----------------------
Abrimos la colección planets y pulsa Insert Document.
Aparecerá un editor con un documento JSON. Rellénalo con:

{
  "name": "Vulcan",
  "species": "Vulcans",
  "affiliation": "Federation",
  "warp_capable": true
}


Agregamos un segundo documento pero esta vez usando Insert Document y cambia el contenido:

{
  "name": "Qo'noS",
  "species": "Klingons",
  "affiliation": "Klingon Empire",
  "warp_capable": true
}

Insertamos un tercero:

{
  "name": "Ferenginar",
  "species": "Ferengi",
  "affiliation": "Ferengi Alliance",
  "warp_capable": true
}


--------------FASE 4 — Visualización y Edición de Documentos-------

Editamos un documento desde el icono Edit Document
Cambiamos warp_capable de true a false en algún planeta no confirmado. Guarda y comprueba que Compass valida el JSON.

---------------------FASE 5 — Consultas Visuales con Filtros-----------------------


  { "affiliation": "Federation" }

-----------------FASE 6 — Agregaciones en la Sala de Análisis------------------------
Entra en Aggregations y añade una etapa $group:

{
  "$group": {
    "_id": "$affiliation",
    "total": { "$sum": 1 }
  }
}


Compass mostrará algo parecido a una estadística diplomática:

Federation: 1
Klingon Empire: 1
Ferengi Alliance: 1

-----------------FASE 7 — Inferir Esquemas-------------------
Entramos en la pestaña Schema dentro de la colección.

Compass examinará los documentos e inferirá:

Tipos de campos
Frecuencia de aparición
Valores más comunes



--------------------FASE 8 — Crear Índices------------------------
Abrimos pestaña Indexes para crear un índice sobre el campo name.

   Create Index y configuramos:

Field: name
Sort: Ascending
Clic en Create.

---------------------FASE 9 — Desconexión y Cierre de Misión--------------------
Cerramos Compass.
Detenemos el servicio MongoDB 

  sudo systemctl stop mongod
