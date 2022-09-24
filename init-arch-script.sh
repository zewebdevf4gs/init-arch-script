#Install needed packages
sudo pacman -S pacman-contrib piper xfce4-whiskermenu-plugin virt-viewer xcape ntfs-3g firefox vlc gparted gnome-disk-utility baobab galculator p7zip psensor virt-manager qemu-desktop libvirt edk2-ovmf dnsmasq iptables-nft syncthing
#Enable Super key, Syncthing & libvirt daemon
xcape -e 'Super_L=Alt_L|F1'
systemctl enable --now syncthing.service --user
sudo systemctl enable --now libvirtd.service
#Install yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
#Remove yay's source folder
rm -rf ./yay-bin
#Install needed AUR packages
yay -S yandex-browser kotatogram-desktop-bin
#Set needed git variables
git config --global user.email "4130+zewebdevf4gs@users.noreply.github.com"
git config --global user.name "zewebdevf4gs"
#Get base configuration files for the system type from github
git clone https://github.com/zewebdevf4gs/base-arch-sys-config.git
#Open downloaded config folder and local .config folder to restore needed/wanted configuration files
sudo thunar base-arch-sys-config &
sudo thunar /home/admin/.config &
#Clean pacman & yay caches
sudo paccache -rk0
sudo rm -rf ~/.cache/yay/*
#Set swappiness
echo 'vm.swappiness = 200' >> /etc/sysctl.d/99-swappiness.conf
#Dummy swap entry in fstab
echo '#Dummy swap partition entry with priority /dev/sdb2 none swap defaults,pri=99  0 0' >> /etc/fstab
#Lm_sensors report
sensors-detect
#Enable vfio for wifi
sudo mousepad /etc/default/grub/
# PASTE ON grub FILE: GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 intel_iommu=on vfio-pci.ids=8086:24fb"
#Rebuild GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg
#Set VFIO
{echo 'options vfio-pci ids=8086:24fb
softdep iwlwifi pre: vfio-pci'} >> /etc/modprobe.d/vfio.conf
#Rebuild initramfs
sudo mkinitcpio -p linux
sudo mkinitcpio -p linux-zen
sudo mkinitcpio -p linux-lts
sudo mkinitcpio -p linux-hardened
#fb.me/profile.php_?id=Mf6F9EWwFhrTTlT11yWKjJ8Gy9UEAZZizA1a0Y2277T4Ce
