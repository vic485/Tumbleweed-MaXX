#!/bin/bash

#if [[ $(id -u) -ne 0 ]]; then
if [ $UID != 0 ]; then
    echo "Script must be run as root"
    exit 1
fi

# Install main packages needed from official instructions
zypper -n install cpp libXaw7 libncurses{5,6} libjpeg62 libgtk-2_0-0 libglut3 xterm xorg-x11-fonts dejavu-fonts

# Install extra packages needed to support Maxx applications
## libXm4 - required by winterm and adminterm
zypper -n install libXm4

# Install MaXX Interactive Desktop with official installer
cd /tmp
bash -c "$(curl -fsSL https://s3.ca-central-1.amazonaws.com/cdn.maxxinteractive.com/maxx-desktop-installer/MaXX-Desktop-LINUX-x64-2.1.1-Installer.sh)"

# Some final additional items
## shutdown is in /usr/sbin which is not in the standard user path causing the MaXX Shutdown and Reboot programs to fail
ln /usr/sbin/shutdown /usr/bin/shutdown

# TODO: rox-filer fails to load pngs on generic desktop install. The below should work according to
# https://rox.sourceforge.net/desktop/node/91.html but it didn't work for me. rox-filer is supposed to be
# temporary, so we may not need to fix this in the future.
#gdk-pixbuf-query-loaders-64 > /etc/gtk-2.0/gdk-pixbuf.loaders
