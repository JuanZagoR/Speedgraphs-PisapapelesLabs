#!/bin/bash
###### Tags a reemplazar ######
filename="influxdb.yaml"
host="influxdb.paginadeprueba.com"
token="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
organization="xxxxxxxxxxxxxxxx"
bucket="Bucket"
tag="HomeAssistant"

set -e
echo -e "\e[1;35mSpeedgraphs - Pisapapeles Labs\e[0m"
sleep 1
echo -e "\e[0;35mInfluxDB Configurator 0.1 - Alpha\e[0m"
sleep 2

echo -e "\e[1;36m➤ Este script configurará la plantilla de InfluxDB para enviar las métricas a su base de datos\e[0m"
sleep 3

cd /mnt/Docker/Speedgraphs/Config

###### Host ######
echo
echo -e "\e[1;36m➤ Ingrese la dirección del host (o instancia) de InfluxDB:\e[0m"
echo -e "\e[1;30m  Ejemplo: influxdb.paginadeprueba.com\e[0m"
read -p " " replace
if [[ $host != "" && $replace != "" ]]; then
  sed -i "s/$host/$replace/" $filename && echo -e "\e[0;32m✔ Host añadido al archivo \e[0m" || echo -e "\e[0;31m✖ Hubo un problema al reemplazar el host\e[0m"
fi

###### Token ######
echo
echo -e "\e[1;36m➤ Ingrese su token de InfluxDB:\e[0m"
echo -e "\e[1;30m  Ejemplo: RrijJB-KTvOIGjfgQ9qL48mxXKKckZNC5DwkoafmOumx4VkDzatcwVC0g5z-RDP9QTp8Er-Wj5wY8Ckpi4Qf5g==\e[0m"
read -p " " replace
if [[ $token != "" && $replace != "" ]]; then
  sed -i "s/$token/$replace/" $filename && echo -e "\e[0;32m✔ Token añadido al archivo \e[0m"
fi

###### Organización ######
echo
echo -e "\e[1;36m➤ Ingrese la 'organización' a la que serán enviados los datos (en hexadecimal):\e[0m"
echo -e "\e[1;30m  Ejemplo: e9f7c9b3b3ef015e\e[0m"
read -p " " replace

if [[ $organization != "" && $replace != "" ]]; then
  sed -i "s/$organization/$replace/" $filename && echo -e "\e[0;32m✔ Organización añadida al archivo \e[0m"
fi

###### Bucket ######
echo
echo -e "\e[1;36m➤ Ingrese el bucket al que serán enviados los datos:\e[0m"
echo -e "\e[1;30m  Ejemplo: Speedgraphs\e[0m"
read -p " " replace

if [[ $bucket != "" && $replace != "" ]]; then
  sed -i "s/$bucket/$replace/" $filename && echo -e "\e[0;32m✔ Bucket añadido al archivo \e[0m"
fi

###### Tag ######
echo
echo -e "\e[1;36m➤ Ingrese el tag (sin espacios) que asignará a esta instancia de Home Assistant:\e[0m"
echo -e "\e[1;30m  Ejemplo: Operador01-MundoClawomistelTR\e[0m"
read -p " " replace

if [[ $tag != "" && $replace != "" ]]; then
  sed -i "s/$tag/$replace/" $filename && echo -e "\e[0;32m✔ Tag de instancia añadido al archivo \e[0m"
fi



echo
echo -e "\e[1;32m✔ Configuración de InfluxDB completada con éxito.\e[0m"
echo -e "\e[1;34m  Consulta la documentación oficial en github.com/JuanZagoR/Speedgraphs-PisapapelesLabs para terminar la configuración.\e[0m"
echo -e "\e[1;34m  Verifique la configuración dentro de Home Assistant antes de reiniciar. Gracias por usar este script. \e[0m"