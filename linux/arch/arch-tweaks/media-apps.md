# Media app tweaks
## VLC
* Uncheck `Allow only one instance` and `Save recently played items` in Preferences.
* In the Audio Settings, change the `Output module` to `ALSA audio output`. This allows then checking the `Always reset audio start level to:` option, to set the start volume when opening VLC.
* In the Input & Codecs Settings, change `Hardware accelerated decoding` from `Automatic` to `VA-API Video decoder via DRM`. This fixes playback of some H265 encoded videos.


## Steam install
* Enable the [multilib](https://wiki.archlinux.org/index.php/Official_repositories#multilib) repositories to run 32 bit applications:
  ```bash
  nvim /etc/pacman.conf
  # Uncomment the following lines:
  #[multilib]
  #Include = /etc/pacman.d/mirrorlist
  ```
  Do not uncomment [`[multilib-testing]`](https://wiki.archlinux.org/index.php/official_repositories#Testing_repositories) unless you have very good reasons.

* Install the steam package with some font dependencies:
  ```bash
  sudo pacman -Syu ttf-liberation wqy-zenhei steam
  ```

* Note that you also require a [32-bit version OpenGL graphics driver](https://wiki.archlinux.org/index.php/Xorg#Driver_installation), but this may come with the installation of Steam.


## Calibre
### [Sort books in hierarchical groups](https://manual.calibre-ebook.com/sub_groups.html)

### Calibre backup
Calibre has really useful backup functionality that includes all plugins and customizations, as well as the ebook library itself. It can be used from both the GUI, or from the command line with `calibre-debug --export-all-calibre-data`:
```bash
# This will prompt for export directory and the calibre library to export:
calibre-debug --export-all-calibre-data
# Alternatively, specify both as absolute paths:
calibre-debug --export-all-calibre-data <export-dir> <library>
# E.g.:
calibre-debug --export-all-calibre-data '/storage/backup/backup/backups/calibre-backup/2020-12-01-0300' '/home/david/Documents/Calibre Library'
# To export all calibre libraries, use the `all` keyword instead of a specific library:
calibre-debug --export-all-calibre-data '/storage/backup/backup/backups/calibre-backup/2020-12-13-2300-calibre-all' all
```
This is straightforward to script/alias.


## Gnome Rhythmbox
* Works flawlessly, and looks OK.
* C/GTK code, so performance is great.
* Stores all playlists in `~/.local/share/rhythmbox/playlists.xml`.
* If music files within the music library are not found, it often helps to remove the Rhythmbox library in order to rebuild it properly:
  - Quit Rhythmbox
  - Move `~/.local/share/rhythmbox/rhythmdb.xml` to another directory.
  - Restart Rhythmbox and rescan the music library.

* Migrate all old iTunes exported `.m3u8` playlists to Linux:
  ```
  find '/home/david/Music/playlists' -type f -exec sed -i 's/\/Users\/David/\/home\/david/g' {} \;
  ```
  This simply replaces each occurrence of `/Users/David` with `/home/david` for every file in the `playlists` directory.

  To also get rid of the iTunes directory structure, place the `~/Music/iTunes/iTunes Media/Music/` Library directly in `~/Music/music-lib`, and update the paths again:
  ```
  find '/home/david/Music/playlists' -type f -exec sed -i 's/\/home\/david\/Music\/iTunes\/iTunes Media\/Music/\/home\/david\/Music\/music-lib/g' {} \;
  ```

  Note that for a `Library.xml` file, you'll still need to replace `iTunes/iTunes%20Media/Music` with `music-lib`.


