#!/usr/bin/env bash

[ "$EUID" -eq 0 ] && { echo "Don't run uder sudo/root."; exit 1; }

SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]:-$0}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

sudo pacman -S --noconfirm  pacman-contrib gnupg
sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key F3B607488DB35A47 
sudo pacman -U --noconfirm \
'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-22-1-any.pkg.tar.zst' \
'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-22-1-any.pkg.tar.zst' 
sudo cp "$SCRIPT_DIR/pacman_with_cachy.conf" /etc/pacman.conf
sudo pacman -Syu
