source /etc/profile
export PS1="(chroot) ${PS1}"
mount /dev/sda1 /boot
emerge-webrsync
emerge --sync
eselect news read
eselect profile set 1
emerge --ask --verbose --update --deep --newuse @world
echo "Europe/Bucharest" > /etc/timezone
emerge --config sys-libs/timezone-data
emerge vim
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
eselect locale set 4
env-update
source /etc/profile
export PS1="(chroot) ${PS1}"
emerge linux-firmware
emerge gentoo-sources
eselect kernel set 1
emerge installkernel-gentoo gentoo-kernel-bin
emerge --depclean
echo "/dev/sda1   /boot        ext2    defaults,noatime     0 2" >> /etc/fstab
echo "/dev/sda2   none         swap    sw                   0 0" >> /etc/fstab
echo "/dev/sda3   /            ext4    noatime              0 1" >> /etc/fstab
vim /etc/conf.d/hostname
emerge --noreplace netifrc
echo 'config_enp4s0="dhcp"' >> /etc/conf.d/net
cd /etc/init.d
ln -s net.lo net.enp4s0
rc-update add net.enp4s0 default
passwd
vim /etc/conf.d/hwclock
emerge sysklogd
rc-update add sysklogd default
emerge mlocate
updatedb
rc-update add sshd default
emerge e2fsprogs dosfstools
emerge dhcpcd
rc-update add dhcpcd default
emerge net-wireless/iw wpa_supplicant
emerge --verbose grub:2
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
exit
