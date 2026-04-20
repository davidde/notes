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

