@echo off
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
