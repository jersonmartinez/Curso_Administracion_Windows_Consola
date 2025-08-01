@echo off
title Gestión de Mensajes de Red
color 0C

:menu
cls
echo ========================================
echo    GESTION DE MENSAJES DE RED
echo ========================================
echo.
echo 1. Enviar mensaje a todos los usuarios
echo 2. Enviar mensaje a usuario específico
echo 3. Enviar mensaje a equipo específico
echo 4. Ver usuarios conectados
echo 5. Enviar mensaje urgente
echo 6. Enviar mensaje con timeout
echo 7. Programar mensaje
echo 8. Salir
echo.
set /p opcion="Selecciona una opción (1-8): "

if "%opcion%"=="1" goto todos
if "%opcion%"=="2" goto usuario
if "%opcion%"=="3" goto equipo
if "%opcion%"=="4" goto usuarios
if "%opcion%"=="5" goto urgente
if "%opcion%"=="6" goto timeout
if "%opcion%"=="7" goto programar
if "%opcion%"=="8" goto salir
goto menu

:todos
cls
echo === ENVIAR MENSAJE A TODOS ===
set /p mensaje="Ingresa el mensaje: "
msg * "%mensaje%"
if %errorlevel%==0 (
    echo ✓ Mensaje enviado exitosamente
) else (
    echo ✗ Error al enviar mensaje
)
pause
goto menu

:usuario
cls
echo === ENVIAR MENSAJE A USUARIO ===
set /p usuario="Nombre del usuario: "
set /p mensaje="Mensaje: "
msg %usuario% "%mensaje%"
if %errorlevel%==0 (
    echo ✓ Mensaje enviado a %usuario%
) else (
    echo ✗ Error al enviar mensaje
)
pause
goto menu

:equipo
cls
echo === ENVIAR MENSAJE A EQUIPO ===
set /p equipo="Nombre/IP del equipo: "
set /p mensaje="Mensaje: "
msg /server:%equipo% * "%mensaje%"
if %errorlevel%==0 (
    echo ✓ Mensaje enviado al equipo %equipo%
) else (
    echo ✗ Error al enviar mensaje
)
pause
goto menu

:usuarios
cls
echo === USUARIOS CONECTADOS ===
query user
pause
goto menu

:urgente
cls
echo === MENSAJE URGENTE ===
set /p mensaje="Mensaje urgente: "
msg * "URGENTE: %mensaje%"
echo ✓ Mensaje urgente enviado
pause
goto menu

:timeout
cls
echo === MENSAJE CON TIMEOUT ===
set /p tiempo="Tiempo en segundos: "
set /p mensaje="Mensaje: "
msg * /time:%tiempo% "%mensaje%"
echo ✓ Mensaje enviado con timeout
pause
goto menu

:programar
cls
echo === PROGRAMAR MENSAJE ===
set /p hora="Hora (HH:MM): "
set /p mensaje="Mensaje: "
at %hora% msg * "%mensaje%"
echo ✓ Mensaje programado para las %hora%
pause
goto menu

:salir
echo Gracias por usar el gestor de mensajes
exit 