@echo off
:menu_principal
echo 1. Crear Windows To Go
 echo 2. Configurar arranque dual
 echo 3. Crear workspace personalizado
 echo 4. Gestionar instalaciones
 echo 5. Backup y restauracion
 echo 6. Salir
 echo.
 set /p opcion="Seleccione una opcion: "
 if "%opcion%"=="1" call crear-windows-to-go-basico.bat
 if "%opcion%"=="2" call configurar-arranque-dual.bat
 if "%opcion%"=="3" call crear-workspace-personalizado.bat
 if "%opcion%"=="4" call gestionar-multiples-instalaciones.bat
 if "%opcion%"=="5" call backup-restauracion.bat
 if "%opcion%"=="6" goto salir
 goto menu_principal
:salir
echo Gracias por usar la Gestion de Windows To Go
exit
