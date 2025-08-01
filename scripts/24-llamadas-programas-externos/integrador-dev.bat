@echo off
:: Integrador de herramientas de desarrollo
title 💻 Integrador Dev
color 0B

echo ========================================
echo    💻 INTEGRADOR DE HERRAMIENTAS DEV
echo ========================================
echo.

:: Verificar Git
echo 🔍 Verificando Git...
git --version >nul 2>&1
if %errorlevel%==0 (
    echo ✅ Git encontrado
    git status
) else (
    echo ❌ Git no encontrado
)

:: Verificar Node.js
echo 🔍 Verificando Node.js...
node --version >nul 2>&1
if %errorlevel%==0 (
    echo ✅ Node.js encontrado
    node --version
) else (
    echo ❌ Node.js no encontrado
)

:: Verificar Python
echo 🔍 Verificando Python...
python --version >nul 2>&1
if %errorlevel%==0 (
    echo ✅ Python encontrado
    python --version
) else (
    echo ❌ Python no encontrado
)

echo.
pause 