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

echo Darkmode wird aktiviert
echo.
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
echo.
echo Darkmode aktiviert
echo.

eecho Taskleiste wird angepasst
echo.
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f
echo.
echo Taskleiste wurde angepasst
echo.

echo Alle Taskleisten-Icons werden entfernt
echo.
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f
::Remove-Item "$env:ALLUSERSPROFILE\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" -Recurse -Force
::DEL /F /Q %AppData%\Microsoft\Internet\Explorer\Quick Launch\User Pinned\TaskBar\*
::DEL /F /Q %AllUsersProfile%\Microsoft\Internet\Explorer\Quick Launch\User Pinned\TaskBar\*
echo Alle Taskleisten-Icons wurden entfernt
echo.

echo Entfernen von Edge vom User Desktop
echo.
setlocal
set "currentUser=%USERNAME%"
set "desktopPath=%USERPROFILE%\Desktop"
del "%desktopPath%\Microsoft Edge.lnk"
endlocal
echo.
echo Verknüpfungs wurden vom User Desktop entfernt
echo.

echo Explorer wird neugestartet
echo.
taskkill /f /im explorer.exe
start explorer.exe
echo.
echo Explorer wurde neugestartet
echo.

msg * "Userskiript wurde durch geführt. Bitte Logs prüfen!"

echo  Neustart Prompt
curl https://raw.githubusercontent.com/CliffordTT/CYMScripts/main/CYMRestartPrompt.bat -o C:\_CYMOS\CYMRestartPrompt.bat && start C:\_CYMOS\CYMRestartPrompt.bat

pause
