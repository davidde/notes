# PowerShell Commands
## `grep <PATTERN> <FILE/FOLDER>`
```powershell
Get-ChildItem <FILE/FOLDER> -recurse | Select-String -Pattern <PATTERN>

# Example:
Get-ChildItem "2-finaliteit\6-ado\Theorie\AdoCursus\*.cs" -recurse | Select-String -Pattern "refresh"
# This will return all filenames with line numbers where the pattern occurred.
```