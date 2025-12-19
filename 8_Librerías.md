Vamos a aprender como implementar librerias con Python e implementa el ReconLite.

Para importar

 import requests

Para importar cosas concretas

 from datetime import datetime

Para poner un alias 

  import pandas as pd

En cuanto a los gestores de paquetes pip:
Comandos básicos

  pip --version
  python3 -m pip --version
  
Instalar una librería

  python3 -m pip install requests
  
Actualizar una librería

  python3 -m pip install --upgrade requests

Ver lo instalado

  python3 -m pip list
  
Ver información de un paquete

  python3 -m pip show requests

Para evitar romper el sistema y hacer que cada proyecto tenga sus librerías:
En la carpeta del proyecto:

  python3 -m venv venv

Activarmos en Linux/Mac:

  source venv/bin/activate

Windows (PowerShell):

  venv\Scripts\Activate.ps1
  
Windows (CMD):

  venv\Scripts\activate.bat
  
Cuando está activo, normalmente verás (venv) al inicio de la terminal.

Instalamos dentro del entorno

  python -m pip install requests

Para salir del entorno:

  deactivate

Y para saber si algo es estándar o externo:
Estándar
  import json
  import os
  import datetime
  
Externas 

  import requests
  import pandas
  import flas
