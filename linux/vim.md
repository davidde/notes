# VIM Cheatsheet
## Normal mode
### General commands
| Keybinding      | Result                                                  |
|-----------------|---------------------------------------------------------|
| ZZ              | Write file and exit Vim (= `:wq!`)                      |
| ZQ              | Quit Vim without writing changes (= `:q!`)              |
|                 |                                                         |
| a               | Insert text after the cursor                            |
| A               | Insert text at the end of the line                      |
| i               | Insert text before the cursor                           |
|                 |                                                         |
| o               | Begin a new line below the cursor                       |
| O               | Begin a new line above the cursor                       ||                 |                                                         |
| u               | Undo the last operation.                                |
| `<CTRL+r>`      | Redo the last undo.                                     |
|                 |                                        |
|                 |                                                         |

### Navigation
| Keybinding      | Result                                                  |
|-----------------|---------------------------------------------------------|
| j, k            | Move the cursor down/up one line                        |
| h, l            | Move the cursor left/right one character                |
|                 |                                                         |
| g               | Namespace key to activate other mappings, e.g. `gE/g_/gt/gT/g,/g;/gu/gU/gn/gf`    |
| gf              | "Goto File"; Edit the file whose name is under or after the cursor. |
| gg              | Go to start of file                                     |
| G               | Go to end of file                                       |
| `5gg` / `5G`    | Go to line 5                                            |
|                 |                                                         |
| w               | Move forward one word (next alphanumeric word)          |
| W               | Move forward one word (delimited by a white space)      |
| 5w              | Move forward five words                                 |
| b               | Move backward one word (previous alphanumeric word)     |
| B               | Move backward one word (delimited by a white space)     |
| 5b              | Move backward five words                                |
| 0 ("zero")      | Go to start of line                                     |
| $               | Go to end of line                                       |
| ^               | Go to first non-empty character of the line             |
|                 |                                                         |
| (               | Jump to the previous sentence                           |
| )               | Jump to the next sentence                               |
| {               | Jump to the previous paragraph                          |
| }               | Jump to the next paragraph                              |
| [[              | Jump to the previous section                            |
| ]]              | Jump to the next section                                |
| []              | Jump to the end of the previous section                 |
| ][              | Jump to the end of the next section                     |
|                 |                                                         |
|                 |                                                         |


### Text modification
| Keybinding      | Result                                                  |
|-----------------|---------------------------------------------------------|
| v               | Select characters                                       |
| V               | Select whole lines                                      |
| `<CTRL+v>`      | Select rectangular blocks                               |
| y               | Copy ('yank')                                           |
| yy              | Copy ('yank') the current line, including the newline character at the end of the line |
| [“x]yy          | Copy the current lines into register x                  |
| d               | Cut ('delete')                                          |
| dd              | Cut ('delete') the current line, including the newline character at the end of the line |
| p               | Paste after the cursor                                  |
| P               | Paste before the cursor                                 |
|                 |                                                         |
| x               | Delete character at cursor                              |
| dw              | Delete a word.                                          |
| d0              | Delete to the beginning of a line.                      |
| d$              | Delete to the end of a line.                            |
| d)              | Delete to the end of sentence.                          |
| dgg             | Delete to the beginning of the file.                    |
| dG              | Delete to the end of the file.                          |
| dd              | Delete line                                             |
| 3dd             | Delete three lines                                      |
| x               | Delete character at cursor                              |
| dw              | Delete a word.                                          |
| d0              | Delete to the beginning of a line.                      |
| d$              | Delete to the end of a line.                            |
| d)              | Delete to the end of sentence.                          |
| dgg             | Delete to the beginning of the file.                    |
| dG              | Delete to the end of the file.                          |
| dd              | Delete line                                             |
| 3dd             | Delete three lines                                      |
|                 |                                                         |
| r{text}         | Replace the character under the cursor with {text}      |
| R               | Replace characters instead of inserting them            |
|                 |                                                         |
| ~               | Switch case                                             |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         ||                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |


## Command mode with `:`
| Keybinding      | Result                                                  |
|-----------------|---------------------------------------------------------|
| :h `<topic>`    | See help on `<topic>`.                                  |
| :q              | Close window, either VIM itself or subwindow like help dialog. |
| :q!             | Quit Vim without saving the modified file.              |
| :w              | Save ("Write") the file                                 |
| :w new_name     | Save the file with new name                             |
| :version        | Show version info, as well as vimrc search paths        |
| :scriptnames    | List loaded scripts                                     |
| :verbose        | Check where an option (`=`) was last set,  e.g. `:verbose set mouse` |
|                 |                                                         |
|                 |                                                         ||                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |


## Config
> **NOTE:**  
> These directives require command mode (`:` prefix) when used interactively
> inside vim, e.g. `:set command`.  
> The `:` should not be put in a vimrc.

Run `vim --version` to see which features vim was compiled with.

| Keybinding      | Result                                                  |
|-----------------|---------------------------------------------------------|
| set mouse=a     | Enable mouse functionality for All modes.               |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         ||                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |
|                 |                                                         |

The `<Leader>` key is mapped to `\` by default. It is a way of extending the VIM shortcuts by using key sequences to perform a command. Be aware that when you do press the `<leader>` key you only have 1000ms (by default) to enter the following key. A popular remapping of the `<Leader>` key is `Space`, because it is easy to reach with either hand, making the follow up key equally easy.

## NeoVIM
Note that neovim requires `~/.config/nvim/init.vim` in order to source a `.vimrc` or `.nvimrc` file:
```vim
"""""""""""""""""""""""""""""
" ~/.config/nvim/init.vim
"""""""""""""""""""""""""""""

source ~/.vimrc

" Neovim specific stuff:

```

## vscodeVIM
### EasyMotion
Once easymotion is active, initiate motions using the following commands. After you initiate the motion, text decorators/markers will be displayed and you can press the keys displayed to jump to that position. `leader` is configurable and is `\` by default, although commonly remapped to `<space>`.

| Motion Command                      | Description                                                                                                    |
| ----------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| `<leader><leader> s <char>`         | Search character                                                                                               |
| `<leader><leader> f <char>`         | Find character forwards                                                                                        |
| `<leader><leader> F <char>`         | Find character backwards                                                                                       |
| `<leader><leader> t <char>`         | Til character forwards                                                                                         |
| `<leader><leader> T <char>`         | Til character backwards                                                                                        |
| `<leader><leader> w`                | Start of word forwards                                                                                         |
| `<leader><leader> b`                | Start of word backwards                                                                                        |
| `<leader><leader> l`                | Matches beginning & ending of word, camelCase, after `_`, and after `#` forwards                               |
| `<leader><leader> h`                | Matches beginning & ending of word, camelCase, after `_`, and after `#` backwards                              |
| `<leader><leader> e`                | End of word forwards                                                                                           |
| `<leader><leader> ge`               | End of word backwards                                                                                          |
| `<leader><leader> j`                | Start of line forwards                                                                                         |
| `<leader><leader> k`                | Start of line backwards                                                                                        |
| `<leader><leader> / <char>... <CR>` | Search n-character                                                                                             |
| `<leader><leader><leader> bdt`      | Til character                                                                                                  |
| `<leader><leader><leader> bdw`      | Start of word                                                                                                  |
| `<leader><leader><leader> bde`      | End of word                                                                                                    |
| `<leader><leader><leader> bdjk`     | Start of line                                                                                                  |
| `<leader><leader><leader> j`        | JumpToAnywhere motion; default behavior matches beginning & ending of word, camelCase, after `_` and after `#` |

`<leader><leader> (2s|2f|2F|2t|2T) <char><char>` and `<leader><leader><leader> bd2t <char>char>` are also available.
The difference is character count required for search.
For example, `<leader><leader> 2s <char><char>` requires two characters, and search by two characters.
This mapping is not a standard mapping, so it is recommended to use your custom mapping.

## Common problems
### Clipboard access
* Cannot copy to clipboard / copy with middle mouse button:  
  Visual Mode requires using Shift+Mouse to select text, and CTRL+Shift+C to copy the selection.
* Linux has essentially two clipboards:
  - System clipboard (CTRL+C/V) mapped to register `+` in Vim
  - Selection clipboard (Middle Click) mapped to register `*` in Vim  
  
  You can copy explicitly to these clipboards by combining the register key `"` with a clipboard and copy command, e.g. `"+y` or `"*yy`. See also below.
* To copy to a specific clipboard with `"+y` or `"*y`:
  - Vim needs to be compiled with `+xterm_clipboard`: you can check this with `vim --version`. If it does not have it compiled in, the easiest way to get it is to install gvim:
    ```
    sudo pacman -Syu gvim
    ```
    This is a vim package with advanced features, as well as a graphical vim version (the old vim will be removed, then reinstalled).
  - Neovim requires the `wl-clipboard` package:
    ```
    sudo pacman -Syu wl-clipboard
    ```

