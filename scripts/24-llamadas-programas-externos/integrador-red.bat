@echo off
:: Integrador de herramientas de red
title 🌐 Integrador de Red
color 0E

echo ========================================
echo    🌐 INTEGRADOR DE HERRAMIENTAS DE RED
echo ========================================
echo.

:: Escaneo de red con Nmap
if exist "C:\Program Files (x86)\Nmap\nmap.exe" (
    echo 🔍 Escaneando red local...
    "C:\Program Files (x86)\Nmap\nmap.exe" -sn 192.168.1.0/24 -oN scan_resultado.txt
    
    echo 📋 Resultados del escaneo:
    type scan_resultado.txt
) else (
    echo ⚠️ Nmap no encontrado
)

:: Análisis de tráfico con Wireshark
if exist "C:\Program Files\Wireshark\tshark.exe" (
    echo 📊 Capturando tráfico de red...
    "C:\Program Files\Wireshark\tshark.exe" -i 1 -w captura.pcap -c 100
) else (
    echo ⚠️ Wireshark no encontrado
)

:: Diagnóstico con herramientas nativas + externas
echo 🔧 Diagnóstico de conectividad...
ping google.com
tracert google.com

echo.
pause 