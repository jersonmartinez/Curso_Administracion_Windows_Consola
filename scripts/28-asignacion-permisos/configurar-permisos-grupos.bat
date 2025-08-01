@echo off
:: Configurar permisos para grupos
echo Configurando permisos para grupos...

:: Dar permisos a un grupo
icacls "recurso/" /grant "Grupo_Desarrollo:(OI)(CI)M" /t

echo.
echo ✅ Permisos configurados para grupo
pause 