#!/bin/bash

set -e


packages=(
flameshot
papirus-icon-theme
rofi
jq
redshift
qt5ct
kvantum
gnome-system-monitor
polkit-gnome
gnome-keyring
mpd
mpc
ncmpcpp
playerctl
mpdris2
prettyping
lsd
thefuck
bat
fzf
ncdu
tldr
)

sudo dnf in -y "${packages[@]}"

