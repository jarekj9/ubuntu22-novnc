FROM ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG C
ENV VNCADDR 127.0.0.1:5901
ENV VNCPASS password

COPY app/app.sh /app/
COPY app/install_firefox.sh /app/
COPY noVNC/index.html /usr/share/novnc/

# fonts are required for novnc, lxde for GUI, autocutsel for vnc clipboard
RUN apt-get update && \
    apt-get install -y --no-install-recommends novnc websockify tightvncserver xfonts-base xfonts-100dpi xfonts-75dpi lxde autocutsel vim

RUN sh /app/install_firefox.sh
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

VOLUME /cert
EXPOSE 8080

CMD ["/app/app.sh"]
