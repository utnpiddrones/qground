# QGroundControl
Repositorio con el docker e implementación de [QGroundControl](https://github.com/mavlink/qgroundcontrol).

Para utilizar QGC, vea la seccion [Ejecución](#ejecución).

Para construir una nueva version de QGC, vea la sección [Instalación y buildeo](#instalación-y-buildeo).

Todas las imágenes de docker están subidas en Docker Hub bajo el repositorio [utnpiddrones/qground](https://hub.docker.com/repository/docker/utnpiddrones/qground).


## Ejecución
Si solamente quiere correr QGC, puede ejecutar la siguiente línea
```
docker run --rm utnpiddrones/qground:latest
```

Si quiere correr QGC en su proyecto, debe incluir el siguiente servicio mínimo en su archivo `docker-compose.yaml`:
```
services:
  qground:
    image: utnpiddrones/qground:latest

    environment:
      - DISPLAY=${DISPLAY}
      - QT_X11_NO_MITSHM=1
      
    privileged: true

    volumes:
      - /tmp/.X11-unix:/tmp/.X11-unix:rw
```


## Instalación y buildeo

En esta sección se explican los pasos necesarios para construir desde el código fuente una nueva versión de QGroundControl.

1. Clonar este repositorio con todos sus submódulos:

```
$ git clone --recursive -j8 https://github.com/utnpiddrones/qground.git
```

En caso de querer actualizar la versión de QGC, hacer un checkout de la versión estable que quiera y luego actualizar los submódulos con:
```
cd qgroundcontrol && git checkout vX.X.X
cd .. && git submodule update --recursive
```

2. Crear la carpeta para buildear y ejecutar el docker correspondiente:

```
$ mkdir qgroundcontrol/build
$ docker compose run --rm qgroundbuild
```

3. Ahora, dentro de la carpeta `qgroundcontrol/build` tendrá la totalidad de los archivos de compilación.

## Datos del último build

Versión de QGroundControl (commit hash): 05aaf33cf5647d56fa9210311022bc486fe9af9b (Revisado el 25/05/2022)

## TODO
1. Implementar carga automática de misiones y parámetros.
