# btrfs basics
One of the greatest advantages of btrfs is its ability to create snapshots of the system at any point in time. A snapshot is simply a subvolume that shares its data (and metadata) with another subvolume. It's a good idea to always have a backup snapshot of the functioning system, in case the system breaks or something unexpected happens.

## Longevity optimizations
### Create subvolume for `~/.cache`
```
mv /home/david/.cache /home/david/.cache2
sudo btrfs subvol create /home/david/.cache
sudo chown david:david /home/david/.cache
sudo chmod 700 /home/david/.cache
mv -v /home/david/.cache2/* /home/david/.cache
rmdir -v /home/david/.cache2
```
:warning: Turns out this may not be a good idea, since an `@home` snapshot will then exclude this directory by default. After a btrfs rollback, `~/.cache` will be created empty and with root permissions, which messes up lots of things. E.g.:
  - It obstructs Firefox from running with the error `Your Firefox profile cannot be loaded. It may be missing or inaccessible.`.
  - It can mute pulseaudio in a very obscure way.

  This may in fact be caused by rolling back from `/snapshots` instead of from `/btrfs/@snapshots`.

  Currently not a subvolume for the above reasons.

### Disable CoW for Chrome's databases
* Open Chrome to generate the database files and folders.

* ```
  mkdir -vp ~/.config/google-chrome/Default/databases
  sudo chattr +C ~/.config/google-chrome/Default/databases
  lsattr -l ~/.config/google-chrome/Default
  ```

### Disable CoW for Firefox's databases
* Open firefox, browse to `about:support`, find the `Profile Directory` and click to open.

* The profile directory will be something like `~/.mozilla/firefox/63rhrfk6.default-release`, and holds multiple sqlite databases. In order to disable CoW on all of these, we temporary rename it, create the NoCoW replacement, and then **copy** the files back:
  ```bash
  # Close firefox first, and then:
  mv -v ~/.mozilla/firefox/63rhrfk6.default-release ~/.mozilla/firefox/63rhrfk6.default-release-copy
  mkdir -v ~/.mozilla/firefox/63rhrfk6.default-release
  sudo chattr +C ~/.mozilla/firefox/63rhrfk6.default-release
  cp -rv ~/.mozilla/firefox/63rhrfk6.default-release-copy/* ~/.mozilla/firefox/63rhrfk6.default-release
  lsattr -l ~/.mozilla/firefox/63rhrfk6.default-release
  ```

## Creating and managing snapshots
* Snapshots are created with the command `btrfs subvolume snapshot <source-subvolume-path> <destination-path/name>`, e.g.:
  ```
  sudo btrfs subvolume snapshot / /snapshots/@-2020-10-06-1300
  sudo btrfs subvolume snapshot /home /snapshots/@home-2020-10-06-1300
  ```
  It's a good practice to add a timestamp for convenience; use whatever date template you're most comfortable with.
  Note that all btrfs commands can be abbreviated to even a single letter and anything in between, as long as they remain unambiguous, e.g. you could use `sudo btrfs sub snap / /snapshots/@`.

* To delete a snapshot use:
  ```
  sudo btrfs subvolume delete /snapshots/@home-2020-10-06-1300
  ```

* For copying, you can make a btrfs CoW copy with `cp --reflink` for single files or `cp -R --reflink` for directories. Of course, regular `cp` still works too, it just does not use CoW by default. To copy a subvolume, use `btrfs subvolume snapshot <source-path> <dest-path>`.

* Note that systemd usually creates btrfs subvolumes for `/var/lib/machines` and `/var/lib/portables`, which is useful since they would only add irrelevant data to the root `@` snapshots. It's still a good idea to disable Copy-on-Write (COW) for VMs and databases:
  ```bash
  sudo chattr +C /var/lib/machines

  sudo mkdir /var/lib/{mysql,postgres}
  sudo chmod 700 /var/lib/{mysql,postgres}
  sudo chattr +C /var/lib/{mysql,postgres}

  # Verify No_COW:
  sudo lsattr -l /var/lib
  ```

* Other useful commands:
  - `btrfs property`: get/set/list properties like label, compression and read(-only)/write status.
    ```bash
    sudo btrfs property get /
    # ro=false
    # label=CryptRoot
    ```
  - `btrfs filesystem`: command group that works primarily on the whole filesystem.
    ```
    sudo btrfs filesystem show /
    ```
    This will show total and free space in the last line.

  - After getting the root UUID with the previous command, you can use it with e.g.:
    ```
    cat /sys/fs/btrfs/c1a412ad-5106-414b-b4fc-4c6b745a9f2c/features/compress_zstd
    ```
    This will return 0 or 1, indicating disabled or enabled zstd compression.

## Rolling back to a previous snapshot
In order to roll back, it is very important to understand that the **btrfs top-level subvolume AKA btrfs root** is usually not mounted by default. The btrfs root is NOT the same as the system root, and is mostly left empty except for nested subvolumes, which are usually mounted individually. The btrfs root should be mounted temporarily for doing subvolume operations and unmounted again afterwards. Within this volume, we can access the subvolumes directly, with their subvolume (`@`) paths instead of their file paths.

In order to mount the btrfs root, we need the btrfs device/partition and an available mounting location, e.g.:
```
sudo mount -v /dev/mapper/cryptroot /mnt
```
Since this is quite a mouthful, I prefer to put an entry in fstab so it can be mounted with simply `mount /btrfs`:
```bash
# Create mount location for btrfs root:
mkdir /btrfs
# Add entry to fstab:
vim /etc/fstab
# Add this line:
/dev/mapper/cryptroot    /btrfs    btrfs    defaults,noatime,noauto,subvol=/    0 0
```
With this in place, rolling back is as simple as:

* To roll back the system (`/`):
  ```bash
  # Mount btrfs root:
  sudo mount -v /btrfs

  # First we move the system root `@` to the @snapshots subvolume:
  sudo mv -v /btrfs/@ /btrfs/@snapshots/@-OLD-2020-10-06-1330

  # Then we move the @ snapshot to the system root @ that fstab knows about:
  # WARNING: Do not use snapshots from `/snapshots`, but from `/btrfs/@snapshots`!!!
  sudo mv -v /btrfs/@snapshots/@-2020-10-06-1300 /btrfs/@
  # If we want to keep the @ snapshot in @snapshots,
  # we shouldn't use `cp` instead of `mv`, but `subvolume snapshot`:
  sudo btrfs subvolume snapshot /btrfs/@snapshots/@-2020-10-06-1300 /btrfs/@

  reboot
  ```
  Check out the [Ubuntu Wiki](https://help.ubuntu.com/community/btrfs#How_to_work_with_snaphots_in_Ubuntu.27s_layout) for more information.

* To only roll back `/home`, no reboot is required:
  ```bash
  # 1) Mount btrfs root:
  sudo mount -v /btrfs

  # 2) Unmount /home:
  #    Note this is best done when logged out of the GUI, in a root tty 
  #    (CTRL + Alt + <F2/3/4/5/6>, CTRL + Alt + F1 to return to GUI)
  #    Otherwise umount will likely complain /home is busy ...
  sudo umount -v /home

  # 3) Move the subvolumes:
  sudo mv -v /btrfs/@home /btrfs/@snapshots/@home-OLD-2020-10-06-1400
  sudo btrfs subvolume snapshot /btrfs/@snapshots/@home-2020-10-06-1300 /btrfs/@home

  # 4) Mount new /home (it's also in fstab):
  sudo mount -v /home

  # 5) Unmount btrfs root:
  sudo umount -v /btrfs
  ```
  Alternatively, if you just want to 'try out' a snapshot a single time, you can mount it directly in step 4, skipping step 3 entirely:
  ```bash
  # 4) Mount snapshot as /home directly:
  sudo mount -vo subvol=/@snapshots/@home-2020-10-06-1300,defaults,noatime /dev/mapper/cryptroot /home
  ```
  Check out the [btrfs Wiki](https://btrfs.wiki.kernel.org/index.php/SysadminGuide#Managing_Snapshots) for more information.

## Setting up snapper for automatic snapshots
Optional

## Defragment btrfs
It is best to defragment only the root and home subvolumes (not snapshots or swap).

* To defragment a single file, we run the following command:
  ```
  sudo btrfs filesystem defragment -vf /path/to/file
  ```
  `-f`: flush data for each file before going to the next file. This will limit the amount of dirty data to current file, otherwise the amount accumulates from several files and will increase system load. This can also lead to ENOSPC if there’s too much dirty data to write and it’s not possible to make the reservations for the new data (i.e. how the COW design works).

* To defragment an entire directory/subvolume recursively:
  ```
  sudo btrfs filesystem defragment -vrf /path/to/directory
  ```
  `-r`: defragment files recursively in given directories, does not descend to subvolumes or mount points.

Example:
```
sudo btrfs filesystem defragment -vrf /
sudo btrfs filesystem defragment -vrf /home
```
This will defragment both the root `/` and `/home` subvolumes.

Problem: Defragmenting `/home` blocks on `/home/david/.dropbox-dist/dropbox-lnx.x86_64-113.4.507/dropbox`. => CTRL+C, close dropbox and run again.

