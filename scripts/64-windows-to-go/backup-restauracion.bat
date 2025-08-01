@echo off
REM Backup y restauración de Windows To Go
set /p usb="Unidad USB: "
set /p backup="Ruta de backup: "
dism /capture-image /imagefile:"%backup%\wtg_backup.wim" /capturedir:%usb% /name:"WTG Backup"
echo Backup completado
pause
