@echo off
color 02
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
::: Dieses Script wurde erstellt von:
:::   _____ __     __ __  __   ____    _____    _____  _______
:::  / ____|\ \   / /|  \/  | / __ \  / ____|  |_   _||__   __|
::: | |      \ \_/ / | \  / || |  | || (___      | |     | |   
::: | |       \   /  | |\/| || |  | | \___ \     | |     | |   
::: | |____    | |   | |  | || |__| | ____) |_  _| |_    | |   
:::  \_____|   |_|   |_|  |_| \____/ |_____/(_)|_____|   |_|   
echo.
echo Ersteller: TT
echo Erstellungsdatum: 10.08.2024
echo Version 1.0
echo.

echo C:\_CYMOS wird erstellt
echo.
mkdir C:\_CYMOS
echo _CYMOS Folder erstellt
echo.

echo Enrgieoptionen werden angepasst
echo.
powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0
for /f "tokens=*" %%A in ('"wmic path Win32_NetworkAdapter where (NetEnabled='TRUE') get DeviceID"') do (
    if not "%%A"=="DeviceID" (
        REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\%%A" /v PnPCapabilities /t REG_DWORD /d 24 /f
    )
)
echo.
echo Energieoptionen wurden angepasst
echo.

echo Anpassen der OEM-Informationen
echo.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Manufacturer /t REG_SZ /d "CYMOS Medizin IT" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportURL /t REG_SZ /d "https://www.cymos.de" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportPhone /t REG_SZ /d "06039/709000" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportHours /t REG_SZ /d "Mo.-Fr. 08-17 Uhr" /f
mkdir C:\Windows\OEM
echo .
curl https://www.cymos.de/wp-content/uploads/2022/04/CYMOS-Logo-medizin-it.png -o C:\Windows\OEM\CYMLogo01.bmp
echo .
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Logo /t REG_SZ /d "C:\Windows\OEM\CYMLogo01.bmp" /f
echo.
echo OEM-Informationen erfolgreich aktualisiert!
echo.

echo Darkmode wird aktiviert
echo.
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
echo.
echo Darkmode aktiviert
echo.

echo Taskleiste wird angepasst
echo.
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f
echo.
echo Taskleiste wurde angepasst
echo.

echo Standard Software Instalation wird ausgeführt
echo.
curl https://ninite.com/7zip-chrome-firefox-flash-foxit-javaoraclex8-teamviewer-vlc/ninite.exe -o C:\_CYMOS\CYMNinite01.exe && C:\_CYMOS\CYMNinite01.exe
echo.
echo Instllation abgeschlossen
echo.

echo Entfernen von Edge, Foxit Reader & VLC vom Öffentlichen Desktop
echo.
del "C:\Users\Public\Desktop\Microsoft Edge.lnk"
del "C:\Users\Public\Desktop\Foxit PDF Reader.lnk"
del "C:\Users\Public\Desktop\VLC media player.lnk"
echo.
echo Verknüpfungen wurden vom Öffentlichen Desktop entfernt
echo.

echo Alle Taskleisten-Icons werden entfernt
echo.
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f
::Remove-Item "$env:ALLUSERSPROFILE\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" -Recurse -Force
::DEL /F /Q %AppData%\Microsoft\Internet\Explorer\Quick Launch\User Pinned\TaskBar\*
::DEL /F /Q %AllUsersProfile%\Microsoft\Internet\Explorer\Quick Launch\User Pinned\TaskBar\*
echo Alle Taskleisten-Icons wurden entfernt
echo.

echo Explorer wird neugestartet
echo.
taskkill /f /im explorer.exe
start explorer.exe
echo.
echo Explorer wurde neugestartet
echo.

echo Debloaten von Windows
echo.
sc config WaaSMedicSvc start= disabled
sc config WSearch start= disabled
sc config XblAuthManager start= disabled
sc config XblGameSave start= disabled
sc config XboxNetApiSvc start= disabled
sc config DiagTrack start= disabled
sc stop DiagTrack
sc config dmwappushsvc start= disabled
sc stop dmwappushsvc
echo Lösche temporäre Dateien und Caches...
del /q /f /s %TEMP%\*
del /q /f /s C:\Windows\Temp\*
echo Deaktiviere Telemetrie und Datensammlung...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /t REG_SZ /d "" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d "0" /f
curl https://raw.githubusercontent.com/Raphire/Win11Debloat/master/Get.ps1 -o C:\_CYMOS\CYMWinDebloat01.ps1 && powershell -ExecutionPolicy Bypass -File "C:\_CYMOS\CYMWinDebloat01.ps1 -RemoveApps"
echo Windows wurde Debloatet
echo.

echo PC-Namen/ Domain Join durchführen
sysdm.cpl

echo.
start C:\Windows\Setup
echo.

msg * "Adminskiript wurde durch geführt. Bitte Logs prüfen!"

echo  Neustart Prompt
curl https://raw.githubusercontent.com/CliffordTT/CYMScripts/main/CYMRestartPrompt.bat -o C:\_CYMOS\CYMRestartPrompt.bat && start C:\_CYMOS\CYMRestartPrompt.bat

pause

::setlocal
::set "PC_NAME=%COMPUTERNAME%"
::msg * Der Computername ist: %PC_NAME%
::endlocal
