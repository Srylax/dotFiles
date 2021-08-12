#!/usr/bin/env bash

##	+-----------------------------------+-----------------------------------+
##	|                                                                       |
##	|                        Pos Install Scrypt                             |
##	|                                                                       |
##	| Copyright (c) 2021, Bragatte <marcelobragatte@gmail.com>.             |
##	|                                                                       |
##	| All programs are free software: you can redistribute it and/or modify |
##	| it under the terms of the GNU General Public License as published by  |
##	| the Free Software Foundation, either version 3 of the License, or     |
##	| (at your option) any later version.                                   |
##	|                                                                       |
##	| This script should be run with SUDO command.                          |
##	| Detail instructions:                                                  |
##	| <https://github.com/BragatteMAS/Linux_posintall_script>               |
##	+-----------------------------------------------------------------------+

echo ' \n Auto install Programs!!!! \n	'

# -------------------------------------------------------------------------- #
#APT command line package used to install programs Debian/Ubuntu distros stores
# -----------------------------VARIABLES APT-------------------------------- #
PACMAN_INSTALL=(
discord
firefox
xmonad
xmonad-contrib
xmobar
xorg-server
xorg-apps
xorg-utils
xserver-utils
wget
curl
unzip
spotifyd
pulseaudio
pulseaudio-alsa
pulseaudio-bluetooth
pulseaudio-zeroconf
pulseaudio-equalizer
alsa-utils
bluez
bluez-utils
picom
pcmanfm
npm
nano
less
jdk-openjdk
atom
fish
emacs
linux-headers
dkms
usbutils
ghc-static
lsusb
python-pip
python-pywal
telnet
inetutils
ntfs-3g
netcat
openssh
openssh-server
htop
#synaptic              #System|program manager
neofetch              #System|verify info term
#gufw                  #System|firewall for linux
# git #git-lfs           #System|control modifications
#stacer                #System|clean and monitor programs
alacritty             #System|GPU enhanced terminal
#timeshift             #System|backup
#virtualbox-qt         #System|emulate OS	'sudo adduser $USER vboxusers'
#gdebi make rpm        #System|packages manager
#nemo                  #System|file manager
#zsh                   #Terminal|alternative option for bash in terminal
#terminator            #Terminal|high configurtion term
#gnome-sushi           #Image|previsualize files pressing space Nautilus
#flameshot             #Image|capture screen
#ffmpeg                #Image|extension
#arandr                #Video|monitor settings
#simplescreenrecorder  #Video|capture and film screen
#winff winff-gtk2 winff-qt       #Video|convert formats
#xpad                            #Productivity|sticky note application for GTK
#steam lutris piper ratbagd wine #Games|systems
#openssh-server                  #System|remotely controlling & transferring
#tigervnc-viewer                 #System|VNC
#openconnect network-manager-openconnect network-manager-openconnect-gnome       #System|VPN
#openvpn network-manager-openvpn network-manager-openvpn-gnome                   #System|ProtonVPN
#gnome-tweaks gnome-shell-extensions gnome-shell-extension-prefs chrome-gnome-shell  #Gnome|desktop utilities

)
# -------------------------------------------------------------------------- #
#Programs select from SNAP store <https://snapcraft.io/store>
# -----------------------------VARIABLES SNAP------------------------------- #
# SNAP_INSTALL=(
# bitwarden         #System|password manager
#audacity          #Sound|audio editor and recording app
#spotify           #Sound|digital music service
#bing-wall         #Image|Wallpapers automatically generated
#photogimp         #Image|patch 'Adobe' for GIMP
#inkscape          #Image|vector graphics software
#peek              #Image|gif creator
#kdenlive          #Video|Edition
#bpytop            #System|memory verify
# discord           #Comunication|interaction/gamer chat
#telegram-desktop  #Comunication|alternative for whatsapp
#rambox            #Comunication|join different systems of comunication
#chromium          #Productivity|browser
#todoist           #Productivity|Task manager
#foliate           #Productivity|ebook viewer
#feedreader        #Productivity|RSS
#zotero-snap       #Productivity|References
#homeserver        #Productivity|Share folders in urls
#docker            #Productivity|container environmental 'sudo groupadd docker' && 'sudo usermod -aG docker $USER'
#qsnapstore        #Productivity|Snap store improved
#pymol-oss         #Research
#weka-james-carroll #ML

# )
# --------------------------------------------------------------------------- #
#Programs select from the Arch User repository
# -----------------------------VARIABLES FLAT-------------------------------- #
YAY_INSTALL=(
bitwarden
spotify-tui
pacmixer
openrazer-meta
xorg-xrdb
)
# --------------------------------------------------------------------------- #
#Programs select from Flathub store <https://flathub.org/home>
# -----------------------------VARIABLES FLAT-------------------------------- #
# FLAT_INSTALL=(
# flatseal               #System|permissions
# filezilla              #System|SQL manager
# org.gnome.Boxes        #System|virtualization
# OnionShare             #System|transfer files safety
# pavucontrol	           #Sound|Control
# obsproject.Studio      #Video|streaming software
# org.blender.Blender    #Video|3D pipeline—model,animation,simulation,rendering
# org.videolan.VLC       #Video|media player open-source
# zoom                   #Video|webinars
# slack                  #Comunication|team chat
# skype                  #Comunication|chat support
# dropbox                #Productivity|online files manager
# masterpdf              #Productivity|pdf-editor
# com.wps.Office         #Productivity|office reader for doc win
# jamovi                 #Productivity|real-time, statisticial spreadsheet
# openboard              #Productivity|educational software interactive board
# geogebra               #Productivity|dynamic geometry program
# blanket                #Productivity|back environmental sounds to work
# organizer              #Productivity|shifts your files according to their filetype
# meld                   #Productivity|diif across files
# calibre                #Productivity|reader kindle types
# gitkraken              #Productivity|code commit
# nz.mega.MEGAsync       #Productivity|storage
# fontfinder             #Productivity|design
# com.toggl.TogglDesktop #Productivity|design
# com.gitlab.cunidev.Workflow #Productivity|timecontrol
# gpuviewer
# )
# ---------------------------------------------------------------------- #
#Deb packages
# URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
# URL_Balena="https://dl.bintray.com/etcher/debian/pool/stable/e/etcher/balena-etcher-electron_1.5.99_amd64.deb"  #att with inexistent ":" insert in the middle of url
# URL_Iriun="http://iriun.gitlab.io/iriunwebcam.deb"

#PPA
#sudo add-apt-repository ppa:lutris-team/lutris

### --------------------- Basic system utilities ---------------------- ###
## Removing any apt locks ##
# sudo rm /var/lib/dpkg/lock-frontend
# sudo rm /var/cache/apt/archives/lock

## Adding / Confirming 32-bit Architecture ##
# sudo dpkg --add-architecture i386

## Updating the repository ##
sudo pacman -Syu

##installing yay
sudo pacman -Sy --needed git base-devel
mkdir dev/workspaces/
cd dev/workspaces/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# ---------------------------------------------------------------------- #
## Install programs Pacman
for pacman_program in ${PACMAN_INSTALL[@]}; do
  sudo pacman -Sy --needed "$pacman_program"
  echo "[successful installation] - $pacman_program"
done

## Install programs yay
for yay_program in ${YAY_INSTALL[@]}; do
  if ! dpkg -l | grep -q $ysy_program; then # Just install if not exist
    yay -Sy --needed "$yay_program"
  fi
done

# ## Install programs SNAP
# for snap_program in ${SNAP_INSTALL[@]}; do
#   if ! pacman -Q | grep -q $snap_program; then # Just install if not exist
#     sudo snap install "$snap_program"
#   fi
# done


# ---------------------------------------------------------------------- #
echo '\n All done! Reboot your pc, run this script a second time to check the instalation confirmation message and keep walking!'
### ------------------------------------------------------------------- ####
