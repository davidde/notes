# Cryptsetup/luks
## Adding secondary encrypted drives ...
> **Note:**  
> See the [fstab](https://wiki.archlinux.org/index.php/Fstab) and
> [crypttab](https://wiki.archlinux.org/index.php/Dm-crypt/System_configuration#crypttab)
> Archwikis for more information, as well as the [cryptsetup man pages](https://linux.die.net/man/8/cryptsetup), [FAQ](https://gitlab.com/cryptsetup/cryptsetup/-/wikis/FrequentlyAskedQuestions) and [LUKS2 spec](https://gitlab.com/cryptsetup/cryptsetup/blob/master/docs/on-disk-format-luks2.pdf).

## ... with GNOME Disks
To simply change mount options, Gnome Disks has your back, all without having to touch the command line:
* Click the Settings icon of the partition/disk, and pick
  `Edit Mount Options...`.
* Flip the switch `User Session Defaults` to off, so you can specify
  your custom mount options.
* Unselecting both `Mount at system startup` and `Show in user interface`,
  will likely result in `nosuid,nodev,nofail,noauto` mount options:
  `nosui` and `nodev` are mostly security-focused optimizations, while
  `nofail` and `noauto` are required for not mounting on boot without error. You can still add `noatime` for performance considerations.
  These values will be written to the above-mentioned `/etc/fstab` file.
* Mount point: Type the path to mount to, e.g. `/storage/main`.
* Identify As: e.g. `UUID=UUID-of-/dev/mapper/main`
* Filesystem Type: ext4

While Gnome Disks can probably be used all the way to add secondary encrypted storage, I prefer the command line over GUI solutions because of the added control. See the next section for a full walkthrough.

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
  ```
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
  sudo cryptsetup --verbose --type luks2 --pbkdf argon2id --hash sha512 --iter-time 5000 --use-random luksFormat /dev/sdb2
  sudo cryptsetup --verbose --type luks2 --pbkdf argon2id --hash sha512 --cipher serpent-xts-plain64 --iter-time 6000 --use-random luksFormat /dev/sdb3
  ```

  <br>

> :warning: **Sidenote: Password Entropy Formula**
>
> To calculate a specific password's entropy:  
> - **A**: Size of the **Alphabet**; number of unique possible characters that could be used.
> - **L**: Password **Length**; number of characters in the password.
> - **C** = Number of possible **Combinations** = A^L
> - **E** = **Entropy** = log2(C) = ln(C) / ln(2) = log10(C) / log10(2) bits of entropy
> <br>
>
> Examples:
> * 6 word BIP39 passphrase:
>   - A = 2048 words
>   - L = 6
>   - C = A^L = 2048^6 = 7.37869762948... * 10^19
>   - E = log(2048^6) / log(2) = **66 bits of entropy**
> * 12 word BIP39 passphrase:
>   - A = 2048 words
>   - L = 12
>   - C = A^L = 2048^12 = 5.44451787073... * 10^39
>   - E = log(2048^12) / log(2) = **132 bits of entropy**
> * 24 word BIP39 passphrase:
>   - A = 2048 words
>   - L = 24
>   - C = A^L = 2048^24 = 2.96427748447... * 10^79
>   - E = log(2048^24) / log(2) = **264 bits of entropy**
> * 30 character random password:
>   - A = 70 characters (10 numbers + 52 upper/lowercase letters + 8 symbols)
>   - L = 30
>   - C = A^L = 70^30 = 2.25393402906... * 10^55
>   - E = log(70^30) / log(2) = **183.878... bits of entropy**
> * 30 character random ascii password:
>   - A = 95 characters (printable ascii character set)
>   - L = 30
>   - C = A^L = 95^30 = 2.14638763942... * 10^59
>   - E = log(95^30) / log(2) = **197.095... bits of entropy**
> * 50 character random password:
>   - A = 70 characters (10 numbers + 52 upper/lowercase letters + 8 symbols)
>   - L = 50
>   - C = A^L = 70^50 = 1.79846504264... * 10^92
>   - E = log(70^50) / log(2) = **306.464... bits of entropy**
> * 50 character random ascii password:
>   - A = 95 characters (printable ascii character set)
>   - L = 50
>   - C = A^L = 95^50 = 7.69449752767... * 10^98
>   - E = log(95^50) / log(2) = **328.492... bits of entropy**
> * 20 character random unicode password:
>   - A = 143 859 unicode characters
>   - L = 20
>   - C = A^L = 143859^20 = 1.4412547170... * 10^103
>   - E = log(143859^20) / log(2) = **342.685... bits of entropy**
> * 30 character random unicode password:
>   - A = 143 859 unicode characters
>   - L = 30
>   - C = A^L = 143859^30 = 5.4715593271... * 10^154
>   - E = log(143859^30) / log(2) = **514.028... bits of entropy**
> 
> Note that statistically, a brute force attack is not required to guess *all* possible combinations. Therefore, we tend to look at the expected number of guesses required to have a 50% chance of guessing the password:  
> **G** = Expected number of **Guesses** = 2^(E-1)  
> E.g. for 24 word BIP39 passphrase: G = 2^(264-1) = 1.48213874223... * 10^79
> which is basically half the number of possible combinations.
>
> Calculate BIP39 weakening by randomness reduction:  
> * Suppose you select the words from a smaller subset that better "reflects" your liking and memorability: e.g. 2024 / (4 or 8 or 16) = 512 or 256 or 128 words (Obviously, if you completely select the words yourself without any randomization at all, the subset might actually be even smaller! 128 words is probably a good approximation for a subset chosen for memorability.)
> * Suppose you order the words into a specific order to better memorize them, such that there is only a single logical way in which they are ordered. This will reduce the entropy with the faculty of the number of words (N!).  
> 
> => E = log( (512^24) / (24!) ) / log(2) = **136.962 bits of entropy**  
> (without reordering: E = log(512^24) / log(2) = **216 bits of entropy**)  
> (with a mild reordering that still retains a subset of combinations: **157 bits of entropy**)  
> => E = log( (256^24) / (24!) ) / log(2) = **112.962 bits of entropy**  
> (without reordering: E = log(256^24) / log(2) = **192 bits of entropy**)  
> (with a mild reordering that still retains a subset of combinations: **133 bits of entropy**)  
> => E = log( (128^24) / (24!) ) / log(2) = **88.962 bits of entropy**  
> (without reordering: E = log(128^24) / log(2) = **168 bits of entropy**)  
> (with a mild reordering that still retains a subset of combinations: **109 bits of entropy**)  
> 
> These are very significant entropy reductions compared to the original completely random BIP39 phrase with **264 bits of entropy**. This means it is especially risky to use a "made up" passphrase, since it is not really feasible to tell in which category it would fall! For all we know, it may have an entropy below 80, which would definitely bring it into the crackable territory, considering the research, time and money, as well as hacker efforts that flow into this space. Personally, I would expect a 24 word BIP39 passphrase generated by someone wanting to remember it easily to fall into the last category of about **109 bits of entropy** with a standard deviation of 15 or so (94-124 bits), but this is of course a very rudimentary guess.

* Add a key file so you won't need to enter multiple passwords on boot:
  ```bash
  # Generate a keyfile with:
  dd if=/dev/urandom of=/root/.keyfile bs=1024 count=4
  # This will copy 4 times 1024 random bytes from urandom to the keyfile.  

  # Add this keyfile as key to your encrypted volume(s):  
  sudo cryptsetup --verbose luksAddKey /dev/sdb1 /root/.keyfile
  # With argon2id key stretching and sha512 hash:
  sudo cryptsetup --verbose --type luks2 --pbkdf argon2id --hash sha512 luksAddKey /dev/sdb2 /root/.keyfile
  # With argon2id key stretching, sha512 hash, serpent cipher, and higher iter-time:
  sudo cryptsetup --verbose --type luks2 --pbkdf argon2id --hash sha512 --cipher serpent-xts-plain64 --iter-time 6000 luksAddKey /dev/sdb2 /root/.keyfile
  ```

  It is not necessary to add this keyfile to the `FILES` variable of `/etc/mkinitcpio.conf`!
  
  Additionally, while the computer is off, the keyfile is stored inside the encrypted drive, so it is secure. But when the computer is on however, the keyfile is unencrypted, with a copy on the ramdisk. So, for security it would be best if only root can read it:
  ```bash
  sudo chmod 400 /root/.keyfile
  ```

* If at some point you need to remove a specific passphrase or keyfile, look into `luksRemoveKey` or [luksKillSlot](https://askubuntu.com/questions/1125246/how-to-remove-an-unknown-key-from-luks-with-cryptsetup/1125316#1125316):  
  ```bash
  # Check which keys (passphrase or keyfile) are present:
  sudo cryptsetup luksDump /dev/sdb
  # Check which slot a specific key occupies with --verbose flag:
  sudo cryptsetup --verbose luksOpen /dev/sdb1 name
  # Remove a specific slot without providing the matching passphrase:
  # (you'll need to provide one of the other passphrases)
  sudo cryptsetup --verbose luksKillSlot /dev/sdb1 1
  ```

  Example `luksDump` output for a luks1 volume:
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

  - If you simply want to change a specific passphrase, use `luksChangeKey` with the corresponding key slot:
    ```bash
    sudo cryptsetup --verbose luksChangeKey /dev/sdb1 --key-slot 0
    # Note non-default options need to be provided again, e.g.:
    sudo cryptsetup --verbose --type luks2 --pbkdf argon2id --hash sha512 --iter-time 5000 luksChangeKey /dev/sdb1 --key-slot 0
    ```
    If you leave out the `--key-slot`, the passprase you enter interactively will still be replaced by the new passphrase, but the new passphrase will be placed inside the next available key slot, instead of the one you just removed.
    Personally I feel maintenance is easier if the passphrase is consistently located at key slot 0, and the key file at key slot 1.

  - To check if your luks encrypted device is luks1 or luks2, use:
    ```bash
    sudo cryptsetup --verbose isLuks /dev/sdb1 --type luks1
    sudo cryptsetup --verbose isLuks /dev/sdb1 --type luks2
    ```
    (The `luksFormat` default differs depending on your version of cryptsetup.)

  - If you do not have a full backup of your encrypted data, it would make sense to at least [backup the LUKS header](https://wiki.archlinux.org/index.php/Dm-crypt/Device_encryption#Backup_and_restore):
    ```
    sudo cryptsetup -v luksHeaderBackup /dev/sdb1 --header-backup-file /storage/backup/luks-header-sdb1
    ```

* Decrypt and create file system(s) of your preferred type:
  ```
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
  chmod 700 /storage/main

  sudo mkdir /storage/bulk
  sudo mount -v /dev/mapper/bulk /storage/bulk
  sudo chown david:david /storage/bulk
  chmod 700 /storage/bulk
  ```
  Setting the owner of the mount point while the device is not mounted is pointless, since the associated owner will be changed by the owner of the mounted filesystem. The same applies for the permissions.

  > | :warning: Warning: |
  > |--------------------|
  > | An incorrect fstab entry can lead to mounting problems. You can check whether a volume is correctly mounted in Gnome Disks. If mounting was not successful and you are repurposing a disk that was already in use with fstab, you should proceed with the next steps to update `/etc/fstab` first. Come back to this step after the reboot (but make sure the above `/storage` mount points are created before booting). |

  Also note, that to lock the containers again, they need to be unmounted first:
  ```
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
  main  UUID=UUID-of-/dev/sdb1  /root/.keyfile  luks
  bulk  UUID=UUID-of-/dev/sdb2  /root/.keyfile  luks
  ```
  Obviously, in each case change the UUIDs to the appropriate values (of the physical LUKS partition, not the mapper).

* Add entries for the mappers in `/etc/fstab`, to automatically mount
  the decrypted LUKS mappers:
  ```
  UUID=UUID-of-/dev/mapper/main  /storage/main  ext4  noatime  0  2
  UUID=UUID-of-/dev/mapper/bulk  /storage/bulk  ext4  noatime  0  2
  ```

* Regenerate initramfs:
  ```
  sudo mkinitcpio -P
  ```
  If you get a mkinitcpio error, do NOT reboot before fixing it, since it will likely prevent you from booting.

* Reboot, enter your LUKS passphrase once, and the newly encrypted
  data partitions are mounted and ready to go!

### Set up LUKS decryption with systemd-cryptsetup
The default cryptsetup utility requires both the device path as well as a mapping name:
```
cryptsetup open <DEVICE> <NAME>
```
`systemd-cryptsetup` allows opening and closing with only the assigned name.
This requires either a keyfile specified in `/etc/crypttab`, or a keyfile to be present in `/etc/cryptsetup-keys.d` named `VOLUME-NAME.key`:
```
sudo mkdir /etc/cryptsetup-keys.d
sudo chmod 700 /etc/cryptsetup-keys.d
sudo ln -sv /root/.keyfile /etc/cryptsetup-keys.d/BACKUP.key
```
Then (after reboot), you can open/close the volume with:
```
sudo systemctl start systemd-cryptsetup@BACKUP
sudo systemctl stop systemd-cryptsetup@BACKUP
```
You can even mount it at once (without cryptsetup):
```bash
# Systemd mount (works without cryptsetup command):
sudo systemctl start storage-BACKUP.mount
# Systemd unmount (does not lock/luksClose the volume):
sudo systemctl stop storage-BACKUP.mount
# Locking it again does require the cryptsetup command,
# but it does not require the above stop mount command:
sudo systemctl stop systemd-cryptsetup@BACKUP
```
All automatically generated mount units can be found in `/run/systemd/generator/`.
However, the `stop systemd-cryptsetup` command seems to fail when files were accessed, and even worse, it does not report a failure to lock a volume. All in all, these systemd services seem not robust enough for real-world use (late 2020!). I've created a replacement `luks_unlock.zsh` script in my [dotfiles](https://github.com/davidde/.dotfiles/blob/master/scripts/luks_unlock.zsh).

## Unlocking external drives through crypttab
`sudo vim /etc/crypttab`:
```
drivename  UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  /root/.luks.external.key  noauto,x-udisks-auth
```

By default, a user who is logged in locally can plug in an USB disk and mount it without having to authenticate as administrator. The `x-udisks-auth` disables this and forces you to provide authorization.

Note that by adding `x-udisks-auth`, upon connecting an encrypted drive you will get a Gnome polkit popup window prompting you to authenticate in order to unlock the drive. This may or may not be what you wanted; you can turn it off in dconf-editor, `org > gnome > desktop > media-handling` (Either switch `automount` or `autorun-never` to off).

To make mounting also work with the `luks_unlock.zsh` script, add the following line to `/etc/fstab`:
```
/dev/mapper/drivename  /run/media/david/drivename  ext4  noatime,noauto  0  0
```

| :warning: |
|-----------|
| There seems to be a bug in Gnome Disks when you go into `Edit Encryption Options...`, it sometimes modifies the key file, obviously completely breaking it. |

## Creating a (one-time use) encrypted file container
```bash
# Create the container (25MB leaves less than 10MB useable):
dd if=/dev/urandom of=/home/david/Documents/luks-closed bs=1M count=25
# Encrypt it (keyfile argument should be left out for using password):
sudo cryptsetup --verbose luksFormat /home/david/Documents/luks-closed /root/.luks.desktop.key
# Open it:
sudo cryptsetup --verbose luksOpen /home/david/Documents/luks-closed luks-open --key-file /root/.luks.desktop.key
# Create file system:
sudo mkfs.ext4 /dev/mapper/luks-open
# Mount it:
mkdir /home/david/Documents/luks-mount
sudo mount /dev/mapper/luks-open /home/david/Documents/luks-mount
# Change ownership to user instead of root:
sudo chown david:david /home/david/Documents/luks-mount
# Close it afterwards:
sudo umount /home/david/Documents/luks-mount
sudo cryptsetup luksClose luks-open
# Optionally delete it (if one-time use):
rm /home/david/Documents/luks-closed
rmdir /home/david/Documents/luks-mount
```