#!/bin/bash

bail()
{
  echo "$1"
  exit 1
}

if [ -z "${VNCADDR}" ]; then
  bail "VNCADDR cannot be null!"
fi

unset SSLCERT
unset SSLARG
if [ -n "${CERTFILE}" ]; then
  SSLCERT="/cert/${CERTFILE}"
  if [ -e "${SSLCERT}" ]; then
    SSLARG="--cert=${SSLCERT}"
  else
    bail "${SSLCERT} does not exist!"
  fi
fi

# Set USER environment variable
export USER=root

# Create .vnc directory if it doesn't exist
mkdir -p /root/.vnc

# Generate Xauthority file
touch /root/.Xauthority

# Set correct font path
export X11FONTPATH=/usr/share/fonts/X11/misc/,/usr/share/fonts/X11/Type1

# Start VNC server on display :1 with a password
echo $VNCPASS | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

#for novnc clipboard need autocutsel:
cat <<EOF> /root/.vnc/xstartup
#!/bin/sh
xrdb "$HOME/.Xresources"
xsetroot -solid grey -cursor_name left_ptr
autocutsel -fork
export XKL_XMODMAP_DISABLE=1
/etc/X11/Xsession
EOF
chmod +x /root/.vnc/xstartup

# workaround to get rid of "No session for pid" error on startup
mv /usr/bin/lxpolkit /usr/bin/lxpolkit.bak

# Start VNC server on display :1
export DISPLAY=:1
vncserver :1 -geometry 1600x900 -depth 24
startlxde &

# Start websockify to connect VNC server to novnc
exec websockify --web=/usr/share/novnc/ ${SSLARG} 8080 "${VNCADDR}"
