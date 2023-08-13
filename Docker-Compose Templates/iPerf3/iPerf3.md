# Configuración de iPerf3
Para configurar una instancia equipada con iPerf, a fin de realizar pruebas de velocidad fuera de la red, es necesario contar con un servidor externo que nos permita tomar mediciones de manera precisa de nuestra conexión a internet. 

## iPerf3 dentro de Docker 
La forma más simple de ejecutar un servidor iPerf3, es a través de un contenedor en Docker. Para ello, únicamente bastará con ejecutar los siguientes comandos:

- Creamos una carpeta para guardar la plantilla, y luego entramos a ella:

    ```bash
    mkdir iPerf3-Server && cd iPerf3-Server
    ```

- Posteriormente, descargamos la plantilla de iPerf3 desde este repositorio
    ```bash
    wget https://raw.githubusercontent.com/JuanZagoR/Speedgraphs-PisapapelesLabs/main/Docker-Compose%20Templates/iPerf3/docker-compose.yaml
    ```
- Finalmente, ejecutamos *docker-compose* para iniciar el contenedor con las configuraciones de la plantilla:

    ```bash
    docker-compose up -d
    ```


## iPerf3 como servicio
En caso de que queramos ejecutar iPerf directamente sobre el servidor a manera de servicio, primero instalaremos el paquete correspondiente:

```bash
sudo apt install iperf3 -y
```

Luego, añadiremos un usuario interno para manejar dicho servicio:

```bash
sudo adduser iperf --disabled-login --gecos iperf
```
Y añadiremos un archivo de configuración para iPerf3:
```bash
sudo nano /etc/systemd/system/iperf3-server@.service
```
En donde pegaremos lo siguiente:
```bash
[Unit]
Description=iperf3 server on port %i
After=syslog.target network.target

[Service]
ExecStart=/usr/bin/iperf3 -s -1 -p %i
Restart=always
RuntimeMaxSec=3600
User=iperf

[Install]
WantedBy=multi-user.target
DefaultInstance=5201
```
Guardamos con Ctrl+C, y cerramos con Ctrl+X, para recargar los servicios enseguida:
```bash
sudo systemctl daemon-reload
```
### Pruebas de velocidad simultáneas
Para realizar pruebas simultáneas en el mismo servidor, sin que nos encontremos el error *iperf3: error - the server is busy running a test. try again later*, añadimos el siguiente comando, que creará un script para Systemd con 41 instancias de iPerf3: entre los puertos 9200 y 9240:
```bash
for p in $(seq 9200 9240); do sudo systemctl enable iperf3-server@$p ; done
```
Finalmente, reiniciamos el servidor:
```bash
sudo reboot
```