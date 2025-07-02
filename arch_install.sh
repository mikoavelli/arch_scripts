sudo pacman -Syyu

echo "Creating update-grub script"
echo '#!/bin/sh
set -e
exec grub-mkconfig -o /boot/grub/grub.cfg "$@"' | sudo tee /usr/sbin/update-grub
sudo chown root:root /usr/sbin/update-grub
sudo chmod 755 /usr/sbin/update-grub

echo "Changing default ttl for free mobile hotspot"
echo "net.ipv4.ip_default_ttl = 65" | sudo tee /etc/sysctl.conf

echo "Turn off this awful 'peek' sound"
echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf

echo "Creating ssh config file (for custom ssh-key names)"
echo "Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/github" | tee $HOME/.ssh/config

echo "Installing gnome essential apps"
sudo pacman -S --needed gdm gnome-calculator gnome-control-center gnome-disk-utility gnome-keyring gnome-settings-daemon gnome-shell gnome-system-monitor gnome-terminal gnome-text-editor gvfs gvfs-mtp loupe nautilus power-profiles-daemon xdg-user-dirs-gtk

echo "Installing full AMD drivers"
sudo pacman -S --needed mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-mesa-layers lib32-vulkan-mesa-layers libva-utils libva-mesa-driver

echo "Installing essential apps"
sudo pacman -S --needed base-devel bash-completion git vim vlc steam firefox telegram-desktop timeshift ntfs-3g dosfstools sbctl pwgen man adw-gtk-theme gnome-shell-extension-dash-to-panel gnome-shell-extension-appindicator gnome-tweaks bat flatpak less

echo "Installing yay"
cd $HOME/.config/ && git clone https://aur.archlinux.org/yay.git && cd yay/ && makepkg -si && cd

yay- Syyu

echo "Installing yay packages"
yay -S --needed gdm-settings morewaita-icon-theme gnome-shell-extension-just-perfection-desktop lazydocker

echo "Signing modules for Secure Boot"
sudo sbctl create-keys
sudo sbctl sign -s /boot/vmlinuz-linux
sudo sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI

echo "Enabling necessery services"
sudo systemctl enable gdm.service
sudo systemctl enable bluetooth.service

echo "Installing flatpak for clean installation of some apps (f.e. okular)"
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y org.kde.okular
flatpak override --user --env QT_SCALE_FACTOR=1.25 org.kde.okular
flatpak update -y

echo "Disabling some services .."
sudo systemctl disable remote-fs avahi-daemon
sudo systemctl mask remote-fs avahi-daemon

echo "Finallization ..."
yay -Syyu
yay -Rsn $(yay -Qdtq)

