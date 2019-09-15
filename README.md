# Remove unwanted keyboard layout

Powershell script for remove unwanted keyboard Czech QWERTZ layout from Windows 10 without reboot

If you would like to save output then run script with redirect, for example:  
`powershell .\RemoveUnwantedKBLayout.ps1 >output_file.txt`

or you can write output to the clipboard:  
`powershell .\RemoveUnwantedKBLayout.ps1 |clip`

This script is unsigned. For run it you must first enable runing unsigned scripts in Powershell (this allow running unsigned scripts that you write on your local computer and signed scripts from Internet):  
1) Start Windows PowerShell with the "Run as Administrator" option
2) Run the Set-ExecutionPolicycmdlet: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`
