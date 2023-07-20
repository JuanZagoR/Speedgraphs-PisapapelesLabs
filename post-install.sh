#!/bin/bash
set -e
echo -e "\e[1;35mSpeedgraphs - Pisapapeles Labs\e[0m"
sleep 1
echo -e "\e[0;35mPost-Install 0.1 - Alpha\e[0m"
sleep 2
echo

echo -e "\e[1;36m➤ Eliminando respaldo antiguo existente...\e[0m"
sleep 1
sudo rm -rf /mnt/Docker/Speedgraphs/Config/BackupConfig && echo -e "\e[0;32m✔ Respaldo antiguo eliminado \e[0m" || echo -e "\e[0;31m✖ Hubo un problema al eliminar el respaldo antiguo\e[0m"
echo

echo -e "\e[1;36m➤ Respaldando configuración actual...\e[0m"
sleep 1
sudo mkdir /mnt/Docker/Speedgraphs/Config/BackupConfig
yes | sudo cp -i /mnt/Docker/Speedgraphs/Config/*.yaml /mnt/Docker/Speedgraphs/Config/BackupConfig
echo -e "\e[0;32m✔ Configuración anterior respaldada \e[0m"

echo
echo -e "\e[1;36m➤ Obteniendo archivos de configuración personalizados para Home Assistant\e[0m"
cd /mnt/Docker/Speedgraphs/Config
sudo wget -q https://github.com/JuanZagoR/Speedgraphs-PisapapelesLabs/blob/dev/HomeAssistant%20Config/configuration.yaml -O configuration.yaml && echo -e "\e[0;32m✔ Archivo de configuración reemplazado \e[0m" || echo -e "\e[0;31m✖ Hubo un problema al reemplazar el archivo\e[0m"
sudo wget -q https://github.com/JuanZagoR/Speedgraphs-PisapapelesLabs/blob/dev/HomeAssistant%20Config/fastdotcom.yaml -O fastdotcom.yaml && echo -e "\e[0;32m✔ Configuración de Fast.com añadida \e[0m" || echo -e "\e[0;31m✖ Hubo un problema al añadir la configuración de Fast.com\e[0m"
sudo wget -q https://github.com/JuanZagoR/Speedgraphs-PisapapelesLabs/blob/dev/HomeAssistant%20Config/heartbeat.yaml -O heartbeat.yaml && echo -e "\e[0;32m✔ Configuración de Heartbeat añadida \e[0m" || echo -e "\e[0;31m✖ Hubo un problema al añadir la configuración de Heartbeat\e[0m"
sudo wget -q https://github.com/JuanZagoR/Speedgraphs-PisapapelesLabs/blob/dev/HomeAssistant%20Config/influxdb.yaml -O influxdb.yaml && echo -e "\e[0;32m✔ Configuración de InfluxDB añadida \e[0m" || echo -e "\e[0;31m✖ Hubo un problema al añadir la configuración de InfluxDB\e[0m"
sudo wget -q https://github.com/JuanZagoR/Speedgraphs-PisapapelesLabs/blob/dev/HomeAssistant%20Config/iperf3.yaml -O iperf3.yaml && echo -e "\e[0;32m✔ Configuración de iPerf3 añadida \e[0m" || echo -e "\e[0;31m✖ Hubo un problema al añadir la configuración de iPerf3\e[0m"

echo
echo -e "\e[1;33mConsulta la documentación oficial en github.com/JuanZagoR/Speedgraphs-PisapapelesLabs para terminar la configuración.\e[0m"
echo -e "\e[1;36mGracias por usar este script.\e[0m"