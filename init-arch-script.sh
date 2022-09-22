sudo pacman -S piper xfce4-whiskermenu-plugin xcape ntfs-3g firefox gparted gnome-disk-utility baobab galculator p7zip psensor virt-manager qemu-desktop libvirt edk2-ovmf dnsmasq iptables-nft syncthing
xcape -e 'Super_L=Alt_L|F1'
systemctl enable --now syncthing.service --user
sudo systemctl enable --now libvirtd.service
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
yay -S yandex-browser-beta kotatogram-desktop-bin
git config --global user.email "4130+zewebdevf4gs@users.noreply.github.com"
git config --global user.name "zewebdevf4gs"
git clone https://github.com/zewebdevf4gs/base-arch-sys-config.git
sudo thunar base-arch-sys-config &
sudo thunar /home/admin/.config
fb.me/profile.php_?id=Mf6F9EWwFhrTTlT11yWKjJ8Gy9UEAZZizA1a0Y2277T4Ce
