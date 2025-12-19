--- FASE 1 Generación de identidades ---

Creamos usuarios

  sudo adduser trinity
  sudo adduser apoc
  sudo adduser switch
  sudo adduser neo

Asignamos privilegios

  sudo usermod -aG sudo neo

Y verificamos 

  id neo

--- FASE 2 Grupos de la Resistencia ---

Creamos grupos

  sudo groupadd zion
  sudo groupadd matrix

Asignamos usuarios a los gripos

  sudo usermod -aG zion neo
  sudo usermod -aG zion trinity

  sudo usermod -aG matrix neo
  sudo usermod -aG matrix apoc
  sudo usermod -aG matrix switch
  
Si queremos verificar

  groups neo
  groups trinity
  groups apoc
  groups switch

--- FASE 3 Estructura de directorios---

Los creamis

  sudo mkdir /mission-data
  sudo mkdir /simulacion
  sudo mkdir /backdoor

Configuramos permisos


  sudo chown :zion /mission-data
  sudo chmod 770 /mission-data

  sudo chown :matrix /simulacion
  sudo chmod 775 /simulacion

  sudo chown neo:neo /backdoor
  sudo chmod 700 /backdoor

---FASE 4 Pruebas de acceso ---

su - apoc
touch /mission-data/test.txt    Permission denied

ls /backdoor                    Permission denied

touch /simulacion/fake.txt      permitido

su - trinity
touch /simulacion/test.txt      Permission denied
ls /simulacion                  lectura permitida

su - neo
touch /mission-data/plan.txt    permitido
ls /backdoor                    permitido

---FASE 5 — Usuario Smith (Agente)----

Creamos

  sudo adduser smith
  sudo chmod 700 /home/smith

Verificamos aislamiento

su - smith
ls /mission-data    Permission denied
ls /simulacion      ermission denied
ls /backdoor        Permission denied

--- FASE 6 — Logs en tiempo real ---

Usamos el comando

  sudo journalctl -f

---FASE 7 Accesos y sesiones---

Vemos los usuarios conectados

  who
  w

Vemos historiald e logins

  last

Y los fallos de autentiacacion 

 sudo zgrep -i "failed" /var/log/auth.log*

---FASE 8 — Uso de sudo ---

  sudo journalctl -u sudo
  sudo grep 'COMMAND=' /var/log/auth.log


---FASE 9 — Historial de comandos---

Para verlo usamos

   sudo su - trinity
   history

