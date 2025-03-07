# https://forum.proxmox.com/threads/perl-warning-setting-locale-failed.94218/post-609489
export DEBIAN_FRONTEND=noninteractive
dpkg-reconfigure tzdata locales
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
echo 'LANG="en_US.UTF-8"'>/etc/default/locale
dpkg-reconfigure locales
update-locale LANG=en_US.UTF-8
