#!/bin/bash

set -e

echo "--- Starting Arch Linux Setup ---"

echo "-> Synchronizing package databases and updating system"
sudo pacman -Syyu

echo "-> Creating update-grub script"
cat <<EOT | sudo tee /usr/sbin/update-grub
#!/bin/sh
set -e
exec grub-mkconfig -o /boot/grub/grub.cfg "\$@"
EOT
sudo chown root:root /usr/sbin/update-grub
sudo chmod 755 /usr/sbin/update-grub

echo "-> Changing default ttl for free mobile hotspot"
sudo mkdir -p /etc/sysctl.d/ 
cat <<EOT | sudo tee /etc/sysctl.d/99-ttl-hotspot-fix.conf
net.ipv4.ip_default_ttl = 65
EOT

echo "-> Disabling motherboard speaker beep"
cat <<EOT | sudo tee /etc/modprobe.d/nobeep.conf
blacklist pcspkr
EOT

echo "-> Creating SSH config for custom key names"
mkdir -p ~/.ssh
chmod 700 ~/.ssh
if ! grep -q "Host github.com" ~/.ssh/config; then
cat <<EOT | tee -a ~/.ssh/config
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/github
EOT
fi

echo "-> Installing gnome essential apps"
sudo pacman -S --needed gdm gnome-calculator gnome-control-center gnome-disk-utility gnome-keyring gnome-settings-daemon gnome-shell gnome-system-monitor gnome-terminal gnome-text-editor gvfs gvfs-mtp loupe nautilus power-profiles-daemon xdg-user-dirs-gtk

echo "-> Installing full AMD drivers"
sudo pacman -S --needed mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-mesa-layers lib32-vulkan-mesa-layers libva-utils libva-mesa-driver

echo "-> Installing essential apps"
sudo pacman -S --needed base-devel bash-completion git micro vlc steam firefox telegram-desktop timeshift ntfs-3g dosfstools sbctl pwgen man adw-gtk-theme gnome-shell-extension-dash-to-panel gnome-shell-extension-appindicator gnome-tweaks bat flatpak less wl-clipboard

echo "-> Creating basic micro settings.json"
mkdir -p ~/.config/micro
cat <<EOF | tee ~/.config/micro/settings.json
{
    "scrollbar": true,
    "softwrap": true,
    "wordwrap": true
}
EOF

echo "-> Creating basic micro bindings.json"
cat <<EOF | tee ~/.config/micro/bindings.json
{
	"Ctrl-z": "Undo",
	"Ctrl-y": "Redo"
}
EOF

if ! command -v yay &> /dev/null; then
echo "-> Installing yay"
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd /tmp/yay
  makepkg -si
  cd $HOME
  rm -rf /tmp/yay/
fi

yay -Syyu

echo "-> Installing yay packages"
yay -S --needed gdm-settings morewaita-icon-theme gnome-shell-extension-just-perfection-desktop lazydocker

echo "-> Signing modules for Secure Boot"
sudo sbctl create-keys
sudo sbctl sign -s /boot/vmlinuz-linux
sudo sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI

echo "-> Enabling necessery services"
sudo systemctl enable gdm.service
sudo systemctl enable bluetooth.service

echo "-> Installing flatpak for clean installation of some apps (f.e. okular)"
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user -y org.kde.okular
flatpak override --user --env QT_SCALE_FACTOR=1.25 org.kde.okular
flatpak update -y

echo "-> Disabling some services .."
sudo systemctl disable remote-fs.target avahi-daemon.service
sudo systemctl mask remote-fs.target avahi-daemon.service

echo "-> Finallization ..."
yay -Syyu
yay -Yc

echo "--- Setup Complete! Please reboot your system. ---"
