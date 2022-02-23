# GoCryptFS
## Create GoCryptFS vault in Dropbox
### Initializing a gocryptfs volume
Initialise the Dropbox vault:
```
mkdir ~/Dropbox/VAULT
gocryptfs -init ~/Dropbox/VAULT
```

#### Notes
* For extra security, you can choose to keep `gocryptfs.conf` outside of the dropbox cloud, and provide it every time with the `-config` option:
  ```
  gocryptfs -config /path/to/gocryptfs.conf -init ~/Dropbox/VAULT
  ```
  Without `gocryptfs.conf`, there is no way to crack the password, so the password can be somewhat weaker. But this is mostly a redundant concern if you have a strong password. Also note that you now have 2 dependencies to unlock the volume, and you can't lose either one. If either is lost, only the master key can recover the volume. This master key is printed a single time after initialising, so keep it somewhere safe.
* Recovering data with the master key is done with the `-masterkey` flag:
  ```
  gocryptfs -masterkey=6f717d8b-6b5f8e8a-fd0aa206-778ec093-62c5669b-abd229cd-241e00cd-b4d6713d ~/Dropbox/VAULT /path/to/mount
  ```
  But note that this exposes the masterkey to shell history, so it is safer to use:
  ```
  gocryptfs -masterkey=stdin ~/Dropbox/VAULT /path/to/mount
  ```
  And then specify the masterkey as input.  
  Using a masterkey for unlocking will skip reading the `gocryptfs.conf` file, even if it is available, so non-standard options like `-aessiv` and `-plaintextnames` have to be specified explicitly. You can also [use the master key to recreate a lost `gocryptfs.conf` file](https://github.com/rfjakob/gocryptfs/wiki/Recreate-gocryptfs.conf-using-masterkey).

* Besides a `gocryptfs.conf` file at the root of the volume, each directory also has a `gocryptfs.diriv` file that holds 16 bytes of random data used for randomizing the encrypted file names. If one of these is somehow lost, damaged or modified, then you lose the file names in that directory, as they can no longer be decrypted. However, you *can* recover all *file contents* by creating a new random .diriv in the affected **encrypted** directory:
  ```
  dd if=/dev/urandom of=gocryptfs.diriv bs=16 count=1
  ```
  Then creating a bunch of empty files in the **decrypted** directory:
  ```
  touch file{1..10}
  ```
  This gives you 10 valid file names in the encrypted directory. You can then rename each of your old files over one of the new empty files.

  This is unlikely to happen by accident, since the `.diriv` files are marked read-only immediately upon creation and are not accessible through the decrypted view. Nevertheless, if tampering with the cipherdir is a concern, you should definitely keep a backup of it.

### Mounting/unmounting gocryptfs volume
* Mount the Dropbox vault:
  ```
  mkdir ~/Vaults/dropbox
  gocryptfs ~/Dropbox/VAULT ~/Vaults/dropbox
  ```
  If you keep `gocryptfs.conf` not inside the VAULT cipherdir, add the `-config` option:
  ```
  gocryptfs -config /path/to/gocryptfs.conf ~/Dropbox/VAULT ~/Vaults/dropbox
  ```

* Unmount the Dropbox vault:
  ```
  fusermount -u ~/Vaults/dropbox
  ```
  The unmount argument needs to be the mountpoint directory, not the cipherdir.

Now every file that is put into `~/Vaults/dropbox`, will appear in encrypted form in `~/Dropbox/VAULT` and sync to other devices, where they can again be decrypted outside dropbox.

## Use the Dropbox vault as git remote
* Initialize the git bare repos inside the decrypted vault:
  ```bash
  # Git bare repos carry the .git extension by convention:
  git init --bare ~/Vaults/dropbox/.dotfolder.git
  git init --bare ~/Vaults/dropbox/markdown.git
  ```
* Add the bare repos as remote to the main repos:
  ```
  cd ~/.dotfolder
  git remote add dropbox ~/Vaults/dropbox/.dotfolder.git
  git push -u dropbox --all
  
  cd ~/Documents/markdown
  git remote add dropbox ~/Vaults/dropbox/markdown.git
  git push -u dropbox --all
  ```
  From here on you can simply use `git push/pull` to synchronize the main repos with their decrypted remotes at `~/Vaults/dropbox/********.git`.

## Decrypt and clone on another device
* Create and mount the Dropbox vault:
  ```
  md ~/Vaults/dropbox
  gocryptfs ~/Dropbox/VAULT ~/Vaults/dropbox
  ```
  On the first run on a Mac, you will be notified to specifically allow the developer certificate in security settings before decryption can succeed.

* Clone the decrypted bare repos:
  ```
  git clone ~/Vaults/dropbox/.dotfolder.git ~/.dotfolder
  git clone ~/Vaults/dropbox/markdown.git ~/Documents/markdown
  ```

## Notes on submodules without remotes
For content/writing projects you may want to use submodules that don't have their own remote. Since they will be pushed to the parent remote anyway, a separate remote per submodule is not really required and would only bring additional complexity.

In order to use submodules without their own remote, it is important to add them with absolute paths, because `submodule add` will otherwise resolve the path as relative to the parent repository’s origin remote:
```bash
cd parent-repo
git submodule add $(pwd)/submodule-repo
git commit -m "Add submodule to parent-repo"
git push
```
It is important to realise that this will store an absolute local path in `.gitmodules`, meaning on any other device one would have to adjust the URLs manually after `git submodule init` (in `.git/config` and `.gitmodules`).
Note that when updating the submodule, it also requires committing to both the submodule-repo, as well as the parent repo:
```bash
cd parent-repo/submodule-repo
touch new-file.md
git add new-file.md
git commit -m "Add new file to submodule-repo"
# In the submodule-repo, `git status` will now report:
# "nothing to commit, working tree clean"
# We can now return to the parent-repo:
cd ..
# In the parent repo, `git status` will report:
# "modified:   submodule-repo (new commits)"
# So we need to add these commits to the parent-repo by committing here too:
git add submodule-repo
git commit -m "Add submodule-repo updates in parent-repo"
```
This is very important since the submodule-repo does not have its own separate remote outside that of the parent-repo.

Also be aware that when cloning the parent-repo, you'll have to provide the `--recurse-submodules` flag or enable the `submodule.recurse` option:
```
git config --global submodule.recurse true
```
Only with this option will submodules be cloned/pulled along.

In conclusion, it is probably not a good idea to use submodules without remotes, since the desired reduction in complexity entails a complexity increase where it is less intuitive.

## Use a keyfile to unlock
GoCryptFS does not support binary keyfiles, however, using a really long random password stored in a normal text file is actually pretty similar.
We can use a 100+ character random string, put it in a text file and use that:
* Create the keyfile:
  ```bash
  sudo vim /root/.gocryptfs.dropbox.key
  ```
  Paste the password inside on a single line. Do not put anything else inside the file. Note the max password size for gocryptfs is 2048 bytes, so feel free to go crazy.
* Restrict the permissions on the file for security:
  ```
  sudo chmod 400 /root/.gocryptfs.dropbox.key
  ```
  The added advantage is that no one will be able to execute gocryptfs with this keyfile without root access.
* ~~Now you can unlock the gocryptfs vault with:~~
  ```bash
  sudo gocryptfs -passfile /root/.gocryptfs.key ~/Dropbox/VAULT ~/Vaults/dropbox
  ```
  **This doesn't actually work because gocryptfs only works when run as user (without sudo), but we need sudo to access the key file!**
  This also means you cannot initialize a gocryptfs volume with the config file in a protected directory like `/root`, but you *can* move it there afterwards and mount through fstab.
* To make this work, we have to add a line to fstab:
  ```
  /home/david/Dropbox/VAULT  /home/david/Vaults/dropbox  fuse./usr/bin/gocryptfs  nofail,allow_other,passfile=/root/.gocryptfs.dropbox.key  0  0
  ```
  Adding this line to `/etc/fstab` will mount `/home/david/Dropbox/VAULT` to `/home/david/Vaults/dropbox` on boot, using the password in `/root/.gocryptfs.dropbox.key`.
  
  Notes:
  - Adjust the gocryptfs path according to the location of the binary (`which gocryptfs`).
  - Use the `nofail` option to prevent an unbootable system if the gocryptfs mount fails (see the `-nofail` option for details).
  - The `allow_other` option allows other users than the one doing the actual mounting to access the mounted filesystem. This is useful since the mounting is done by the root user.
  - If your `gocryptfs.conf` is not located in the cipherdir, add the `config` parameter, e.g.:
    ```
    /home/david/Dropbox/VAULT  /storage/main/main/Vaults/dropbox  fuse./usr/bin/gocryptfs  nofail,allow_other,passfile=/root/.gocryptfs.dropbox.key,config=/root/.gocryptfs.dropbox.conf  0  0
    ```
  - Use `sudo mount -av` to test the line without having to reboot. This will mount **all** filesystems specified in fstab that aren't yet mounted and don't have the `noauto` flag specified.
  - To specifically mount/unmount only the gocryptfs volume, use:
    ```
    sudo mount -v /home/david/Vaults/dropbox
    sudo umount -v /home/david/Vaults/dropbox
    ```
  - If you don't want it automounted on boot, replace the `nofail` flag with `noauto` (verify first with both flags; `noauto` not in gocryptfs man page).
  - Note the fstab mountpoint location does not seem to understand symlinks, so specify the symlink target path instead.

