#!/bin/sh
set -e
echo -e "\e[1;35mSpeedgraphs - Pisapapeles Labs\e[0m"
sleep 2

echo -e "\e[0;32mComprobando permisos...\e[0m"
if [[ $EUID -ne 0 ]]; then
   echo -e "\e[0;31mPara usar este script, es necesario elevar permisos. Use 'sudo bash "$0"' en su lugar\e[0m" 1>&2
   exit 1
fi

echo -e "\e[0;32mActualizando repositorios...\e[1;30m"
sleep 2
sudo apt update && echo "Repositorios actualizados" || echo -e "\e[0;31mHubo un problema al actualizar repositorios\e[0m"

sleep 2
echo -e "\e[0;32mLos siguientes paquetes serán actualizados:\e[0m"

sleep 2
sudo apt list --upgradable

sleep 5
echo -e "\e[0;32mActualizando paquetes...\e[0m"

sleep 2
sudo apt upgrade -y && echo -e "\e[0;32mPaquetes actualizados\e[0m" || echo -e "\e[0;31mHubo un problema al actualizar los paquetes\e[0m"
echo -e "\e[0;32mInstalando paquetes pendientes...\e[0m"

sleep 2
sudo apt install sudo net-tools wget curl -y && echo -e "\e[0;32mDependencias instaladas correctamente\e[0m" || echo -e "\e[0;31mHubo un problema al instalar dependencias\e[0m"

sleep 2
echo -e "\e[0;32mInstalando la última versión de Docker (Community Edition) desde el sitio oficial...\e[0m"
sudo curl -fsSL https://get.docker.com/ | sudo bash -s
echo -e "\e[0;32mDocker-CE ha sido instalado\e[0m" || echo -e "\e[0;31mError al instalar Docker-CE\e[0m"

sleep 2
echo -e "\e[0;32mCreando carpetas y descargando imagen de Home Assistant\e[0m"
sudo mkdir -p /mnt/Docker/Speedgraphs
sudo chmod 777 -R /mnt/Docker/Speedgraphs
cd /mnt/Docker/Speedgraphs && echo -e "\e[0;32mDirectorios creados\e[0m" || echo -e "\e[0;31mError al acceder al directorio\e[0m"
echo -e "\e[0;32mObteniendo la última imagen de Home Assistant, desde GHCR...\e[0m"

sleep 2
docker pull ghcr.io/home-assistant/home-assistant:stable && echo -e "\e[0;32mImagen descargada correctamente\e[0m" || echo -e "\e[0;31mHubo un problema al descargar la imagen\e[0m"
echo -e "\e[0;32mObteniendo plantilla de Docker-Compose desde repositorio\e[0m"

sleep 2
wget https://raw.githubusercontent.com/JuanZagoR/Speedgraphs-PisapapelesLabs/dev/Docker-Compose%20Templates/HomeAssistant/docker-compose.yaml && echo -e "\e[0;32mPlantilla  descargada correctamente\e[0m" || echo -e "\e[0;31mHubo un problema al descargar la plantilla\e[0m"

sleep 2
echo -e "\e[0;32mCreando contenedor a partir de plantilla...\e[0m"
docker compose up -d && echo -e "\e[0;32mContenedor creado, revisando estado...\e[0m" || echo -e "\e[0;31mHubo un problema al crear el contenedor\e[0m"

sleep 5
docker logs PPLabs-HomeAssistant-Prod
echo -e "\e[1;34mConfigura la instancia de Home Assistant de este servidor, a través de http://$(hostname  -I | cut -f1 -d' '):8123\e[0m"