@echo off
REM Script de limpieza para el entorno de pruebas
REM Elimina archivos temporales y restaura el estado inicial

REM Elimina archivos temporales en C:\BatchScripts\temp
if exist C:\BatchScripts\temp rd /s /q C:\BatchScripts\temp

REM Restaura scripts originales si hay backup
if exist C:\BatchScripts\backup xcopy C:\BatchScripts\backup\* C:\BatchScripts\ /Y /E

REM Mensaje final
ECHO Limpieza y restauración completada.
