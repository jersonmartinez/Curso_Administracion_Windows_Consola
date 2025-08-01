@echo off
:: Compresor inteligente por tipo de archivo
title 🧠 Compresor Inteligente
color 0A

echo ========================================
echo    🧠 COMPRESOR INTELIGENTE
echo ========================================
echo.

set /p directorio="Directorio a comprimir: "

echo 🔍 Analizando tipos de archivos...
echo.

:: Comprimir archivos de texto (alta compresión)
echo 📝 Comprimiendo archivos de texto...
compact /c /s "%directorio%\*.txt" 2>nul
compact /c /s "%directorio%\*.log" 2>nul
compact /c /s "%directorio%\*.ini" 2>nul

:: Comprimir archivos de código
echo 💻 Comprimiendo archivos de código...
compact /c /s "%directorio%\*.bat" 2>nul
compact /c /s "%directorio%\*.cmd" 2>nul
compact /c /s "%directorio%\*.ps1" 2>nul

:: Comprimir documentos
echo 📄 Comprimiendo documentos...
compact /c /s "%directorio%\*.doc" 2>nul
compact /c /s "%directorio%\*.docx" 2>nul

echo.
echo ✅ Compresión inteligente completada.
echo 💡 Los archivos de imagen y video no se comprimieron (ya optimizados)
pause 