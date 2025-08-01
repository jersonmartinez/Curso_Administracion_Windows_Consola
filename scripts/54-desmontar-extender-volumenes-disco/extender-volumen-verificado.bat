@echo off
echo ========================================
echo  EXTENDER VOLUMEN CON VERIFICACION
echo ========================================
echo.
REM Verificar espacio disponible antes de extender
echo Verificando espacio no asignado...
diskpart /s <(echo list disk & echo list volume)
echo.
set /p unidad="Unidad a extender (ej: D): "
set /p tamano="Tamaño a agregar en MB: "
REM Crear script de extensión
echo select volume %unidad% > extend_verified.txt
echo extend size=%tamano% >> extend_verified.txt
echo exit >> extend_verified.txt
REM Ejecutar extensión
diskpart /s extend_verified.txt
del extend_verified.txt
REM Verificar resultado
echo.
echo Verificando extensión completada...
wmic logicaldisk where "DeviceID='%unidad%:'" get Size,FreeSpace /format:value
echo Volumen %unidad%: extendido exitosamente
pause
