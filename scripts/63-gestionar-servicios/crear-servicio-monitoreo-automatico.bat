@echo off
REM Crea un servicio personalizado que monitorea automáticamente servicios críticos
REM Requiere privilegios de administrador
set "servicio=MonitorServicios"
set "script=C:\Scripts\monitor_servicios.bat"
if not exist "C:\Scripts" mkdir "C:\Scripts"
echo @echo off > "%script%"
echo setlocal enabledelayedexpansion >> "%script%"
echo echo Iniciando monitoreo de servicios... >> "%script%"
echo echo Monitoreo iniciado: %%date%% %%time%% >> "%script%"
echo. >> "%script%"
echo :monitor_loop >> "%script%"
echo for %%s in (spooler eventlog themes) do ( >> "%script%"
echo     sc query %%s ^| findstr "RUNNING" ^>nul >> "%script%"
echo     if !errorlevel! neq 0 ( >> "%script%"
echo         echo [ALERTA] %%s no esta ejecutandose >> "C:\Logs\servicios.log" >> "%script%"
echo         sc start %%s >> "%script%"
echo     ) >> "%script%"
echo ) >> "%script%"
echo timeout /t 300 /nobreak ^>nul >> "%script%"
echo goto monitor_loop >> "%script%"
sc create "%servicio%" binpath= "%script%" displayname= "Monitor de Servicios" start= auto
sc description "%servicio%" "Servicio de monitoreo automatico de servicios criticos"
sc config "%servicio%" obj= "LocalSystem"
if not exist "C:\Logs" mkdir "C:\Logs"
sc start "%servicio%"
sc query "%servicio%"
echo Servicio de monitoreo automatico creado
pause
