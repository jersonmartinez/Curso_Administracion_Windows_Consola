@echo off
REM Formatea múltiples unidades de manera automatizada usando un bucle FOR

echo 🔄 FORMATEO DE MÚLTIPLES UNIDADES (FOR)
echo =========================================

echo ⚠️  Esta operación formateará múltiples unidades

echo.
echo 🔄 Formateando múltiples unidades...

for %%d in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        echo 📁 Formateando unidad %%d:...
        format %%d: /FS:NTFS /Q /V:UNIDAD_%%d /Y
        echo.
    )
)

echo ✅ Formateo de múltiples unidades completado
echo.
pause
