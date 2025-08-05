@echo off
REM ========================================
REM Test Environment for Windows 10 Lab
REM ========================================
REM This script tests the environment functionality

setlocal enabledelayedexpansion

echo.
echo ========================================
echo Testing Windows 10 Lab Environment
echo ========================================
echo.

echo [1/6] Testing VM status...
vagrant status | findstr "running" >nul
if %errorlevel% equ 0 (
    echo    ✓ VM is running
) else (
    echo    ✗ VM is not running
    echo    Starting VM...
    vagrant up
)

echo.
echo [2/6] Testing RDP connectivity...
vagrant port | findstr "3389" >nul
if %errorlevel% equ 0 (
    echo    ✓ RDP port is available
    for /f "tokens=4" %%i in ('vagrant port ^| findstr "3389"') do set "rdp_port=%%i"
    echo    RDP Port: !rdp_port!
) else (
    echo    ✗ RDP port not found
)

echo.
echo [3/6] Testing network connectivity...
ping -n 1 192.168.56.10 >nul
if %errorlevel% equ 0 (
    echo    ✓ Host-only network is working
) else (
    echo    ✗ Host-only network not responding
)

echo.
echo [4/6] Testing environment file...
if exist ".env.vagrant" (
    echo    ✓ Environment file exists
    findstr "VAGRANT_WIN_USER" .env.vagrant >nul
    if %errorlevel% equ 0 (
        echo    ✓ Environment configuration is valid
    ) else (
        echo    ✗ Environment configuration incomplete
    )
) else (
    echo    ✗ Environment file not found
    echo    Creating from template...
    copy "env.vagrant.example" ".env.vagrant" >nul
)

echo.
echo [5/6] Testing provision scripts...
if exist "provision\create-user.ps1" (
    echo    ✓ User creation script found
) else (
    echo    ✗ User creation script missing
)

if exist "provision\configure-windows.ps1" (
    echo    ✓ Windows configuration script found
) else (
    echo    ✗ Windows configuration script missing
)

if exist "provision\install-dev-tools.ps1" (
    echo    ✓ Development tools script found
) else (
    echo    ✗ Development tools script missing
)

echo.
echo [6/6] Testing scripts directory...
if exist "..\scripts" (
    echo    ✓ Scripts directory found
    dir "..\scripts" /b | find /c /v "" >nul 2>&1
    if %errorlevel% equ 0 (
        echo    ✓ Scripts directory contains files
    ) else (
        echo    ⚠ Scripts directory is empty
    )
) else (
    echo    ⚠ Scripts directory not found at ..\scripts
)

echo.
echo ========================================
echo Environment Test Complete
echo ========================================

echo.
echo Connection Information:
echo Host: 127.0.0.1
echo Port: !rdp_port!
echo User: batchtester
echo Password: P@ssw0rd123
echo.
echo Quick Commands:
echo - Connect: vagrant rdp
echo - Status: vagrant status
echo - Stop: vagrant halt
echo - Destroy: vagrant destroy -f
echo.
echo ========================================
pause 