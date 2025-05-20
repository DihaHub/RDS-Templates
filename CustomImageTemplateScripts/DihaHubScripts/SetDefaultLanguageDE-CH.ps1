# The language we want as new default. Language tag can be found here: https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/available-language-packs-for-windows?view=windows-11#language-packs
$LPlanguage = "de-CH"

# As In some countries the input locale might differ from the installed language pack language, we use a separate input local variable.
# A list of input locales can be found here: https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-input-locales-for-windows-language-packs?view=windows-11#input-locales
$InputlocaleRegion = "de-CH"

# Geographical ID we want to set. GeoID can be found here: https://learn.microsoft.com/en-us/windows/win32/intl/table-of-geographical-locations
$geoId = "223"

# Configure new language defaults under current user (system) after which it can be copied to system
Set-WinUILanguageOverride -Language $LPlanguage

# adding the input locale language to the preferred language list, and make it as the first of the list. 
$LangList = New-WinUserLanguageList -Language $InputlocaleRegion
 
# Weitere Sprachen hinzufügen
$LangList.Add("fr-CH")
$LangList.Add("it-CH")
 
# Eingabemethoden setzen
$LangList[0].InputMethodTips.Clear()
$LangList[0].InputMethodTips.Add("0807:00000807") # de-CH
$LangList[1].InputMethodTips.Clear()
$LangList[1].InputMethodTips.Add("100C:0000100C") # fr-CH
$LangList[2].InputMethodTips.Clear()
$LangList[2].InputMethodTips.Add("0810:0000100C") # it-CH mit fr-CH Layout (z. B. bei Romands in TI)
 
# Liste anwenden
Set-WinUserLanguageList $LangList -Force

# Set Win Home Location, sets the home location setting for the current user. This is for Region location 
Set-WinHomeLocation -GeoId $geoId

# Set Culture, sets the user culture for the current user account. This is for Region format
Set-Culture -CultureInfo $InputlocaleRegion

# Optional: Systemlocale auf DE (Schweiz) setzen (z.B. für nicht-Unicode-Programme)
Set-WinSystemLocale $InputlocaleRegion

# Copy User International Settings from current user to System, including Welcome screen and new user
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True

#Set Timezone to Central Europe Standard Time
$timezoneID = "Central Europe Standard Time"
Set-TimeZone -Id $timezoneID
