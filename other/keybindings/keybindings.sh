#!/bin/bash
# Dump all shortcuts
# mkdir keybindings
# dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > media_keys.conf
# dconf dump /org/gnome/desktop/wm/keybindings/ > wm_keybindings.conf
# dconf dump /org/gnome/shell/keybindings/ > shell_keybindings.conf
# dconf dump /org/gnome/mutter/keybindings/ > mutter_keybindings.conf
# dconf dump /org/gnome/mutter/wayland/keybindings/ > wayland_keybindings.conf

# Restore all shortcurs
cat media_keys.dconf | dconf load /org/gnome/settings-daemon/plugins/media-keys/
cat wm_keybindings.dconf | dconf load /org/gnome/desktop/wm/keybindings/
cat shell_keybindings.dconf | dconf load /org/gnome/shell/keybindings/
cat mutter_keybindings.dconf | dconf load /org/gnome/mutter/keybindings/
cat wayland_keybindings.dconf | dconf load /org/gnome/mutter/wayland/keybindings/

