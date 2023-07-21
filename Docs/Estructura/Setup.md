# Setup
Para comenzar, es necesario tener Home Assistant funcionando en un servidor. 

Dado que vamos a cargar algunas configuraciones personalizadas, es necesario que la instancia nos permita modificar con facilidad los archivos de configuración dentro de la carpeta de instalación. El método más simple, es utilizando Home Assistant OS/Supervised y añadiendo el complemento 'Text Editor' que se encuentra en la tienda.

En caso de tener instalado Home Assistant Core, es obligatorio tener acceso también a la carpeta de instalación para poder añadir las plantillas.

Una vez configurada correctamente la instancia de Home Assistant, es necesario modificar el archivo *configuration.yaml* con el contenido de la carpeta *HomeAssistant Config* de este repositorio. Además, será necesario crear o copiar los siguientes archivos:

- *fastdotcom.yaml*
- *heartbeat.yaml*
- *http.yaml*
- *influxdb.yaml*
- *iperf3.yaml*

Y añadir las configuraciones correspondientes de cada una de las versiones correspondientes del repositorio. En el caso de los archivos *iperf3.yaml* e *influxdb.yaml*, también será necesario reemplazar los valores predeterminados del host, con aquellos que correspondan a nuestros servidores de prueba y base de datos, respectivamente.

# LXC/VM
En este repositorio se encuentra una serie de scripts que permiten configurar rápidamente Home Assistant y las distintas integraciones usadas para las pruebas, con apenas un par de comandos. El único requisito, es utilizarlos dentro de una máquina virtual (VM) o contenedor LXC basado en Ubuntu o Debian.

Estos scripts se encargarán de instalar las dependencias faltantes, descargar las plantillas necesarias para hacerlos funcionar, y modificar los archivos de configuración para habilitar las integraciones.



``` bash
curl -fsSL https://raw.githubusercontent.com/JuanZagoR/Speedgraphs-PisapapelesLabs/dev/configurator-lxc.sh > /tmp/configurator.sh && sudo bash configurator.sh
```