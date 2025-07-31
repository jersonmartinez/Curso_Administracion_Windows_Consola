@echo off
:: Sistema de backup y restauración del PATH
echo ========================================
echo        BACKUP DEL PATH
echo ========================================
echo.
echo 💾 Creando backup del PATH...

:: Crear backup con timestamp
set "fecha=%date:~6,4%%date:~3,2%%date:~0,2%"
set "hora=%time:~0,2%%time:~3,2%%time:~6,2%"
set "timestamp=%fecha%_%hora%"
set "timestamp=%timestamp: =0%"

:: Guardar PATH en archivo con timestamp
echo %PATH% > PATH_backup_%timestamp%.txt
echo ✅ Backup creado en PATH_backup_%timestamp%.txt

echo.
echo 💡 Para restaurar más tarde:
echo    set /p PATH_RESTORE^<PATH_backup_%timestamp%.txt
echo    PATH %%PATH_RESTORE%%
echo.
pause 