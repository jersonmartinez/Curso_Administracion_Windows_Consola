@echo off
:: Comparación inteligente con filtros
echo ========================================
echo      🎯 COMPARACIÓN INTELIGENTE
echo ========================================
echo.
echo 🔍 Comparando con filtros inteligentes...
fc archivo1.txt archivo2.txt | findstr /v "comentario\|timestamp"
echo.
echo 💡 Útil para: análisis complejos, filtrado de diferencias
echo.
pause 