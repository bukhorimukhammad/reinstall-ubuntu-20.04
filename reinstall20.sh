#!/bin/bash
# Reinstall Ubuntu 20.04 (DigitalOcean / VPS berbasis KVM)
# ⚠️ Semua data lama akan hilang setelah reboot

set -e

# URL installer Ubuntu 20.04 (focal)
KERNEL_URL="http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/ubuntu-installer/amd64/linux"
INITRD_URL="http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/ubuntu-installer/amd64/initrd.gz"

# URL preseed kamu (RAW link GitHub preseed.cfg)
PRESEED_URL="https://raw.githubusercontent.com/bukhorimukhammad/reinstall-ubuntu-20.04/main/preseed.cfg"

echo "📥 Download kernel & initrd..."
wget -O /boot/linux $KERNEL_URL
wget -O /boot/initrd.gz $INITRD_URL

echo "📝 Buat GRUB config manual..."
cat > /boot/grub/custom.cfg <<EOF
menuentry "Auto Reinstall Ubuntu 20.04" {
    linux /boot/linux auto=true priority=critical url=$PRESEED_URL
    initrd /boot/initrd.gz
}
EOF

echo "🧹 Bersihkan 40_custom bawaan..."
echo "" > /etc/grub.d/40_custom
chmod -x /etc/grub.d/40_custom

echo "🔄 Update GRUB..."
update-grub

echo "🎯 Set grub-reboot ke installer untuk reboot berikutnya..."
grub-reboot "Auto Reinstall Ubuntu 20.04"

echo "✅ Reinstall entry sudah ditambahkan ke GRUB."
echo "⚠️ Jalankan 'reboot' sekarang untuk mulai reinstall Ubuntu 20.04."
