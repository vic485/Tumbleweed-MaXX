#!/bin/bash

#if [[ $(id -u) -ne 0 ]]; then
if [ $UID != 0 ]; then
    echo "Script must be run as root"
    exit 1
fi

function confirm_prompt {
	while true; do
		read -p "$* [Y/n]: " yn
		case $yn in
			[Yy]*) return 0;;
			[Nn]*) return 1;;
		esac
	done
}

function write_data_dir {
	# https://bbs.archlinux.org/viewtopic.php?id=19223
	cat > /etc/profile.d/data_dirs.sh<< EOF
#!/bin/bash
export XDG_DATA_DIRS="$XDG_DATA_DIRS:/usr/share"
EOF
return 0
}

confirm_prompt "Did you install flatpak or a desktop environment (e.g. KDE/GNOME)?" || write_data_dir

echo "Installing dependencies."

# Install main packages needed from official instructions
zypper -n install cpp libXaw7 libncurses{5,6} libjpeg62 libgtk-2_0-0 libglut3 xterm xorg-x11-fonts dejavu-fonts

# Install extra packages needed to support Maxx applications
## libXm4 - required by winterm and adminterm
zypper -n install libXm4

echo "Installing MaXX Desktop."

# Install MaXX Interactive Desktop with official installer
cd /tmp
bash -c "$(curl -fsSL https://s3.ca-central-1.amazonaws.com/cdn.maxxinteractive.com/maxx-desktop-installer/MaXX-Desktop-LINUX-x86_64-2.2.0-Installer.sh)"

echo "Final preparations."

# Some final additional items
## shutdown is in /usr/sbin which is not in the standard user path causing the MaXX Shutdown and Reboot programs to fail
ln /usr/sbin/shutdown /usr/bin/shutdown

# Sketchy link until future updates fix.
## Rox-Filer requires libxml2.so.2 but only libxml2.so.16 is officially provided now
ln /usr/lib64/libxml2.so.16 /usr/lib64/libxml2.so.2

confirm_prompt "Install pavucontrol? (Will setup pulse/pipewire if not done already)" && zypper -n install pavucontrol

echo "Done! Logout or Reboot."

# Quick and dirty (and bad) check if we installed under "Generic Desktop"
#if [ "$XDG_CURRENT_DESKTOP" ~= "KDE ] && [ "$XDG_CURRENT_DESKTOP" ~= "GNOME" ]; then
# Fix png loading, installing flatpak may also perform the same function
# from https://bbs.archlinux.org/viewtopic.php?id=19223
#cat > /etc/profile.d/data_dirs.sh<< EOF
##!/bin/bash
#export XDG_DATA_DIRS="$XDG_DATA_DIRS:/usr/share"
#EOF
#fi
