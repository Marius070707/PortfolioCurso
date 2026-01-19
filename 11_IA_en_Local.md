Para usar IA en local podemos hacerlo de varias formas: 

  tgpt → un cliente que conecta con modelos en la nube 
  Ollama → un motor local que ejecuta modelos en tu propio sistemaç

Para instalar Ollama:

  curl -fsSL https://ollama.com/install.sh | sh

Para comprobar que funciona. Tiene que salir active (running)

  systemctl status ollama

Dos modos para probarlo de forma sencilla:

  ollama run phi
  ollama run llama3

Para ver los modelos instalados:

  ollama list

Para mover los modelos 

  export OLLAMA_MODELS=/ruta/grande/ollama-models

Y para desinstalar:

  sudo systemctl stop ollama
  sudo rm /usr/bin/ollama
  sudo rm /etc/systemd/system/ollama.service
  sudo rm -rf /usr/share/ollama

Para instalar el modelo codellama y ver que está instalado:

  ollama pull codellama
  ollama list

Usar el modo interactivo:

  ollama run codellama

Y le hacemos una petición:

  ollama run codellama "escribe un script en bash para hacer backup de /etc" 

Importante elegir el tamaño de coddellama

  ollama pull codellama:7b

Algunas opciones para por ejemplo mover script

  sudo mv ollama-shell.sh /usr/local/bin/ollama-shell

No olvidar dar permisos de ejecucióin

  sudo chmod +x /usr/local/bin/ollama-shell

Y algunos comandos que conviene saber:

  ollama run llama3:8b # Ejecutar modelo
  ollama list # Modelos instalados 
  ollama pull mistral # Descargar modelo 
  ollama rm mistral # Borrar modelo 
  ollama ps # Modelos en uso 
  ollama stop llama3:8b # Detener modelo
