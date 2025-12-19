Primero lo instalamos con

  snap install amass

Y comprobamos 

 amass version

Un uso basico sería

 amass enum -passive -d ejemplo.com

Uso con salido a archivo

  amass enum -passive -d ejemplo.com -o subdominios.txt

Enumeración con múltiples dominios

  amass enum -passive -df dominios.txt -o resultados.txt 

SUbfinder
Lo instamaos con

  sudo apt install subfinder

Opción manual 

  sudo apt install snapd
  sudo snap install subfinder

Para un Uso básico

  subfinder -d ejemplo.com

Para Guardar resultados

  subfinder -d ejemplo.com -o subfinder.txt

Geolocalización
Geolocalización de IP con whois. Te da infromacion relevante como el pais, organzaicion, rango de IPs...:

  whois 8.8.8.8

Uso de geoiplookup. iNSTALAMOS y usamos

  sudo apt install geoip-bin
  geoiplookup 8.8.8.8

Geolocalización con APIs desde terminal

  curl ipinfo.io/8.8.8.8

Un ejemplo de proceso final sería

  amass enum -passive -d ejemplo.com -o amass.txt
  subfinder -d ejemplo.com -o subfinder.txt
  sort amass.txt subfinder.txt | uniq > subdominios_finales.txt

Y finalmente 

   while read sub; do
    echo "Resolviendo $sub"
    host $sub
  done < subdominios_finales.txt
