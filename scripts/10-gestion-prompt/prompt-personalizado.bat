@echo off
:: Ejemplo de prompt personalizado
:: Este script muestra cómo configurar un prompt personalizado con colores

echo Configurando prompt personalizado...
setx PROMPT "$_$e[0;1;44mN$e[1;30;47mI$e[0;1;44mC$E[35;40m $d$s$t$h$h$h$h$h$h$_$E[1;33;40m$p$_$E[0;0m~$g$s"

echo.
echo ✅ Prompt personalizado configurado exitosamente
echo 💡 El nuevo prompt se aplicará en la próxima ventana de comandos
echo.
pause 