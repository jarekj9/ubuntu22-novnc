#!/bin/bash

apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
apt update
apt install caddy -y



cat <<EOF> /etc/caddy/Caddyfile
{
    # Global options block
    log {
        output file /var/log/caddy/access.log {
            roll true              # Rotate logs, enabled by default
            roll_size 10MB         # Set the maximum size a log file can grow to before it gets rotated
            roll_keep 10           # Set the number of rolled files to keep
            roll_keep_for 720h     # Set the maximum age of a log file before it gets deleted
        }
        level INFO                 # Set the log level (INFO, DEBUG, ERROR, etc.)
    }
}
:443 {
tls internal

@websockets {
    header Connection *Upgrade*
    header Upgrade    websocket
}
reverse_proxy @websockets http://localhost:8080

reverse_proxy http://localhost:8080

    tls {
        on_demand
    }
}
EOF