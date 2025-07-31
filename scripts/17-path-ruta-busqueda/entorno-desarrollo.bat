@echo off
:: Configurar entorno de desarrollo completo
echo ========================================
echo     ENTORNO DE DESARROLLO
echo ========================================
echo.
echo 🔧 Configurando entorno de desarrollo...

:: Agregar herramientas de desarrollo al PATH
echo 📁 Agregando Git...
PATH %PATH%;C:\DevTools\Git\bin

echo 📁 Agregando Python...
PATH %PATH%;C:\DevTools\Python\Scripts

echo 📁 Agregando NodeJS...
PATH %PATH%;C:\DevTools\NodeJS

echo 📁 Agregando Java...
PATH %PATH%;C:\DevTools\Java\bin

:: Crear variables de entorno para el proyecto
echo 📝 Configurando variables de entorno...
SET DEV_HOME=C:\Proyectos
SET JAVA_HOME=C:\DevTools\Java
SET PYTHONPATH=C:\DevTools\Python\Lib\site-packages

echo.
echo ✅ Entorno configurado exitosamente
echo 📋 PATH actualizado con herramientas de desarrollo
echo.
pause 