@echo off
echo Ejecutando aplicaciones administrativas...
runas /user:administrador /savecred "services.msc"
timeout /t 2 /nobreak >nul
runas /user:administrador /savecred "compmgmt.msc"
timeout /t 2 /nobreak >nul
runas /user:administrador /savecred "eventvwr.msc"
echo Aplicaciones administrativas ejecutadas
pause 