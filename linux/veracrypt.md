# Veracrypt
Veracrypt is a really useful tool for cross-platform disk encryption. On top of that, it also has the really useful feature to create hidden volumes. As a result, you end up with 2 passwords for an encrypted volume:
- The outer volume password: This is the password of the volume with the data that is less sensitive, which can be revealed in case of threaths.
- The hidden volume password: This is the password that should *not* be revealed, and where all sensitive data should be stored.

Depending on which password you enter, the respective volume will be mounted. Note however, that if you want to *write* to the outer volume, you need to mount it with [Hidden Volume Protection](https://www.veracrypt.fr/en/Protection%20of%20Hidden%20Volumes.html) enabled, or you risk overwriting the hidden volume.

This tutorial demonstrates how to create a hidden volume; check the [veracrypt documentation](https://www.veracrypt.fr/en/Documentation.html) if you need more info.

## Preliminaries
* Remove partitions of the disk, and shred it:
  ```
  sudo shred -vn 1 /dev/sdc
  ```
  Even for new disks a single pass shred is recommended since they come written with all zeros. This weakens encryption since it will be trivial to distinguish encrypted data from the default zeros. Of course this only reveals usage patterns/metadata and not the data itself, but `shred` can fill the entire disk with random data instead of zeros, preventing this altogether.

* Create partition table and partitions using `parted`'s interactive mode:
  ```bash
  sudo parted /dev/sdc
  (parted) mklabel gpt
  (parted) mkpart "PLAIN" 1MB 1TB
  (parted) set 1 msftdata on # Enable Windows support
  (parted) mkpart "CRYPT" 1TB 100%
  # Verify everything looks ok:
  (parted) print
  (parted) quit
  ```
  We also create a `PLAIN` partition for convenience, which will be accessible on all OSes (exfat). This is not required if you don't need it. The `CRYPT` partition on `/dev/sdc2` is where we will create the veracrypt hidden volume, and spans starting from the end of the first TB to the end of the disk (100% in the mkpart line).

* Verify the partitions' names with fdisk or lsblk:
  ```bash
  sudo fdisk -l
  lsblk -f
  ```

* Initialize exfat file system for first partition, since we want it to be directly usable on any OS without encryption:
  ```
  sudo mkfs.exfat -L "PLAIN" /dev/sdc1
  ```

## Creating a Veracrypt hidden volume
Note that Veracrypt is a Windows-first application, and creating volumes on Linux is generally pretty flaky/slow. If you have the choice, create the volumes on Windows with the GUI. Mounting/dismounting will work fine on Linux.

### GUI
Creating a hidden volume is more intuitive in the GUI, and there is less risk of messing up or doing it in the wrong order:
* In the GUI, click `Create Volume`.
* In the next screen, select `Encrypt a non-system partition/drive` (Windows), or `Create a volume within a partition/drive` (Linux).
* Select `Hidden Veracrypt volume`.
* Now we create the outer volume:
  - On Windows:
    - Select `Normal mode` for Volume Creation Mode. This screen is Windows-only.
    - Click `Select Device...`, and click the external hard disk to encrypt. Likely something like `\Device\Harddisk1\Partition2`.
  - On Linux:
    - Click `Select Device...` and choose `/dev/sdc2`.
    - Click `Yes` in the popup to confirm you want to create the volume, and enter your admin password.

  The hidden volume will be created afterwards inside it.

* For the outer volume encryption options, just go with the defaults of `AES` and `SHA-512`.
* On Windows, you'll be asked to verify if the size of the partition is correct to make sure you don't accidently encrypt the wrong disk.
* In the next screen, enter the password for the *outer volume*.
* In the `Format options` screen, choose `FAT` filesystem type, since this is required on Linux in order for Veracrypt to correctly calculate the maximum size of the volume.

  If the volume is larger than 2TB, `FAT` will not be an option, so go with `Linux Ext4` for Linux only volumes, or `exfat` for all OSes. You will still be able to choose a different filesystem for the hidden volume.
* Move the mouse as randomly as you can for strengthening the encryption, and click `Format`.
* Copy some files to the outer volume and click `Next` to scan it to determine the size available for the hidden volume.
* Choose the encryption options:
  - If you want to use a cascade, `AES(Twofish(Serpent))` is arguably most recommended, since it will look like a regular `AES` from the outside. Using a cascade will guard against the possibility that vulnerabilities may be discovered in the future against a specific encryption algorithm.
  - For a hashing algorithm, `Whirlpool` is the most recommended alternative.

* Next set the hidden volume size. This will be limited by the still remaining size in the outer volume.
* Move the mouse randomly again for the hidden volume, and click `Format`. This concludes the creation of the hidden volume.

### Command line
When using the text user interface, the following procedure must be followed to create a hidden volume:
1) Create an outer volume with no filesystem.
2) Create a hidden volume within the outer volume.
3) Mount the outer volume using hidden volume protection.
4) Create a filesystem on the virtual device of the outer volume.
5) Mount the new filesystem and fill it with data.
6) Dismount the outer volume.

If at any step the hidden volume protection is triggered, start again from 1).

#### 0) Basics
Check the help page for command line usage:
```bash
veracrypt -h
```

* Mount a volume:
  ```
  veracrypt /dev/sdc2 /mnt/veracrypt1
  ```
  This will return:
  ```
  Enter password for /dev/sdc2: STRONGPASSWORD
  Enter PIM for /dev/sdc2: Enter
  Enter keyfile [none]: Enter
  Protect hidden volume (if any)? (y=Yes/n=No) [No]: Enter
  ```

* To mount a volume using keyfile(s):
  ```
  veracrypt -k /path/to/keyfile /dev/sdc2
  ```

* To mount a volume, *only* prompting for its password:
  ```bash
  veracrypt -t -k "" --pim=0 --protect-hidden=no /dev/sdc2 /mnt/veracrypt1
  ```
  * `-t, --text`: uses text user interface. The graphical user interface is used by default if available. This option must be specified as the first argument.

  * `-k ""`: The empty keyfile disables interactive requests for keyfiles.

  * `--pim=0`: [PIM](https://www.veracrypt.fr/en/Personal%20Iterations%20Multiplier%20(PIM).html) stands for "Personal Iterations Multiplier", and controls the number of iterations used by the [header key derivation function](https://www.veracrypt.fr/en/Header%20Key%20Derivation.html). When a PIM value is not specified or if it is equal to 0, VeraCrypt uses the default number of iterations (depending on the volume type and the derivation algorithm) to mount/open the volume. (Usage not required if you use a sufficiently strong password). Also note that passing a PIM on the command line is potentially insecure as the PIM may be visible in the process list (see ps(1)) and/or stored in a command history file or system logs.

  * `--protect-hidden=no`: Do not write-protect a hidden volume when mounting the outer volume. If `yes`, the user will be prompted for a password to open the hidden volume, before mounting the outer volume.

* Dismounting volumes:
  ```bash
  # Single volume:
  veracrypt -d /dev/sdc2

  # All mounted volumes:
  veracrypt -d
  ```

#### 1) Create an outer volume with no filesystem
* Launch `veracrypt` from the terminal with the options `-c/--create` and `-t/--text`:
  ```
  veracrypt -t -c
  ```
  This will launch an interactive mode that asks for all the relevant settings.
  
* First up is the volume type:
  ```
  Volume type:
  1) Normal
  2) Hidden
  Select [1]: 1
  ```
  We select `Normal` since we're creating the outer volume first.

* Path to the volume and your sudo password:
  ```
  Enter volume path: /dev/sdc2
  Enter your user password or administrator password:
  ```

* Select the encryption settings:
  ```
  Encryption Algorithm:
    1) AES
    2) Serpent
    3) Twofish
    4) Camellia
    5) Kuznyechik
    6) AES(Twofish)
    7) AES(Twofish(Serpent))
    8) Camellia(Kuznyechik)
    9) Camellia(Serpent)
    10) Kuznyechik(AES)
    11) Kuznyechik(Serpent(Camellia))
    12) Kuznyechik(Twofish)
    13) Serpent(AES)
    14) Serpent(Twofish(AES))
    15) Twofish(Serpent)
  Select [1]: 1

  Hash algorithm:
    1) SHA-512
    2) Whirlpool
    3) SHA-256
    4) Streebog
  Select [1]: 1
  ```

* Filesystem to format the volume with:
  ```
  Filesystem:
    1) None
    2) FAT
    3) Linux Ext2
    4) Linux Ext3
    5) Linux Ext4
    6) NTFS
    7) exFAT
    8) Btrfs
  Select [2]: 1
  ```
  We should select `None` since we're setting up an outer volume for a hidden volume.

* Set the password for encrypting the outer volume. For PIM and keyfile path, just press enter to set empty values:
  ```
  Enter password:
  Re-enter password:

  Enter PIM: Enter

  Enter keyfile path [none]: Enter
  ```

* Type random characters to improve the cryptographic strength of the encryption key. You can paste them from a random source like `/dev/urandom` by executing the following command in a different terminal tab:
  ```
  head -c 500 /dev/urandom
  ```
  Select them and middle click paste in the Veracrypt tab:
  ```
  Please type at least 320 randomly chosen characters and then press Enter:

  Done: 100.000%  Speed: 54 MB/s  Left: 0 s

  The VeraCrypt volume has been successfully created.
  ```

To create the outer volume in non-interactive mode, run the following command:
```
veracrypt -t -c --volume-type=normal /dev/sdc2 --encryption=aes --hash=sha-512 --filesystem=none --random-source=/dev/urandom -k "" --pim=0 -p mypassword
```
Note however, that passing the password and pim on the command line is not advisable as it will be visible in shell history; you can just leave those out and specify them interactively.

#### 2) Create a hidden volume within the outer volume
Repeat above steps with volume type `Hidden` to create the hidden volume.

* If you're using disk encryption, you can use a keyfile for convenience, to prevent typing the very long and secure password. Veracrypt will still prompt for sudo access, so this still prevents unauthorized access on your own computer, while keeping really strong security on other computers.

* If you want to use a cascade algorithm, `AES(Twofish(Serpent))` is arguably most recommended, since it will look like a regular `AES` from the outside. Using a cascade algorithm will guard against the possibility that vulnerabilities may be discovered in the future against a specific encryption algorithm.

* For a hashing algorithm, `Whirlpool` is the most recommended alternative.

#### 3) Mount the outer volume using hidden volume protection
```
veracrypt --protect-hidden=yes --filesystem=none /dev/sdc2
```
Make sure to use the outer volume password, and not the hidden volume one!

#### 4) Create a filesystem on the virtual device of the outer volume
* List the mounted volumes:
  ```
  veracrypt -l
  1: /dev/sdc2 /dev/mapper/veracrypt1
  ```

* Create filesystem:
  ```
  sudo mkfs.vfat -n "CRYPT" /dev/mapper/veracrypt1
  ```

#### 5) Mount the new filesystem and fill it with data
```
sudo mount -v /dev/mapper/veracrypt1 /mnt/veracrypt1
```

#### 6) Dismount the outer volume
```
veracrypt -d /dev/sdc2
```

The hidden volumes is now ready for use. You can mount it with:
```
veracrypt -t -k /path/to/keyfile /dev/sdc2 /mnt/veracrypt1
```
Make sure to use the hidden volume password this time.

