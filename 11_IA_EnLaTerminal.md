------- 1. Primero vamnos a explicar como instalarlo en los distintos sistemas operativos --------
---1.1 Instalaciones en Windows---
  
Instalamos Node.js (versión LTS) y verificamos desde cmd con

  node -v
  npm -v

Instalamos tgpt: desde cmd instalamos y comprobamos

  npm install -g tgpt
  tgpt --help
  
Primer uso en Windows con un ejemplo simple y otro más técnico

  tgpt "¿Qué es un firewall?"
  tgpt "Explícame el comando netstat en Windows con ejemplos"

--- 1.2 Instalación en Linuz ----

  curl -sSL https://raw.githubusercontent.com/aandrew-me/tgpt/main/install | bash -s /usr/local/bin

Y comprobamos con 

  tgpt --help

Ejemplo OSINT:

  tgpt "¿Qué es OSINT y qué tipos de fuentes existen?"

Ejemplo Linux:

  tgpt "Explícame el comando grep con ejemplos reales"

Ejemplo scripting:

  tgpt "Hazme un script bash para comprobar si un host responde a ping"


--------- 2. Uso básico de tgpt --------------

Primero probamos con una consulta directa

  tgpt "Explícame qué es un hash"
  
Y después con respuestas más técnicas

  tgpt "Explícame qué es SHA-256 con un ejemplo práctico"
  
También hay modo conversación que permite hacer varias preguntas seguidas manteniendo contexto.

  tgpt -c



"comando para ver conexiones activas en linux"
