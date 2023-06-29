#!/bin/sh
set -e
echo "Actualizando repositorios..."
sleep 2
sudo apt update && echo "Repositorios actualizados" || echo "Hubo un problema al actualizar repositorios"
sleep 2
echo "Los siguientes paquetes serán actualizados:"
sleep 2
sudo apt list --upgradable
sleep 5
echo "Actualizando paquetes..."
sleep 2
sudo apt upgrade -y && echo "Paquetes actualizados" || echo "Hubo un problema al actualizar los paquetes"
echo "Instalando paquetes pendientes..."
sleep 2
sudo apt install sudo docker.io docker-compose net-tools wget curl -y && echo "Dependencias instaladas correctamente" || echo "Hubo un problema al instalar dependencias"
echo "Creando carpetas y descargando imagen de Home Assistant"
sleep 2
sudo mkdir -p /mnt/Docker/Speedgraphs
sudo chmod 777 -R /mnt/Docker/Speedgraphs
cd /mnt/Docker/Speedgraphs && echo "Directorios creados" || echo "Error al acceder al directorio"
echo "Obteniendo la última imagen de Home Assistant, desde GHCR..."
sleep 2
docker pull ghcr.io/home-assistant/home-assistant:stable && echo "Imagen descargada correctamente" || echo "Hubo un problema al descargar la imagen"
echo "Obteniendo plantilla de Docker-Compose desde repositorio"
sleep 2
wget https://raw.githubusercontent.com/JuanZagoR/Speedgraphs-PisapapelesLabs/dev/Docker-Compose%20Templates/HomeAssistant/docker-compose.yaml && echo "Plantilla  descargada correctamente" || echo "Hubo un problema al descargar la plantilla"
sleep 2
echo "Creando contenedor a partir de plantilla..."
docker-compose up -d && echo "Contenedor creado, revisando estado..." || echo "Hubo un problema al crear el contenedor"
sleep 5
docker status PPLabs-HomeAssistant-Prod
echo "Script finalizado, configure la instancia de Home Assistant, y posteriormente, ejecute el segundo script"