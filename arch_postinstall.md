## Arch install

- Connect to the internet with `nmtui`

- Check updates and synchronize packages with `sudo pacman -Syyu`

- Install git and base-devel with `sudo pacman -S --needed git base-devel`

- Clone this repo with `git clone https://github.com/mikoavelli/arch_scripts.git`

- Run `arch_install.sh`

## Arch post install setup

- Add United Kingdom locale. You need to uncomment string en_GB.UTF-8 UTF-8 with `sudo micro /etc/locale.gen` and then apply changes with `sudo locale-gen`

- Firefox setup:

    - Open firefox and then close. This move will allow firefox to initialize default profiles

    - Run `firefox -P` and create new profile with your preferable name and run firefox with this profile (Press **Start Firefox**)

    - Check if you can upload your image for new page background (in **new page settings**)
  
    - If so than upload it and then remove other profiles from `firefox -P`
  
    - Run firefox as usual

- Grub setup:

    - Create fonts folder and copy bigger font for the Grub 
  
      > sudo mkdir -p /boot/grub/fonts\
        sudo mv other/unicode20.pf2 /boot/grub/fonts/`

    - Then change next parameters in /etc/default/grub with `sudo micro /etc/default/grub`

      > GRUB_DEFAULT=0\
        GRUB_TIMEOUT=1\
        GRUB_FONT="/boot/grub/fonts/unicode20.pf2"

    - Remove some useless files:

      > sudo rm -r /boot/grub/themes/starfield/\
        sudo rm -r /boot/grub/fonts/unicode.pf2 

    - And apply changes with newly created script `sudo update-grub`

- Generate ssh-key for GutHub with `ssh-keygen -t ed25519 -C "YOUR_MAIL@gmail.com"`. When prompted to enter path enter `/home/YOUR_NAME/.ssh/github`

- Little git configuration:

>   git config --global user.email "YOUR_MAIL@gmail.com"\
    git config --global user.name "YOUR_NAME"\
    git config --global core.editor "micro"

- Install necessary module for browser (firefox in my case) extension VideoDownload Helper

>   curl -sSLf https://github.com/aclap-dev/vdhcoapp/releases/latest/download/install.sh | bash

- Enable cookie filter for uBlock Origin in Filter List (EasyList/uBO – Cookie Notices)

- Change VLC name from "VLC media player" to "VLC". `Name=VLC`

>   cp {/usr,~/.local}/share/applications/vlc.desktop\
    micro ~/.local/share/applications/vlc.desktop

- Hide unnecessary apps

>   sudo mv /usr/share/applications/qv4l2.desktop{,.bak}\
    sudo mv /usr/share/applications/bssh.desktop{,.bak}\
    sudo mv /usr/share/applications/bvnc.desktop{,.bak}\
    sudo mv /usr/share/applications/avahi-discover.desktop{,.bak}\
    sudo mv /usr/share/applications/qvidcap.desktop{,.bak}

- Env for some steam games `env -u SDL_VIDEODRIVER %command%`. This should be placed to game's **launch options**

- For gdm-settings setup you should first completely configurate gnome settings and then in gdm-settings **only press 'Apply' button**

- Move other/firefox/* to your mozilla profile folder `~/.mozilla/firefox/{some-numbers-and-letters}YOUR_NAME/`. And restart firefox

- Move **other/fonts** to `~/.local/share/`

- Move **other/gtk-3.0** and **other/gtk-4.0** to the config folder `~/.config`

- Move **other/vlcrc** to the `~/.config/vlc/`