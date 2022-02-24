# Complete tutorial for installing Manjaro with encryption
> **Second Manjaro install, September 23, 2020!**

We will be installing Manjaro with [LUKS encryption](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition) directly on a GPT partitioned disk using Manjaro Architect.

Specifics:

* **Manjaro Architect**: This is the more advanced ISO available which enables much more control over the installation process. This installer does not include a live environment where you can testrun the OS. For that you need a live ISO from the [Manjaro Downloads](https://manjaro.org/download/) page (where you can also get the Architect ISO). A big advantage of the Architect ISO is that it never gets outdated, since it will pull all the latest packages from the internet. You can basically keep using it indefinitely, while the live ISOs contain a specific OS from 1 point in time. Of course, on a rolling release like Manjaro this is less inconvenient compared to a fixed release like Ubuntu.

* **UEFI/GPT**: The 'modern' way of doing things, GPT is preferable over MBR and the legacy BIOS approach, but this does require that your computer is not ancient.

* **systemd-boot**: A reliable bootloader is an important part of every OS. GRUB is the default on most linux distro's simply because it supports literally every possible scenario. GRUB comes with everything and the kitchen sink included, and this can have a serious impact when debugging boot errors. So when the requirements of an installation are crystal clear and do not require exotic GRUB features, it pays to go with a more minimal bootloader like systemd-boot.

* **LUKS2 encryption**: We're aiming to hit the sweet spot between security and convenience, and want to be as close as possible to 'Full Disk Encryption'. This is why we will encrypt both the system (`/`), and the user data (`/home`).
Technically, this is not FDE because we're leaving a small 0.5GiB EFI boot partition unencrypted. This is required for the OS to bootstrap itself. While it is technically possible to encrypt this partition and use a bootloader like [GRUB](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#Encrypted_boot_partition_(GRUB)) to decrypt it, this has all sorts of complications on performance and convenience, as well as requiring us to use GRUB.

* **NO LVM**: The Logical Volume Manager (LVM for short) manages all disks in Linux. It also allows to create what can be considered 'virtual' partitions; LVM volumes residing on a single LUKS encrypted partition. This gives the impression of a physical partition, while at the same time masking these volumes while encrypted. However, this adds performance and complexity complications and should not be done unless absolutely required.

* **Single partition system**: We will be using a single partition for `/` and `/home` and use a swapfile instead of a swap partition. This is the simplest and most straightforward approach, only requiring 1 encrypted partition without any LVM complications.
If you're accustomed to putting user data on other partitions/devices, it is trivial to add secondary encrypted drives.
On top of that, I think symlinking (`ln -s <SOURCE> <TARGET>`) home directories gives more control about what is located where. For example, you can keep 'Documents' on SSD, while symlinking 'Videos' to HDD:
  ```
  rm ~/Videos
  ln -s /storage/Videos ~
  ```
  If you prefer to have all user data on a separate partition for ease of reinstalling, you can symlink all user data directories, or alternatively use an `rsync` cronjob for important directories, to keep redundant duplicates of them on your secondary drive.

The following tutorial will go over the complete process, from actually burning the ISO install image, to getting a fully working Manjaro Linux OS.


## Burn ISO to disk
Download the [Manjaro Architect ISO file](https://manjaro.org/downloads/official/architect/).  
Next, we need to burn this file to a USB stick:

### From Linux
```bash
# List all disks to find the USB stick:
sudo fdisk -l
# Unmount it:
sudo umount -v /dev/sdX
# Copy the ISO to the USB stick:
sudo dd bs=4M if=/path/to/iso of=/dev/sdX status=progress oflag=sync
```

### From Mac
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

### From Windows
On Windows use one of the many GUI programs, e.g. [Rufus](https://rufus.ie/).


## Wipe the disk to which you want to install Manjaro
> ### [Warning:](https://wiki.archlinux.org/index.php/Securely_wipe_disk#Preparations_for_block_device_encryption)
> If block device encryption is mapped on a partition that contains
> non-random or unencrypted data, the encryption is weakened and
> becomes comparable to filesystem-level encryption: disclosure of
> usage patterns on the encrypted drive becomes possible. Therefore,
> do not fill space with zeros, simple patterns (like badblocks) or
> other non-random data before setting up block device encryption.

Even though the installer itself will later offer to wipe your disk, this is a regular overwrite-based disk-wipe that is not ideal for SSDs. So if you're using an SSD you may want to do a ['Secure Erase'](https://wiki.archlinux.org/index.php/Solid_state_drive/Memory_cell_clearing) now.

If you're using a HDD, you can use the `shred` command line tool now, or let the installer do it later. 

### SSD: NVMe example
From any live ISO, check which commands the [NVMe drive](https://wiki.archlinux.org/index.php/Solid_state_drive/Memory_cell_clearing#NVMe_drive) supports with the command:
```bash
# Find the drive's name with either fdisk or lsblk:
sudo fdisk -l # NVMe devices are typically indicated with names like e.g. /dev/nvme0n1p1,
lsblk -f      # where 0 indicates NVMe disk 0 (first), n1 for namespace 1, p1 for partition 1.
# And check support:
# (nvme-cli package may still need to be installed)
sudo nvme id-ctrl /dev/nvme0 -H | grep "Format \|Crypto Erase\|Sanitize"
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
sudo nvme format /dev/nvme0 -s 2 -n 1
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
# shred will not be able to fully remove it. We use 'parted' for this:
sudo parted /dev/sdb
# Find any existing partitions by running print:
(parted) print
# Remove existing partitions:
(parted) rm 1  # Replace 1 with the partition number you want to remove.
# -> Repeat for all remaining partitions on the disk.
# -> Exit parted, and continue with shredding:
(parted) quit

# shred --verbose --iterations=1 (default 3 takes longer):
sudo shred -vn 1 /dev/sdb
# Note: even 1 iteration will take a LONG time for large drives!
# (Read: at least an hour per terabyte)
```

## Booting the ISO
> | :warning: Warning: |
> |--------------------|
> | Make sure to boot the Manjaro Architect ISO in **UEFI mode**, otherwise the UEFI boot entry cannot be added! |

When booted, you will be greeted with a `Welcome to Manjaro` screen, where you can set a few initial options:
- Timezone
- Keyboard
- Language
- Drivers (this includes graphics: use `non-free` option for nvidia)

Afterwards, push enter on the Manjaro Architect boot option, and you will enter a terminal environment; log in with user `manjaro`, password `manjaro`, and enter `setup` to start the installation.

This will bring you into the `Main Menu`, where we'll have to work through 2 big steps:  
1. Prepare Installation
2. Install Desktop System

Before continuing, doublecheck that you're using the UEFI version of the installer; in the top left corner you should see something like:
```
Manjaro Architect Installer v0.9.33 - UEFI (x86_64)
```
Note the UEFI part; if it says `BIOS` instead, reboot and pick the right installer!

## I. Prepare Installation
### 1. Set Virtual Console
A keyboard layout (vconsole) will already be chosen automatically based on
your language choice. If the expected default works for you, you can skip
this menu entry. Alternatively, open it to see your current configuration
and decide on keeping/altering it.

### 2. List Devices
Here you can see the available drives and storage devices if you like.
You can skip this step safely.

### 3. Partition Disk
Make sure to select the correct device (the NVMe SSD in my case), which we wiped earlier.

Two partitions are required:
* A FAT32 partition of at least half a GiB with the ESP (= EFI System Partition) flag set,
  which has to be left unencrypted to serve as boot partition.
* The remaining space as 1 big partition, which we will encrypt later.

This is exactly what the `Automatic Partitioning` option will create, but it appears the automatic partitioning tool does not correctly initialize the filesystems, resulting in a non-booting OS. Luckily, it is straightforward to do this manually with `parted`, using the following commands:
```bash
(parted) mklabel gpt
(parted) mkpart "ESP" fat32 1MiB 512MiB
(parted) set 1 esp on
(parted) mkpart "OS" ext4 512MiB 100%
# Make sure everything looks good:
(parted) print
(parted) quit
```

Either of these options will result in 2 partitions on the device; in my case `/dev/nvme0n1p1` (0.5GiB ESP) and `/dev/nvme0n1p2` (named 'OS' in our manual partitioning, and 'primary' by the Automatic Partitioner).

See [Parted Archwiki](https://wiki.archlinux.org/index.php/Parted) for more information.

### 4. Raid
Skip

### 5. Logical Volume Management
Skip

### 6. LUKS Encryption
At this point, you have 2 options:
* Choose `Automatic LUKS Encryption` and select the large partition we previously created. The disadvantage is that this will default to the older LUKS1 format because grub does not yet work fully with LUKS2.
* Manually encrypt the partition with LUKS2, since we won't be using GRUB anyway.

LUKS2 has a few nice additions like more advanced encryption options, significantly stronger protection against GPU and FPGA bruteforce attacks, as well as a more robust header that lowers the chance of getting locked out of your disk when it gets damaged. LUKS2 is preferable, so we temporarily exit the installer (press `Cancel` until you're back in the terminal environment) to encrypt the disk.

In the terminal environment, use the following commands:
```bash
# Double check you're encrypting the right device, or you might lose data:
sudo cryptsetup --verbose --type luks2 luksFormat /dev/nvme0n1p2
# This uses the LUKS2 defaults (See 'cryptsetup --help'):
#   * PBKDF (Password-Based Key Derivation Function): argon2i
#   * Iteration time: 2000ms
#     This is the number of milliseconds spent on PBKDF passphrase processing
#     (only relevant when changing passphrases)
#   * Random number generator: /dev/urandom
#   * Cipher: aes-xts-plain64
```
It is a good practice to **always** use the `--verbose` or `-v` flag with cryptsetup, so that you receive feedback about what you're doing.

Alternatively, if you're really paranoid, you can use one of the following extra-secure options:
(`--hash sha512` and `--key-size 512`?)
```bash
sudo cryptsetup --verbose --type luks2 --iter-time 4000 --use-random luksFormat /dev/nvme0n1p2
# This is likely the optimal choice regarding the security-performance tradeoff,
# since the default AES cipher is more battle-tested, as well as benefits from hardware acceleration:
sudo cryptsetup --verbose --type luks2 --pbkdf argon2id --hash sha512 --iter-time 5000 --use-random luksFormat /dev/nvme0n1p2
# But note that the serpent cipher is supposedly stronger than AES:
sudo cryptsetup --verbose --type luks2 --pbkdf argon2id --hash sha512 --cipher serpent-xts-plain64 --iter-time 6000 --use-random luksFormat /dev/nvme0n1p2
```

With that done, type `setup` again to continue with the Manjaro Architect installer, and find your way back to the LUKS encryption menu. We have to unlock the partition before continuing, or we will not be able to install the OS:
* Open encrypted partition: `/dev/nvme0n1p2`
* Specify a name for the encrypted block device: `cryptroot`
* Enter the password you used previously for encrypting the partition. 
* When completed, press `Back` and `Cancel` the `LUKS Encryption` menu
  to return to the `Prepare Installation` Menu, and continue with
  `Mount Partitions`.

### 7. ZFS
Skip since btrfs

### 8. Mount Partitions
* First select the ROOT Partition, where Manjaro will be installed:  
  - `/dev/mapper/cryptroot`: Make sure the partition has the `/dev/mapper/` part, as this indicates the decrypted state of the LUKS partition. If you have no mapper, return to the `LUKS encryption` step to open it first!
  - Choose Filesystem: ext4
  - Mount options: noatime  
    This option reduces disk IO by preventing read accesses to update
    the atime information. This has no impact on the `last modified time`.
    If `noatime` is not set, each read access will also result in a write operation.
    This means using `noatime` can lead to significant performance gains.

* Select SWAP Partition: swapfile

* Select additional partitions: Done

* Select UEFI partition: choose the ESP partition from before, `/dev/nvme0n1p1` in my case.

* Select UEFI mountpoint: `/boot` (not `/boot/efi`!).

### 9. Configure Installer Mirrorlist
1. Edit Pacman Configuration: Not required

2. Edit Pacman Mirror Configuration: Not required

3. Rank Mirrors by Speed:
   * Choose Manjaro Branch: stable
   * Select your custom mirrors:
     Select those that came out on top with the `space` bar, and scroll down to `OK`.

### 10. Refresh Pacman Keys
This, and the following preparations are not strictly required.
We can go back to the main menu, and choose `2. Install Desktop System`.

## II. Install Desktop System
### 1. Install Manjaro Desktop
* Install Base:  
  First we have to select the Linux kernel to use;
  it makes sense to choose an alternative kernel here already,
  so we won’t need to install a backup kernel later manually.
  The base-devel group is required to use the AUR in your installed system.
  Select them with the `Space` key:  
  ```
  [*] yay + base-devel
  [*] linux-lts
  [*] linux-latest
  [ ] ...
  ```
* Install Desktop Environment:  
  I prefer GNOME for its minimalism and consistency.

* Extra packages:  
  Type the extra packages you want to install and select them with tab.  
  Do **NOT** press enter until you are done selecting packages.

  Some useful apps/packages that are not included by default (even with full install):  
  - audacity: Audio editing
  - avidemux-qt: Video split & merge
  - blender: 3D Graphics
  - calibre: Ebook management
  - darktable: Photo editing
  - elisa: Music Player
  - gocryptfs: File encryption
  - guake: Dropdown terminal
  - inkscape: Vector graphics
  - kdenlive: Video editor
  - krita: Digital painting
  - mpv: Media player
  - okular: PDF viewer and annotator
  - onlyoffice-desktopeditors: Office suite
  - qbittorrent: Torrent client
  - syncthing: Continuous file synchronization
  - tesseract (& tesseract-data-eng): OCR engine
  - veracrypt: Disk/folder encryption
  - vlc: Media player
  
  Press `Enter` to continue.

* Choose between a full or minimal install:  
  `Full` is recommended unless you want to have absolute control
  and don't mind manually installing more packages.

* Now you can inspect the packages to be installed in nano:  
  You can still remove something if you made an error previously.  
  `Ctrl+o` and `Enter` to save, and `Ctrl+x` to exit.  
  **The install will now happen, which might take some time.**

* Install Display Driver:  
  `Auto-install proprietary drivers` is recommended for nvidia, free drivers otherwise.
  Afterwards, press `Enter` to continue.

### 2. Install Bootloader
Install UEFI Bootloader: **systemd-boot**  

### 3. Configure Base
* Generate fstab: Use the `Device UUID` option.
* Set Hostname: Name your computer, preferably in lowercase, e.g. `manjaro-desktop`
* Set System Locale: en_US
* Set Desktop Keyboard Layout: us
* Set Timezone and Clock: Europe > Brussels  
  Then select `UTC`.
* Set Root Password: *********
* Add New User:  
  - Enter user name (lower case letters only)
  - Choose the default shell: zsh
  - Provide the password!
  
### 4. System Tweaks
#### 4. Security and systemd Tweaks
* Amend journald Logging: `SystemMaxUse=200M`
* Disable Coredump Logging: `Disable`
* Restrict Access to Kernel Logs: `Disable`

------------------------------------------------------------------------

And with this, we are DONE!  
Exit the installer, and enter `reboot` at the command line to boot into your new desktop.

If your display's colors have a yellowish tinge to them, most likely GNOME's `Night Light` feature is enabled, which reduces blue light to help you sleep better. You can turn this off in `Settings > Display > Night Light` if it really annoys you (or simply toggle it in the right corner of the screen).
