ARG IMAGE_NAME="utnpiddrones/qground"
ARG TAG_BUILD="build"

FROM ${IMAGE_NAME}:${TAG_BUILD}

USER root

RUN apt update && apt -y --quiet --no-install-recommends install \
    libqt5gui5 \
	&& apt-get -y autoremove \
	&& apt-get clean autoclean \
	&& rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

USER user

COPY qgroundcontrol/build/staging /home/user/qground

CMD [ "/home/user/qground/QGroundControl" ]



