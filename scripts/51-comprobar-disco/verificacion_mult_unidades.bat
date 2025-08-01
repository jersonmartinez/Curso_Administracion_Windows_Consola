@echo off
REM Verifica la integridad de todas las unidades del sistema de manera sistemática
REM Utiliza CHKDSK para cada unidad detectada

echo 🔍 VERIFICACIÓN DE MÚLTIPLES UNIDADES
echo ======================================

echo.
echo 🔍 Detectando y verificando todas las unidades...
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        echo Verificando %%d:\ ...
        chkdsk %%d: /F
    )
)

echo ✅ Verificación de todas las unidades completada
echo.
pause
