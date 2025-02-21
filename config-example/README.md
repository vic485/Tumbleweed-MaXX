# Configuration files

## alacritty.toml
Alacritty terminal configuration. Uses JetBrains Mono font and Kanagawa colors from Gogh color schemes. Place in `~/.config/alacritty/`

## lightdm.conf
LightDM greeter configuration to set cursor and background. Can be merged with `/etc/lightdm/lightdm-gtk-greeter.conf`

## settings.ini
GTK3/4 settings file. Prefers dark mode for applications, and sets the cursor. Place in `~/.config/gtk-3.0/` and `~/.config/gtk-4.0/` Note: cursor size is set to 24 and should be changed to 32 to match default or change size in `~/.maxxdesktop/Xdefaults.d/Xdefaults.5dwm`

## sgisession
Auto start script. Starts some nice to have extra utilites. Place as `~/.sgisession`

## stalonetrayrc
Simple defaults for stalonetray use with Maxx. Fixes icon size and (tries to) screen position. Position set to bottom left of a 1080 display. Place as `~/.stalonetrayrc`
