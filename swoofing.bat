@echo off
color b
title Spoofer MTA

cls

(
echo Stop-Process -Name "WmiPrvSE" -Force
echo Set-Location -Path C:\ -Force
echo Remove-Item C:\ProgramData:NT -Force
echo Remove-Item C:\ProgramData:NT2 -Force
echo Set-Location -Path C:\ProgramData -Force
echo Remove-Item "MTA San Andreas All" -Force
echo Set-Location -Path C:\Users\%username%\AppData -Force
echo Remove-Item C:\Users\%username%\AppData\Roaming:NT -Force
echo Remove-Item C:\Users\%username%\AppData\Roaming:NT2 -Force
echo Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID2*" -Recurse -Force
echo Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections" -Recurse -Force
echo Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Multi Theft Auto: San Andreas All\1.6" -Recurse -Force
echo rd "C:\ProgramData\MTA San Andreas All" -Recurse -Force
echo Set-Location -Path J:\
) > C:\Users\service.ps1

echo [+] Spoofer mta undetect
ping 127.0.0.1 -n 2 > nul
cls

set chave=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Multi Theft Auto: San Andreas All\1.6\Settings\general
set value=serial
cls
for /f "tokens=2,*" %%a in ('reg query "%chave%" /v "%value%" 2^>nul ^| findstr "%value%"') do (
    echo [+] Your Current Serial: %%b
)
ping 127.0.0.1 -n 2 > nul

powershell -ExecutionPolicy Bypass -File C:\Users\service.ps1 > nul 2>&1


sc stop FairplayKD > NUL 2>&1
sc query FairplayKD | findstr /C:"ESTADO" | findstr /C:"STOPPED" > NUL
if %errorlevel% equ 0 (
    echo [+] Turning off FairplayKD checks
) else (
    echo [+] FairplayKD is already shut down
)
ping 127.0.0.1 -n 2 > NUL

rmdir /s /q "C:\Program Files (x86)\MTA San Andreas 1.6\MTA\logs" > NUL 2>&1
rmdir /s /q "C:\ProgramData\MTA San Andreas All\1.6\upcache" > NUL 2>&1
rmdir /s /q "C:\ProgramData\MTA San Andreas All\Common\temp3" > NUL 2>&1
rmdir /s /q "C:\ProgramData\MTA San Andreas All\Common\data\cache" > NUL 2>&1
del "C:\ProgramData\MTA San Andreas All\1.6\report.log" > NUL 2>&1
del "C:\Program Files (x86)\MTA San Andreas 1.6\MTA\config\servercache.xml" > NUL 2>&1

taskkill /f /im WmiPrvSE.exe > NUL 2>&1
rmdir /s /q "C:\ProgramData\MTA San Andreas All\Common" -Force > NUL 2>&1
rmdir /s /q "C:\ProgramData\MTA San Andreas All\1.6" -Force > NUL 2>&1
mkdir "C:\ProgramData\MTA San Andreas All\Common" > NUL 2>&1
mkdir "C:\ProgramData\MTA San Andreas All\1.6" > NUL 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductId /t REG_SZ /d %random:~-4%-41Z79-03200-S6%random:~-4% /f > NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Multi Theft Auto: San Andreas All\1.6\Settings" /f > NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Multi Theft Auto: San Andreas All\Common\diagnostics" /f > NUL 2>&1

echo [+] Deleting all existing logs

set "spoofer_file=%~dp0spoofer.sys" > NUL 2>&1
set "kdmapper_exe=%~dp0kdmapper.exe" > NUL 2>&1

"%kdmapper_exe%" "%spoofer_file%" > NUL 2>&1

ping 127.0.0.1 -n 3 > nul

if exist "%spoofer_file%" (
    cls
    echo [/] Driver loading successfully
) else (
    cls
    echo [/] Driver loading Error
)

timeout /t 1 /nobreak >nul
cls
timeout /t 2 /nobreak >nul

echo [+] All processes have been completed

timeout /t 2 /nobreak >nul

    cls
    echo [+] getting new serial
    start "" "C:\Program Files (x86)\MTA San Andreas 1.6\Multi Theft Auto.exe"
    sc stop FairplayKD > NUL 2>&1
    ping 127.0.0.1 -n 2 > NUL
    sc delete FairplayKD > NUL 2>&1
    ping 127.0.0.1 -n 12 > NUL


setlocal

set "process=gta_sa.exe"

:check_process
tasklist | find /i "%process%" > nul
if %errorlevel% equ 0 (
set chave=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Multi Theft Auto: San Andreas All\1.6\Settings\general
set value=serial
cls
for /f "tokens=2,*" %%a in ('reg query "%chave%" /v "%value%" 2^>nul ^| findstr "%value%"') do (
    echo [+] Your New Serial: %%b
)
    timeout /t 4 /nobreak > nul
    exit
) else (
    timeout /t 1 /nobreak > nul
    goto check_process
)

endlocal



