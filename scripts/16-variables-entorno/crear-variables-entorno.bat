@echo off
:: Crear variables de entorno persistentes
echo ========================================
echo    CREAR VARIABLES DE ENTORNO
echo ========================================
echo.

echo 🔧 Creando variable a nivel de usuario:
SETX CursoAWC "Curso de Administración de Windows desde la Consola"
echo ✅ Variable CursoAWC creada (usuario)
echo.

echo 🔧 Creando variable a nivel de sistema:
SETX CursoAWC "Curso de Administración de Windows desde la Consola" /M
echo ✅ Variable CursoAWC creada (sistema)
echo.

echo 🔧 Creando variable MYPATH a nivel de usuario:
SETX MYPATH "%PATH%"
echo ✅ Variable MYPATH creada (usuario)
echo.

echo 🔧 Creando variable MYPATH a nivel de sistema:
SETX MYPATH "%PATH%" /M
echo ✅ Variable MYPATH creada (sistema)
echo.

echo 💡 Las variables se guardan en el registro y persisten entre sesiones
echo    Verificar en una nueva sesión de consola o desde interfaz gráfica
echo.
pause 