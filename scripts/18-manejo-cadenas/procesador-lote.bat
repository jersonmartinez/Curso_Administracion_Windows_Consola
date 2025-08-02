@echo off
:: Procesar múltiples archivos
echo ========================================
echo        PROCESADOR DE LOTE
echo ========================================
echo.
echo 🔍 Procesando archivos en el directorio actual...
echo.

for %%f in (*.txt) do (
    echo 📄 Archivo: %%f
    echo 📝 Nombre: %%~nf
    echo 🔍 Extensión: %%~xf
    echo 🛤️ Ruta completa: %%~ff
    echo.
)
echo 💡 Útil para: inventarios, reportes, procesamiento masivo
echo.
pause 