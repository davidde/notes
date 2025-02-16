# rsync file copying tool
A big advantage of using `rsync` is that it moves only the portions of files that have changed, which can save a lot of time and bandwidth when you're syncing large directories. Additionally, if the sync was interrupted for some reason, it can just pick up where it left off. This makes it very practical for incremental syncs, where files are added to a large existing directory (which is occasionally synced), since only the new files will need to be uploaded/copied.

`Rsync` stands for remote sync, and as such is often used to sync files between a local and a remote system (even though it works just as well for syncing files between different folders on a single system). So in order to use `rsync` effectively, we need 2 machines; one to act as local machine, and the other to act as remote machine. Usually this would be a client and a server, but for simplicity's sake we will be using a Windows 11 desktop PC and an Android Galaxy Tab.

To use `rsync` to sync with a remote system, you only need SSH access configured between your local and remote machines, as well as `rsync` installed on both systems.  
This guide will detail installing `rsync` on Windows, as well as on Android using Termux in order to sync files between Windows and Android. (Installation on Linux is trivial with a package manager, and is much simpler to set up.)

## Windows installation with Git Bash
Since `rsync` is a unix tool that is not natively supported on Windows, we need to find a workaround to get it working. One of the most convenient ways is to simply use `Git Bash`:
* Download and install [Git for Windows](https://gitforwindows.org).
* In the [MSYS2 repo](https://repo.msys2.org/msys/x86_64/), download and extract the latest `rsync` and `libxxhash` (rsync dependency) packages. ([MSYS2](https://www.msys2.org/) is a software distribution and building platform for Windows that uses the Arch Linux package manager Pacman.)
* Move the uncompressed files into their respective folders where Git is installed (`C:\Program Files\Git\`). Essentially, just move the following 3 files:
  - `rsync\usr\bin\rsync.exe` to `C:\Program Files\Git\usr\bin\rsync.exe`.
  - `rsync\usr\bin\rsync-ssl` to `C:\Program Files\Git\usr\bin\rsync-ssl`.
  - `libxxhash\usr\bin\msys-xxhash-0.dll` to `C:\Program Files\Git\usr\bin\msys-xxhash-0.dll`.
* Open Git Bash (`File Explorer > Right click > Show more options > Open Git Bash here`) and run:
  ```bash
  rsync --version
  ```
  to check if everything is working so far.
* You could also use it in PowerShell like this:
  ```powershell
  & "C:\Program Files\Git\usr\bin\rsync.exe" --version
  ```
  Note the use of the ampersand `&`; this is required to make PowerShell recognize an external executable, instead of treating it as a cmdlet or a string. You can add this command to your PowerShell profile.
* Make sure an SSH client is also installed; more info [here](./ssh.md).

## Android installation with Termux
* Install [F-droid](https://f-droid.org/docs/Get_F-Droid/#option-2-download-and-install-f-droid-apk).
* Install [Termux from F-droid](https://f-droid.org/en/packages/com.termux/).  
  (Termux is no longer available on Google Play, so F-droid is the best option.)
* In Termux, update the installed packages:
  ```bash
  pkg upgrade
  ```
  If this fails, use:
  ```bash
  apt update && apt full-upgrade
  ```
  Start a new session afterwards, so that Termux doesn't use outdated configuration.
* Enable storage access in Termux:
  ```bash
  termux-setup-storage
  ```
  This command creates a new `~/storage` folder with symbolic links to various common folders, and is required in order for Termux to access the normal Android file system.
* Install `rsync` and `OpenSSH` in Termux. This will also generate SSH keys:
  ```bash
  pkg install rsync openssh
  ```
  The Termux app doesn't have permission to use the default SSH port 22, so change the port in `../usr/etc/ssh/sshd_config`:
  ```bash
  nano ../usr/etc/ssh/sshd_config
  ```
  Simply uncomment the existing line with the port number 8022:
  ```
  Port 8022
  ```
  Save the file using `Ctrl+O` and `Enter`, and exit nano with `Ctrl+X`.
* Next, find the IP address of the Android device:
  ```bash
  ifconfig
  ```
  (Or find it in `Android Settings > About Device > Status information > IP address`.)
  This should result in something like `172.27.27.193`.
* Create a user password in Termux:
  ```bash
  passwd
  ```
* Start the SSH server daemon:
  ```bash
  sshd -D
  ```
  The `-D` option tells the SSH daemon to run in the foreground. The daemon can then be terminated with `Ctrl+C`. Without this option, the daemon runs in the background and can be killed with the `pkill sshd` command.
* When the SSH daemon in Termux is running, you can SSH to the Android device from the computer. Enter the IP address of the Android device as the hostname, and specify the previously updated port number with the `-p` flag:
  ```bash
  # From computer!
  ssh -p 8022 172.27.27.193
  ```
  Termux will accept any user name, so it's not necessary to prepend the user like `user@172.27.27.193`. But you do have to correctly enter the password that you set a moment ago.
* If everything is working correctly, you should now be greeted with a `Welcome to Termux!` prompt! You can log out of Termux with `Ctrl+D` or the `exit` command.
* To avoid having to type the password every time you want to open an SSH connection, you can copy a public key from the computer to the Termux session on the Android device. On a linux device we could simply execute:
  ```powershell
  # For default SSH key:
  ssh-copy-id -p 8022 172.27.27.193
  # Use the -i flag for a non-default public key, e.g.:
  ssh-copy-id -p 8022 172.27.27.193 -i ~/.ssh/github_rsa.pub
  ```
  But `ssh-copy-id` is not available on Windows, so instead use this command in the local Windows terminal:
  ```powershell
  type $env:USERPROFILE\.ssh\github_rsa.pub | ssh -p 8022 172.27.27.193 "cat >> .ssh/authorized_keys"
  ```
  Always double check you're actually copying the public key (`.pub`), and not the private key!
* From this point on, password authentication could be disabled by editing the sshd config again in `../usr/etc/ssh/sshd_config` (on the Android device). Update the line beginning with "PasswordAuthentication" to:
  ```bash
  PasswordAuthentication no
  ```
  Make sure the you can still login before doing this.
* To make it even easier to use this ssh command (and rsync also!), we can put the port and ip address in `~/.ssh/config`:
  ```
  Host tab
    HostName 172.27.27.193
    IdentityFile ~/.ssh/github_rsa
    Port 8022
  ```
  You should now be able to ssh into the Android device by simply doing:
  ```
  ssh tab
  ```

## rsync command
### Basic command:
```bash
rsync [FLAGS] SRC DEST
```
**Trailing slash syntax gotcha**:
* If you want to transfer the actual directory, you omit the trailing slash of `~/dir1`:
  ```bash
  rsync ~/dir1 username@remote_host:destination_directory
  ```
  This will put the `dir1` folder into the destination_directory.
* If you want to transfer the directory's contents directly, use a trailing slash:
  ```bash
  rsync ~/dir1/ username@remote_host:destination_directory
  ```
  This will put the contents of `dir1` directly into the destination_directory.

It is also possible to reverse `src` and `dest` to sync in the reverse order, from remote to local device.

### Command with more useful flags:
```bash
rsync -auh --info=progress2 --exclude='{".Trash*","lost+found",".DS_Store","._*"}' SRC DEST
```
* `-a, --archive`: a combination flag equivalent to `-rlptgoD`, a quick way of saying you want recursion (i.e. traverse directories) and want to preserve almost everything (including modification times, groups, owners, permissions and symlinks, but `-H, --hard-links` being a notable exception). It’s more commonly used than `-r, --recursive` and is the recommended flag to use.
* `-u, --update`: forces rsync to skip any files which exist on the destination and have a modified time that is newer than the source file.
* `-h, --human-readable`: outputs numbers in a more human-readable format.
* `--info=progress2`: prints a progress bar for all files.
* `--exclude`: exclude files with these patterns. Can also be used in the form `--exclude-from=FILE` where FILE should be an `excludes.list` file containing the files to exclude.

Other interesting flags:
* `-n, --dry-run`: perform a trial run with no changes made.
* `-v, --verbose`: print what the command is doing.
* `-e COMMAND, --rsh=COMMAND`: specify the remote shell / SSH command to use. E.g.:
  ```bash
  rsync -have "C:\Program Files\Git\usr\bin\ssh.exe -i ~/.ssh/github_rsa.pub -p 8022" user@192.168.1.78:/sdcard/Notes/* /d/NOTES/notes/
  ```
  This flag is useful if you need additional options to the ssh command outside of the user and host, like the port and public key. It is not required otherwise.
  Alternatively, you can also put these options in `~/.ssh/config`.
* `--delete`: make sure that files that no longer exist in the source location are also removed in the destination. This is very useful for maintaining exact duplicates with incremental updates. However, be careful with the trailing slash syntax for the source location. **Combining the wrong trailing slash syntax with the wrong destination will likely delete everything in the destination!** Using `-n, --dry-run` is beneficial here.

## Using rsync with the previously set up SSH
> [!NOTE]
> It doesn't seem there is a straightforward way to make `rsync` work with the native Windows SSH command, which is a shame, since that version works well with `ssh-agent` to set up passwordless logins. This means that each `rsync` to/from a remote device will prompt for the SSH key's password (or the remote's password after failing 3 times). A solution to this is to generate a passwordless SSH key, since you'll only be using it on your own devices anyway.

First make sure the SSH server daemon is running in Termux on the Android device:
```bash
sshd -D
```
Then continue to use `rsync` from the Windows computer:

### In Git Bash:
* **Syncing from the Windows PC to Android:**

  ```bash
  rsync -havu --info=progress2 --exclude='{".Trash*","lost+found",".DS_Store","._*"}' /d/new-pics tab:/storage/emulated/0/Pictures
  ```
  Git Bash uses the ssh in `C:\Program Files\Git\usr\bin\ssh.exe` by default, which works fine, but asks for your SSH key password, since it's not added to this SSH's SSH agent.
* **Syncing from Android to the Windows PC:**

  ```bash
  rsync -havu --info=progress2 --exclude='{".Trash*","lost+found",".DS_Store","._*"}' tab:/storage/emulated/0/Pictures/new-pics /d
  ```

### In PowerShell:
* **Syncing from the Windows PC to Android:**

  Note the **double and single quotes** around the SSH binary, this is essential for PowerShell to get the right path:
  ```powershell
  & "C:\Program Files\Git\usr\bin\rsync.exe" -havu --info=progress2 --exclude='{".Trash*","lost+found",".DS_Store","._*"}' -e "'C:\Program Files\Git\usr\bin\ssh.exe' -v" /d/new-pics tab:/storage/emulated/0/Pictures
  ```
  PowerShell uses the ssh in `/c/Windows/System32/OpenSSH/ssh.exe` by default, which means we need to pass it `rsync`'s SSH from Git Bash. Again we need to provide the SSH key password, which is trickier here; you can just copy, right-click, and directly press enter, which should correctly pass the password.

* **Syncing from Android to the Windows PC:**

  Note the **double and single quotes** around the SSH binary, this is essential for PowerShell to get the right path:
  ```powershell
  & "C:\Program Files\Git\usr\bin\rsync.exe" -havu --info=progress2 --exclude='{".Trash*","lost+found",".DS_Store","._*"}' -e "'C:\Program Files\Git\usr\bin\ssh.exe' -v" tab:/storage/emulated/0/Pictures/new-pics /d
  ```
