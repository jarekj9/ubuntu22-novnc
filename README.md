# Ubuntu docker image with firefox and noVNC access

## Base Docker Image
ubuntu:jammy
##
Branch with_caddy_https adds caddy for automatic https/tls. It works with any domain, which does not have to be preconfigured. It uses port 443 (and 80 for ACME challenge).
It can also open defined URL in firefox upon startup.

## Run the image
noVNC will listen on port 8080 inside the container.


# branch with_caddy_https:

```
docker run --rm -e VNCPASS=yourpassword -e URL_TO_OPEN=https://github.com -p 80:80 -p 443:443 jarekj9/ubuntu22novnc:tls

 Expose:                                                                                            
 TCP-443 - HTTPS                                                                                    
 TCP-80 - ACME Challenge                                                                            
┌───┬──────────────────────────────────────────────────────────────────────────────────────────────┐
│   │                                                                                              │
│   │                                                                                              │
│   │                                                                                              │
│ ┌─▼───────────────────┐          ┌─────────┐             ┌────────────┐         ┌────────────┐   │
│ │                     │          │         │             │            │ TCP-5901│            │   │
│ │ Caddy web server    │ TCP-8080 │  noVNC  │  websockets │ websockify │  (VNC)  │ VNC server │   │
│ │ with automatic TLS  ├──────────►         ├─────────────►            ├─────────►            │   │
│ │                     │          │         │             │            │         │            │   │
│ └─────────────────────┘          └─────────┘             └────────────┘         └────────────┘   │
│                                                                                                  │
│                                                                                                  │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

# branch master:

```
docker run --rm -e VNCPASS=yourpassword -e URL_TO_OPEN=https://github.com -p 8080:8080 jarekj9/ubuntu22novnc

  Expose:                                                                                             
  TCP-8080                                                                                            
 ┌──┬───────────────────────────────────────────────────────────────────────────────────────────────┐ 
 │  │                                                                                               │ 
 │  │                                                                                               │ 
 │  │                                                                                               │ 
 │  │                               ┌─────────┐             ┌────────────┐         ┌────────────┐   │ 
 │  │                               │         │             │            │ TCP-5901│            │   │ 
 │  │                               │  noVNC  │  websockets │ websockify │  (VNC)  │ VNC server │   │ 
 │  └───────────────────────────────►         ├─────────────►            ├─────────►            │   │ 
 │                                  │         │             │            │         │            │   │ 
 │                                  └─────────┘             └────────────┘         └────────────┘   │ 
 │                                                                                                  │ 
 │                                                                                                  │ 
 └──────────────────────────────────────────────────────────────────────────────────────────────────┘                                                                                                  
                                                                                                        
```

## Parameters - env variables:
- VNCPASS - password required to access novnc
- URL_TO_OPEN - this url will be opened in browser upon startup
- MAXMINUTES - this will display time countdown in novnc page (to use with custom automatic container removal)
