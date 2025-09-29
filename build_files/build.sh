#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos

dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
COPRS="atim/starship erikreider/SwayNotificationCenter yalter/niri-git tofik/nwg-shell"
for COPR in $COPRS; do dnf5 -y copr enable $COPR; done
dnf5 -y install wl-clipboard distrobox alsa-firmware polkit dbus-tools dbus-daemon qt5-wayland qt6-wayland wireplumber pipewire pulseaudio-utils network-manager-applet NetworkManager-openvpn NetworkManager-openvpn-gnome NetworkManager-openconnect NetworkManager-openconnect-gnome bluez bluez-tools blueman nautilus gvfs-mtp gvfs-gphoto2 gvfs-smb gvfs-nfs gvfs-fuse gvfs-archive heif-pixbuf-loader ffmpeg ffmpeg-libs ffmpegthumbnailer pipewire-libs-extra libfdk-aac gstreamer1-plugins-bad gstreamer1-plugins-ugly gnome-keyring luajit luajit-devel spice-server spice-vdagent spice-webdavd micro starship swww swaync niri greetd greetd-selinux xwayland-satellite adw-gtk3-theme xdg-desktop-portal-gnome firacode-nerd-fonts fish gtklock wofi fuzzel eza bat doas tailscale alacritty hyfetch fastfetch nwg-look android-tools
for COPR in $COPRS; do dnf5 -y copr disable $COPR; done

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
