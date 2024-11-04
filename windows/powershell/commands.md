# PowerShell Commands
> ### Creating a PowerShell profile to load commands on each session
> * Create a text file `profile.ps1` and place it at `C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1`.
> 
> * If you get an error it cannot be loaded, you likely have to update the execution policy like so:
>   ```powershell
>   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
>   ```
> * To get the zsh-like behaviour of prepending a command with a space to exclude it from command history, add the following function to the PowerShell profile:
>   ```powershell
>   # When a command starts with a space, don't add it to Powershell history:
>   Set-PSReadLineOption -AddToHistoryHandler {
>       param($command)
>       if ($command -like ' *') {
>           return $false
>       }
>       return $true
>   }
>   ```

### `grep <PATTERN> <FILE/FOLDER>`
`grep` is obviously not directly available in PowerShell, but can be achieved in the following way with `Get-ChildItem`:
```powershell
Get-ChildItem <FILE/FOLDER> -recurse | Select-String -Pattern <PATTERN>

# Example:
Get-ChildItem "2-finaliteit\6-ado\Theorie\AdoCursus\*.cs" -recurse | Select-String -Pattern "refresh"
# This will return all filenames with line numbers where the pattern occurred.
```

### `New-Alias <NEW_NAME> <COMMAND>`
Creates an alias `NEW_NAME` for an existing `COMMAND`.

### PDF Tool [PSWritePDF](https://github.com/EvotecIT/PSWritePDF)
* Installation:
  ```powershell
  Install-Module PSWritePDF -Force -Scope CurrentUser
  ```
* Merge pdfs:
  ```powershell
  Merge-PDF -InputFile "C:\Path\to\inputfile1.pdf", "C:\Path\to\inputfile2.pdf" -OutputFile "C:\Path\to\outputfile.pdf"
  ```
* Split pdf into single pages:
  ```powershell
  Split-PDF -FilePath "C:\Path\to\inputfile-to-split.pdf" -OutputFolder "C:\Path\to\output-folder"
  ```

For more info see [this blog post about PSWritePDF](https://evotec.xyz/merging-splitting-and-creating-pdf-files-with-powershell/).