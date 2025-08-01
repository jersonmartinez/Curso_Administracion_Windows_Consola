@echo off
:: Compresor con verificación de integridad
title 🔐 Compresor Seguro
color 0F

set /p archivo="Archivo a comprimir: "

echo ========================================
echo    🔐 COMPRESOR CON VERIFICACIÓN
echo ========================================
echo.

:: Calcular hash antes de comprimir
echo 🔍 Calculando hash original...
certutil -hashfile "%archivo%" MD5 > hash_original.txt

:: Comprimir archivo
echo 📦 Comprimiendo archivo...
compact /c "%archivo%"

:: Calcular hash después de comprimir
echo 🔍 Verificando integridad...
certutil -hashfile "%archivo%" MD5 > hash_comprimido.txt

:: Comparar hashes
fc hash_original.txt hash_comprimido.txt >nul
if %errorlevel%==0 (
    echo ✅ Integridad verificada - archivo comprimido correctamente
) else (
    echo ❌ Error de integridad detectado
)

:: Limpiar archivos temporales
del hash_original.txt hash_comprimido.txt

echo.
pause 