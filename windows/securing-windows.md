# Securing Windows
## Secure Boot
Secure boot prevents malicious code from hijacking your internal boot process, e.g. when the internal HDD is infected by unsigned bootkit malware.

## Only allow booting from _internal HDD_
* Secure boot does nothing for the likely attack vector where someone with physical access to the device boots an image from a flash drive.  
* To prevent unauthorized access from booting external media, the UEFI has to be configured properly.

### The strongest protection comes from:
* Internal Drive at #1 + Anything else/External Media **Disabled**:  
  Don't just put external media last; in this case a sophisticated attacker can still boot from external USB drives after physically removing the internal hard drive. The system will automatically proceed to boot from the next item in the list...

* Quick Boot Menu Disabled.

* ​Admin Password for UEFI, so the above 2 cannot be revoked without providing your admin password.

## Full disk encryption
Full Disk encryption provides significant additional security when an attacker gets physical access to the disk.