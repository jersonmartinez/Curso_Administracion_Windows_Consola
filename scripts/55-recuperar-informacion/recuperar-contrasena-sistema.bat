@echo off
echo ========================================
echo  RECUPERAR CONTRASEÑAS DEL SISTEMA
echo ========================================
echo.

REM Listar usuarios del sistema
echo Usuarios del sistema:
net user

echo.
set /p usuario="Usuario a recuperar: "

REM Crear script para resetear contraseña
echo @echo off > reset_password.bat
echo echo Reseteando contraseña para %usuario%... >> reset_password.bat
echo net user %usuario% * >> reset_password.bat
echo echo Contraseña reseteada >> reset_password.bat
echo pause >> reset_password.bat

echo Script creado: reset_password.bat
echo Ejecute como administrador para resetear contraseña
echo.

REM Alternativa: habilitar cuenta de administrador
echo Habilitando cuenta de administrador...
net user administrator /active:yes
net user administrator *

echo Cuenta de administrador habilitada
echo Contraseña: (vacía)
pause
