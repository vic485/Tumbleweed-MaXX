#!/bin/sh

# Sort of sets up xscreensaver to work with MaXX
# Currently, xscreensaver-settings fails with the below error, so my .xscreensaver config is provided
# 20:43:51: X error:
#  Failed request: BadMatch (invalid parameter attributes)
#  Major opcode:   42 (X_SetInputFocus)
#  Resource id:    0x130000b
#  Serial number:  505 / 523

mkdir -p ~/.config/systemd/user/

# Output user service file from /usr/share/xscreensaver
# omit `Alias` under install section because it fails to register
# add no-splash to exec to disable splash screen
cat >~/.config/systemd/user/xscreensaver.service<<EOF
[Unit]
Description=XScreenSaver
Documentation=man:xscreensaver
Documentation=man:xscreensaver-settings
Documentation=https://www.jwz.org/xscreensaver
After=graphical-session-pre.target
PartOf=graphical-session.target
ConditionUser=!@system
Conflicts=org.gnome.ScreenSaver org.cinnamon.ScreenSaver org.mate.ScreenSaver org.xfce.ScreenSaver light-locker

[Service]
ExecStart=/usr/bin/xscreensaver --no-splash
Restart=on-failure
OOMScoreAdjust=-1000

[Install]
WantedBy=default.target
EOF

systemctl --user enable xscreensaver
systemctl --user start xscreensaver
