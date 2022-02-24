# Arch Install
> **First Arch install, September 28, 2020!**

We will be installing Arch with [LUKS encryption](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition) directly on a GPT partitioned disk.

**Specifics:**

* **UEFI/GPT**: The 'modern' way of doing things, GPT is preferable over MBR and the legacy BIOS approach, but this does require a computer that is not ancient.

* **systemd-boot**: A reliable bootloader is an important part of every OS. GRUB is the default on most linux distro's simply because it supports literally every possible scenario. GRUB comes with everything and the kitchen sink included, and this can have a serious impact when debugging boot errors. So when the requirements of an installation are crystal clear and do not require exotic GRUB features, it pays to go with a more minimal bootloader like systemd-boot.

* **LUKS2 encryption**: We're aiming to hit the sweet spot between security and convenience, and want to be as close as possible to 'Full Disk Encryption'. This is why we will encrypt both the system (`/`), and the user data (`/home`). Technically, this is not FDE because we're leaving a small 0.5GiB EFI boot partition unencrypted. This is required for the OS to bootstrap itself. While it is technically possible to encrypt this partition and use a bootloader like [GRUB](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#Encrypted_boot_partition_(GRUB)) to decrypt it, this has all sorts of complications on performance and convenience, as well as requiring us to use GRUB.

* **NO LVM**: The Logical Volume Manager (LVM for short) manages all disks in Linux. It also allows to create what can be considered 'virtual' partitions; LVM volumes residing on a single LUKS encrypted partition. This gives the impression of a physical partition, while at the same time masking these volumes while encrypted. However, this adds performance and complexity complications and should not be done unless absolutely required.

* **Single partition system**: We will be using a single partition for `/` and `/home` and use a swapfile instead of a swap partition. This is the simplest and most straightforward approach, only requiring 1 encrypted partition without any LVM complications. If you're accustomed to putting user data on other partitions/devices, it is trivial to add secondary encrypted drives. On top of that, symlinking home data directories gives more control about what is located where. For example, you can keep `Documents` on SSD, while symlinking `Videos` to HDD:
  ```
  rm ~/Videos
  ln -s /storage/Videos ~
  ```
  If you prefer to have all user data on a separate partition for ease of reinstalling, you can also symlink all user data directories, or even `home` itself. Alternatively, you can also use an `rsync` cronjob for important directories, to keep redundant duplicates of them on a secondary drive.

* **btrfs**: btrfs is really useful on any rolling release distro, since snapshots make it trivial to roll back the system to a previous state. Note also that btrfs performance is significantly better on NVMe SSDs compared to SATA SSDs.

The following tutorial will go over the complete process, from actually burning the ISO install image, to getting a fully working Arch Linux OS.


# Preliminaries
## Burn ISO to disk
Download the [Arch ISO file](https://www.archlinux.org/download/) and burn it to a USB stick:

### On Linux
```bash
# List all disks to find the USB stick:
sudo fdisk -l
# Unmount it:
sudo umount -v /dev/sdX
# Copy the ISO to the USB stick:
sudo dd bs=4M if=/path/to/iso of=/dev/sdX status=progress oflag=sync
```

### On Mac
```bash
# List all disks to find the USB stick:
diskutil list
# Unmount it:
diskutil unmountDisk /dev/diskN
# Copy the iso:
sudo dd bs=1m if=/path/to/iso of=/dev/diskN; sync
# (Check progress by pressing Ctrl+T)
# Eject the disk when finished:
sudo diskutil eject /dev/diskN
```

### On Windows
On Windows use one of the many GUI programs, e.g. [Rufus](https://rufus.ie/).

## Booting the ISO
> | :warning: Warning: |
> |--------------------|
> | Make sure to boot the Arch ISO in **UEFI mode**, otherwise the UEFI boot entry cannot be added! |

When booting, `Install Arch` will automatically be selected, and you will be dropped in a root terminal with the instruction to follow the [Arch installation guide](https://wiki.archlinux.org/index.php/installation_guide). Additionally, the [Bullet Proof Guide](https://wiki.archlinux.org/index.php/User:Altercation/Bullet_Proof_Arch_Install) is useful too, for its focus on btrfs, luks and systemd-boot.

The first thing to do is to verify the boot mode:
```bash
ls /sys/firmware/efi/efivars
```
If the command shows the directory without error, then the system is booted in UEFI mode. If the directory does not exist, reboot and pick the right installer!


## Set the keyboard layout
This is only necessary if you are **not** using the default `us` qwerty keyboard layout:
```bash
# View the current keyboard configuration:
localectl status
# List all available keymaps:
localectl list-keymaps
# Set keymap for current session:
loadkeys us  # already the default
```


## Installing over SSH
If you have a second computer around, it is very convenient to do the installation from that computer over SSH. This way, we can have the [Arch installation guide](https://wiki.archlinux.org/index.php/installation_guide) and this tutorial open in parallel and easily copy and paste commands where necessary.

To do so, do the following on the Arch ISO computer (the one that is getting Arch installed):

* Set a password for root:
  ```
  passwd
  ```
  This is a security measure ensuring no one can SSH into your computer and take over. This password will only last for this session on the Arch ISO (since it is read only). This will NOT carry over as root password for your new install!

* Start SSH:
  ```bash
  systemctl start sshd
  # You can check if it's actually running with:
  systemctl status sshd
  ```

* Look up the IP address of the Arch ISO computer:
  ```
  ip addr show
  ```

Then, on the second computer, SSH into the Arch ISO computer with:
```
ssh root@<IP-OF-ARCH-COMPUTER>
```
and continue the installation like normal, from the second computer.


## Configure network
If you're using ethernet, DHCP will already be running. Verify with ping:
```bash
ping archlinux.org
```
If you need Wi-Fi then run wifi-menu and enable the profile:
```bash
wifi-menu # Let it scan networks, pick yours
netctl enable wlan-ssid # Can tab complete profile
```


## Wipe the disk to which you want to install
> ### [Warning:](https://wiki.archlinux.org/index.php/Securely_wipe_disk#Preparations_for_block_device_encryption)
> If block device encryption is mapped on a partition that contains
> non-random or unencrypted data, the encryption is weakened and
> becomes comparable to filesystem-level encryption: disclosure of
> usage patterns on the encrypted drive becomes possible. Therefore,
> do not fill space with zeros, simple patterns (like badblocks) or
> other non-random data before setting up block device encryption.

### SSD
A regular overwrite-based disk-wipe is not ideal for SSDs, so you may want to do a ['Secure Erase'](https://wiki.archlinux.org/index.php/Solid_state_drive/Memory_cell_clearing).

#### NVMe example
Check which commands the [NVMe drive](https://wiki.archlinux.org/index.php/Solid_state_drive/Memory_cell_clearing#NVMe_drive) supports with the command:
```bash
# Find the drive's name with either fdisk or lsblk:
fdisk -l # NVMe devices are typically indicated with names like e.g. /dev/nvme0n1p1,
lsblk -f      # where 0 indicates NVMe disk 0 (first), n1 for namespace 1, p1 for partition 1.
# And check support:
# (nvme-cli package may still need to be installed)
nvme id-ctrl /dev/nvme0 -H | grep "Format \|Crypto Erase\|Sanitize"
```

This will return something like:
```
[1:1] : 0x1    Format NVM Supported
[29:29] : 0    No-Deallocate After Sanitize bit in Sanitize command Supported
  [2:2] : 0    Overwrite Sanitize Operation Not Supported
  [1:1] : 0x1  Block Erase Sanitize Operation Not Supported
  [0:0] : 0x1  Crypto Erase Sanitize Operation Not Supported
[2:2] : 0x1    Crypto Erase Supported as part of Secure Erase
[1:1] : 0      Crypto Erase Applies to Single Namespace(s)
[0:0] : 0      Format Applies to Single Namespace(s)
```
indicating the SSD controller supports formatting on a per namespace basis, so we can use the command:
```bash
nvme format /dev/nvme0 -s 2 -n 1
# -s <n>, --ses=<n>: Secure Erase Settings:
#    0 = No secure erase
#    1 = User data erase
#    2 = Cryptographic erase
# -n 1: namespace 1
```
to reformat the drive using a cryptographic erase.

### HDD
Securely erase the drive's partition table and data:
```bash
# It is advisable to remove the partition table before shredding, because
# shred might not be able to fully remove it. We use 'parted' for this:
parted /dev/sdb
# Find any existing partitions by running print:
(parted) print
# Remove existing partitions:
(parted) rm 1  # Replace 1 with the partition number you want to remove.
# -> Repeat for all remaining partitions on the disk.
# -> Exit parted, and continue with shredding:
(parted) quit

# shred --verbose --iterations=1 (default 3 takes longer):
shred -vn 1 /dev/sdb
# Note: even 1 iteration will take a LONG time for large drives!
# (Read: at least an hour per terabyte)
```


## Partition the disk
Make sure to select the correct device (the NVMe SSD in my case), which we wiped earlier.

Two partitions are required:  
* A FAT32 partition of at least half a GiB with the ESP (= EFI System Partition) flag set,
  which has to be left unencrypted to serve as UEFI boot partition.
* The remaining space as 1 big partition, which we will encrypt later.

This is pretty straightforward with `parted`, using the following commands:
```bash
parted /dev/nvme0n1
(parted) mklabel gpt
(parted) mkpart "ESP" fat32 1MiB 512MiB
(parted) set 1 esp on
(parted) mkpart "CryptDevice" btrfs 512MiB 100%
# Make sure everything looks good:
(parted) print
(parted) quit
```

This will result in 2 partitions on the device; in my case `/dev/nvme0n1p1` (0.5GiB "ESP") and `/dev/nvme0n1p2` (named "CryptDevice"), which will be encrypted later on.

See [Parted Archwiki](https://wiki.archlinux.org/index.php/Parted) for more information.


## LUKS Encryption
LUKS2 has a few nice additions compared to LUKS1, like more advanced encryption options, significantly stronger protection against GPU and FPGA bruteforce attacks, as well as a more robust header with some redundancy that lowers the chance of getting locked out of your disk when it gets damaged. If there aren't any specific constraints requiring LUKS1, LUKS2 is preferable.

* Use the following command for a standard LUKS2 encrypted partition:
```bash
# Double check you're encrypting the right device, or you might lose data:
cryptsetup --verbose --type luks2 luksFormat /dev/nvme0n1p2
# This uses the LUKS2 defaults (See 'cryptsetup --help'):
#   * PBKDF (Password-Based Key Derivation Function): argon2i
#   * Iteration time: 2000ms
#     This is the number of milliseconds spent on PBKDF passphrase processing
#     (only relevant when changing passphrases)
#   * Random number generator: /dev/urandom
#   * Cipher: aes-xts-plain64
```
It is a good practice to **always** use the `--verbose` or `-v` flag with cryptsetup, so that you receive feedback about what you're doing.

* Alternatively, if you're really paranoid, you can use one of the following extra-secure options:
```bash
cryptsetup --verbose --type luks2 --iter-time 4000 --use-random luksFormat /dev/nvme0n1p2
# This is likely the optimal choice regarding the security-performance tradeoff,
# since the default AES cipher is more battle-tested, as well as benefits from hardware acceleration:
cryptsetup --verbose --type luks2 --pbkdf argon2id --hash sha512 --iter-time 5000 --use-random luksFormat /dev/nvme0n1p2
# But note that the serpent cipher is supposedly stronger than AES:
cryptsetup --verbose --type luks2 --pbkdf argon2id --hash sha512 --cipher serpent-xts-plain64 --iter-time 6000 --use-random luksFormat /dev/nvme0n1p2
```

* Open the encrypted partition:
  ```
  cryptsetup --verbose open /dev/nvme0n1p2 cryptroot
  ```

## Format the partitions
Once the partitions have been created and decrypted, they must be formatted with an appropriate file system:
```bash
# Format EFI system partition as fat32, setting the label with -n:
mkfs.fat -F32 -n EFI /dev/nvme0n1p1
# Format root partition as btrfs, setting the label with -L:
mkfs.btrfs -L CryptRoot /dev/mapper/cryptroot
```

## Initialize and mount file system
* Mount the encrypted partition, i.e. the btrfs root:
  ```bash
  mount -v /dev/mapper/cryptroot /mnt
  ```
  Note this is NOT the system root that is generally located at `/`! The system root is one of several subvolumes that resides inside the btrfs root, and will be named `@`. Similarly, the `/home` subvolume will be named `@home` in the btrfs root. We will now proceed to creating these subvolumes.

* Create the btrfs subvolumes:
  ```
  btrfs subvolume create /mnt/@
  btrfs subvolume create /mnt/@home
  btrfs subvolume create /mnt/@swap
  btrfs subvolume create /mnt/@snapshots
  ```
  The next step is to mount them correctly in the system root.

* Unmount everything and remount just the subvolumes under our top-level subvolume:
  ```bash
  # Unmount btrfs root:
  umount -v /mnt
  # Mount system root:
  mount -vo defaults,subvol=@,compress=zstd,noatime /dev/mapper/cryptroot /mnt
  # Create directories for mounting other subvolumes and esp:
  mkdir /mnt/{efi,home,snapshots,swap}
  # Mount home:
  mount -vo defaults,subvol=@home,compress=zstd,noatime /dev/mapper/cryptroot /mnt/home
  # Mount snapshots:
  mount -vo defaults,subvol=@snapshots,compress=zstd,noatime /dev/mapper/cryptroot /mnt/snapshots
  # Mount swap:
  mount -vo defaults,subvol=@swap,noatime /dev/mapper/cryptroot /mnt/swap
  # Create swapfile:
  touch /mnt/swap/swapfile
  # Set 600 permissions on it:
  chmod 600 /mnt/swap/swapfile
  # Disable Copy-on-Write (CoW) for it:
  # (You cannot create a single subvolume with the 'nodatacow' mount option without also disabling cow
  # for all other subvolumes on the same filesystem, which would prevent snapshots altogether.
  # Luckily, we CAN unset cow specifically for files/folders:)
  chattr +C /mnt/swap/swapfile
  # Check if COW is unset correctly:
  lsattr -l /mnt/swap
  # Set size of the swap file to 32GiB:
  fallocate /mnt/swap/swapfile -l 32G
  # Format the swapfile:
  mkswap /mnt/swap/swapfile
  # Turn the swap file on:
  swapon /mnt/swap/swapfile
  ```

  > **Note on [btrfs mount options](https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)#MOUNT_OPTIONS):**
  > - `compress=zstd`: Compression is a big advantage of btrfs, both for reduced file sizes, as well as the accompanying better performance. `zstd` is the latest implementation, superseding `lzo`.
  > - `noatime`: This option reduces disk IO by preventing read accesses to update the access time information. This only impacts the `last access time`, not the `last modified time`. If `noatime` is not set, each file that is read will also result in a write operation. This means using `noatime` can lead to significant performance gains. On COW file systems like btrfs it is especially useful to reduce unnecessary writes.
  > - `ssd`: This option will be enabled automatically when btrfs detects non-rotating storage.
  > - `space_cache`: The free space cache greatly improves performance when reading block group free space into memory. However, managing the space cache consumes some resources, including a small amount of disk space. There are two implementations; the safe default v1, and a v2 which can be enabled with `space_cache=v2`. If a version is not explicitly specified, the default v1 implementation will be chosen.
  > - `discard`: [discard/TRIM](https://wiki.archlinux.org/index.php/Solid_state_drive#TRIM) support is available for most SSDs. However, if we pass the `discard` option here, we would activate [continuous TRIM](https://wiki.archlinux.org/index.php/Solid_state_drive#Continuous_TRIM). It's generally recommended to use [periodic trim](https://wiki.archlinux.org/index.php/Solid_state_drive#Periodic_TRIM) with the kernel parameter `rd.luks.options=discard` and then enable the fstrim systemd service with `systemctl enable fstrim.timer`, but more on that later.  
  > Note also the [gotcha's for encrypted systems](https://wiki.archlinux.org/index.php/Dm-crypt/Specialties#Discard/TRIM_support_for_solid_state_drives_(SSD)); the kernel parameter does not work for secondary SSDs, and the concerns regarding plausible deniability, although this is probably less relevant for the majority of people.
  > - `autodefrag`: Since btrfs is a CoW filesystem, fragmentation is a concern. Enabling automatic file defragmentation helps counter this, but comes with the cost of significantly increasing the number of writes, reducing the SSD's life span. Also, it is still possible to manually defragment if required. Clearly, there are arguments to be made both PRO and CON `autodefrag`.

* It's also a good idea to create separate subvolumes for non-critical data that we do NOT want included in the root `@` and `@home` subvolume snapshots. This works beautifully since nested subvolumes are never included in the snapshot of their parent subvolume. This way, a lot of unnecessary writes can be prevented, which benefits storage capacity, SSD longevity, and eventually performance. Possible candidates for separate subvolumes:
  - `/var/cache` (and `~/.cache`, but home dir/user does not exist yet): The caches contain cached files; files that are generated and can be re-generated any time, but are stored to save the time of recomputing them. Any application can create files here, and is aware they can disappear any time. This means it is safe to just remove the contents, and replace it with a new subvolume cache.
  - `/var/log`: Over time, the log can grow quite large, so it's a good idea to exclude it from snapshots, since it does not hold critical system data.
  - Do NOT create separate subvolumes for `/tmp`: Arch uses tmpfs by default for `/tmp`, which is optimized specifically for this workload.
  Since different mount options are not required for these subvolumes, it is fine to create them directly in the root subvolume `@` (mounted at `/`), so they do not need to be mounted explicitly:
  ```
  btrfs subvolume create /mnt/var/cache
  btrfs subvolume create /mnt/var/log
  ```
  If for some reason you do want to pass [different mount options](https://btrfs.wiki.kernel.org/index.php/FAQ#Can_I_mount_subvolumes_with_different_mount_options.3F) for these subvolumes, you should create them in the btrfs root (i.e. same level as `@` and `@home`), and mount them explicitly.

  Note that this complicates matters on rollback, since you now need to keep separate subvolume backups and move them back into place. This also means the subvolumes will not be present in the btrfs root, but you can always pry them out of the original subvolume that is replaced by the rollback.  
  All in all, it's probably simpler to create them in the btrfs root and mount them:
  ```bash
  # Mount btrfs root:
  mkdir /mnt/btrfs
  mount -v /dev/mapper/cryptroot /mnt/btrfs
  # Create subvolumes in btrfs root:
  btrfs subvolume create /mnt/btrfs/@var-cache
  btrfs subvolume create /mnt/btrfs/@var-log
  # Mount btrfs root subvolumes to system root:
  mount -vo defaults,subvol=@var-cache,compress=zstd,noatime /dev/mapper/cryptroot /mnt/var/cache
  mount -vo defaults,subvol=@var-log,compress=zstd,noatime /dev/mapper/cryptroot /mnt/var/log
  ```
  This way, nothing will mysteriously break after rolling back only `/`.

  To check if an existing directory is a btrfs subvolume, use `stat /path`:
  ```bash
  # E.g.: stat /var/log
    File: /var/log
    Size: 0           Blocks: 0          IO Block: 4096   directory
  Device: 2bh/43d  Inode: 2           Links: 1
  Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
  Access: 2021-01-23 12:26:50.975949350 +0100
  Modify: 2021-01-23 12:26:50.975949350 +0100
  Change: 2021-01-23 12:26:50.975949350 +0100
   Birth: -
  ```
  A subvolume is identified by inode number 256, but inode number 2 (like shown here), indicates the so called "empty-subvolume". This means that a nested subvolume was snapshotted, and this entity will then exist in its place after a rollback (since nested subvolumes are never included in snapshots).

* Mount the ESP partition:
  ```
  mount -v /dev/nvme0n1p1 /mnt/boot
  ```
  For systemd-boot, it is simplest to [mount the ESP](https://wiki.archlinux.org/index.php/EFI_system_partition#Mount_the_partition) at `/boot`. If you mount it anywhere else like e.g. `/efi`, you will have to manually copy the boot images from `/boot` to `/efi` on every modification (e.g. kernel/mkinit upgrade), or automate it in some way.

# Installing the OS
## Select the mirrors
Packages to be installed must be downloaded from mirror servers. `reflector` is a Python script which can retrieve the latest mirror list from the Arch Linux Mirror Status page, filter the most up-to-date mirrors, sort them by speed and overwrite `/etc/pacman.d/mirrorlist`. Since this file will later be copied to the new system by pacstrap, it is worth getting it right:
```
reflector --verbose --latest 15 --sort rate --save /etc/pacman.d/mirrorlist
```

## Install essential packages
Use the `pacstrap` script to bootstrap the initial Arch system:
```
pacstrap /mnt base base-devel linux-lts linux-zen linux-zen-headers \
linux-firmware intel-ucode btrfs-progs man-pages man-db vim zsh
```
This will install some important base packages:
- `base`: Package for base Arch system.
- `base-devel`: Package group for compiling from AUR and using ABS (Arch Build System).
- `linux-lts`: Long-Term Support kernel; it's good to have a backup kernel in case of a regression.
- `linux-zen`: The [ZEN Kernel](https://github.com/zen-kernel/zen-kernel) is the result of a collaborative effort of kernel hackers to provide the best Linux kernel possible for everyday systems (contrary to the default kernel's server optimizations).
- `linux-zen-headers`: Headers and scripts for building modules for the Linux ZEN kernel.
- `linux-firmware`: Firmware for common hardware.
- `intel-ucode`: Microcode for intel processors (use `amd-ucode` for AMD processors).
- `btrfs-progs`: btrfs user programs.
- `man-pages` and `man-db`: Man pages are always useful in case we need to troubleshoot inside the chroot.
- `vim`: We will need a text editor when chrooted. If you're not familiar with `vim`, use `nano` here instead.
- `zsh`: If you prefer zsh over bash.  
You can of course use `linux` instead of `linux-zen` (or add it extra), if you have a preference for the default linux kernel.

These packages do not include all the tools from the live installation, so installing other packages is necessary for a complete system. You can append package names to the `pacstrap` command above (space separated) or use pacman while chrooted into the new system.

For comparison, packages available in the live system can be found in [packages.x86_64](https://gitlab.archlinux.org/archlinux/archiso/-/blob/master/configs/releng/packages.x86_64).


# Configuring the system
## Fstab
* Generate an fstab file using the `-U` flag to define by UUID:
  ```
  genfstab -U /mnt >> /mnt/etc/fstab
  ```

* Check the resulting `/mnt/etc/fstab` file, and edit it in case of errors:
  ```
  cp /mnt/etc/fstab /mnt/etc/fstab.bak
  vim /mnt/etc/fstab
  ```

  **fstab** example:
  ```bash
  # Static information about the filesystems.
  # See fstab(5) for details.

  # <file system>            <dir>              <type>    <options>                                                 <dump>  <pass>

  # Primary disk
  ################

  # @ subvolume: system root
  /dev/mapper/cryptroot      /                  btrfs     noatime,compress=zstd:3,ssd,space_cache,subvol=@              0    0

  # ESP partition
  /dev/nvme0n1p1             /boot              vfat      umask=0022,codepage=437,utf8,errors=remount-ro                0    2

  # @home subvolume
  /dev/mapper/cryptroot      /home              btrfs     noatime,compress=zstd:3,ssd,space_cache,subvol=@home          0    0

  # @snapshots subvolume
  /dev/mapper/cryptroot      /snapshots         btrfs     noatime,compress=zstd:3,ssd,space_cache,subvol=@snapshots     0    0

  # @swap subvolume
  /dev/mapper/cryptroot      /swap              btrfs     noatime,ssd,space_cache,subvol=@swap                          0    0

  # Swapfile
  /swap/swapfile             none               swap      defaults                  0    0

  # / subvolume: btrfs root
  /dev/mapper/cryptroot      /btrfs             btrfs     noatime,noauto,compress=zstd:3,ssd,space_cache,subvol=/       0    0

  # Secondary storage disks
  ###########################

  # backup
  /dev/mapper/backup         /storage/backup    ext4      noatime,noauto                   0    0

  # bulk
  /dev/mapper/bulk           /storage/bulk      ext4      noatime                          0    2

  # main
  /dev/mapper/main           /storage/main      ext4      noatime                          0    2
  ```


## Chroot
Change root into the new system:
```
arch-chroot /mnt
```

* Research [pacman package signing](https://wiki.archlinux.org/index.php/Pacman/Package_signing):
  ```
  pacman-key --init
  pacman-key --populate archlinux
  ```


## Timezone and system clock
* Enable network time synchronization:
  ```
  timedatectl set-ntp true
  ```

* Check the current timezone defined for the system:
  ```
  timedatectl status
  ```
  Also check for `NTP service: active`, to see if the previous enabling of the ntp service was successful.

* To list available timezones:
  ```
  timedatectl list-timezones
  ```

* Set the local timezone by symlinking to `/etc/localtime`:
  ```
  ln -sv /usr/share/zoneinfo/Europe/Brussels /etc/localtime
  ```

* Run `hwclock` to generate `/etc/adjtime`:
  ```
  hwclock --systohc
  ```
  The Hardware Clock is usually not very accurate; it gains or loses the same amount of time every day. `hwclock` keeps track of this systematic drift in `/etc/adjtime`.

* Enable the Network Time Protocol Daemon to prevent system time drift:
  ```bash
  # sudo pacman -Syu ntp
  sudo systemctl enable ntpd.service --now
  ```

## Localization
It is beneficial to set the locale before installing additional packages, because some packages rely on a default locale being set.

* Edit `/etc/locale.gen` and uncomment `en_US.UTF-8 UTF-8` (and/or other needed locales).

* Generate the locale(s) by running `locale-gen`.

* Create the `/etc/locale.conf` file, and set the `LANG` variable accordingly:
  `vim /etc/locale.conf`
  ```
  LANG=en_US.UTF-8
  ```

* If you changed the [keyboard layout](#-Set-the-keyboard-layout), persist the changes in `/etc/vconsole.conf`:
  ```
  KEYMAP=us
  ```


## Install additional packages
> Remove this section; install useful packages after reboot.

* Create list of all installed packages:
  ```
  pacman -Qqe > packages-installed.list
  ```

* Install packages from a list, while not reinstalling previously installed packages that are already up-to-date:
  ```
  pacman -Syu --needed - < /packages-archiso.list
  ```

* Remove packages from a list:
  ```
  pacman -R - < /packages.list
  ```

## Network configuration
* Create the `/etc/hostname` file with your hostname inside, preferably lowercase:
  ```
  echo arch-desktop > /etc/hostname
  ```

* Add matching entries to `/etc/hosts`:
  ```
  127.0.0.1    localhost
  ::1          localhost
  127.0.1.1    arch-desktop.localdomain    arch-desktop
  ```
  If the system has a permanent IP address, it should be used instead of 127.0.1.1.

For [Wireless configuration](https://wiki.archlinux.org/index.php/Network_configuration/Wireless), also install the [wpa_supplicant](https://www.archlinux.org/packages/core/x86_64/wpa_supplicant/) and [dialog](https://www.archlinux.org/packages/core/x86_64/dialog/) packages, as well as the needed [firmware packages](https://wiki.archlinux.org/index.php/Network_configuration/Wireless#Installing_driver/firmware). 

For more information, check out the [network configuration](https://wiki.archlinux.org/index.php/Network_configuration) documentation of the Arch Wiki.


## Initramfs
Creating a new initramfs is usually not required, because [mkinitcpio](https://jlk.fjfi.cvut.cz/arch/manpages/man/mkinitcpio.8.en) is run on installation of the kernel packages with `pacstrap`. However, if you're using LVM, LUKS or RAID, `/etc/mkinitcpio.conf` needs to be updated.

* Since we're using LUKS encryption and systemd, we add the proper [hooks](https://wiki.archlinux.org/index.php/Mkinitcpio#HOOKS) to `/etc/mkinitcpio.conf`:
  ```
  cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak
  vim /etc/mkinitcpio.conf
  ```

  ```bash
  # HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)
  HOOKS=(base systemd keyboard sd-vconsole autodetect modconf block sd-encrypt filesystems fsck)

  # To be able to use btrfs-check without booting from a live USB, also add it to the initial ramdisk:
  # This is not required, and btrfsck is considered a "last resort".
  BINARIES=(/usr/bin/btrfs)
  ```
  Note on hooks:
  - `systemd` replaces `udev`
  - Put `keyboard` before `autodetect` for laptops with external keyboard.
  - `sd-vconsole`: Adds the specified keymap(s) from `/etc/vconsole.conf` to the initramfs. If you use system encryption, especially full-disk encryption, make sure to add it before the encrypt hook.
  - `sd-encrypt`: systemd version of `encrypt` hook.
  - `btrfs`: It's a common misconception that this hook is required when using btrfs. This is not the case; it is only required for **multi-device btrfs volumes** that do NOT use either of the 'udev' or 'systemd' hooks!  
  If you're in doubt about a hook, there is a useful `-H, --hookhelp` flag to pass to mkinitcpio for more information:
  ```
  mkinitcpio -H btrfs
  ```
  - `fsck`: Note that `fsck` should NOT be run on btrfs volumes, so if you have it here, either make sure their `fsck` field in fstab is `0`, or [symlink the btrfs fsck utility](https://btrfs.wiki.kernel.org/index.php/FAQ#What.27s_the_difference_between_btrfsck_and_fsck.btrfs) to `/bin/true`:
    ```
    ln -s /bin/true /sbin/fsck.btrfs
    ```


* Recreate the initramfs images:
  ```
  mkinitcpio -P
  ```


## Passwords
* Set the root password:
  ```
  passwd
  ```

* Create a user account and password:
  ```bash
  # Create user account with `-m/--create-home`, `-s/--shell` and `-G/--groups` flags:
  useradd -m -s $(which zsh) -G sudo david
  # Create password for new user:
  passwd david
  ```
  You can remove a user account with `userdel <user>`.

* Switch to user and update/create user directories (e.g. Documents, Downloads, etc.):
  ```
  su david
  xdg-user-dirs-update
  ```


## Bootloader
* Install [systemd-boot](https://wiki.archlinux.org/index.php/systemd-boot):
  ```
  bootctl install
  ```
  [bootctl](https://www.freedesktop.org/software/systemd/man/bootctl.html) is a default package on Arch.

* If a new version of `systemd-boot` is available, you can manually update it with:
  ```
  bootctl update
  ```


### [Configuring systemd-boot](https://wiki.archlinux.org/index.php/systemd-boot#Configuration)
#### Adding loaders
* systemd-boot will search for boot menu items in `/boot/loader/entries/*.conf`, so that is where the loaders should be located. For the options field, use something like:
  ```
  options rd.luks.name=<luks-device-UUID>=cryptroot root=/dev/mapper/cryptroot rootflags=subvol=@ rd.luks.options=discard resume=/dev/mapper/cryptroot resume_offset=<OFFSET> rw
  ```
  - Note the `rootflags` option, which is required for btrfs! As I learned the hard way on my first ever Arch install, the OS will not boot if you leave it out.
  - `rd.luks.options=discard` is required for TRIM support, but make sure your SSD supports TRIM with:
  ```
  lsblk --discard
  ```
  If the `DISC-GRAN` (discard granularity) and `DISC-MAX` (discard max bytes) fields have non-zero values, TRIM is supported.
  - The `resume` and `resume_offset` parameters are required for hibernation. Follow [these instructions](https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate#Hibernation_into_swap_file_on_Btrfs) to get the offset:
    ```bash
    cd /tmp
    curl https://raw.githubusercontent.com/osandov/osandov-linux/master/scripts/btrfs_map_physical.c -o btrfs_map_physical.c
    gcc -O2 -o btrfs_map_physical btrfs_map_physical.c
    ./btrfs_map_physical /path/to/swapfile
    getconf PAGESIZE
    # Then divide the first physical offset returned by btrfs_map_physical
    # by the pagesize returned by getconf:
    # 67174400 / 4096 = 16400
    ```

* To create the loader files efficiently, redirect the proper UUID to the first `.conf` file with:
  ```
  blkid -s UUID -o value /dev/nvme0n1p2 > /boot/loader/entries/arch-linux.conf
  ```
  And then modify and copy it to the following loader entries (only the title and vmlinuz/initramfs images should differ between them):
  - `/boot/loader/entries/arch-linux-lts.conf`:
    ```
    title   Arch Linux LTS
    linux   /vmlinuz-linux-lts
    initrd  /intel-ucode.img
    initrd  /initramfs-linux-lts.img
    options rd.luks.name=d26a2a51-fa29-4edf-8917-ccda626a601b=cryptroot root=/dev/mapper/cryptroot rootflags=subvol=@ rd.luks.options=discard resume=/dev/mapper/cryptroot resume_offset=16400 rw
    ```
  - `/boot/loader/entries/arch-linux-zen.conf`:
    ```
    title   Arch Linux ZEN
    linux   /vmlinuz-linux-zen
    initrd  /intel-ucode.img
    initrd  /initramfs-linux-zen.img
    options rd.luks.name=d26a2a51-fa29-4edf-8917-ccda626a601b=cryptroot root=/dev/mapper/cryptroot rootflags=subvol=@ rd.luks.options=discard resume=/dev/mapper/cryptroot resume_offset=16400 rw
    ```
    Note that the paths for the `linux` and `initrd` fields are relative to the ESP (`/boot`).

* Note that the [microcode initrd option](https://wiki.archlinux.org/index.php/Microcode#systemd-boot) needs to be loaded **before** the initramfs initrd option. The latest microcode `cpu_manufacturer-ucode.img` must be available at boot time in your EFI system partition (ESP). If the ESP is not mounted as `/boot`, you need to copy `/boot/cpu_manufacturer-ucode.img` to your ESP on every update of the microcode package!

* Run `bootctl status` to check for problems.

#### Loader configuration
* The loader configuration is stored in [/boot/loader/loader.conf](https://jlk.fjfi.cvut.cz/arch/manpages/man/loader.conf.5):
  ```
  cp /boot/loader/loader.conf /boot/loader/loader.conf.bak
  vim /boot/loader/loader.conf
  ```

  `/boot/loader/loader.conf`:
  ```
  default  arch-linux-zen.conf
  timeout  4
  console-mode  max
  editor   no
  ```
  - `default`: Default entry to select as defined in the previous step; can be a wildcard like `arch-*.conf`.
  - `timeout`: Menu timeout in seconds before the default entry is booted. If this is not set, the menu will only be shown on Space key (or most other keys actually work too) press during boot.
  - `console-mode`: changes UEFI console mode:
    - `0` for 80x25;
    - `1` for 80x50;
    - `2` and above for non-standard modes provided by the device firmware, if any;
    - `auto` picks a suitable mode automatically;
    - `max` for highest available mode;
    - `keep` (default) for the firmware selected mode.
  - `editor`: Boolean to enable the kernel parameters editor or not. yes (default) is enabled, no is disabled; since the user can add init=/bin/bash to bypass root password and gain root access, it is strongly recommended to set this option to `no` if the machine can be accessed by unauthorized persons.  
    If you need to change kernel parameters on boot, temporarily change this to `true`, and press `e` during the boot menu. An initrd line similar to the following should appear:
    ```
    initrd=\initramfs-linux.img root=/dev/sda2 quiet splash
    ```
    Then you can add additional kernel parameters to the end of the string, like e.g. `debug`, which enables debug messages for both the kernel and systemd. Press Enter to boot with the new parameters.

* When everything is ready, definitely run:
  ```
  bootctl status
  ```
  This will let you know if the default boot entry is OK, e.g. whether the right images are present in the ESP.


## Desktop Environment
We will now be installing the Gnome desktop:
* It can be as simple as just installing the `gnome` package group:
  ```
  pacman -Syu gnome
  ```
  However, this will install dozens upon dozens of packages that are not required, and then we haven't even installed the `gnome-extra` package group. This is why I usually keep a file named `gnome-packages.list` containing all gnome packages that are essential or otherwise useful:
  ```
  eog
  file-roller
  gdm
  gedit
  gnome-calendar
  gnome-characters
  gnome-control-center
  gnome-disk-utility
  gnome-keyring
  gnome-logs
  gnome-screenshot
  gnome-session
  gnome-settings-daemon
  gnome-shell
  gnome-shell-extensions
  gnome-system-monitor
  gnome-terminal
  gnome-themes-extra
  gnome-weather
  gvfs
  gvfs-goa
  gvfs-google
  gvfs-gphoto2
  gvfs-mtp
  gvfs-nfs
  gvfs-smb
  mutter
  nautilus
  networkmanager
  rygel
  sushi
  tracker
  tracker-miners
  xdg-user-dirs-gtk
  yelp
  gnome-boxes
  gnome-nettool
  gnome-tweaks
  gnome-usage
  dconf-editor
  chrome-gnome-shell
  ```
  Note `gnome-boxes`, `gnome-nettool`, `gnome-tweaks`, `gnome-usage` and `dconf-editor` are from the `gnome-extra` package group. `chrome-gnome-shell` is not included in either the `gnome` or `gnome-extra` groups, but is required for installing Gnome extensions through Chrome or Firefox.

* With a list like this, it is trivial to install just these packages:
  ```
  pacman -Syu --needed - < ./packages-gnome.list
  ```
  Alternatively, you can just install the `gnome` and `gnome-extra` package groups and then manually select by number which packages you want installed, but this may take some time:
  ```
  pacman -Syu gnome gnome-extra
  ```

* The last thing to do, is to enable some services to work automatically after booting:
  ```bash
  # Enable networking/internet automatically:
  systemctl enable NetworkManager
  # Enable Gnome Display Manager for graphical Gnome desktop & login:
  systemctl enable gdm.service
  # Enable fstrim for SSD TRIM support:
  systemctl enable fstrim.timer
  ```
  Enabling `fstrim.timer` will cause `fstrim.service` to execute weekly (Monday at 00:00 local time). If the system is inactive at this time, it will be run immediately upon becoming active again. `fstrim.service` in turn executes `/usr/bin/fstrim --fstab --verbose --quiet` and informs storage devices about unused blocks, which makes wear leveling and block erasure more efficient, improving SSD longevity.


## Reboot
* Exit the chroot environment by typing `exit`.

* Optionally unmount all partitions with `umount -R /mnt`. This allows noticing any "busy" partitions, and finding the cause with e.g. `fuser -vm /mnt`. [fuser](https://jlk.fjfi.cvut.cz/arch/manpages/man/fuser.1) displays the PIDs of the processes using the specified files or file systems. It is common for swap partitions not to unmount properly, but all partitions will be unmounted by systemd anyway when rebooting.

* And finally, the moment of truth we've been waiting for ...   
  **`WILL   ...   IT   ...   BOOT   ???`**
  ```
  reboot
  ```

* See [General recommendations](https://wiki.archlinux.org/index.php/General_recommendations) for system management directions and post-installation tutorials.

* See the **tweaks** directory for many useful post-install customizations, and [[2-arch-debug.md]] for more on troubleshooting.

[//begin]: # "Autogenerated link references for markdown compatibility"
[2-arch-debug.md]: 2-arch-debug.md "Arch debugging"
[//end]: # "Autogenerated link references"