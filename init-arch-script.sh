# Update
sudo pacman -Syyu
# Install desired packages, separated for readability
sudo pacman -S pacman-contrib piper wmctrl gftp xfce4-whiskermenu-plugin ffmpeg cdrkit xdg-user-dirs zip qbittorrent chromium
sudo pacman -S xcape ntfs-3g firefox vlc gparted gnome-disk-utility baobab galculator p7zip psensor syncthing obs-studio 
sudo pacman -S virt-manager qemu-desktop libvirt edk2-ovmf dnsmasq iptables-nft virt-viewer handbrake libwmf libopenraw libavif libheif libjxl librsvg webp-pixbuf-loader networkmanager
# Install all of VLCs optional dependencies to fix fucked video playback -no kwallet 
sudo pacman -S pcsclite aribb25 aribb24 projectm libgoom2 lirc sdl_image libtiger libkate zvbi lua52-socket libmicrodns protobuf ttf-dejavu smbclient libmtp vcdimager libgme libva-intel-driver libva-vdpau-driver libdc1394
# Fix Virt-Manager issues
sudo mousepad /etc/libvirt/qemu.conf
# user = "admin"
# admin = "libvirt"
sudo systemctl restart libvirtd
sudo usermod -a -G libvirt $(whoami)

# Create br0
sudo systemctl enable --now NetworkManager
nmcli connection add type bridge ifname br0 stp no
nmcli connection add type bridge-slave ifname eno1 master br0
nmcli connection down eno1
nmcli connection up bridge-br0
nmcli connection up bridge-slave-eno1
# Create user folders
#xdg-user-dirs-update
# Install demucs
#pip3 install --user -U demucs
# python3 -m demucs -d cpu PATH_TO_AUDIO_FILE_1
# Enable Super key, Syncthing, TRIM & libvirt daemon
xcape -e 'Super_L=Alt_L|F1'
systemctl enable --now syncthing.service --user
sudo systemctl enable --now fstrim.timer
# Install yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
# Remove yay's source folder
rm -rf ./yay-bin
# Install needed AUR packages
yay -S yandex-browser kotatogram-desktop-bin tartube screendimmer
# yay -S yacy ttf-vlgothic neo-matrix 
# Enable yacy service
# systemctl enable --now yacy.service

# Clean pacman & yay caches
sudo paccache -rk0
sudo rm -rf ~/.cache/yay/*

#SU
su
# Set swappiness
echo 'vm.swappiness = 200' >> /etc/sysctl.d/99-swappiness.conf
# Dummy swap entry in fstab
echo '#Dummy swap partition entry with priority /dev/sdb2 none swap defaults,pri=99  0 0' >> /etc/fstab
exit
# Generate Lm_sensors report
sensors-detect

# Enable vfio for GPU
sudo mousepad /etc/default/grub/
# PASTE ON grub FILE (Network Card): GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 intel_iommu=on vfio-pci.ids=8086:24fb"
# Rebuild GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg
# Set VFIO
{echo 'options vfio-pci ids=8086:24fb
softdep iwlwifi pre: vfio-pci'} >> /etc/modprobe.d/vfio.conf
# Rebuild initramfs
sudo mkinitcpio -p linux
sudo mkinitcpio -p linux-zen
sudo mkinitcpio -p linux-lts
sudo mkinitcpio -p linux-hardened
# fb.me/profile.php_?id=Mf6F9EWwFhrTTlT11yWKjJ8Gy9UEAZZizA1a0Y2277T4Ce
