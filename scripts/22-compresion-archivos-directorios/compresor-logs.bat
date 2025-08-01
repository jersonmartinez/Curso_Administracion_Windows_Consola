@echo off
:: Compresor de logs con rotación
title 📊 Compresor de Logs
color 0C

set "log_dir=C:\Logs"
set "dias_antiguos=7"

echo ========================================
echo    📊 COMPRESOR DE LOGS CON ROTACIÓN
echo ========================================
echo.

echo 🔍 Buscando logs antiguos...
forfiles /p "%log_dir%" /s /m *.log /d -%dias_antiguos% /c "cmd /c echo @path" > temp_logs.txt

if exist temp_logs.txt (
    echo 📦 Comprimiendo logs antiguos...
    for /f "tokens=*" %%f in (temp_logs.txt) do (
        echo Comprimiendo: %%~nxf
        compact /c "%%f"
    )
    del temp_logs.txt
    echo ✅ Logs comprimidos exitosamente.
) else (
    echo ℹ️ No se encontraron logs antiguos para comprimir.
)

echo.
pause 