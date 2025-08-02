@echo off
:: Crear nombres con timestamp
echo ========================================
echo        GENERADOR DE TIMESTAMP
echo ========================================
echo.
:: Obtener fecha y hora formateada
set "fecha=%date:~6,4%%date:~3,2%%date:~0,2%"
set "hora=%time:~0,2%%time:~3,2%%time:~6,2%"
set "timestamp=%fecha%_%hora%"
set "timestamp=%timestamp: =0%"

echo ⏰ Timestamp: %timestamp%
echo 📄 Nombre de archivo: backup_%timestamp%.zip
echo.
echo 💡 Útil para: backups, logs, archivos únicos
echo.
pause 