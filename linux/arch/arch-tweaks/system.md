# System tweaks
## Update sudoers
First thing to do is update the sudoers file, so we can actually use `sudo`.
Note that to modify `/etc/sudoers`, it is important to always use the `visudo` command:
```
su root
visudo
```
If this throws an error about no editor being configured, manually specify the editor before the command:
```bash
EDITOR=vim visudo
# = `vim /etc/sudoers`, but with safety checks
```
and don't forget to set the editor in the file.

Then uncomment/add the following to the file:
```bash
# Uncomment the sudo line:
%sudo   ALL=(ALL) ALL
# Uncomment the targetpw line:
Defaults targetpw
# With this enabled, the sudo password is the password of the target user
# instead of the invoking user; i.e. the root password instead of your username password,
# unless you use the '-u <user>' flag, in which case you have to enter that user's password.
# Without this set, any sudo invocation only needs the invoking user's password.
# For a single user system, this is a security improvement since this effectively prevents
# using the user login password for accessing root privileges.
# For multi user systems/servers, this would actually be more insecure since it would require
# the superuser to share his/her password with other users, and that is also why it is no default.

# Then add the following 3 lines:

# Default editor for visudo:
Defaults editor=/usr/bin/vim

# Timeout after which the sudo password has to be reentered in minutes (default 5):
Defaults timestamp_timeout=15

# Enable humorous insults easter egg on incorrect password:
Defaults insults
```

## Install oh-my-zsh
Opening the terminal at this point will likely prompt you to setup zsh, but it's ok to skip this (press `q`) since oh-my-zsh would override these settings anyway. Then:
```
sudo pacman -Syu wget
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
If there is a missing character for `Heavy Round-tipped Rightwards Arrow` (the arrow before the zsh prompt),
which is not included in all fonts, just install an additional font that does have it, e.g. noto:
```
sudo pacman -Syu noto-fonts noto-fonts-emoji noto-fonts-extra
```
At this point, we're ready to clone our dotfiles for a more personal touch.

**Terminal Font:** Droid Sans Mono, font-size 12


## AUR access (Arch specific)
* Install yay:
  ```
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  makepkg -si
  ```

* Install a few useful AUR packages like:
  ```
  yay -Syu google-chrome
  yay -Syu visual-studio-code-bin
  yay -Syu informant
  yay -Syu caffeine-ng
  yay -Syu dropbox
  yay -Syu spotify
  ```
  - Make sure the proper fonts are installed **before** installing vscode;
    ```
    sudo pacman -Syu otf-fira-mono ttf-droid ttf-croscore
    ```
  - If dropbox and/or spotify return a PGP signature error, enter `curl -sS https://linux.dropbox.com/fedora/rpm-public-key.asc | gpg --import -` for dropbox, and `curl -sS https://download.spotify.com/debian/pubkey.gpg | gpg --import -` for spotify, and build again.  
  - To have `caffeine-ng` run on startup, add it to the `Gnome Tweaks > Startup Applications` list. Also, `libappindicator-gtk3` and the Gnome extension [appindicator-support](https://extensions.gnome.org/extension/615/appindicator-support/) are required for Gnome Wayland:
    ```bash
    sudo pacman -Syu libappindicator-gtk3 chrome-gnome-shell
    # chrome-gnome-shell allows installing gnome extensions directly in a browser:
    # First install the firefox/chrome gnome-shell-extension addon, and then activate appindicator-support.
    # This gnome extension should be installed through the gnome website, and not a package manager.
    ```
    Both should be installed before installing `caffeine-ng`.


## Update xdg-user-dirs
* We create a new data dir in order to have all data that should be synced to other devices (Music, Calibre libraries, etc.) in a single directory:
  ```
  mkdir ~/Data
  ```
* Change location of Music dir:
  ```
  xdg-user-dirs-update --set MUSIC $HOME/Data/Music
  ```
* Remove unused directories like Public and Desktop:
  ```
  xdg-user-dirs-update --set DESKTOP $HOME
  xdg-user-dirs-update --set PUBLIC $HOME
  ```

This will update `~/.config/user-dirs.dirs` to point Music to the new location, and prevent the Public and Desktop directories from being recreated on reboot. In order to activate the changes in e.g. the file explorer/Nautilus, you have to reboot or log back in. This does not remove the existing Public and Desktop directories, but they will no longer be recreated after you remove them.
