--FASE 1---
Hay que filtrar por tipo de dispositivo y ubi

Búsquedas a realizar:

  product:GoAhead  
  product:"Hikvision"  
  port:554 has_screenshot:true  
  http.title:"login"  

Y se Aplican filtros de localización:

  country:ES product:GoAhead  
  city:Madrid http.title:"login"  

--Fase 2 --

Filtrar por organización y dominio.

  org:"Universidad Complutense"  
  org:"Telefonica"  

  hostname:"uic.es"  
  hostname:"unizar.es"  

--Fase 3--

Búsquedas a realizar

  ip:82.X.X.X  
  org: "Ayuntamiento de x" 

  product:"nginx"  
  product:"nginx" port:443  

  asn:3352  

  -Misiones especiales--

Misión Ash Sistemas obsoletos
Para Encontrar un dispositivo antiguo que no debería seguir activo:

  os:"Windows XP"  
  "Server: Apache/2.2"  

Misión Ripley Servicios críticos expuestos
Para Buscar servicios críticos abiertos sin autenticación:

  port:22 "OpenSSH_7"  
  port:21 Anonymous  

Misión Bishop — Análisis visual
Para Buscar paneles que tengan captura para analizar visualmente:

  has_screenshot:true city:Barcelona  

  
