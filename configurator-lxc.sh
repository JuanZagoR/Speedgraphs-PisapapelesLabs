#!/bin/sh
set -e
echo -e "\e[1;35mSpeedgraphs - Pisapapeles Labs\e[0m"
sleep 1
echo -e "\e[0;35mConfigurator 0.2 - Beta\e[0m"
sleep 2

echo
echo -e "\e[1;36mComprobando permisos...\e[0m"
if [[ $EUID -ne 0 ]]; then
   echo -e "\e[0;31mPara usar este script, es necesario elevar permisos. Use 'sudo bash "$0"' en su lugar\e[0m" 1>&2
   exit 1
fi
echo -e "\e[1;32m✔ El script se está ejecutando con permisos de administrador\e[0m"
echo

echo -e "\e[1;36m➤ Actualizando repositorios...\e[1;30m"
sleep 2
sudo apt update -qqqy && echo -e "\e[0;32m✔ Repositorios actualizados\e[0m" || echo -e "\e[0;31m✖ Hubo un problema al actualizar repositorios\e[0m"

echo
sleep 2
echo -e "\e[1;36m➤ Los siguientes paquetes serán actualizados:\e[1;30m"

sleep 2
sudo apt list --upgradable

echo
sleep 5
echo -e "\e[1;36m➤ Actualizando paquetes...\e[1;30m"

sleep 2
sudo apt upgrade -qqqy && echo -e "\e[0;32m✔ Paquetes actualizados\e[0m" || echo -e "\e[0;31m✖ Hubo un problema al actualizar los paquetes\e[0m"
echo -e "\e[1;36m➤ Instalando dependencias faltantes...\e[1;30m"

sleep 2
sudo apt install sudo net-tools wget curl -qqqy && echo -e "\e[0;32m✔ Dependencias instaladas correctamente\e[0m" || echo -e "\e[0;31m✖ Hubo un problema al instalar dependencias\e[0m"

echo
sleep 2
echo -e "\e[1;36m➤ Instalando la última versión de Docker (Community Edition) desde el sitio oficial...\e[1;30m"
sudo curl -fsSL https://get.docker.com/ | sudo bash -s
echo -e "\e[0;32m✔ Se ha instalado la última versión de Docker-CE\e[0m" || echo -e "\e[0;31m✖ Error al instalar la última versión de Docker-CE\e[0m"
echo

sleep 2
echo -e "\e[1;36m➤ Creando carpetas y descargando imagen de Home Assistant...\e[0m"
sudo mkdir -p /mnt/Docker/Speedgraphs
sudo chmod 777 -R /mnt/Docker/Speedgraphs
cd /mnt/Docker/Speedgraphs && echo -e "\e[0;32m✔ Directorios creados\e[0m" || echo -e "\e[0;31m✖ Error al acceder al directorio\e[0m"

echo
echo -e "\e[1;36m➤ Obteniendo la última imagen de Home Assistant, desde GHCR...\e[1;30m"
sleep 2
docker pull ghcr.io/home-assistant/home-assistant:stable && echo -e "\e[0;32m✔ Imagen descargada correctamente\e[0m" || echo -e "\e[0;31m✖ Hubo un problema al descargar la imagen\e[0m"

echo
echo -e "\e[1;36m➤ Obteniendo plantilla de Docker-Compose desde repositorio...\e[0m"
sleep 2
wget -q https://raw.githubusercontent.com/JuanZagoR/Speedgraphs-PisapapelesLabs/dev/Docker-Compose%20Templates/HomeAssistant/docker-compose.yaml -O docker-compose.yaml && echo -e "\e[0;32m✔ Plantilla descargada correctamente\e[0m" || echo -e "\e[0;31m✖ Hubo un problema al descargar la plantilla\e[0m"

sleep 2
echo
echo -e "\e[1;36m➤ Creando contenedor a partir de plantilla...\e[1;30m"
docker compose up -d && echo -e "\e[0;32m✔ Contenedor creado\e[0m" || echo -e "\e[0;31m✖ Hubo un problema al crear el contenedor\e[0m"

echo
echo -e "\e[1;36m➤ Abriendo logs de Home Assistant, a través de Docker...\e[0m"
sleep 5
docker logs PPLabs-HomeAssistant-Prod && echo -e "\e[0;32m✔ Contenedor funcionando\e[0m" || echo -e "\e[0;31m✖ Hubo un problema al solicitar los logs\e[0m"

echo
echo -e "\e[1;34m➤ Configura la instancia de Home Assistant de este servidor, a través de http://$(hostname  -I | cut -f1 -d' '):8123\e[0m"
echo -e "\e[1;34m  Una vez configurada la instancia, este script modificará la configuración de Home Assistant"
echo -e "\e[1;34m  para añadir las integraciones necesarias para llevar a cabo las pruebas de velocidad"

sleep 5
echo
echo "Presiona cualquier tecla para continuar con el script:"
read -s -n 1
echo -e "\e[0;32mContinuando con la configuración...\e[0m"
echo 

sleep 2
echo -e "\e[1;36m➤ Obteniendo archivos de configuración personalizados para Home Assistant\e[0m"
cd /mnt/Docker/Speedgraphs/Config
sudo mv configuration.yaml backup.configuration.yaml
sudo wget -q https://github.com/JuanZagoR/Speedgraphs-PisapapelesLabs/blob/dev/HomeAssistant%20Config/configuration.yaml -O configuration.yaml && echo -e "\e[0;32m✔ Archivo de configuración reemplazado \e[0m" || echo -e "\e[0;31m✖ Hubo un problema al reemplazar el archivo\e[0m"
sudo wget -q https://github.com/JuanZagoR/Speedgraphs-PisapapelesLabs/blob/dev/HomeAssistant%20Config/fastdotcom.yaml -O fastdotcom.yaml && echo -e "\e[0;32m✔ Configuración de Fast.com añadida \e[0m" || echo -e "\e[0;31m✖ Hubo un problema al añadir la configuración de Fast.com\e[0m"
sudo wget -q https://github.com/JuanZagoR/Speedgraphs-PisapapelesLabs/blob/dev/HomeAssistant%20Config/heartbeat.yaml -O heartbeat.yaml && echo -e "\e[0;32m✔ Configuración de Heartbeat añadida \e[0m" || echo -e "\e[0;31m✖ Hubo un problema al añadir la configuración de Heartbeat\e[0m"
sudo wget -q https://github.com/JuanZagoR/Speedgraphs-PisapapelesLabs/blob/dev/HomeAssistant%20Config/influxdb.yaml -O influxdb.yaml && echo -e "\e[0;32m✔ Configuración de InfluxDB añadida \e[0m" || echo -e "\e[0;31m✖ Hubo un problema al añadir la configuración de InfluxDB\e[0m"
sudo wget -q https://github.com/JuanZagoR/Speedgraphs-PisapapelesLabs/blob/dev/HomeAssistant%20Config/iperf3.yaml -O iperf3.yaml && echo -e "\e[0;32m✔ Configuración de iPerf3 añadida \e[0m" || echo -e "\e[0;31m✖ Hubo un problema al añadir la configuración de iPerf3\e[0m"

echo
echo -e "\e[1;36mConsulta la documentación para terminar la configuración. Gracias por usar este script.\e[0m"