# Ubuntu docker image with firefox and noVNC access

## Base Docker Image
ubuntu:jammy
##
Branch with_caddy_https adds caddy for automatic https/tls. It works with any domain, which does not have to be preconfigured. It uses port 443 (and 80 for ACME challenge).

## Run the image
noVNC will listen on port 8080 inside the container.
```
docker run --rm -e VNCPASS=yourpassword -p 8080:8080 jarekj9/ubuntu22novnc
docker run --rm -e VNCPASS=yourpassword -e URL_TO_OPEN=https://github.com -p 8080:8080 jarekj9/ubuntu22novnc
```

```
+--------------------------------------------------------------------------------------------------+
|                                                                                                  |
| TCP-443 - HTTPS                                                                                  |
| TCP-80 - ACME Challenge                                                                          |
| +---------------------+          +---------+             +------------+         +------------+   |
| |                     |          |         |             |            | TCP-5901|            |   |
| | Caddy web server    | TCP-8080 |  noVNC  |  websockets | websockify |  (VNC)  | VNC server |   |
| | with automatic TLS  +---------->         +------------->            +--------->            |   |
| |                     |          |         |             |            |         |            |   |
| +---------------------+          +---------+             +------------+         +------------+   |
|                                                                                                  |
|                                                                                                  |
+--------------------------------------------------------------------------------------------------+
```
