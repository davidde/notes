# Arch debugging
## Pacman
To work with Arch successfully, basic knowledge of [pacman](https://www.archlinux.org/pacman/pacman.8.html) is required:
- (`sudo pacman -S <PACKAGE>`): **S**ynchronize (install) a package. This is what many tutorials will tell you to do, **but** if the OS is not up to date, this will simply fail obscurely and possibly result in an unbootable OS. This is why you should always use **`-Syu`**.
- **`sudo pacman -Syu <PACKAGE>`**: Install a package, but update
first to prevent further problems.
- **`sudo pacman -Syu`**: Update all existing non-AUR packages.
- `sudo pacman -R <PACKAGE>`: **R**emove a package.
- `sudo pacman -Rsn <PACKAGE>`: Remove the package and every single associated config file (outside of those in home dir).
- `sudo pacman -Rsnc <PACKAGE>`: Using `-c` with `-R` also removes packages that depend on the package you are uninstalling and is unlikely needed often; it can be useful if pacman is refusing to remove a package because another package depends on it. Note that this may also uninstall user-installed packages if they depend on the package that is being uninstalled. Check this with `pacman -Qi`.
- `sudo pacman -Qi <PACKAGE>`: **Q**uery **i**nfo on a package, like its dependencies (`Depends On` field) and packages that have a dependency on it (`Required by` field). If you remove packages with the `-c` flag, it is useful to check first which packages will be uninstalled. You can rerun this command for every package listed in the `Required by` section, to verify all packages that will be uninstalled recursively.
- `sudo pacman -Ql <PACKAGE>`: **Q**uery a package to **l**ist all the files it owns. Very useful to track where a certain package installed its binaries.
- `sudo pacman -Sc`: Clean the pacman pkg cache (`/var/cache/pacman/pkg`).
- To find the latest installed/upgraded packages:
  ```
  grep -i installed /var/log/pacman.log
  grep -i upgraded /var/log/pacman.log
  ```
- To find which package owns a certain file/binary:
  * First update the database:
    ```
    sudo pacman -Fy
    ```
  * Then you can see which package contains the binary with:
    ```
    pacman -F <path>
    ```

Run `man pacman` for more.

### Yay
Yay is technically an AUR-helper, but it has the simplest command to update everything: simply `yay`! If no arguments are provided, `yay -Syu` will be performed, updating both repo and AUR packages in one go.

Another advantage of `yay` is that most pacman flags work identical for `yay`, so your pacman knowledge is still useful for `yay`. Use `yay -Syu --rebuild package` to rebuild broken packages (e.g. when its dependencies are updated), `yay -Ss package` to search for a package, and `yay -R package` to remove a package.


## Logs
### journalctl
In Arch, nearly everything logs to `journalctl`:
```bash
# Print the log of the current boot process:
sudo journalctl -b
# Print the log of the previous boot process:
sudo journalctl -b -1 # -2 for boot before that, etc.
# This can be really useful if some problem (i.e. hanging screen)
# forced you to reboot, and you want to investigate what caused the problem.

# Query only the warnings or errors with:
sudo journalctl -b -p warning
sudo journalctl -b -p err

# Use the -f flag to follow the log messages as they are added:
sudo journalctl -b -f
```

### systemctl
systemd also has many useful status commands:
```bash
# Check the status of systemd decryption at boot:
sudo systemctl status systemd-cryptsetup@main
```


## Boot recovery procedure
### Example 1
```
[FAILED] Failed to start Switch Root.
See 'systemctl status initrd-switch-root.service' for details.
You are in emergency mode. After logging in, type "journalctl -xb" to view
system logs, "systemctl reboot" to reboot, "systemctl default" or "exit"
to boot into default mode.

Cannot open access to console, the root account is locked.
See sulogin(8) man page for more details.

Press Enter to continue.
```
This error is caused by not adding the rootflags parameter to the options in the `arch-linux.conf` files.  
(If we added it like specified in the `Configuring systemd-boot > Adding loaders` section, this error will not occur.)

* The first thing to do when presented with this is to search the internet for similar errors. When we have some idea of the alternate configs we can trial and error, we boot back into the Arch install ISO and start testing. First we decrypt and mount all partitions/btrfs-volumes, and then we change root with `arch-chroot`:
  ```bash
  # Decrypt:
  cryptsetup -v open /dev/nvme0n1p2 cryptroot
  # Mount root:
  mount -vo defaults,subvol=@,compress=zstd,noatime /dev/mapper/cryptroot /mnt
  # Mount home:
  mount -vo defaults,subvol=@home,compress=zstd,noatime /dev/mapper/cryptroot /mnt/home
  # Mount snapshots:
  mount -vo defaults,subvol=@snapshots,compress=zstd,noatime /dev/mapper/cryptroot /mnt/snapshots
  # Mount swap:
  mount -vo defaults,subvol=@swap /dev/mapper/cryptroot /mnt/swap
  # Mount ESP:
  mount -v /dev/nvme0n1p1 /mnt/boot
  # Chroot:
  arch-chroot /mnt
  ```
  These steps can be automated by putting them in a script in the `/boot` partition. Note you'll have to mount `/boot` first then, to access the script:
  ```bash
  # Create mount dir:
  mkdir /tmp/boot
  # Mount /boot partition, i.e. /dev/nvme0n1p1:
  mount -v /dev/nvme0n1p1 /tmp/boot
  # Run script:
  /tmp/boot/arch-chroot.sh
  ```
  We cannot mount it at `/mnt` since that will be the target for the system.

* Temporarily enable editor in `/boot/loader/loader.conf`, so we can enable kernel parameter `debug` interactively:
  ```bash
  vim /boot/loader/loader.conf
  # Change 'editor' field to yes.
  # This will allow us to press 'e' during the boot menu and add the 'debug' parameter.
  ```

* Add btrfs root subvolume in `/boot/loader/entries/arch-linux-zen.conf`
  ```bash
  # Add btrfs `rootflags=subvol=@` to `arch-linux-zen.conf` options (right before 'rw'):
  vim /boot/loader/entries/arch-linux-zen.conf
  # Exit chroot:
  exit
  # Reboot:
  reboot
  ```
  => btrfs rootflags fixed it!  
  => Also change it for the other configs.  
  => Disable editor in `/boot/loader/loader.conf` again.


### Example 2: Try to fix boot that skips keyfile and asks for password
```bash
## 1.
# Move keyfile out of /root:
sudo mv /root/.keyfile /etc/.keyfile
# Change keyfile path in FILES var in mkinitcpio.conf:
sudo vim /etc/mkinitcpio.conf
# Change keyfile path in crypttab:
sudo vim /etc/crypttab
# Regenerate initramfs:
sudo mkinitcpio -P
## NOPE: Not due to keyfile location!

## 2.
# Add extra keyslot for keyfile to test if slot is faulty:
sudo cryptsetup --verbose --type luks2 --pbkdf argon2id --hash sha512 --key-file /root/.keyfile luksAddKey /dev/sdb3 /root/.keyfile
# NOPE: Not due to keyslot, remove keyslot 2 again:
# (0 and 1 were already taken before adding the third)
sudo cryptsetup --verbose luksKillSlot /dev/sdb3 2

## 3.
# Fixed after temporarily enabling editor in `/boot/loader/loader.conf`,
# so we can add the kernel parameter `debug` interactively by pressing `e`
# at the kernel choice boot screen:
sudo vim /boot/loader/loader.conf
# Change `editor` field from `no` to `yes` and reboot and press `e`.
# Change back to `no` afterwards!
# => Keyfile failure returns!

## 4.
# Remove if empty:
sudo rmdir /etc/cryptsetup-keys.d

## NOTE (that after a faulty boot):
sudo systemctl status systemd-cryptsetup@main
# RETURNS:
# arch-desktop systemd-cryptsetup[1079]: Failed to activate with key file '/root/.keyfile'. (Key data incorrect?)
# => Seems to indicate that either the keyfile is incorrect, or it cannot be found.
# Since unlocking with the keyfile manually works flawlessly from the same location, it can only be because it is not yet available by the time systemd needs it. Move it to other location?
# => Set read for root:
sudo chmod 400 /root/.keyfile
# This seems to fix it again; if the failure returns, try:
# 1. updating the luks keyslot with default `--iter-time` of 2000ms:
sudo cryptsetup --verbose --type luks2 --pbkdf argon2id --hash sha512 --key-file /root/.keyfile --key-slot 1 luksChangeKey /dev/sdb3 /root/.keyfile
# NOTE that the first keyfile is the OLD keyfile (to unlock the volume), while the last is the NEW keyfile required to unlock keyslot 1, which happen to be the same keyfiles in this case!

# Remove keyfile from FILES in mkinitcpio,
# btrfs binary from BINARIES,
# put `sd-encrypt` hook before `filesystems`,
# and return `autodetect` hook before `keyboard`:
sudo vim /etc/mkinitcpio.conf
# BINARIES=()
# FILES=()
# HOOKS=(base systemd autodetect keyboard sd-vconsole modconf block sd-encrypt filesystems fsck)
sudo mkinitcpio -P

# 
```

* If it still comes back it might be due to the watchdog error on reboot: `Watchdog did not stop`. It might be a good idea to disable watchdogs:
  - https://wiki.archlinux.org/index.php/improving_performance#Watchdogs
  - https://bbs.archlinux.org/viewtopic.php?pid=1755695#p1755695
  - https://bbs.archlinux.org/viewtopic.php?pid=1679767#p1679767

* Add `nowatchdog` to `/boot/loader/entries/arch-linux-zen.conf`.
* Check with `cat /proc/sys/kernel/watchdog`: 0/1 for disabled/enabled.
* Add `blacklist iTCO_wdt` to `/etc/modprobe.d/watchdog.conf`.

:warning:  
If you hit C-A-D more than 7 times within 2s the system will instantly reboot, and not wait for offending services. It will still try to sync file systems and so on, but hanging services won't cause further delays. It's the escape hatch if shutdown is hung and you don' want t wait anymore. It's not a hard power off, and not a clean shutdown, but something reasonably in the middle. (Comparable to a long press on the Power button.)

[A stop job is running for User Manager for UID 1000](https://github.com/systemd/systemd/issues/12262). Seems GNOME is preparing a fix.

#### Post to Arch Forum
I can confirm this is probably some sort of race condition, since it seems to fail arbitrarily. It's also really hard to fix. I've literally tried dozens of things, but now it finally seems to be working again.

For anyone running into this problem in the future, I'll list some of the things I did that *could* have made the difference:
- Update bios
- Switch to proprietary nvidia drivers
- Set keyfile permissions to 400 instead of 000.
- Add extra keyslot for the same keyfile with default `--iter-time` of 2000ms
- [Disable watchdogs](https://wiki.archlinux.org/index.php/improving_performance#Watchdogs).
- Change `HOOKS` in `/etc/mkinitcpio.conf`:
  - For some reason I had `sd-encrypt` right after `filesystems`, I moved it back to right before.
  - Return `autodetect` hook before `keyboard`: I recall changing this because ArchWiki recommended in [Common Hooks > Keyboard](https://wiki.archlinux.org/index.php/mkinitcpio#Common_hooks) to place `keyboard` before `autodetect` in order to always include all keyboard drivers.

Since the error `Failed to activate with key file '/root/.keyfile'. (Key data incorrect?)` seems to indicate the keyfile is somehow incorrect, but manually unlocking with it works flawlessly each and every time, it seems that something occasionally blocks the keyfile from being (fully?) available when systemd needs it.

At this point I can't really tell anymore which one or which combination actually fixed things, but I recommend trying things out from the bottom up.

## Baloo_file_extractor
`baloo_file_extractor` is an indexing daemon that comes with some KDE packages like `dolphin` and `elisa`, and can consume excessive RAM and CPU power when running.

* Check status of baloo:
  ```bash
  balooctl status
  ```

* Temporarily stop the indexing process:
  ```bash
  balooctl stop
  # Restart with:
  balooctl start
  ```

* Disable the indexing process:
  ```bash
  balooctl disable
  # Enable again with:
  balooctl enable
  ```

### Reducing baloo runtime
The baloo config file is located at `~/.config/baloofilerc`.

By default, baloo indexes the entire home directory. But since the only dependent package on my Arch Gnome system is Elisa (Music Player), it only really needs access to the Music directory. On Arch, you can check the dependent packages with:
```
pacman -Qi baloo | grep "Required By"
```

This means we can just restrict baloo to index only the Music folder, by adding the following to `~/.config/baloofilerc`:
```bash
[General]
folders[$e]=$HOME/Music/
```
The `$e` allows environment variable expansion.

Once you added additional folders to the blacklist or disabled Baloo entirely, a process named `baloo_file_cleaner` removes all unneeded index files automatically. Index files are stored in `~/.local/share/baloo/`.
It might take a while for this process to run. To update indexes manually:
- `balooctl disable`
- Remove baloo indexes at `~/.local/share/baloo/index` and `~/.local/share/baloo/index-lock`.
- Temporarily add `first run=false` to baloofilerc, to force reindexing of the removed index.
- `balooctl enable`
- Remove `first run=false` from baloofilerc.

Baloo before restricting it to Music (indexing entire home dir):
```bash
~ balooctl status
Baloo File Indexer is running
Indexer state: Idle
Total files indexed: 69,511
Files waiting for content indexing: 0
Files failed to index: 0
Current size of index is 7.20 GiB
```

Baloo after restricting it to Music:
```bash
~ balooctl status
Baloo File Indexer is running
Indexer state: Idle
Total files indexed: 7,347
Files waiting for content indexing: 0
Files failed to index: 0
Current size of index is 13.35 MiB
```
Quite the difference!

### Conclusion
It's probably better to just uninstall Elisa; it doesn't even work properly for playlists anyway. **Gnome Rhythmbox** does work flawlessly.


## warning: directory permissions differ on /var/lib/gdm/.local/
Fix:
```
sudo pacman -Rsn gdm
sudo rm -rf /var/lib/gdm/
sudo pacman -Syu gdm
```

## warning: could not get file information for usr/lib/modules/5.10.7-arch1-1/extramodules/nvidia-uvm.ko.xz
Weird warning when upgrading kernels with pacman. Seems to repeat on every kernel upgrade, but so far does not seem to impact anything.

=> This was likely related to having both `nvidia` and `nvidia-dkms` installed, in combination with the headers `linux-headers` and `linux-lts-headers`.

## VLC error where VLC always launched 2 separate audio and video instances
=> This was due to a config error in `vlcrc` that apparently changed after playing audio in VLC. Not sure which setting it was, so just move `~/.config/vlc/vlcrc` elsewhere and launch again. Then migrate the important settings.

## Systemd error
```
systemd[5034]: -.slice: Failed to migrate controller cgroups from /user.slice/user-1000.slice/user@1000.service, ignoring: Permission denied
```
=> A process limit set by systemd has been hit and new processes cannot be forked.

To fix this, add the parameter `systemd.unified_cgroup_hierarchy=true` to bootloader config:
```bash
vim /boot/loader/entries/arch-linux-zen.conf
# Add the parameter to the end of the `options`:
options  rd.luks.name=d26a2a51-fa29-4edf-8917-ccda626a601b=cryptroot root=/dev/mapper/cryptroot rootflags=subvol=@ rd.luks.options=discard resume=/dev/mapper/cryptroot resume_offset=16400 rw systemd.unified_cgroup_hierarchy=true
```
=> Didn't help with luks login problems, so revert.

## Kernel error that requires reboot because of full freeze
```
Dec 16 19:28:44 arch-desktop kernel: INFO: task kworker/u16:3:9122 blocked for more than 1228 seconds.
Dec 16 19:28:44 arch-desktop kernel:       Not tainted 5.9.14-zen1-1-zen #1
Dec 16 19:28:44 arch-desktop kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 16 19:28:44 arch-desktop kernel: task:kworker/u16:3   state:D stack:    0 pid: 9122 ppid:     2 flags:0x00004080
Dec 16 19:28:44 arch-desktop kernel: Workqueue: events_unbound nv50_disp_atomic_commit_work [nouveau]
Dec 16 19:28:44 arch-desktop kernel: Call Trace:
Dec 16 19:28:44 arch-desktop kernel:  __schedule+0x42b/0xc10
Dec 16 19:28:44 arch-desktop kernel:  schedule+0x45/0x170
Dec 16 19:28:44 arch-desktop kernel:  schedule_timeout+0x12b/0x170
Dec 16 19:28:44 arch-desktop kernel:  dma_fence_default_wait+0x15b/0x240
Dec 16 19:28:44 arch-desktop kernel:  ? dma_fence_release+0x150/0x150
Dec 16 19:28:44 arch-desktop kernel:  dma_fence_wait_timeout+0x101/0x120
Dec 16 19:28:44 arch-desktop kernel:  drm_atomic_helper_wait_for_fences+0x81/0xf0 [drm_kms_helper]
Dec 16 19:28:44 arch-desktop kernel:  nv50_disp_atomic_commit_tail+0x87/0x8d0 [nouveau]
Dec 16 19:28:44 arch-desktop kernel:  ? finish_task_switch+0x80/0x270
Dec 16 19:28:44 arch-desktop kernel:  process_one_work+0x1da/0x3d0
Dec 16 19:28:44 arch-desktop kernel:  worker_thread+0x4d/0x460
Dec 16 19:28:44 arch-desktop kernel:  ? process_one_work+0x3d0/0x3d0
Dec 16 19:28:44 arch-desktop kernel:  kthread+0x19f/0x1d0
Dec 16 19:28:44 arch-desktop kernel:  ? __kthread_init_worker+0x50/0x50
Dec 16 19:28:44 arch-desktop kernel:  ret_from_fork+0x22/0x30
```
`kworker` stands for kernel worker, and can actually involve many processes. The processes causing this are listed in the brackets `[]`. Here, the problems are caused by the `drm_kms_helper` and `nouveau` (foss AMD driver) processes, and this may be related to an outdated bios.


## Upgrading BIOS
* To check your bios version:
  ```
  cat /sys/class/dmi/id/bios_version
  ```

* `/sys/class/dmi/id` also contains other interesting files:
  - bios_date
  - bios_vendor
  - bios_version
  - product_family
  - product_name
  - product_serial
  - product_version

  An overview of them all can be obtained with:
  ```
  head /sys/class/dmi/id/*
  ```
  `head` also prints the name of the file above the first few lines of the file contents.

* Modern UEFI based bios systems provide their own UEFI-based flash tools to update the bios without OS involvement. Check your motherboard's manual.


## Sound problems
### Distorted audio
The simple fix to a sound problem is often to just kill the pulseaudio daemon with the `-k` or `--kill` flag (and restart it if necessary):
```bash
pulseaudio -k
# pulseaudio -d
# pulseaudio --start
```

Also, on a computer without bluetooth hardware, it may be useful to comment out the bluetooth modules in `/etc/pulse/default.pa`:
```bash
### Automatically load driver modules for Bluetooth hardware
#.ifexists module-bluetooth-policy.so
#load-module module-bluetooth-policy
#.endif

#.ifexists module-bluetooth-discover.so
#load-module module-bluetooth-discover
#.endif
```

Another possible fix is to add yourself to the audio group:
```
sudo gpasswd -a david audio
```
Type `groups` to see the groups your user belongs to.

See:
* https://bbs.archlinux.org/viewtopic.php?id=252030
* https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/766

Since this seems to be related to the proprietary nvidia driver, it might be a good idea to switch the [default sound card](https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture#Set_the_default_sound_card) from Intel to Nvidia:  
`cat > ~/.asoundrc`:
```
defaults.pcm.card 1
defaults.ctl.card 1
```

### No audio
* Sometimes it seems to be caused by a cache file like `event-sound-cache.tdb.c470ab0864b54a46af032f9d1704ffb7.x86_64-pc-linux-gnu` in `~/.cache`. Remove the file and restart pulseaudio (`pulseaudio -k`).
* Another possible solution:
  ```bash
  rm -rf /tmp/pulse* ~/.pulse* ~/.config/pulse
  pulseaudio -k
  # If necessary:
  pulseaudio --start
  ```
  Or experiment with which specific file in `~/.config/pulse` causes the malfunction, and address the cause.
* Check which sinks are listed:
  ```
  pacmd list-sinks
  ```
  Output of working sound:
  ```
  1 sink(s) available.
    * index: 0
      name: <alsa_output.pci-0000_00_1f.3.analog-stereo>
      driver: <module-alsa-card.c>
      flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY DYNAMIC_LATENCY
      state: SUSPENDED
      suspend cause: IDLE
      priority: 9039
      volume: front-left: 16991 /  26% / -35.18 dB,   front-right: 16991 /  26% / -35.18 dB
              balance 0.00
      base volume: 46396 /  71% / -9.00 dB
      volume steps: 65537
      muted: no
      current latency: 0.00 ms
      max request: 0 KiB
      max rewind: 0 KiB
      monitor source: 0
      sample spec: s16le 2ch 48000Hz
      channel map: front-left,front-right
                  Stereo
      used by: 0
      linked by: 1
      configured latency: 0.00 ms; range is 0.50 .. 1837.50 ms
      card: 1 <alsa_card.pci-0000_00_1f.3>
      module: 7
      properties:
          alsa.resolution_bits = "16"
          device.api = "alsa"
          device.class = "sound"
          alsa.class = "generic"
          alsa.subclass = "generic-mix"
          alsa.name = "CA0132 Analog"
          alsa.id = "CA0132 Analog"
          alsa.subdevice = "0"
          alsa.subdevice_name = "subdevice #0"
          alsa.device = "0"
          alsa.card = "0"
          alsa.card_name = "HDA Intel PCH"
          alsa.long_card_name = "HDA Intel PCH at 0xed340000 irq 145"
          alsa.driver_name = "snd_hda_intel"
          device.bus_path = "pci-0000:00:1f.3"
          sysfs.path = "/devices/pci0000:00/0000:00:1f.3/sound/card0"
          device.bus = "pci"
          device.vendor.id = "8086"
          device.vendor.name = "Intel Corporation"
          device.product.id = "a2f0"
          device.product.name = "200 Series PCH HD Audio"
          device.form_factor = "internal"
          device.string = "front:0"
          device.buffering.buffer_size = "352800"
          device.buffering.fragment_size = "176400"
          device.access_mode = "mmap+timer"
          device.profile.name = "analog-stereo"
          device.profile.description = "Analog Stereo"
          device.description = "Built-in Audio Analog Stereo"
          module-udev-detect.discovered = "1"
          device.icon_name = "audio-card-pci"
      ports:
          analog-output-lineout: Line Out (priority 9000, latency offset 0 usec, available: unknown)
              properties:
                  
          analog-output-headphones: Headphones (priority 9900, latency offset 0 usec, available: no)
              properties:
                  device.icon_name = "audio-headphones"
      active port: <analog-output-lineout>
  ```


* If all else fails, reboot.

### Manually starting and stopping Pulseaudio
When debugging problems or trying new things, automatic starting may not be desirable. As described earlier, putting "autospawn = no" to `/etc/pulse/client.conf` will disable automatic starting. After doing that, a running server can be stopped with
```
pulseaudio --kill
```
or
```
killall pulseaudio
```
Those commands work also when autospawning is enabled, but typically some background application will immediately reconnect, causing the server to get immediately restarted.

In the simplest form, the server can be started with this command:
```
pulseaudio
```
That will run the server in the foreground, which is good if you want to see the log in real time. In this mode you can stop the server with Ctrl-C. If you want to start the server in the background instead, so that you don't have to keep the terminal window open, use the --daemonize option:
```
pulseaudio --daemonize
```
By default the log will only show warnings and errors, but when debugging, more verbose logging is usually needed. One -v option will add "info" level messages to the log, but to get full debug logging, use two v's:
```
pulseaudio -vv
```
Sometimes timestamps are useful when debugging. This command enables debug logging and timestamps:
```
pulseaudio -vv --log-time
```

=> Changed autospawn to `autospawn = yes` in `/etc/pulse/client.conf`!


## Defragment btrfs
```
sudo btrfs filesystem defragment -r /
```


## `gnome-shell-portal-helper` popping up after wake
(This binary is at `/usr/lib/gnome-shell-portal-helper`.)
NetworkManager puts the configuration for this program in `/usr/lib/NetworkManager/conf.d/20-connectivity.conf`. To disable it, shadow this file with an empty one in `/etc/NetworkManager/conf.d/`:
```
sudo touch /etc/NetworkManager/conf.d/20-connectivity.conf
```

## MPV freezes entire system on exit
Error:
```
Dec 19 02:34:40 arch-desktop kernel: INFO: task kworker/u16:3:11088 blocked for more than 122 seconds.
Dec 19 02:34:40 arch-desktop kernel:       Not tainted 5.9.14-zen1-1-zen #1
Dec 19 02:34:40 arch-desktop kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this me>
Dec 19 02:34:40 arch-desktop kernel: task:kworker/u16:3   state:D stack:    0 pid:11088 ppid:     2 flag>
Dec 19 02:34:40 arch-desktop kernel: Workqueue: events_unbound nv50_disp_atomic_commit_work [nouveau]
```
=> Error indicates problem with nouveau, the open-source nvidia drivers. It might be worth it to switch to the proprietary nvidia drivers (package `nvidia`).

### Install nvidia proprietary drivers
#### Try 1
* Install nvidia package:
  ```
  sudo pacman -Syu nvidia
  ```

* Check drivers currently in use:
  ```
  lspci -v
  ```
  Check the driver in use in the VGA section. Currently `nouveau`.

  Alternatively, to get **only** the VGA section, use:
  ```
  lspci -v -s $(lspci | grep ' VGA ' | cut -d" " -f 1)
  ```

* Reboot.

**Returns black screen with single white cursor/hyphen at top left:**  
According to [Arch Wiki](https://wiki.archlinux.org/index.php/NVIDIA/Troubleshooting#Black_screen_on_systems_with_Intel_integrated_GPU) this problem is due to Intel integrated graphics. We should create the file `/etc/modprobe.d/blacklist.conf` to prevent the `i915` and `intel_agp` modules from loading on boot:
```bash
# vim /etc/modprobe.d/blacklist.conf
install i915 /usr/bin/false
install intel_agp /usr/bin/false
```

While we've done the trouble to chroot in, we might as well temporarily enable editor in `/boot/loader/loader.conf`, so we can enable kernel parameter `debug` interactively:
```bash
vim /boot/loader/loader.conf
# Change 'editor' field to yes.
# This will allow us to press 'e' during the boot menu and add the 'debug' parameter.
```
Remember to change it back to `no` afterwards.

**This does not fix the black screen.**
However, it turns out the regular `linux` kernel does work, which was reinstalled together with the `nvidia` package, so likely the other kernels need to be reinstalled too.

=> Turns out `linux-zen` requires [extra setup](https://wiki.archlinux.org/index.php/NVIDIA#Custom_kernel), since it is a custom kernel. The `nvidia-dkms` package will properly rebuild every kernel with **headers** installed. This means we can simply remove the `nvidia` package after installing `linux-headers` and `linux-lts-headers`, and we will also no longer need to install `nvidia-lts` for the `linux-lts` kernel:
```bash
sudo pacman -Syu nvidia-dkms
sudo pacman -Syu linux-headers linux-lts-headers
sudo pacman -R nvidia nvidia-lts
```
See [Dynamic Kernel Module Support](https://wiki.archlinux.org/index.php/Dynamic_Kernel_Module_Support) for more info.

Seems to fix everything!  
Move `/etc/modprobe.d/blacklist.conf` elsewhere, and change editor back to `no`.

To enable Wayland in combination with the proprietary nvidia driver, we need to enable [early KMS start](https://wiki.archlinux.org/index.php/kernel_mode_setting#Early_KMS_start). This brings complications of itself, like requiring a [pacman hook](https://wiki.archlinux.org/index.php/NVIDIA#Pacman_hook) to update the initramfs after every NVIDIA driver upgrade:
- First, to enable **DRM (= Direct Rendering Manager)** [Kernel Mode Setting](https://wiki.archlinux.org/index.php/NVIDIA#DRM_kernel_mode_setting):
  ```bash
  sudo vim /boot/loader/entries/arch-linux-zen.conf
  ```
  Add the `nvidia-drm.modeset=1` kernel parameter. See [Kernel mode setting](https://wiki.archlinux.org/index.php/Kernel_mode_setting) for more info.

- Then, add `nvidia nvidia_modeset nvidia_uvm nvidia_drm` to the MODULES list of `/etc/mkinitcpio.conf`:
  ```bash
  # sudo vim /etc/mkinitcpio.conf
  MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
  ```
  Run `sudo mkinitcpio -P` to apply the `mkinitcpio.conf` changes.

- Add the pacman hook to rebuild the initramfs after every NVIDIA driver upgrade by creating `/etc/pacman.d/hooks/nvidia-zen.hook`:
  ```
  sudo mkdir /etc/pacman.d/hooks
  sudo vim /etc/pacman.d/hooks/nvidia-zen.hook
  ```
  Put the following inside:
  ```bash
  [Trigger]
  Operation=Install
  Operation=Upgrade
  Operation=Remove
  Type=Package
  # Target: nvidia for linux, nvidia-lts for linux-lts, nvidia-dkms for linux-zen!
  Target=nvidia-dkms
  # Change the linux kernel below and in the Exec line if a different kernel is used!
  Target=linux-zen

  [Action]
  Description=Update Nvidia module in initcpio
  Depends=mkinitcpio
  When=PostTransaction
  NeedsTargets
  Exec=/bin/sh -c 'while read -r trg; do case $trg in linux-zen) exit 0; esac; done; /usr/bin/mkinitcpio -P'
  # The complication in the Exec line above is in order to avoid running mkinitcpio
  # multiple times if both nvidia and linux get updated. In case this doesn't bother you,
  # the Target=linux and NeedsTargets lines may be dropped, and the Exec line may be
  # reduced to simply Exec=/usr/bin/mkinitcpio -P
  ```
- Note also that Wayland is explicitly disabled for the proprietary nvidia driver in `/lib/udev/rules.d/61-gdm.rules`:
  ```bash
  # disable Wayland on Hi1710 chipsets
  ATTR{vendor}=="0x19e5", ATTR{device}=="0x1711", RUN+="/usr/lib/gdm-disable-wayland"
  # disable Wayland when using the proprietary nvidia driver
  DRIVER=="nvidia", RUN+="/usr/lib/gdm-disable-wayland"
  # disable Wayland if modesetting is disabled
  IMPORT{cmdline}="nomodeset", RUN+="/usr/lib/gdm-disable-wayland"
  ```
  So you'll need to explicitly uncomment that line in order to try Wayland. Ideally, this should be done by copying `61-gdm.rules` from `/lib/udev/rules.d/` to `/etc/udev/rules.d/`, where the latter file will override the former. Then you can comment out the Wayland line in this copy:
  ```
  sudo cp /lib/udev/rules.d/61-gdm.rules /etc/udev/rules.d/61-gdm.rules
  sudo vim /etc/udev/rules.d/61-gdm.rules
  ```

=> MPV does not work on Wayland with the proprietary nvidia driver. Let's test with [hardware video acceleration](https://wiki.archlinux.org/index.php/Hardware_video_acceleration#NVIDIA):
- Install `nvidia-utils` and `libva-vdpau-driver`.
- Create or edit `~/.config/mpv/mpv.conf`:
  ```bash
  # MPV hardware decoding for nvidia (NVIDIA VDPAU) and wayland combo:
  # Install: sudo pacman -Syu nvidia-utils libva-vdpau-driver
  # Set video output:
  vo=vdpau # vo=opengl
  profile=opengl-hq
  hwdec=vdpau
  hwdec-codecs=all
  scale=ewa_lanczossharp
  cscale=ewa_lanczossharp
  interpolation
  tscale=oversample
  gpu-context=wayland
  ```
  Doesn't work. Note that according to [this](https://github.com/dmazine/arch-linux-install/blob/master/README.md#hardware-video-accelaration), `libva-vdpau-driver` is a driver for AMD, not nvidia.

  You can also run `vdpauinfo` to check if the driver is loaded correctly:
  ```
  sudo pacman -Syu vdpauinfo
  vdpauinfo
  ```
  Seems we'll have to go back to x11 for now, or switch back to nouveau.

## systemd-modules-load: Failed to look up module alias 'crypto-user': Function not implemented
(output of `systemctl status systemd-modules-load.service`)  
= Error preventing boot after btrfs rollback 

=> Cause:
Moving snapshots from `/snapshots` to `/btrfs/@`, instead of from `/btrfs/@snapshots`!

According to [this](https://bbs.archlinux.org/viewtopic.php?id=254970), this error usually happens because the modules of the running kernel do not match the modules of the installed kernel:
```
pacman -Q linux
uname -a
```
should show the same version number. That usually happens if you installed in UEFI mode, configured the ESP as your boot partition but didn't have it mounted during the time of the update.

Most straightforward fix would be to use the live disk/usb you used to install the system mount the partitions correctly under /mnt (and not forgetting about the ESP on /mnt/boot this time (even before that you might want to remove the wrongly created /boot directory)), arch-chrooting into the system, and running
```
pacman -Syu linux
```
so that the kernel get's properly reinstalled and rebuilt.

## Your Firefox profile cannot be loaded. It may be missing or inaccessible.
This prevents Firefox from running.

The problem was the permissions of `~/.cache` were set to root after a btrfs rollback (since `~/.cache` was a subvolume itself, but not mounted or otherwise restored).

Fix:
```
sudo rm ~/.cache
```

## warning: removing 'opencolorio' from target list because it conflicts with 'opencolorio1'
( `:: opencolorio1 and opencolorio are in conflict. Remove opencolorio? [y/N]` => y )

* `warning: could not get file information for usr/bin/dotty`
* `Warning: Could not load "/usr/lib/graphviz/libgvplugin_gdk.so.6" - It was found, so perhaps one of its dependents was not.  Try ldd.`
* 

## Gnome polkit authentication window bug
It stays on top, overlapping the left corner, and cannot be killed.

Solutions:
* Kill `gnome-shell` process. (Will instantly restart.)
* Open `Alt + F2` window, and then type `r` to re-execute the Gnome Window Manager.