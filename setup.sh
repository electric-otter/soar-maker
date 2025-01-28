#!/bin/bash
debootstrap --arch amd64 stable /mnt https://deb.debian.org/debian
echo "Enter chroot..."
mount --make-rslave --rbind /proc /mnt/proc
mount --make-rslave --rbind /sys /mnt/sys
mount --make-rslave --rbind /dev /mnt/dev
mount --make-rslave --rbind /run /mnt/run
chroot /mnt /bin/bash
echo "You would need an hostname."
sudo nano /etc/hostname
echo "Now, you will need to make your distro release info"
sudo nano /etc/os-release
echo "Creating an root user"
adduser rootuser
useradd rootuser -m -G root
#!/bin/bash

# Prompt for the partition to format
read -p "Enter the partition to format (e.g. /dev/sda1): " partition

# Prompt for the desired file system
read -p "Enter the desired file system (e.g. ext4, ntfs, fat32): " filesystem

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root." 
   exit 1
fi

# Unmount the partition
umount "$partition"

# Format the partition
mkfs -t "$filesystem" "$partition"

# Mount the partition 
mount "$partition" /mnt

echo "Partition $partition has been formatted to $filesystem."

echo "Input your custom commands now."
