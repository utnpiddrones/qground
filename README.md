# QGroundControl
Repositorio con el docker e implementación de [QGroundControl](https://github.com/mavlink/qgroundcontrol).

Para utilizar QGC, vea la seccion [Uso](#Uso).

Para construir una nueva version de QGC, vea la sección [Instalación y buildeo](#instalación-y-buildeo).

Todas las imágenes de docker están subidas en Docker Hub bajo el repositorio [utnpiddrones/qground](https://hub.docker.com/repository/docker/utnpiddrones/qground).


## Uso
Para usar QGC, ejecutar:
```bash
docker run --rm utnpiddrones/qground:latest
```

Para intercomunicar QGC con otros Dockers, debe incluir el siguiente servicio mínimo en su archivo `docker-compose.yaml`, completando con el nombre de su red:

```yaml
networks:
  <NETWORK_NAME>:

services:
  qground:
    image: utnpiddrones/qground:latest

    environment:
      - DISPLAY=${DISPLAY}
      - QT_X11_NO_MITSHM=1
      
    privileged: true

    container_name: <CONTAINER_NAME>

    volumes:
      - /tmp/.X11-unix:/tmp/.X11-unix:rw

    networks:
      <NETWORK_NAME>:
```


## Instalación y buildeo

En esta sección se explican los pasos necesarios para construir desde el código fuente una nueva versión de QGroundControl.

1. Clonar este repositorio con todos sus submódulos:

```bash
git clone --recursive -j8 https://github.com/utnpiddrones/qground.git
```

En caso de querer actualizar la versión de QGC, hacer un checkout de la versión estable que quiera y luego actualizar los submódulos con:
```
cd qgroundcontrol && git checkout vX.X.X
cd .. && git submodule update --recursive
```

2. Revisar el archivo `.env` y determinar el "tag" con el que se quiere trabajar, o al que se quiere actualizar la versión.

3. Crear la carpeta para buildear y ejecutar el docker correspondiente:

```
$ mkdir qgroundcontrol/build
$ docker compose run --rm qgroundbuild
```

4. Ahora, dentro de la carpeta `qgroundcontrol/build` tendrá la totalidad de los archivos de compilación.
Por defecto, no puede ejecutarse la GUI desde el docker que los compiló. Por lo tanto, es necesario ejecutar un nuevo Docker copiando el
ejecutable y sus dependencias que fueron compiladas.

```
$ docker compose run --rm qground
```

5. Una vez obtenida la imagen final, reconstruirla y subirla a Docker Hub:
```
$ docker compose build qground
$ docker compose push qground
```
