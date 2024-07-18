# Ubuntu docker image with firefox and noVNC access

## Base Docker Image
ubuntu:jammy

## Run the image
noVNC will listen on port 8080 inside the container and pre-installed caddy will do auto-tls proxying to for it on port 443

```
docker run --rm -e VNCPASS=yourpassword -p 80:80 -p 443:443 jarekj9/ubuntu22novnc:tls
docker run --rm -e VNCPASS=yourpassword -e URL_TO_OPEN=https://github.com -p 80:80 -p 443:443 jarekj9/ubuntu22novnc:tls
docker run --rm -e VNCPASS=yourpassword -e URL_TO_OPEN=https://github.com -e MAXMINUTES=20 -p 80:80 -p 443:443 jarekj9/ubuntu22novnc:tls
```

## Parameters - env variables:
- VNCPASS - password required to access novnc
- URL_TO_OPEN - this url will be opened in browser upon startup
- MAXMINUTES - this will display time countdown in novnc page (to use with custom automatic container removal)
