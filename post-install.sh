#!/bin/bash
sleep 2
echo
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