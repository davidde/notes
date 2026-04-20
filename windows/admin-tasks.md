# Admin tasks
## Configure DHCP (Static/dynamic IP)
* Press `Windows + R`, type `ncpa.cpl` and press `Enter`.
* This opens the `Network Connections` window; double click the connection you want to edit.
* This opens a `Status` window, click `Properties` in the bottom left corner.
* In the `Properties` window, select `Internet Protocol Version 4 (TCP/IPv4)`, and click `Properties` again.
* In the IPv4 window, switch the radiobutton from `Obtain an IP address automatically` (= dynamic IP) to `Use the following IP address` (= static IP), and fill in the data for the IP address you want to use.
* You can do the same for DNS server right below.

## Force-update windows
If the Windows Update GUI doesn't work for some reason, use the following command in an admin command prompt:
```
usoclient startinteractivescan
```

## Prevent unplanned reboots (e.g. for server use cases)
### 1. The "Notify Only" Policy
Instead of letting Windows download updates and then blocking the reboot, this policy stops Windows from downloading them in the first place without your permission. No download = no pending reboot = no reason for Windows to wake up your PC.

1. In Group Policy Editor (`Windows menu > Edit Group Policy`), go to: `Computer Configuration > Administrative Templates > Windows Components > Windows Update > Manage end user experience`
2. Double-click **Configure Automatic Updates**.
3. Set it to **Enabled**.
4. Under "Configure automatic updating," choose **2 - Notify for download and notify for install**.
5. Click **Apply**.
   Result: Windows will tell you updates are ready, but it won't touch them until you click "Download." This keeps your system state "clean" while you sleep.

### 2. Prevent PC waking up when explicitly told to sleep
#### 1. Disable the "Power Management" Wake Policy
Windows has a specific policy that gives it permission to wake the system for updates. You need to kill this explicitly.

1. In Group Policy Editor, go to: `Computer Configuration > Administrative Templates > Windows Components > Windows Update > Legacy Policies` (or just under the main Windows Update folder in some versions).
2. Look for **Enabling Windows Update Power Management to automatically wake up the system to install scheduled updates**.
3. Set this to **Disabled**.
4. Click **Apply**.

#### 2. The "Scheduled Maintenance" Killer
Even with the settings above, Windows has a "Maintenance" task that runs at 2:00 AM by default.

1. Press the **Start** button and search for **"Security and Maintenance"**.
2. Expand the **Maintenance** section and click **Change maintenance settings**.
3. **Uncheck** "Allow scheduled maintenance to wake up my computer at the scheduled time."

This is to prevent the computer from waking up when you explicitly put it to sleep.

#### 3. Disable wake timers and devices
1. If the computer still wakes itself up from sleep, try the following commands:
  ```powershell
  # This will list the device that caused the last wake:
  # (Likely causes are network adapters using Wake-on-LAN)
  powercfg /lastwake
  # This requires an admin powershell, and lists any scheduled wake timers that are still active:
  powercfg /waketimers
  ```
2. Disable the device's ability to wake the computer, e.g. for a network adapter:
   - Open `Device Manager > Network Adapters > "Adapter name" > Properties`
   - `Power Management` tab: Uncheck **Allow this device to wake the computer**.
   - `Advanced` tab: Find `Wake on Magic Packet` and `Wake on Pattern Match`, and set both to **Disabled**.
3. Deactivate any wake timers still running.

## Securing Windows
### Secure Boot
Secure boot prevents malicious code from hijacking your internal boot process, e.g. when the internal HDD is infected by unsigned bootkit malware.

### Only allow booting from _internal HDD_
* Secure boot does nothing for the likely attack vector where someone with physical access to the device boots an image from a flash drive.  
* To prevent unauthorized access from booting external media, the UEFI has to be configured properly.

#### The strongest protection comes from:
* Internal Drive at #1 + Anything else/External Media **Disabled**:  
  Don't just put external media last; in this case a sophisticated attacker can still boot from external USB drives after physically removing the internal hard drive. The system will automatically proceed to boot from the next item in the list...

* Quick Boot Menu Disabled.

* ​Admin Password for UEFI, so the above 2 cannot be revoked without providing your admin password.

### Full disk encryption
Full Disk encryption provides significant additional security when an attacker gets physical access to the disk.

