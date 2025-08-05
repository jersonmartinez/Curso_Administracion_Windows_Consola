@echo off
REM ========================================
REM Windows 10 Lab Environment Cleanup Script
REM ========================================
REM This script cleans up temporary files and restores initial state
REM Can be run on both host and VM

setlocal enabledelayedexpansion

echo.
echo ========================================
echo Windows 10 Lab Environment Cleanup
echo ========================================
echo.

REM Check if running on host or VM
if exist "C:\BatchScripts" (
    echo Running cleanup on VM...
    goto :vm_cleanup
) else (
    echo Running cleanup on host...
    goto :host_cleanup
)

:vm_cleanup
echo.
echo [VM] Cleaning up temporary files and restoring state...
echo.

REM Clean up temporary files in BatchScripts
if exist "C:\BatchScripts\temp" (
    echo Removing temporary files...
    rd /s /q "C:\BatchScripts\temp"
)

REM Clean up log files
if exist "C:\BatchScripts\logs" (
    echo Removing log files...
    rd /s /q "C:\BatchScripts\logs"
)

REM Restore scripts from backup if available
if exist "C:\BatchScripts\backup" (
    echo Restoring scripts from backup...
    xcopy "C:\BatchScripts\backup\*" "C:\BatchScripts\" /Y /E /Q
)

REM Clean up Windows temporary files
echo Cleaning Windows temporary files...
del /q /f "%TEMP%\*.*" 2>nul
del /q /f "C:\Windows\Temp\*.*" 2>nul

REM Clean up PowerShell execution history
if exist "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" (
    echo Cleaning PowerShell history...
    del /q /f "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
)

echo.
echo [VM] Cleanup completed successfully!
goto :end

:host_cleanup
echo.
echo [HOST] Cleaning up Vagrant environment...
echo.

REM Stop and destroy VM if running
echo Checking Vagrant VM status...
vagrant status 2>nul
if %errorlevel% equ 0 (
    echo Stopping VM...
    vagrant halt 2>nul
    
    echo Destroying VM...
    vagrant destroy -f 2>nul
)

REM Clean up Vagrant cache
echo Cleaning Vagrant cache...
if exist ".vagrant" (
    rd /s /q ".vagrant"
)

REM Clean up temporary files
echo Cleaning temporary files...
if exist "temp" rd /s /q "temp"
if exist "logs" rd /s /q "logs"

REM Remove environment file if it exists
if exist ".env.vagrant" (
    echo Removing environment file...
    del ".env.vagrant"
)

echo.
echo [HOST] Cleanup completed successfully!

:end
echo.
echo ========================================
echo Cleanup process finished!
echo ========================================
echo.
echo To recreate the environment:
echo 1. Copy env.vagrant.example to .env.vagrant
echo 2. Modify .env.vagrant as needed
echo 3. Run: vagrant up
echo.
pause
