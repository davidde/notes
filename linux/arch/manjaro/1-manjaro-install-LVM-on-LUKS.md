# Manjaro Architect LVM on LUKS installation
> **Installed Manjaro on August 13, 2020!**

> ### Note:
> The better approach might be to replace the swap partition with a swapfile.
> That way we only need a single encrypted partition, and can ditch LVM,
> further simplifying everything and freeing us from its performance penalty.
> 
> As [@Chrysostomus mentions on the forum](https://forum.manjaro.org/t/manjaro-architect-full-disk-encryption/570/19?u=davidde),
> it is then best to select `/boot` over `/boot/efi` as EFI mount point
> for [better performance](https://forum.manjaro.org/t/manjaro-architect-full-disk-encryption/570/15?u=davidde).
> 
> So, to sum it up:
> * Automatic partitioning.
> * Create LUKS container in the bigger volume.
> * Mount the LUKS container to `/`. Choose ext4 or xfs if you want to use a swapfile.
> * For swap, choose swap file.
> * For extra mounts, don’t choose anything.
> * For EFI mount point, choose `/boot` and the smaller automatically created partition.

> ### Burn ISO to disk:
> ```bash
> # Linux:
> sudo fdisk -l
> sudo umount -v /dev/sdN
> sudo dd bs=4M if=/path/to/iso of=/dev/sdN status=progress oflag=sync
> ```
>
> ```bash
> # Mac:
> # Find the right disk:
> diskutil list
> # Unmount it:
> diskutil unmountDisk /dev/diskN
> # Copy the iso with rdisk (raw disk) instead of disk,
> # to speed up copying:
> sudo dd bs=1m if=/path/to/iso of=/dev/rdiskN; sync
> # (Check progress by pressing Ctrl+T)
> # Eject the disk when finished:
> sudo diskutil eject /dev/rdiskN
> ```

We will be creating an [LVM on LUKS](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS) encrypted Manjaro installation with UEFI and GPT using Manjaro Architect. While technically not FDE, both `/` and `/home` are fully encrypted (with the exception of a small 0.5GiB /boot partition).

Make sure to boot the Manjaro-Architect ISO in **UEFI mode** (the full disk one, without 'Partition 1'),
otherwise the GRUB UEFI boot entry cannot be added. If 2 UEFI
installation media (partitions) show up, use the largest one.

When booted, you will have the option to set a few initial options:
- Keyboard
- Language
- Timezone
- Drivers (this includes graphics: use `non-free` option)

Afterwards, push enter on the Manjaro Architect boot option.
Log in with user `manjaro`, password `manjaro`, and enter `setup`.
This will bring you into the 'Main Menu',
where we'll have to work through 2 big steps:  
1. Prepare Installation
2. Install Desktop System

If you get stuck anywhere, check out this
[Manjaro Architect Tutorial](https://archived.forum.manjaro.org/t/installation-with-manjaro-architect-iso/20429) or this
[Manjaro Architect LVM on LUKS Tutorial](https://archived.forum.manjaro.org/t/installation-lvm-on-luks-with-manjaro-architect/42396)
for more detailed information.

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
Two partitions are required:
* A FAT32 partition of at least half a GiB with the ESP flag set,
  which has to be left unencrypted to serve as boot partition.
* The remaining space as 1 partition that could even be left unformatted,
  since it will be encrypted anyway to serve as the LVM Volume Group that will
  allow for multiple Logical Volumes inside.

```bash
(parted) mklabel gpt
(parted) mkpart "EFI system partition" fat32 1MiB 512MiB
(parted) set 1 esp on
(parted) mkpart "Encrypted system partition" ext4 512MiB 100%
# Make sure everything looks good:
(parted) print
```

See [Parted Tutorial](https://linuxconfig.org/how-to-manage-partitions-with-gnu-parted-on-linux)
and [Parted Archwiki](https://wiki.archlinux.org/index.php/Parted) for more information.

### 6. LUKS Encryption
* Choose `Automatic LUKS Encryption` and select the large partition
on your SSD we previously created.
* Specify a name for the encrypted block device: cryptroot
* When completed, press `Back` and `Cancel` the `LUKS Encryption` menu
  to return to the `Prepare Installation` Menu, and continue with
  `Logical Volume Management`.

### 5. Logical Volume Management
> **Note:**  
> If you do not need multiple encrypted partitions, a better approach is to replace the swap partition with a swapfile. That way, only a single encrypted partition is necessary, and we can ditch LVM, freeing us from its performance penalty and further simplifying everything. It is then best to select `/boot` over `/boot/efi` as EFI mount point for [better performance](https://forum.manjaro.org/t/manjaro-architect-full-disk-encryption/570/15).
>
> So, to sum it up:
>
> * Automatic partitioning.
> * Create LUKS container in the bigger volume.
> * Mount the LUKS container to `/`. Choose ext4 or xfs if you want to use a swapfile.
> * For swap, choose swap file.
> * For extra mounts, don’t choose anything.
> * For EFI mount point, choose `/boot` and the smaller automatically created partition.

* Create VG and LV(s):  
  - Enter the name of the Volume Group (VG) to create: LVM-VG
  - Select the partition(s) to use for the Physical Volume:  
    `[*] /dev/mapper/cryptroot`
  - Enter the number of Logical Volumes (LVs) to create in `[LVM-VG]`: 2  
    Only a root and swap partition; a separate /home partition is not required
    since symlinks provide more power and control to put specific /home dirs
    (like e.g. Pictures or Downloads) on other drives or partitions.
  - Enter the name of the Logical Volume (LV) to create: lvol-root
  - Enter the size of the Logical Volume (LV) in Megabytes (M) or Gigabytes (G): 920G  
    On a 1TB SSD this will keep ca. 33GB for the swap partition.  
    If you plan on using hibernation (aka suspend to disk),
    the size of the swap partition should at least equal your RAM (32GB for me).
    Otherwise, you can get by with a lot less swap space.
  - Enter the name of the Logical Volume (LV) to create: lvol-swap
  - Do you wish to view the new LVM scheme? Yes  
    Check to see if everything looks ok, then press `Back` and `Cancel`
    the `Logical Volume Management` menu to return to the
    `Prepare Installation` Menu, and continue with `Mount Partitions`.

### 8. Mount Partitions
* First select the ROOT Partition, where Manjaro will be installed:  
  - E.g. `/dev/mapper/LVM--VG-lvol--root`
  - Choose Filesystem: ext4
  - Mount options: noatime  
    This option reduces disk IO by preventing read accesses to update
    the atime information. This has no impact on the `last modified time`.
    If `noatime` is not set, each read access will also result in a write operation.
    This means using `noatime` can lead to significant performance gains.

* Select SWAP Partition:
  E.g. `/dev/mapper/LVM--VG-lvol--swap`

* When choosing the UEFI boot partition choose the FAT32 partition from before,
with mountpoint `/boot/efi` (not `/boot`!).

### 9. Configure Installer Mirrorlist
1. Edit Pacman Configuration: Not required

2. Edit Pacman Mirror Configuration:  
   Optionally configure your country and those geographically close,
   so the upcoming 'Rank Mirrors' will take less time:  
   ```bash
   ## Branch Pacman should use (stable, testing, unstable)
   Branch = stable

   ## Generation method
   ## 1) rank   - rank mirrors depending on their access time
   ## 2) random - randomly generate the output mirrorlist
   Method = rank

   ## Specify to use only mirrors from specific a country.
   ## Can add multiple countries separated by a comma (ex: Germany,France)
   ## Empty means all
   OnlyCountry = Belgium,Netherlands,Germany,France

   ## Mirrors directory
   # MirrorlistsDir = /etc/pacman.d/mirrors

   ## Output file
   # OutputMirrorlist = /etc/pacman.d/mirrorlist

   ## When set to True prevents the regeneration of the mirrorlist if
   ## pacman-mirrors is invoked with the --no-update argument.
   ## Useful if you don't want the mirrorlist regenerated after a
   ## pacman-mirrors package upgrade.
   # NoUpdate = False
   ```
   Press Ctrl+O then Enter to save, and Ctrl+x to exit.

3. Rank Mirrors by Speed:
   Select those that came out on top.

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
  Useful apps/packages:  
  - audacity: Audio editing
  - blender: 3D Graphics
  - calibre: Ebook management
  - darktable: Photo editing
  - gocryptfs: File encryption
  - guake: Dropdown terminal
  - gthumb: Image viewer and manager
  - handbrake (& handbrake-cli): Video transcoder
  - inkscape: Vector graphics
  - krita: Digital painting
  - mpv: Media player
  - onlyoffice-desktopeditors: Office suite
  - qbittorrent: Torrent client
  - rsync: File transfer
  - syncthing (& optional GUI: syncthing-gtk): Continuous file synchronization
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
  `Auto-install proprietary drivers` is recommended.
  Afterwards, press `Enter` to continue.

### 2. Install Bootloader
- Install UEFI Bootloader: **grub**  
- Enter your encryption passphrase.  
- Press `Yes` to set grub as default bootloader.

### 3. Configure Base
* Generate fstab: Use the `UEFI Part UUID` option.
* Set Hostname: Name your computer.
* Set System Locale: en_US
* Set Desktop Keyboard Layout: us
* Set Timezone and Clock: Europe > Brussels  
  Then select `utc`.
* Set Root Password: *********
* Add New User(s):  
  - Enter user name (lower case letters only)
  - Choose the default shell (zsh, bash or fish)
  - Provide the password(s)!
  
### 4. System Tweaks
#### 2. Enable Hibernation
Enable hibernation automatically.

With this, we are done! Exit the installer, and enter `reboot`
at the command line to boot into your new desktop.

# Additional tweaks and configuration
If your display's colors have an orange tinge to them, most likely GNOME's `Night Light` feature is enabled, which reduces blue light to help you sleep better.
You can turn it off (or decide to keep it) in `Settings > Display > Night Light`.

## Debugging Hibernation
It seems that the last `System Tweak`, to ‘Enable hibernation automatically’ does not work out of the box with encryption. Do the following to fix it:
* If you get `ERROR: resume: hibernation device y not found` when booting,
  make sure the correct UUID for your swap partition is present in the `resume=` parameters of
  `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub`:
  ```
  GRUB_CMDLINE_LINUX_DEFAULT="quiet resume=UUID=c0ddf00f-35dd-4356-a24e-9f778a4e70f1 resume=/dev/disk/by-uuid/c0ddf00f-35dd-4356-a24e-9f778a4e70f1"
  ```
* Make sure the `resume` HOOK in `/etc/mkinitcpio.conf` is listed last:  
  ```
  HOOKS=(base udev autodetect keymap modconf block encrypt lvm2 filesystems keyboard resume)
  ```
* Regenerate grub:  
  ```
  sudo mkinitcpio -P
  sudo update-grub
  ```
* To test hibernation, `pm-hibernate` of the `pm-utils` is very useful:  
  ```
  pamac install pm-utils
  sudo pm-hibernate
  ```
If everything went well, your computer should now be in hibernation.

## Additional installs

> **Note on package managers:**  
> * **pamac**, the Manjaro-based package manager is more intuitive 
> and beginner-friendly. For instance, when the OS is not fully up to date,
> `pamac install` will update it first, preventing big problems from occurring. Some useful commands:  
>   - `pamac search package`: search the repos for 'package'.
>   - `pamac search -a package`: search the repos and AUR for 'package'.
>   - `pamac install package`: install 'package' from the repos.
>   - `pamac build package`: build 'package' from the AUR.
>   - `pamac remove package`: uninstall 'package' installed from either the repos or AUR.
>   - `pamac update/upgrade (-a)`: update/upgrade all packages (including AUR with `-a` option).
> * **pacman**, the Arch-based package manager is generally considered
> to be the more powerful option, but also less beginner-friendly.
> For instance, installing a package is done with `sudo pacman -S package`,
> and this is also what many tutorials will tell you to do, **but**
> if the OS is not up to date, this will simply fail obscurely and
> possibly result in an unbootable OS. This is why you should always use
> **`sudo pacman -Syu package`** to install software, as this will update
> first and prevent further problems. To simply update all existing non-AUR packages, use **`sudo pacman -Syu`**.
> Use `sudo pacman -R package` to remove a package, and `sudo pacman -Rsn package` to remove the package and every single associated config file (outside of those in home dir). Using `-c` with `-R` removes packages that depend on the package you are uninstalling and is unlikely needed often; it can be useful if pacman is refusing to remove a package because another package depends on it. Note that this may also uninstall user-installed packages if they depend on the package being uninstalled; you can check this with `sudo pacman -Qi <PACKAGE>` (Redo this for every package listed in the `Required by` section, to verify which packages will be uninstalled).
> `sudo pacman -Sc` to clean the pacman pkg cache (`/var/cache/pacman/pkg`).
> * **yay**: while technically an AUR-helper, it has the simplest command to update everything: simply `yay`! If no arguments are provided, `yay -Syu` will be performed, updating both repo and AUR packages in one go. Use `yay -Syu --rebuild package` to rebuild broken packages (e.g. when its dependencies are updated), `yay -Ss package` to search for a package, and `yay -R package` to remove a package.

* oh-my-zsh:  
  `sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
* `pamac build google-chrome visual-studio-code-bin spotify dropbox`  
  If spotify or dropbox return a PGP signature error, enter
  `curl -sS https://download.spotify.com/debian/pubkey.gpg | gpg --import -` or
  `curl -sS https://linux.dropbox.com/fedora/rpm-public-key.asc | gpg --import -` respectively and build again.
  Also `caffeine-ng`.
* Activate the `Window List` GNOME extension in the `Extensions` app to get a bottom taskbar with the active programs.
* Add the [Custom Hot Corners](https://extensions.gnome.org/extension/1362/custom-hot-corners/), [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/) and [Archlinux updates indicator](https://extensions.gnome.org/extension/1010/archlinux-updates-indicator/) GNOME extensions (to do this efficiently use the Firefox browser with the [GNOME Shell integration](https://addons.mozilla.org/en-US/firefox/addon/gnome-shell-integration/) extension).  
  Set up hot corners:  
  - Left Top: Show Applications
  - Left Bottom: Toggle Overview
  - Right Top: Run command: `guake` (Toggles guake dropdown)
  - Right Bottom: Run command: `xdg-screensaver lock` (Locks screen)
* Install KVM Virtual Machine Manager:  
  ```
  sudo pacman -Syu virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat
  sudo systemctl enable libvirtd.service
  sudo systemctl start libvirtd.service
  ```

## Tweaks
### sudo
Note that to modify `/etc/sudoers`, you should always use `visudo`:
```
sudo visudo
```

* Require the sudo password to be the password of the target user specified with `-u`. Defaults to the root password if no `-u` option is provided.
  ```bash
  # targetpw is set now:
  # (comment out to unset)
  Defaults targetpw
  ```
  If this option is not set, the password of the invoking user is used. This means only the user password is required to elevate priviledges and use sudo.

  **Note that this is only a security improvement for a single user system!** Otherwise it would require the superuser to share his/her password with the other users. This is why it is not set as a system default.
* Change the timeout after which the sudo password has to be reentered in minutes (default 5):
  ```
  Defaults timestamp_timeout=10
  ```
* Enable humorous insults easter egg on incorrect password:
  ```
  Defaults insults
  ```

Everything put together:
```bash
##
## Require the sudo password to be the password of the target user specified with -u.
## Defaults to the root password if no -u option is provided.
## Comment out to unset, and the password of the invoking user will be used:
Defaults targetpw
## Timeout after which sudo password has to be reentered in minutes (default 5):
Defaults timestamp_timeout=10
## Enable insults easter egg:
Defaults insults
```

### Disable Nautilus 'Recent files'
* Open `dconf Editor`.
* Navigate to `org > gnome > desktop > privacy`.
* Find the `remember-recent-files` option.
* Uncheck the `Use default value` slider, and change the custom value to `false`.

+ Folders first, add `/` and `dropbox` shortcuts, enable creating new file from rightclick.

### VLC
* Uncheck `Allow only one instance` and `Save recently played items` in Preferences.
* In the Audio Settings, change the `Output module` to `ALSA audio output`. This allows then checking the `Always reset audio start level to:` option, to set the start volume when opening VLC.
* In the Input & Codecs Settings, change `Hardware accelerated decoding` from `Automatic` to `VA-API Video decoder via DRM`. This fixes playback of some H265 encoded videos.

## Adding secondary encrypted drives ...
> **Note:**  
> See the [fstab](https://wiki.archlinux.org/index.php/Fstab) and
> [crypttab](https://wiki.archlinux.org/index.php/Dm-crypt/System_configuration#crypttab)
> Archwikis for more information, as well as the [cryptsetup man pages](https://linux.die.net/man/8/cryptsetup).  
> There are also
> [this short Manjaro tutorial](https://archived.forum.manjaro.org/t/adding-an-encrypted-data-partion-to-fully-encrypted-manjaro-system/30936),
> and [this longer Arch-based one](https://www.pavelkogan.com/2014/05/23/luks-full-disk-encryption/).  
> On top of that, there are these Ubuntu tutorials on
> [LVM on LUKS secondary drives](https://www.erianna.com/adding-an-secondary-encrypted-drive-with-lvm-to-ubuntu-linux/)
> and [encrypting multiple partitions with a single passphrase](https://eve.gd/2012/11/02/luks-encrypting-multiple-partitions-on-debianubuntu-with-a-single-passphrase/).

## ... with the command line
* Securely erase the drive's partition table and data:
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

  > ### [Warning:](https://wiki.archlinux.org/index.php/Securely_wipe_disk#Preparations_for_block_device_encryption)
  > If block device encryption is mapped on a partition that contains
  > non-random or unencrypted data, the encryption is weakened and
  > becomes comparable to filesystem-level encryption: disclosure of
  > usage patterns on the encrypted drive becomes possible. Therefore,
  > do not fill space with zeros, simple patterns (like badblocks) or
  > other non-random data before setting up block device encryption.

  Note that **SSDs** usually have a [secure erase](https://wiki.archlinux.org/index.php/Solid_state_drive/Memory_cell_clearing) feature that is preferable to shred for longevity reasons.

* Create partition table and partitions using `parted`'s interactive mode:
  ```bash
  sudo parted /dev/sdb
  (parted) mklabel gpt
  (parted) mkpart "main" 1MB 2TB
  (parted) mkpart "bulk" 2TB 100%
  # Make sure everything looks good:
  (parted) print
  (parted) quit
  ```

* Encrypt the disk partition(s) with the cryptsetup luks commands:  
  ```bash
  sudo cryptsetup --verbose --type luks2 luksFormat /dev/sdb1
  sudo cryptsetup --verbose --type luks2 luksFormat /dev/sdb2
  ```
  It is a good practice to **always** use the `--verbose` or `-v` flag with cryptsetup, so that you receive feedback about what you're doing. You can leave out the `--type luks2`, but note that the `luksFormat` default depends on your cryptsetup version, so it might default to `luks1`. You can check this by running `cryptsetup --help`, which will end in the defaults that will be used:
  ```
  Default compiled-in metadata format is LUKS1 (for luksFormat action).

  Default compiled-in key and passphrase parameters:
          Maximum keyfile size: 8192kB, Maximum interactive passphrase length 512 (characters)
  Default PBKDF for LUKS1: pbkdf2, iteration time: 2000 (ms)
  Default PBKDF for LUKS2: argon2i
          Iteration time: 2000, Memory required: 1048576kB, Parallel threads: 4

  Default compiled-in device cipher parameters:
          loop-AES: aes, Key 256 bits
          plain: aes-cbc-essiv:sha256, Key: 256 bits, Password hashing: ripemd160
          LUKS: aes-xts-plain64, Key: 256 bits, LUKS header hashing: sha256, RNG: /dev/urandom
          LUKS: Default keysize with XTS mode (two internal keys) will be doubled.
  ```
  Even so, there is nothing really wrong with luks1, so you might just not care.

  Alternatively, if you're really paranoid, you can use one of the following extra-secure options:
  ```bash
  sudo cryptsetup --verbose --type luks2 --iter-time 4000 --use-random luksFormat /dev/sdb1
  # This is likely the optimal choice regarding the security-performance tradeoff,
  # since the default AES cipher benefits more from hardware acceleration,
  # contrary to the supposedly stronger serpent cipher:
  sudo cryptsetup --verbose --type luks2 --pbkdf argon2id --iter-time 5000 --use-random luksFormat /dev/sdb2
  sudo cryptsetup --verbose --type luks2 --pbkdf argon2id --cipher serpent-xts-plain64 --iter-time 6000 --use-random luksFormat /dev/sdb3
  ```

* Add a key file so you won't need to enter multiple passwords on boot:
  - Either use the default OS-generated keyfile `/crypto_keyfile.bin`:
    ```bash
    sudo cryptsetup --verbose luksAddKey /dev/sdb1 /crypto_keyfile.bin
    # With argon2id key stretching:
    sudo cryptsetup --verbose luksAddKey --pbkdf argon2id /dev/sdb2 /crypto_keyfile.bin
    # Note we don't use more iteration time or another cipher because this would considerably slow down boot times
    ```
  - Or alternatively, generate a new keyfile with:  
    ```
    dd if=/dev/urandom of=/root/.keyfile bs=1024 count=4
    ```
    This will copy 4 times 1024 random bytes from urandom to the keyfile.  

    Then, add this keyfile as key to your encrypted volume(s):  
    ```
    sudo cryptsetup luksAddKey --verbose /dev/sdb1 /root/.keyfile
    sudo cryptsetup luksAddKey --verbose /dev/sdb2 /root/.keyfile
    ```

    If you take this approach, make sure to add this new keyfile to the
    `FILES` variable of `/etc/mkinitcpio.conf`:  
    ```
    FILES=(/crypto_keyfile.bin /root/.keyfile)
    ```
    
    Additionally, while the computer is off, the keyfile is stored inside the encrypted drive, so it is secure. But when the computer is on however, the keyfile is unencrypted, with a copy on the ramdisk. So, for security it would be best if only root can access it:
    ```bash
    # Actually, even root doesn't need to access it:
    sudo chmod 000 /root/.keyfile
    ```
    If you check the permissions on the default keyfile `/crypto_keyfile.bin`, you'll notice none of the permissions are set either.

  - If at some point you need to remove a specific passphrase or keyfile, look into `luksRemoveKey` or [luksKillSlot](https://askubuntu.com/questions/1125246/how-to-remove-an-unknown-key-from-luks-with-cryptsetup/1125316#1125316):  
    ```bash
    # Check which keys (passphrase or keyfile) are present:
    sudo cryptsetup luksDump /dev/sdb
    # Check which slot a specific key occupies with --verbose flag:
    sudo cryptsetup --verbose luksOpen /dev/sdb name
    # Remove a specific slot without providing the matching passphrase:
    # (you'll need to provide one of the other passphrases)
    sudo cryptsetup --verbose luksKillSlot /dev/sdb 1
    ```

    Example `luksDump` output:
    ```
    LUKS header information for /dev/nvme0n1p2

    Version:         1
    Cipher name:     aes
    Cipher mode:     xts-plain64
    Hash spec:       sha256
    Payload offset:  4096
    MK bits:         512
    MK digest:       8e 1a 84 2e aa 57 a2 a9 2b 02 26 1f cf 47 51 52 f8 6d 33 23 
    MK salt:         b0 fd 59 b2 95 0e 6a e2 e7 55 e8 b6 18 04 f8 53 
                     83 64 e6 c5 9f 20 ac fb b8 ec ae c2 be dc 5c 55 
    MK iterations:   136533
    UUID:            14e7097a-3dfc-4f59-bfa7-75f5ea8bb279

    Key Slot 0: ENABLED
        Iterations:           2184532
        Salt:                 63 e6 f8 06 4f 4e 0e 56 25 82 aa 33 81 3a 74 0c 
                              c9 26 95 cf 2d 7f 29 07 0a 28 31 76 41 8c 11 51 
        Key material offset:  8
        AF stripes:           4000
    Key Slot 1: ENABLED
        Iterations:           2216862
        Salt:                 79 29 f8 af 6c fd 46 50 ca e2 f3 6e 12 35 be 09 
                              f0 6f f6 43 76 6e ea bb b2 50 52 a1 e3 88 51 22 
        Key material offset:  512
        AF stripes:           4000
    Key Slot 2: DISABLED
    Key Slot 3: DISABLED
    Key Slot 4: DISABLED
    Key Slot 5: DISABLED
    Key Slot 6: DISABLED
    Key Slot 7: DISABLED
    ```

    If you simply want to change a specific passphrase, use `luksChangeKey` with the corresponding key slot:
    ```
    sudo cryptsetup --verbose luksChangeKey /dev/sdb --key-slot 0
    ```
    If you leave out the `--key-slot`, the passprase you enter interactively will still be replaced by the new passphrase, but the new passphrase will be placed inside the next available key slot, instead of the one you just removed.
    Personally I feel maintenance is easier if the passphrase is consistently located at key slot 0, and the key file at key slot 1.


  - To check if your luks encrypted device is luks1 or luks2, use:
    ```bash
    sudo cryptsetup --verbose isLuks /dev/sdb --type luks1
    sudo cryptsetup --verbose isLuks /dev/sdb --type luks2
    ```
    (The `luksFormat` default differs depending on your version of cryptsetup.)

  - If you do not have a full backup of your encrypted data, it would make sense to at least [backup the LUKS header](https://wiki.archlinux.org/index.php/Dm-crypt/Device_encryption#Backup_and_restore).

* Decrypt and create file system(s) of your preferred type:
  ```bash
  sudo cryptsetup --verbose open /dev/sdb1 main
  sudo mkfs.ext4 /dev/mapper/main

  sudo cryptsetup --verbose open /dev/sdb2 bulk
  sudo mkfs.ext4 /dev/mapper/bulk
  ```
  Note that many tutorials still use `luksOpen`, which is the old syntax (which will also still work). `open` actually defaults to `luks`, which itself will default to either `luks1` or `luks2` depending on your version of cryptsetup.
  The first parameter to `open` is the partition we just encrypted,
  and the second is a descriptive name that is used in the device
  mapper name: `/dev/mapper/[name]`. We then create the file system
  inside this decrypted mapper. We’ll also need this name later on
  to map the decrypted mapper to its underlying physical UUID in
  `/etc/crypttab`, to enable decryption on boot.

* Mount the newly created file systems,
  and prepare them for use by non-root users:
  ```bash
  sudo mkdir -p /storage/main
  sudo mount -v /dev/mapper/main /storage/main
  sudo chown david:david /storage/main

  sudo mkdir /storage/bulk
  sudo mount -v /dev/mapper/bulk /storage/bulk
  sudo chown david:david /storage/bulk
  ```
  Setting the owner of the mount point while the device is not mounted is pointless, since the associated owner will be changed by the owner of the mounted filesystem.

  > | :warning: Warning: |
  > |--------------------|
  > | An incorrect fstab entry can lead to mounting problems. You can check whether a volume is correctly mounted in Gnome Disks. If mounting was not successful and you are repurposing a disk that was already in use with fstab, you should proceed with the next steps to update `/etc/fstab` first. Come back to this step after the reboot (but make sure the above `/storage` mount points are created before booting). |

  Also note, that to lock the containers again, they need to be unmounted first:
  ```bash
  sudo umount /storage/main
  sudo cryptsetup --verbose close main

  sudo umount /storage/bulk
  sudo cryptsetup --verbose close bulk
  ```

  > | Tip:  |
  > |-------|
  > | zsh `lock` and `unlock` aliases are useful shortcuts for unmounting/mounting and locking/unlocking in 1 go! |

* Get physical partition and device mapper UUIDs:
  ```
  sudo blkid
  ```
  You can also find these in the Gnome `Disks` app.

* Add entries for the physical partitions in `/etc/crypttab`,
  in order to automatically decrypt them when booting:
  ```
  main  UUID=UUID-of-/dev/sdb1  /crypto_keyfile.bin  luks
  bulk  UUID=UUID-of-/dev/sdb2  /crypto_keyfile.bin  luks
  ```
  Obviously, in each case change the UUIDs to the appropriate values (of the physical LUKS partition, not the mapper).

* Add entries for the mappers in `/etc/fstab`, to automatically mount
  the decrypted LUKS mappers:
  ```
  UUID=UUID-of-/dev/mapper/main  /storage/main  ext4  defaults,noatime  0  0
  UUID=UUID-of-/dev/mapper/bulk  /storage/bulk  ext4  defaults,noatime  0  0
  ```

* Regenerate initramfs and grub:
  ```
  sudo mkinitcpio -P
  sudo update-grub
  ```
  **NOTE:  
  If you ever get a mkinitcpio ERROR, do NOT reboot before fixing it!**  
  Hint: It won't reboot!  
  Example:
  ```bash
  sudo mkinitcpio -P
  # ERROR: '/lib/modules/5.7.19-2-MANJARO' is not a valid kernel module directory
  pacman -Q linux
  # linux54 5.4.64-1
  
  # Remove old files:
  sudo rm -v /etc/mkinitcpio.d/linux57.*
  sudo rm -v /boot/vmlinuz-5.7-x86_64
  sudo pacman -R linux57 linux57-headers linux57-extramodules
  sudo rm -v /boot/initramfs-5.7-x86_64-fallback.img
  sudo rm -v /boot/initramfs-5.7-x86_64.img

  # Run mkinitcpio again:
  sudo mkinitcpio -P
  sudo update-grub
  ```

* Reboot, enter your LUKS passphrase once, and the newly encrypted
  data partitions are mounted and ready to go!


## ... with GNOME Disks
* Changing mount options:
  - Click the Settings icon of the partition/disk, and pick
    `Edit Mount Options...`.
  - Flip the switch `User Session Defaults` to off, so you can specify
    your custom mount options.
  - Unselecting both `Mount at system startup` and `Show in user interface`,
    will likely result in `nosuid,nodev,nofail,noauto` mount options:
    `nosui` and `nodev` are mostly security-focused optimizations, while
    `nofail` and `noauto` are required for not mounting on boot without error. You can still add `noatime` for performance considerations.
    These values will be written to the above-mentioned `/etc/fstab` file.
  - Mount point: Type the path to mount to, e.g. `/storage/main`.
  - Identify As: e.g. UUID=UUID-of-/dev/mapper/main
  - Filesystem Type: ext4


