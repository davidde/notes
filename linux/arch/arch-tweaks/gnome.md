# GNOME specific tweaks
## Turn on Night Light
Open `Settings > Displays` and click the `Night Light` tab in the top bar.

## Nautilus
* Disable 'Recent files':
  - Open `dconf Editor`.
  - Navigate to `org > gnome > desktop > privacy`.
  - Find the `remember-recent-files` option.
  - Uncheck the `Use default value` slider, and change the custom value to `false`.
* Enable creating new files from rightclick:
  ```
  touch ~/Templates/Empty\ Document
  ```
* In `Preferences > Views`, enable `Sort folders before files` and `Allow folders to be expanded`.
* Enable `Show Hidden Files` in the `≡` button.
* Add some sidebar bookmarks:
  - For root: Click `Other locations` > `Computer`. Then click `Computer` in the URL bar, and click `Add to bookmarks`.
  - For other folders just drag them to the sidebar; e.g. `Dropbox`.
* To fix home directory permissions to make it unaccessible for "other":
  ```
  find Documents -type d -exec chmod 750 {} \;
  find Documents -type f -exec chmod 640 {} \;
  ```
All these settings can be migrated to other devices by exporting them to `.dconf` settings files.

## Import/export dconf settings
* To export/import **all dconf settings**:
  ```
  dconf dump / > all-settings.dconf
  dconf load / < all-settings.dconf
  ```
  
* To export/import specific settings:
  ```bash  
  # Dash to Dock Gnome shell extension:
  dconf dump /org/gnome/shell/extensions/dash-to-dock/ > dash-to-dock.dconf
  dconf load /org/gnome/shell/extensions/dash-to-dock/ < dash-to-dock.dconf

  # Dash to Panel Gnome shell extension:
  dconf dump /org/gnome/shell/extensions/dash-to-panel/ > dash-to-panel.dconf

  # Arch Update Indicator Gnome shell extension:
  dconf dump /org/gnome/shell/extensions/arch-update/ > arch-update.dconf
  ```
  
* Alternatively, you can use [keyfiles](https://askubuntu.com/questions/984205/how-to-save-gnome-settings-in-a-file/984270#984270), and [compile](http://manpages.ubuntu.com/manpages/focal/en/man1/dconf.1.html) them into the database with:
  ```
  dconf compile <OUTPUT> <KEYFILEDIR>
  ```
  where the OUTPUT argument must the location to write a (binary) dconf database **to** and the KEYFILEDIR argument must be a .d directory containing the keyfiles.
  E.g.:
  ```
  sudo dconf compile /etc/dconf/db/local /etc/dconf/db/local.d
  ```

## Gnome extensions
To efficiently add Gnome Shell extensions use Firefox or Chrome with the [GNOME Shell integration](https://addons.mozilla.org/en-US/firefox/addon/gnome-shell-integration/) extension. This requires the `chrome-gnome-shell` package to be installed:
```
sudo pacman -Syu chrome-gnome-shell
```

Some useful extensions:
* [appindicator-support](https://extensions.gnome.org/extension/615/appindicator-support/): Support for system tray indicators, e.g. Caffeine and Night Light.
* [archlinux-updates-indicator](https://extensions.gnome.org/extension/1010/archlinux-updates-indicator/): First install `pacman-contrib` for the `checkupdates` script:
  ```
  sudo pacman -Syu pacman-contrib
  ```
  Update command: `gnome-terminal -- sh -c "sudo pacman -Syu; echo Done - Press enter to exit; read"`
* [custom-hot-corners](https://extensions.gnome.org/extension/1362/custom-hot-corners/): Set up custom hot corners:
  - Left Top: Show Applications
  - Left Bottom: Toggle Overview
  - Right Top: Run command: `guake` (Toggles guake dropdown)
  - Right Bottom: Run command: `xdg-screensaver lock` (Locks screen)  
    Or: `sh -c 'xdg-screensaver lock ; caffeine --kill'` to also deactivate caffeine!  
    This requires the `xdg-utils` package: `yay -Syu xdg-utils`
* [dash-to-dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
* [dash-to-panel](https://extensions.gnome.org/extension/1160/dash-to-panel/): Very customisable bottom taskbar.
* [user-themes](https://extensions.gnome.org/extension/19/user-themes/): Load custom Gnome themes from `~/.themes`.

## Gnome themes
With the [user-themes](https://extensions.gnome.org/extension/19/user-themes/) extension installed, changing the Gnome theme is as simple as copying a theme to `~/.themes/<theme-name>`, and enabling it in Gnome Tweaks.

A good website to browse for themes is [gnome-look.org](https://www.gnome-look.org/browse/page/1/ord/rating/). One of the top themes is [Prof-Gnome-theme](https://www.gnome-look.org/p/1334194/), which looks great.
