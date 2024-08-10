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

setlocal
echo Computer neu starten? (J/N)
set /p userChoice=
if /i "%userChoice%"=="J" (
    echo Der Computer wird neu gestartet...
    shutdown /r /t 10
) else (
    echo Kein Neustart erforderlich.
)
endlocal
