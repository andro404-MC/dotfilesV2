#!/usr/bin/env bash
sudo pacman --needed -S git
git clone --bare https://github.com/andro404-MC/dotfilesV2 $HOME/.local/share/dotfiles
function config {
   git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME $@
}
mkdir -p .dotfiles-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles from https://github.com/andro404-MC/dotfilesV2";
  else
    echo "Moving existing dotfiles to ~/.dotfiles-backup";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi

# checkout dotfiles from repo
config checkout
config config status.showUntrackedFiles no

# YAY
echo '
[rumpowered]
Server = https://jc141x.github.io/rumpowered-packages/$arch ' | sudo tee -a /etc/pacman.conf
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman-key --recv-keys cc7a2968b28a04b3
sudo pacman-key --lsign-key cc7a2968b28a04b3
sudo pacman -Syyu
sudo pacman -S yay

# PACKAGES
yay --needed -S albert autotiling base base-devel bemenu blueberry btop cfonts cliphist dunst engrampa eza fastfetch firefox foot fzf git go gtklock htop hyprlock imv intel-gpu-tools intel-media-driver keepassxc kvantum kvantum-qt5 less libva-intel-driver libva-utils mpc mpd mpv ncmpcpp nemo neovim network-manager-applet networkmanager nm-connection-editor nodejs noto-fonts-cjk npm nsxiv nwg-look p7zip polkit-gnome qbittorrent qt5ct qt6ct ripgrep rofi-calc-git rofi-wayland starship sway swaybg swayidle swayosd-git thunderbird trash-cli ttf-font-awesome ttf-jetbrains-mono-nerd ttf-ubuntu-font-family udiskie unzip waybar wl-clip-persist wl-clipboard wlogout xdg-desktop-portal-wlr xdg-user-dirs xorg-xwayland yazi yt-dlp zathura zathura-cb zathura-ps zoxide zsh dash glow perl-image-exiftool pavucontrol ttf-apple-emoji xorg-xrdb

ya pack -i
sudo systemctl enable --now swayosd-libinput-backend.service
sudo usermod -a -G video $USER

mkdir .cache/zsh/
touch .cache/zsh/history
mkdir .local/share/mpd
mkdir .local/share/mpd/playlists
sudo rm /usr/bin/sh
sudo ln /usr/bin/dash /usr/bin/sh

fc-cache -fr
xdg-user-dirs-update
