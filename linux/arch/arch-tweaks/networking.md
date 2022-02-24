# Web/networking related tweaks
## Enable DoH and ESNI in Firefox
### DoH
* In the Firefox Preferences, scroll down to the bottom of the `General` tab, and click `Network Settings`.
* At the bottom of the `Connection Settings`, check the box for `Enable DNS over HTTPS`.
* This will update the `network.trr.mode` setting in `about:config` from 0 to 2. This is also required for enabling ESNI.

### ESNI
* In the URL bar, go to `about:config`.
* In the search box, type `network.security.esni.enabled`. Its default value will be set to `false`, click the toggle button to change it to `true`.
* You can check your browsing experience security by heading over to `https://www.cloudflare.com/ssl/encrypted-sni/`.
* This will perform 4 tests; it should pass everything except the DNSSEC test. If you also want to pass DNSSEC, you'll have to go back to the `network.trr.mode` setting, and change it to 3. These are the possible [TRR Settings](https://wiki.mozilla.org/Trusted_Recursive_Resolver):
  - 0 - Off (default). use standard native resolving only (don't use TRR at all)
  - 1 - Reserved (used to be Race mode)
  - 2 - First. Use TRR first, and only if the name resolve fails use the native resolver as a fallback.
  - 3 - Only. Only use TRR, never use the native resolver.
    - Up to FF >= 73, this mode also requires the bootstrapAddress pref to be set.
    - Starting with Firefox 74, setting the bootstrap address is no longer mandatory - the browser will simply bootstrap itself using regular DNS, unless the DoH server domain can't be resolved.
    - The native resolver will still be used for portal detection and telemetry ([Bug 1593873](https://bugzilla.mozilla.org/show_bug.cgi?id=1593873))
  - 4 - Reserved (used to be Shadow mode)
  - 5 - Off by choice. This is the same as 0 but marks it as done by choice and not done by default.

### Alternative DoH endpoints
With DNS-over-HTTPS enabled, your requests will by default go through Cloudflare at `https://mozilla.cloudflare-dns.com/dns-query`.

However you can use any DoH compliant endpoint by changing the `network.trr.uri` value to any end point that supports it, such as:

* Google DNS: `https://dns.google.com/experimental`
* Quad9: `https://dns.quad9.net/dns-query`

Especially [Quad9](https://www.quad9.net/) as a non profit is an interesting option.


## Network Manager: Change dynamic ip to static
* The command line utility for Network Manager is nmcli:
  ```bash
  # Show the network connections:
  nmcli con show
  ```
  This returns something like:
  ```
  NAME                UUID                                  TYPE      DEVICE 
  Wired connection 2  fb1f38de-fb0a-36c5-8539-76c38ff724e8  ethernet  enp6s0 
  Wired connection 1  0da86173-7407-3537-ae62-122e69e4028c  ethernet  --   
  ```
  With the first connection highlighted in green, meaning it is the active one.

* Now you can query the active connection with its **NAME**:
  ```
  nmcli con show 'Wired connection 2'
  ```

* To check if it has a static or dynamic ip:
  ```bash
  nmcli -f ipv4 con show 'Wired connection 2'
  ```
  Then check the `ipv4.method` field; `auto` indicates a dynamic (DHCP) ip address, while `manual` indicates a static ip.

  You can also query the method directly:
  ```
  nmcli -f ipv4.method con show 'Wired connection 2'
  ```

* To change the ip from dynamic to static, you have to modify the required variables:
  ```
  nmcli con mod "Wired connection 2" \
    ipv4.addresses "HOST_IP_ADDRESS/IP_NETMASK_BIT_COUNT" \
    ipv4.gateway "IP_GATEWAY" \
    ipv4.dns "PRIMARY_IP_DNS,SECONDARY_IP_DNS" \
    ipv4.dns-search "DOMAIN_NAME" \
    ipv4.method "manual"
  ```
  With:
  - `addresses`: The static ip you want to assign. Good idea to use the current dynamically assigned ip since you know it's not taken. To verify which ip addresses are currently in use, run `nmap -sP '192.168.1.*'`.
  - `gateway`: Typically the IP address of your router.
  - `dns`: If you want to set custom DNS addresses, such as Google's `8.8.4.4` and `8.8.8.8`, or Cloudflare's `1.1.1.1` and `1.0.0.1`, enter the DNS addresses you want to use separated by a comma.
  - `dns-search`: Determines which domain is appended for dns lookups;
  normally the return value of `hostname -f` should be specified here, which usually equals the hostname with `.localdomain` appended.
  E.g.:
  ```
  nmcli con mod "Wired connection 2" \
    ipv4.addresses "192.168.1.149" \
    ipv4.gateway "192.168.1.1" \
    ipv4.dns "1.1.1.1,1.0.0.1" \
    ipv4.dns-search "arch-desktop.localdomain" \
    ipv4.method "manual"
  ```

* To change the ip from static to dynamic, you have to empty most variables and set `ipv4.method` to `auto`:
  ```
  nmcli con mod "Wired connection 2" \
    ipv4.addresses "" \
    ipv4.gateway "" \
    ipv4.dns "" \
    ipv4.dns-search "" \
    ipv4.method "auto"
  ```

* Note you can conveniently edit these fields in Gnome Network Settings, by clicking the Wheel next to the active connection:
  - Go to `IPv4` Tab.
  - `IPv4 Method`: Change to `Manual`.
  - `Addresses`: Enter the IP Address, Netmask (= Subnet Mask) and Gateway you want to assign to the computer. The IP address should be unique for the computer, while the Netmask (typically 255.255.255.0) and Gateway should be the same as the other computers on the network:
  
    | Address        | Netmask           | Gateway          |
    |----------------|-------------------|------------------|
    | 192.168.1.150  | 255.255.255.0     | 192.168.1.1      |

  - If you want to set custom DNS addresses, such as Google's `8.8.4.4` and `8.8.8.8`, or Cloudflare's `1.1.1.1` and `1.0.0.1`, move the DNS Automatic toggle switch to the off position, and enter the DNS addresses you want to use, separated by a comma.
  - Select Apply.
  - At this point, you still need to restart the Network Manager to apply the new settings; this is as simple as toggling the On/Off switch to Off and back On.
  - You should now also be able to verify it from the command line with `nmcli con show 'Wired connection 2'`.

* To find both hostname and domain name:
  ```bash
  hostname -f
  # Returns: arch-desktop.localdomain
  ```

## SyncThing
### [Autostarting](https://docs.syncthing.net/users/autostart.html) on [system startup](https://wiki.archlinux.org/index.php/syncthing#Running_Syncthing) with systemd
* Enable and start syncthing as a user service:
  ```
  systemctl --user enable --now syncthing.service
  ```
  This requires an active user session (i.e. login) for syncthing to start running.

  On a Mac, with a brew-installed syncthing, enable and start it like this:
  ```
  brew services start syncthing
  ```
  You will also want to go to **Settings > Energy Saver** and disable "Wake for network access". This will prevent the wifi to disconnect when the Mac goes to sleep, and enable syncthing to do its thing in the background, while the mac sleeps. (EDIT: Wifi still drops out, it just takes slightly longer ...)

* If you instead want to run syncthing as a system service, leave out the `--user` flag, and specify the syncthing user:
  ```
  systemctl enable --now syncthing@syncthing-user.service
  ```
  This ensures that syncthing is running at system startup even if the user has no active session, meaning this is more useful on a server. Note however that the syncthing user requires a home directory; if you create a service account with `useradd -r`, also create a matching home directory.

* To check if Syncthing runs properly you can use the `status` subcommand:
  ```bash
  # Check status of a user service:
  systemctl --user status syncthing.service

  # Check status of a system service:
  systemctl status syncthing@user.service
  ```

* Systemd logs everything into the journal, so you can easily access Syncthing log messages. In both of the following examples, `-e` tells the pager to jump to the very end, so that you see the most recent logs:
  ```bash
  # See logs for the user service:
  journalctl -e --user-unit=syncthing.service

  # See logs for the system service:
  journalctl -e -u syncthing@user.service
  ```

### Configuration
> See [syncthing docs](https://docs.syncthing.net/users/config.html).

At first start Syncthing will generate a configuration file, some keys and start the admin GUI, which you can access at http://localhost:8384/. Cookies are essential to the correct functioning of the GUI, so make sure your browser accepts them.

At this point, the Syncthing GUI will show a folder named `Default Folder`. This folder corresponds to the `Sync` directory in home, and you can use it as a starting point. Also, if your computer itself might be accessed by untrusted parties, setting up a GUI password is recommended.

For Syncthing to be able to synchronize files with another device, it must be told about that device. This is accomplished by exchanging "device IDs”. A device ID is a unique, cryptographically-secure identifier that is generated as part of the key generation the first time you start Syncthing. It is printed in the log above, and you can see it in the web GUI by selecting "Actions” (top right) and "Show ID”.

Two devices will only connect and talk to each other if they are both configured with each other’s device ID. Since the configuration must be mutual for a connection to happen, device IDs don’t need to be kept secret. They are essentially part of the public key.

To get 2 devices to talk to each other click "Add Remote Device” at the bottom right, and enter the device ID of the other side. You will be able to select it from a "Nearby devices" list, so there's no need to copy or type the long identifier string. In the `Sharing` tab, select the folders you want to share. The device name is optional.

Once you click "Save", the new device will appear on the right side of the GUI, although disconnected. Remember to repeat this step on the other device; an automatic pop-up there should simplify things. Note the "Disconnected" status will not update instantly, it might take a minute.

To sync other folders then the default `Sync` directory, click "Add folder". Specify a folder label, e.g. "Documents" and a folder path, e.g. `/home/david/Documents`. In the `Sharing` tab, specify the devices to share the folder with. Note that the folder ID, e.g. `ka5sw-uwxey` is required on the other device to identify the folder, but an automatic popup should again appear there, making this part really convenient.

### Change folder path of existing/syncing folder
* You cannot just change the folder path in the `edit` field, since syncthing would assume all files are gone and sync empty to all devices.
* To do this, **pause** the folder you want to edit.
* Move the files to the new directory.
* Edit this directory path in `~/.config/syncthing/config.xml` (Mac: `~/Library/Application Support/Syncthing/config.xml`).
* Restart Syncthing: Web GUI > Actions > Restart.
* Make sure the correct folder path is showing and hit `Resume`.

### Mac-specific
* Ignore pattern to prevent syncing Mac `.DS_Store` files:
  ```
  (?d).DS_Store
  ```
  The `(?d)` pattern indicates that the file can be deleted if it prevents a directory from being removed.

### Android-specific
#### Folder marker `.stfolder`
Syncthing creates a folder marker `.stfolder` at the root of a directory it works with. This folder marker isn’t supposed to go anywhere, and if it disappears, Syncthing thinks something unexpected happened and stops.

To restart the folder you can recreate it, but only do this if all the other files are present. If they aren't, the missing files will be deleted on the peer nodes.

Some Android distros, e.g. those on Huawei phones, aggressively clean up empty folders, and this means that the `.stfolder` will be short-lived. It doesn’t take long before Syncthing can no longer sync due to `Error (folder marker missing)`. You can prevent this auto-deletion by recreating the folder and putting a **non-empty** `PLACEHOLDER` file inside. Note you have to create this file on the Android device itself, since anything inside the `.stfolder` will not be synced.

#### Enable daemon "always-on" behaviour
Go into `Syncthing Settings > Behaviour`, and check `Start service automatically on boot`. This will enable Syncthing-as-a-service, i.e. always-on and ready to sync.

As a side effect of this, a permanent notification will be shown in the notification screen notifying us that Syncthing is running. This is rather annoying since it is always-present, and cluttering our notification screen.

We can disable this notification in `Android Settings > Apps > Syncthing > Notifications > Syncthing active`. Disabling this specific notification will remove the permanent notification, without affecting the Syncthing process itself, just like we want.

Also, in `Android Settings > Apps > Syncthing > Power usage details`, make sure the `Power consumption alert` is turned off, and `Background activity` is not restricted.

## Unison
Unison is a 2-way synchronization tool that can even keep track of moved files. It can sync 2 directories both ways, and even keep moved files in sync by simply moving them without recopying and deleting.

For this to work though, you have to specify at least 1 remote replica, so if you're working with 2 local directories you have to prefix localhost to one of them:
```
unison -auto /home/david/Documents ssh://localhost//storage/backup/Documents -debug copy
```
Specifying `-debug copy` will let you verify if the files were moved correctly. Look for messages containing the string `tryCopyMovedFile`.

Note this does require the ssh daemon to be active:
```bash
sudo systemctl start sshd
# Stop it again with:
sudo systemctl stop sshd
```

:warning: **WARNING**:  
This is NOT the case. There is no difference regarding "move" behaviour between local and ssh, other than that ssh **copies** the files from the same replica (in order to prevent having to transfer data over a slow network), while the local variant will always copy the files from the other replica instead of from the copies it has in its own replica. See https://github.com/bcpierce00/unison/issues/472 for context. The conclusion is clear: the copy/delete behavior should be replaced with move behavior using the `rename` system call.


## Prevent system time drift
The Network Time Protocol is the most common method to synchronize the software clock of a GNU/Linux system with internet time servers:
```
sudo pacman -Syu ntp
sudo systemctl enable ntpd.service --now
sudo hwclock --systohc --verbose
```
This is really important when using a TOTP 2FA code generator on Arch!