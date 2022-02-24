# Manjaro boot problems
## ERROR: NOT BOOTING
It seems Manjaro Architect does not correctly update the initramfs hooks for systemd in `/etc/mkinitcpio.conf` and the bootloader entry configs like `/boot/loader/entries/manjarolinux5.4.conf`:  

* In `/etc/mkinitcpio.conf`:
  ```bash
  # Original faulty HOOKS:
  # HOOKS=(base udev autodetect keyboard keymap modconf block encrypt filesystems)

  # Change them to using systemd hooks:
  HOOKS=(base systemd autodetect keyboard sd-vconsole modconf block sd-encrypt filesystems)
  ```
  NOTE:
  - `systemd` replaces `udev`
  - `sd-vconsole` replaces `keymap`
  - `sd-encrypt` replaces `encrypt`

* In `/boot/loader/entries/manjarolinux5.4.conf`:
  ```bash
  # Original faulty options:
  # options root=UUID=<mapper-UUID> rw cryptdevice=UUID=<device-UUID>:cryptroot

  # Change them to using 'rd.luks' terminology:
  options rd.luks.name=<luks-partition-UUID>=cryptroot root=/dev/mapper/cryptroot rw
  ```

* Note: In `/boot/loader/loader.conf` you can specify the default kernel to boot.

* Install systemd-boot:
  ```
  bootctl install
  ```

* Regenerate initramfs:
  ```
  mkinitcpio -P
  ```

* Make sure all images are located in the ESP partition `/efi`, not in `/boot`:
  ```bash
  mv /boot/intel-ucode.img /efi
  # Move all 3 vmlinuz images:
  mv -v /boot/vmlinuz* /efi
  # Move all 6 initramfs images:
  mv -v /boot/initramfs* /efi
  ```


## Restore faulty GRUB
### With Manjaro live iso
> Didn't work ...

* Open Gnome Disks, and decrypt the system disk.
* Mount the mapper(s). (Note if you used LVM it will be shown as a separate disk.)
* Open a terminal and enter `sudo su`.
* Change root into your decrypted system using `manjaro-chroot`:
  ```
  sudo manjaro-chroot -a
  ```
* Mount the EFI partition (the 0.5GB unencrypted partition on your SSD) as `/boot/efi`:
  ```
  sudo mount /dev/sdXN /boot/efi
  # For me this amounts to:
  sudo mount /dev/nvme0n1p1 /boot/efi
  ```
* Update grub:
  ```
  sudo update-grub
  ```
  If things are really bad, you can completely reinstall grub with:
  ```
  sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=manjaro --recheck
  ```

### With Manjaro Architect
Test: `sudo grub-mkconfig -o /boot/grub/grub.cfg`

* Boot Manjaro Architect, but do **not** enter 'setup'.
  Simply log in with root/manjaro and do the following:
  ```bash
  # List disks:
  lsblk -f
  # Decrypt system drive:
  cryptsetup -v open /dev/nvme0n1p2 cryptroot

  # Mount system mapper:
  mount -v /dev/mapper/LVM--VG-lvol--root /mnt
  # Mount the unencrypted 0.5GB EFI partition:
  mount -v /dev/nvme0n1p1 /mnt/boot/efi # /mnt/boot ?? /mnt/efi ?? mkdir /mnt/efi
  # Chroot into the system:
  # manjaro-chroot /mnt
  
  # Or with 'regular' chroot:
  # Change to the root directory of your mounted partitions:
  cd /mnt
  # This is undertaken so that you are working from - and with - your installed system,
  # rather than the installation media. To do so, it will be necessary to enter a series
  # of commands in the following order:
  mount -t proc proc /mnt/proc
  mount -t sysfs sys /mnt/sys
  mount -o bind /dev /mnt/dev
  mount -t devpts pts /mnt/dev/pts/
  # Chroot into the system:
  chroot /mnt

  # Install grub:
  grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=manjaro --recheck # /efi?

  # If you get something like `EFI variables are not supported on this system`,
  # install the efibootmgr, dosfstools and grub packages and try installing grub again:
  pacman -Syu efibootmgr dosfstools grub
  grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=manjaro --recheck # /efi?
  # If it still doesn't work, try exiting the chroot environnment by typing exit,
  # then loading the efivarfs module:
  exit
  modprobe efivarfs
  # Then back in the chroot:
  chroot /mnt
  mount -t efivarfs efivarfs /sys/firmware/efi/efivars
  grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=manjaro --recheck # /efi?

  # Update initial ramdisk:
  mkinitcpio -P

  # Update grub:
  update-grub

  # Exit chroot:
  exit

  reboot
  ```

* Logs are located in `/var/log`, of which the `/var/log/pacman.log` is especially useful:
  ```
  grep -i grub /var/log/pacman.log
  ```

* Regenerate the initial ramdisk with [mkinitcpio](https://wiki.archlinux.org/index.php/Mkinitcpio) (`man 8 mkinitcpio`):
  ```bash
  # Every time a kernel is installed or upgraded, a pacman hook generates automatically a .preset
  # file saved in `/etc/mkinitcpio.d/`. E.g. linux.preset for the official stable linux kernel package:
  ls -al /etc/mkinitcpio.d/  # linux54.preset, linux57.preset, linux58.preset

  # To (re-)generate all existing presets, use the `-P/--allpresets` switch.
  # This is typically used to regenerate all the initramfs images after a
  # change of the global [Configuration](https://wiki.archlinux.org/index.php/Mkinitcpio#Configuration): 
  sudo mkinitcpio -P

  # In particular, to (re-)generate the preset provided by a specific kernel package,
  # use the `-p/--preset` option followed by the preset to utilize:
  sudo mkinitcpio -p linuxXY
  # where XY is the number of your kernel (see `ls -al /etc/mkinitcpio.d/`)
  ```
  The primary configuration file for mkinitcpio is `/etc/mkinitcpio.conf`.

* mkinitcpio error:
  ```bash
  sudo mkinitcpio -P
  # ERROR: '/lib/modules/5.7.19-2-MANJARO' is not a valid kernel module directory
  pacman -Q linux
  # linux54 5.4.64-1
  
  # Remove kernel 5.7:
  sudo mhwd-kernel -r linux57
  sudo rm -v /etc/mkinitcpio.d/linux57.*
  sudo rm -v /boot/vmlinuz-5.7-x86_64
  sudo pacman -R linux57 linux57-headers linux57-extramodules
  sudo rm -v /boot/initramfs-5.7-x86_64-fallback.img
  sudo rm -v /boot/initramfs-5.7-x86_64.img

  # Run mkinitcpio again:
  sudo mkinitcpio -P
  ```

* Manjaro Architect > System Rescue > Install bootloader > Copy efi stub to `/EFI/boot`
  and rename to `bootx64.efi` error:
  ```
  grub error: cp: cannot stat '/EFI/manjaro/grubx64.efi' : No such file or directory
  ```
  Manual copy:
  ```bash
  # Without chroot:
  cp /mnt/efi/EFI/boot/bootx64.efi /mnt/efi/EFI/boot/bootx64.efi.old   # Aug 13
  cp /mnt/boot/grub/x86_64-efi/core.efi /mnt/efi/EFI/boot/bootx64.efi  # Sep 19
  ```

## Conclusion
Not familiar enough with the underlying Arch system to troubleshoot this.

**=> Arch install 28/09/2020!**