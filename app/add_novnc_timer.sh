#!/bin/bash

# adds timer.js after given line: <script type="module" crossorigin="anonymous" src="app/ui.js"></script> in /usr/share/novnc/vnc.html
sed -i '/<script type="module" crossorigin="anonymous" src="app\/ui.js"><\/script>/r /app/timer.js' /usr/share/novnc/vnc.html

# adds timer.html after <body> in /usr/share/novnc/vnc.html
sed -i '/<body>/r /app/timer.html' /usr/share/novnc/vnc.html

# sets correct stop time in added countdown javascript in /usr/share/novnc/vnc.html
zuludate=$(date -u -d "+$MAXMINUTES minutes" +"%Y-%m-%dT%H:%M:%SZ")
sed -i "s/2024-01-01T10:00:00Z/$zuludate/" /usr/share/novnc/vnc.html
