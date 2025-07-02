#!/bin/bash

# Generate ssh-key for github: /home/YOUR_NAME/.ssh/github
ssh-keygen -t ed25519 -C "YOUR_MAIL@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github

git config --global user.email "YOUR_MAIL@gmail.com"
git config --global user.name "YOUR_NAME"

# Install module for VideoDownload Helper extension
curl -sSLf https://github.com/aclap-dev/vdhcoapp/releases/latest/download/install.sh | bash

# For uBlock Origin enable Cookie notices in Filter list

# Add alias ~/.bashrc
alias cat='bat'

# Dump all shortcuts
mkdir keybindings
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > keybindings/media_keys.conf
dconf dump /org/gnome/desktop/wm/keybindings/ > keybindings/wm_keybindings.conf
dconf dump /org/gnome/shell/keybindings/ > keybindings/shell_keybindings.conf
dconf dump /org/gnome/mutter/keybindings/ > keybindings/mutter_keybindings.conf
dconf dump /org/gnome/mutter/wayland/keybindings/ > keybindings/wayland_keybindings.conf

# Restore all shortcurs
cat keybindings/media_keys.dconf | dconf load /org/gnome/settings-daemon/plugins/media-keys/
cat keybindings/wm_keybindings.dconf | dconf load /org/gnome/desktop/wm/keybindings/
cat keybindings/shell_keybindings.dconf | dconf load /org/gnome/shell/keybindings/
cat keybindings/mutter_keybindings.dconf | dconf load /org/gnome/mutter/keybindings/
cat keybindings/wayland_keybindings.dconf | dconf load /org/gnome/mutter/wayland/keybindings/

# Other stuff
cp {/usr,~/.local}/share/applications/vim.desktop
echo "Hidden=true" | tee $HOME/.local/share/applications/vim.desktop

# Change vlc name to VLC
cp {/usr,~/.local}/share/applications/vlc.desktop
vim ~/.local/share/applications/vlc.desktop

# Hide unnecessery apps
sudo mv /usr/share/applications/qv4l2.desktop{,.bak} 
sudo mv /usr/share/applications/bssh.desktop{,.bak} 
sudo mv /usr/share/applications/bvnc.desktop{,.bak} 
sudo mv /usr/share/applications/avahi-discover.desktop{,.bak} 
sudo mv /usr/share/applications/qvidcap.desktop{,.bak}

# Env for some steam games option (add to the launch options):
env -u SDL_VIDEODRIVER %command%

# Delete gdm-settings after it's setup
