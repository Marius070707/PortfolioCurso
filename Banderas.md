Instalamos Git y Gitk con:

  sudo apt install git gitk -y

Parte 1: Configuración del Servidor 

Configuramos Apache 
Ponemos la bandera de España 

Instalamos Apache 

  sudo apt install apache2 -y

Y verificamos con 

  sudo systemctl status apache2
  
Preparamos la carpeta donde haremos las cosas

  cd /var/www/html
  sudo rm -rf *

Cambiamos el propietario de la carpeta al usuario actual

  sudo chown -R $USER:$USER /var/www/html

Iniciamos Git y creamos la bandera Base española

  git init

Creamos el archivo index.html 

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bandera</title>
    <style>
        body { margin: 0; padding: 0; }
        .franja { height: 100px; width: 100%; }
    </style>
</head>
<body>
    <div class="franja" style="background-color: red;"></div>
    <div class="franja" style="background-color: yellow;"></div>
    <div class="franja" style="background-color: red;"></div>
</body>
</html>

Hacemos el primer Commit

  git add index.html
  git commit -m "Añade la bandera inicial (España)"

Y verificamos en el navegador con http://localhost

-----------------------------------------------------------------------

- Parte 2 y 3: Trabajo con Ramas
  
Hay que crear una rama nueva para cada país partiendo de la base y modificar el código.

Bandera 1: Ucrania

Creamos y cambiamos a la rama:

 git checkout -b rumania
 
Modificar index.html: Cambiamos los div del body por:


<div class="franja" style="background-color: blue;"></div>
<div class="franja" style="background-color: yellow;"></div>
<div class="franja" style="background-color: red;"></div>

Guardamos y hacemos Commit:

  git add index.html
  git commit -m "Crea la bandera de Rumania en la rama rumania"

Ahora vamos con la segunda bandera
Bandera 2: Belgica

git checkout -b belgica

<div class="franja" style="background-color: black;"></div>
<div class="franja" style="background-color: yellow;"></div>
<div class="franja" style="background-color: red;"></div>

Y hacemos el commit:

  git add index.html
  git commit -m "Crea la bandera de Belgica"

Bandera 3: Alemania

Creamos la rama con

  git checkout -b alemania
  
Modificamos el archivo index.html con

<div class="franja" style="background-color: black;"></div>
<div class="franja" style="background-color: red;"></div>
<div class="franja" style="background-color: yellow;"></div>

Y hacemos Commit:

  git add index.html
  git commit -m "Crea la bandera de Alemania"

- Parte 4: Visualización con Gitk
  
Ejecuta el comando 

gitk --all &

Veremos etiquetas indicando dónde está cada rama con las banderas.

- Parte 5: Publicación en GitHub

  git remote add origin https://github.com/tu-usuario/banderas_git.git

Y finalmente subimos las ramas con

  git branch -M main
  git push -u origin main
  git push origin italia
  git push origin francia
  git push origin alemania

