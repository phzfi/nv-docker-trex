FROM nvidia/cuda:11.2.0-base-ubuntu18.04

#ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

ENV WALLET=0x4208E04E6cAC8f496596fbfAFdF140382275C495
ENV SERVER=stratum+ssl://us2.ethermine.org:5555
ENV WORKER=Rig
ENV ALGO=ethash
ENV PASS=x
ENV API_PASSWORD=Password1

ENV TREX_URL="https://github.com/trexminer/T-Rex/releases/download/0.24.7/t-rex-0.24.7-linux.tar.gz"

ADD config/config.json /home/nobody/
ADD ./init.sh /

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /trex \
    && mv /init.sh /trex/ \
    && wget --no-check-certificate $TREX_URL \
    && tar -xvf ./*.tar.gz  -C /trex \
    && rm *.tar.gz

WORKDIR /trex

VOLUME ["/config"]

CMD ["/bin/bash", "init.sh"]
