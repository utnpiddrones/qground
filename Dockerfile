FROM ubuntu:22.04

RUN apt-get update && apt-get remove modemmanager -y && apt-get install -y \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-libav \
    gstreamer1.0-gl \
    libqt5gui5 \
    && rm -rf /var/lib/apt/lists/*

COPY QGC.AppImage /home/QGC.AppImage

RUN chmod +x /home/QGC.AppImage

COPY entrypoint.sh /entrypoint.sh

RUN apt-get update && apt-get install -y --no-install-recommends \
    espeak \
    fuse \
    libespeak-dev \
    libfuse2 \
    libgstreamer-plugins-base1.0-dev \
    libgstreamer1.0-0 \
    libgstreamer1.0-dev \
    libsdl2-dev \
    libssl-dev \
    libudev-dev \
    locales \
    speech-dispatcher \
&& rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash user

USER user

WORKDIR /home

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/home/QGC.AppImage" ]



