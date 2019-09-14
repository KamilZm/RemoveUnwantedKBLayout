# Remove unwanted Czech QWERTZ keyboard layout without reboot

# Define Locale ID
$LCID_Czech = '0405'

# Define Keyboard layout code
$Keyboard_Czech_QWERTZ = '00000405'

# Unwanted keyboard layout is dynamically added and isn't in Windows language/keyboard settings
# For remove it must be first correctly added into Windows language/keyboard setting

# Get all installed languages 
$languages = Get-WinUserLanguageList

ForEach ($lang in $languages)
{
    # add QWERTZ keyboard layout to all Windows Czech locales
    if ($lang.InputMethodTips -Like $LCID_Czech + "*")
    {
        $lang.InputMethodTips.Add($LCID_Czech + ":" + $Keyboard_Czech_QWERTZ)
    }
}

# apply changes
Set-WinUserLanguageList $languages -force

ForEach ($lang in $languages)
{
    # remove QWERTZ keyboard layout from all Windows Czech locales
    if ($lang.InputMethodTips -Like $LCID_Czech + "*")
    {
        while ($lang.InputMethodTips.Remove($LCID_Czech + ":" + $Keyboard_Czech_QWERTZ)) {}
    }
}

# apply changes
Set-WinUserLanguageList $languages -force
