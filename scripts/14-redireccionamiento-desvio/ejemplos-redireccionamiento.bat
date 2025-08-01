@echo off
:: Ejemplos de redireccionamiento y desvío de comandos
echo ========================================
echo   REDIRECCIONAMIENTO Y DESVÍO DE COMANDOS
echo ========================================
echo.

echo 📝 Ejemplo 1: Redireccionar salida a archivo
echo "Curso de AWC - Redireccionamiento" > document.txt
echo ✅ Contenido guardado en document.txt
echo.

echo 📋 Ejemplo 2: Guardar lista de tareas
echo Guardando lista de tareas en tasks.txt...
tasklist > tasks.txt
echo ✅ Lista de tareas guardada
echo.

echo 🔍 Ejemplo 3: Filtrar y guardar procesos
echo Filtrando procesos de firefox...
tasklist | find "firefox" > tasks.txt
echo ✅ Procesos filtrados guardados
echo.

echo 👥 Ejemplo 4: Crear archivo con nombres
echo Creando archivo nombres.txt...
(
echo Antonio
echo Patricia
echo Julia
echo Maria
echo Ernesto
) > nombres.txt
echo ✅ Archivo nombres.txt creado
echo.

echo 📊 Ejemplo 5: Ordenar contenido
echo Ordenando nombres alfabéticamente:
sort < nombres.txt
echo.
echo Guardando nombres ordenados:
sort < nombres.txt > NombresOrdenados.txt
echo ✅ Nombres ordenados guardados
echo.

echo 📄 Ejemplo 6: Anexar contenido
echo Anexando líneas al documento:
echo "Una segunda línea para el documento" >> document.txt
echo "Una tercera línea para el documento" >> document.txt
echo ✅ Líneas anexadas
echo.

echo 🔄 Ejemplo 7: Reemplazar contenido
echo "Reemplazando el contenido del documento" > document.txt
echo ✅ Contenido reemplazado
echo.

echo 💡 Opciones de redireccionamiento disponibles:
echo    ^< archivo     - Lee entrada estándar del archivo
echo    ^> archivo     - Escribe salida estándar en archivo
echo    ^>^> archivo   - Anexa salida estándar al archivo
echo    ^>nul          - Anula la salida
echo    1^> archivo    - Escribe salida estándar en archivo
echo    2^> archivo    - Escribe error estándar en archivo
echo    2^>^&1         - Dirige error a través del mismo flujo
echo.
pause 