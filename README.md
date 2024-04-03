# Ubuntu docker image with firefox and noVNC access

## Base Docker Image
ubuntu:jammy

## Run the image
noVNC will listen on port 8080 inside the container.
```
docker run --rm -e VNCPASS=yourpassword -p 8080:8080 jarekj9/ubuntu22novnc
```
