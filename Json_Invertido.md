- EJ 1 — Lista de Productos

El objetivo es que, al abrir `index.html`, el navegador muestre la siguiente salida:

  Lista de Productos  
  Tarta de Chocolate - $15 - Stock: 10  
  Cheesecake - $12 - Stock: 5  
  Brownie - $8 - Stock: 7  

Creamos el archivo JSON: `productos.json`


[
  {
    "nombre": "Tarta de Chocolate",
    "precio": 15,
    "stock": 10
  },
  {
    "nombre": "Cheesecake",
    "precio": 12,
    "stock": 5
  },
  {
    "nombre": "Brownie",
    "precio": 8,
    "stock": 7
  }
]


- EJER. 2 Creación del JSON según el JavaScript

Lozalizar el json con 

fetch('archivo.json')

Si te aparece 

data.forEach(elemento => console.log(elemento.nombre));

Tiene que ser array:

[
  { "nombre": "Ejemplo 1" },
  { "nombre": "Ejemplo 2" }
]


Pero si sale 

data.usuarios.forEach(usuario => console.log(usuario.email));

Tiene que incluir usuarios 

{
  "usuarios": [
    { "email": "usuario1@email.com" },
    { "email": "usuario2@email.com" }
  ]
}


Y si sale pedido.cliente.nombre

es una estrucrtura mas simple

{
  "cliente": {
    "nombre": "Carlos"
  }
}


Comprobamos que funciona 

php -S localhost:8000

Y abrimos en el navegador 

http://localhost:8000




