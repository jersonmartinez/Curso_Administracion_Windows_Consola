@echo off
echo ========================================
echo    ANALIZAR RENDIMIENTO DE DISCO
echo ========================================
echo.

echo Analizando rendimiento de disco...
echo Analisis iniciado: %date% %time%

REM Información de discos lógicos
echo === INFORMACION DE DISCOS LOGICOS ===
wmic logicaldisk get deviceid,size,freespace,volumename /format:table

REM Calcular porcentaje de uso
echo.
echo === PORCENTAJE DE USO DE DISCOS ===
for /f "skip=1 tokens=1,2,3" %%a in ('wmic logicaldisk get deviceid^,size^,freespace /format:csv') do (
    if not "%%a"=="" (
        set /a "uso=((%%b-%%c)*100)/%%b"
        echo Disco %%a: !uso!%% usado
    )
)

REM Información de discos físicos
echo.
echo === INFORMACION DE DISCOS FISICOS ===
wmic diskdrive get model,size,mediatype /format:table

echo Analisis de disco completado
pause
