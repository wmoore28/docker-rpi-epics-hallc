FROM wmoore28/rpi-epics:latest

ENV http_proxy=http://jprox.jlab.org:8081 \
    https_proxy=https://jprox.jlab.org:8081

ENV EPICS_CA_ADDR_LIST="129.57.215.255"

# Added to dialout for access to devices such as /dev/ttyUSB0
RUN useradd -ms /bin/bash epics \
    && usermod -a -G dialout epics
RUN apt-get update \
    && apt-get install -y \
        procserv \
        vim \
    && apt-get clean

COPY run-ioc.sh /
RUN chmod +x /run-ioc.sh

RUN mkdir /logs \
    && chown -R epics:epics /logs
VOLUME /logs

USER epics
WORKDIR /home/epics

RUN cat /usr/local/epics/.epicsrc >> ~/.bashrc
RUN git clone https://github.com/wmoore28/hallc-rpi-epics apps \
    && cd apps \
    && make

CMD /run-ioc.sh ${ioc} ${port}
