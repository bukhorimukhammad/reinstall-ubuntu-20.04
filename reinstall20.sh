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

echo "📝 Tambahkan GRUB entry..."
cat > /etc/grub.d/40_custom <<'EOF'
menuentry "Auto Reinstall Ubuntu 20.04" {
    linux /boot/linux auto=true priority=critical url=https://raw.githubusercontent.com/bukhorimukhammad/reinstall-ubuntu-20.04/main/preseed.cfg
    initrd /boot/initrd.gz
}
EOF

echo "🔄 Update GRUB..."
update-grub

echo "✅ Reinstall entry sudah ditambahkan ke GRUB."
echo "⚠️ Jalankan 'reboot' untuk mulai reinstall Ubuntu 20.04."
