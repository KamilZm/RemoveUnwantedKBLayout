# Remove unwanted Czech QWERTZ keyboard layout without reboot

# If you would like to save output then run script with redirect (for example "powershell .\RemoveUnwantedKBLayout.ps1 >output.txt")
# or you can write output to the clipboard  (for example "powershell .\RemoveUnwantedKBLayout.ps1 |clip)

Write-Host "Remove unwanted Czech QWERTZ keyboard layout without reboot [v0.2]" 
Write-Host "System date:" (Get-Date -format "dd.MM.yyyy hh:mm:ss")

# Locale ID where the keyboard layout is removed
$LCID_Czech = '0405'

# Keyboard layout code whitch is removed
$Keyboard_Czech_QWERTZ = '00000405'

# Get all installed languages 
$languages = Get-WinUserLanguageList

Write-Host "`nInstalled languages" 
Write-Host "===================" 
Write-Host ($languages | Format-Table | Out-String) -NoNewline

# Unwanted keyboard layout is dynamically added and isn't in Windows language/keyboard settings
# For remove it must be first correctly added into Windows language/keyboard setting

Write-Host "Phase 1 - add"
Write-Host "-------------"
ForEach ($lang in $languages)
{
    # add QWERTZ keyboard layout to defined locale 
    Write-Host ("Scan language [" + $lang.LanguageTag + "]")
    if ($lang.InputMethodTips -Like $LCID_Czech + "*")
    {
        Write-Host ("Match [" + $lang.LanguageTag + ":" + $LCID_Czech + "], InputMethodTips [" + $lang.InputMethodTips + "]" )
        Write-Host ("Add [" + $LCID_Czech + ":" + $Keyboard_Czech_QWERTZ + "]" )
	$lang.InputMethodTips.Add($LCID_Czech + ":" + $Keyboard_Czech_QWERTZ)
    }
}

# apply changes
Write-Host "`nModified languages object after phase 1"
Write-Host "---------------------------------------" -NoNewline
Write-Host ($languages | Format-Table | Out-String) -NoNewline
Write-Host ("Commit phase 1" )
Set-WinUserLanguageList $languages -force

Write-Host "`nPhase 2 - remove"
Write-Host "----------------"
ForEach ($lang in $languages)
{
    # remove QWERTZ keyboard layout from defined locale
    Write-Host ("Scan language [" + $lang.LanguageTag + "]")
    if ($lang.InputMethodTips -Like $LCID_Czech + "*")
    {
        Write-Host ("Match [" + $lang.LanguageTag + ":" + $LCID_Czech + "], InputMethodTips [" + $lang.InputMethodTips + "]" )
        Write-Host ("Remove [" + $LCID_Czech + ":" + $Keyboard_Czech_QWERTZ + "]" )
        while ($lang.InputMethodTips.Remove($LCID_Czech + ":" + $Keyboard_Czech_QWERTZ)) {}
    }
}

# apply changes
Write-Host "`nModified languages object after phase 2"
Write-Host "---------------------------------------" -NoNewline
Write-Host ($languages | Format-Table | Out-String) -NoNewline
Write-Host ("Commit phase 2" )
Set-WinUserLanguageList $languages -force

# Get all installed languages after remove layout
$languages = Get-WinUserLanguageList

Write-Host ""
Write-Host "Installed languages [finally]"
Write-Host "=============================" 
Write-Host ($languages | Format-Table | Out-String) -NoNewline
