# Mounting Linux luks-encrypted drives
## With multiple partitions:
* In PowerShell:
  ```powershell
  GET-CimInstance -query "SELECT * from Win32_DiskDrive"
  # DeviceID lists the path we need of the form "\\.\PHYSICALDRIVE*"
  wsl --mount \\.\PHYSICALDRIVE1 --bare
  # This will have no output, but make the disk available in WSL2.
  ```

* In WSL bash:
  ```bash
  # List disks, which shows us the partitions are /dev/sdd1 to 3:
  lsblk
  # Open the partitions with sudo + encryption password:
  sudo cryptsetup open /dev/sdd1 sdd1
  sudo cryptsetup open /dev/sdd2 sdd2
  sudo cryptsetup open /dev/sdd3 sdd3
  # Create mountpoints:
  sudo mkdir -p /storage/sdd1 /storage/sdd2 /storage/sdd3
  # Mount the partitions to the created mountpoints:
  sudo mount /dev/mapper/sdd1 /storage/sdd1
  sudo mount /dev/mapper/sdd2 /storage/sdd2
  sudo mount /dev/mapper/sdd3 /storage/sdd3
  ```
  You can now access the partitions at the mountpoint paths.