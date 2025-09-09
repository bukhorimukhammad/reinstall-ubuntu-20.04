#!/bin/bash
# Reinstall Ubuntu 20.04 (DigitalOcean/umum KVM VPS)
# ⚠️ Semua data akan hilang setelah reboot

set -e

# URL installer Ubuntu 20.04 (focal)
KERNEL_URL="http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/ubuntu-installer/amd64/linux"
INITRD_URL="http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/ubuntu-installer/amd64/initrd.gz"

# URL preseed kamu (RAW link GitHub setelah upload preseed.cfg)
PRESEED_URL="https://raw.githubusercontent.com/YOUR_GITHUB_USER/YOUR_REPO/main/preseed.cfg"

# Download kernel & initrd
wget -O /boot/linux $KERNEL_URL
wget -O /boot/initrd.gz $INITRD_URL

# Tambahkan GRUB entry untuk reinstall otomatis
cat > /etc/grub.d/40_custom <<EOF
menuentry "Auto Reinstall Ubuntu 20.04" {
    linux /boot/linux auto=true priority=critical url=$PRESEED_URL
    initrd /boot/initrd.gz
}
EOF

# Update grub
update-grub

echo "✅ Reinstall entry sudah ditambahkan ke GRUB."
echo "⚠️ Jalankan 'reboot' untuk mulai reinstall otomatis Ubuntu 20.04."
