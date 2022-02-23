# Tridactyl Cheat Sheet
Tridactyl is a Firefox add-on enabling VIM-like modal hotkeys in the browser.

## Normal mode: `Esc`
> This mode is used for navigating around single pages and starting other modes.

| Keybinding    | Result                                                    |
|---------------|-----------------------------------------------------------|
| j, k          | Scroll down/up                                            |
| h, l          | Scroll left/right                                         |
| gg, G         | Scroll to top/bottom                                      |
| H, L          | Navigate backwards/forwards in history                    |
| J, K          | Move to left/right tab                                    |
| .             | Repeat the last action                                    |
| o             | Enter command mode to open link/search in current tab     |
| t             | Enter command mode to open in new tab                     |
| T             | Enter command mode to open the current page in a new tab  |
| d             | Close the current tab                                     |
| u             | Reopen the most recently closed tab                       |
| s             | Enter command mode to search the web                      |
| f             | Enter hint mode to open a link (press the link's letter)  |
| F             | Enter hint mode to open a link in a background tab        |
| ;y            | Enter hint mode to copy link location to clipboard        |
| ;p        | Enter hint mode to copy element text (e.g. paragraph) to clipboard |
| ;#        | Enter hint mode to copy anchor location. Useful for linking someone to a specific part of a page. |
| ;k            | Enter hint mode to kill an element (delete from page)     |
| ;h            | Enter hint mode to select an element (as if you click-n-dragged over it) |
| ;i            | Enter hint mode to view an image                          |
| ;I            | Enter hint mode to view an image in a new tab             |
| ;s            | Enter hint mode to save (download) the linked resource    |
| ;S            | Enter hint mode to save the linked image                  |
| ]]            | Guess the next page to follow                             |
| b             | List of current tabs (Tab to cycle, Enter to select)      |
| y             | Copy selected text to clipboard (yank)                    |
| yy            | Copy current URL to clipboard                             |
| p, P          | Open the clipboard contents as web page, or search for it in the current/new tab. |
| zi, zo, zz    | Zoom in, zoom out and return to the default zoom          |
| /             | Quick find text; jump from match to match with `<CTRL+g>` and `<CTRL+G>` |
| **NOTE:**     | If you want to use Firefox's default `<CTRL+f>` search, run `:unbind <CTRL+f>`. |
| `<CTRL+v>`    | Send the next keystroke to the website, bypassing bindings |
| ?             | Show keyboard shortcuts                                   |
| 


## Command mode: `:`
> This mode allows you to execute more complicated commands by typing them out.

| Command               | Result                                                  |
|-----------------------|---------------------------------------------------------|
| :tutor                | Open the tridactyl tutorial                             |
| :help                 | Advanced help topics                                    |
| :bind [key]           | Explain what this Normal mode keybinding does           |
| :bind [key] [command] | Remap the key to a new command                          |
| :unbind [key]         | Remove what this key does in Normal mode                |
| :set                  | Set a key value pair in config                          |
| :unset                | Reset a config setting to default                       |
| :reset                | Restore a sequence of keys to their default value       |


## Hint mode: `f`
> This mode highlights elements on the web page and performs actions on them, like **f**ollowing links.

Simply type the letter associated with a specific link to go to that page.

## Ignore mode: `Shift-Insert` or `Shift-Esc`
> This mode passes all keypresses through to the web page.

You can still execute a single normal mode binding by pressing `<CTRL+o>` followed by the keys for the binding.


# Tweaks
Tridactyl config file:
```vim
"""""""""""""""""""""""""""""""""""
" ~/.config/tridactyl/tridactylrc "
"""""""""""""""""""""""""""""""""""

" Use a blank page for new tab:
set newtab about:blank

" Use firefox's native CTRL-d bookmark functionality:
unbind <C-d>

" Use firefox's native CTRL-f find functionality:
unbind <C-f>

" Also enable VIM-like find functionality:
bind / fillcmdline find
bind n findnext 1
bind N findnext -1

" Exit the find highlighting:
bind m nohlsearch

" Only search case-sensitive if the pattern contains uppercase letters:
set findcase smart

" Smooth scrolling:
set smoothscroll true
set scrollduration 175

" Allow Ctrl-c to copy in the commandline:
" (Does not work?)
unbind --mode=ex <C-c>

" Rebinds
"""""""""""""""

" Switch d/D: make d take you to the tab you were just on (instead of D):
bind d composite tab #; tabclose #
bind D tabclose

" Switch ;s/;S: make ;s download image of instead of linked resource
bind ;s hint -S
bind ;S hint -s
```

* Install the native messenger (`:installnative` in Tridactyl), and run `:source` to import the rc file from disk to the browser (or just restart). If no argument is given to `:source`, it will try to open `$XDG_CONFIG_HOME/tridactyl/tridactylrc`, `~/.config/tridactyl/tridactylrc` or `~/.tridactylrc`, in that order.

* Use `:firefoxsyncpush` to push your local configuration to firefox sync.

* Use `:firefoxsyncpull` to pull the firefox sync configuration, and **overwrite** your local one.
