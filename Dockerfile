FROM i386/debian:bookworm

LABEL maintainer="im@fruw.org"

ENV LANG en_US.utf8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && \
    apt-get -y install --no-install-recommends \
    ca-certificates \
    locales \
    unzip

RUN localedef -c -i en_US -f UTF8 en_US.UTF8

WORKDIR /steamcmd

ADD http://media.steampowered.com/client/steamcmd_linux.tar.gz /tmp
RUN tar xf /tmp/steamcmd_linux.tar.gz

RUN cp linux32/crashhandler.so linux32/steamservice.so
RUN mkdir ~/.steam
RUN ln -s /steamcmd/linux32/ ~/.steam/sdk32

RUN ./steamcmd.sh +force_install_dir /hlds +login anonymous +app_update 90 +quit; exit 0
RUN ./steamcmd.sh +force_install_dir /hlds +login anonymous +app_update 90 validate +quit

WORKDIR /hlds

ADD https://github.com/AMXX4u/BasePack/releases/download/1.0.20/BasePack.zip /tmp
RUN unzip -o /tmp/BasePack.zip -d /hlds
RUN chmod +x hlds_linux

RUN touch cstrike/banned.cfg
RUN touch cstrike/listip.cfg

ENTRYPOINT ./hlds_run -game cstrike -strictportbind -ip 0.0.0.0 -port 27015 \
  +sv_lan 0 +map de_dust2 -maxplayers 16 +localinfo amxx_cfg cstrike/addons/amxmodx
