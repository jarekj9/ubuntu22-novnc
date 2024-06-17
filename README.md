# Ubuntu docker image with firefox and noVNC access

## Base Docker Image
ubuntu:jammy

## Run the image
noVNC will listen on port 8080 inside the container and pre-installed caddy will do auto-tls proxying to for it on port 443

```
docker run --rm -e VNCPASS=yourpassword -p 80:80 -p 443:443 jarekj9/ubuntu22novnc:tls
docker run --rm -e VNCPASS=yourpassword -e URL_TO_OPEN=https://github.com -p 80:80 -p 443:443 jarekj9/ubuntu22novnc:tls
```