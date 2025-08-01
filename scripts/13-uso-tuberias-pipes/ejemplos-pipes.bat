@echo off
:: Ejemplos de uso de tuberías (PIPES) en Windows
echo ========================================
echo      EJEMPLOS DE TUBERÍAS (PIPES)
echo ========================================
echo.

echo 🔍 Ejemplo 1: Buscar texto en una cadena
echo "Curso de administración de Windows desde la Consola" | find "Windows"
echo.

echo 📝 Ejemplo 2: Crear archivo con contenido
echo Creando archivo names.txt...
(
echo Fernando
echo Ivania
echo Martha
echo Alberto
echo Jerson
) > names.txt
echo ✅ Archivo names.txt creado
echo.

echo 📋 Ejemplo 3: Ordenar contenido
echo Contenido ordenado alfabéticamente:
type names.txt | sort
echo.
echo Contenido ordenado en reversa:
type names.txt | sort /R
echo.

echo 🖼️ Ejemplo 4: Buscar archivos JPG
echo Buscando archivos JPG en Downloads:
dir C:\Users\%username%\Downloads\*.jpg
echo.
echo Alternativa con pipe:
dir C:\Users\%username%\Downloads | find ".jpg"
echo.

echo 📄 Ejemplo 5: Buscar archivos TXT en todo el sistema
echo Buscando archivos TXT (mostrando solo los primeros resultados):
dir c:\ /s /b | find "TXT" | more
echo.

echo 🔧 Ejemplo 6: Buscar procesos específicos
echo Buscando procesos de notepad:
tasklist | find "notepad"
echo.

echo 💡 Los pipes permiten conectar la salida de un comando con la entrada de otro
echo.
pause 