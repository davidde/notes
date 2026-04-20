# Registry tweaks
## DWORD (32 bit)
* Disable web suggestions in file explorer:  
  `Computer\HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer\DisableSearchBoxSuggestions`: 1
* Disable web search in start menu:  `Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BingSearchEnabled`: 0
* Disable sidepanes like Bookmarks sidebar in Adobe Reader:  
  `Computer\HKEY_CLASSES_ROOT\Acrobat.Document.DC\shell\Open\command`: `"C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe" /A "navpanes=0" "%1"`
* 