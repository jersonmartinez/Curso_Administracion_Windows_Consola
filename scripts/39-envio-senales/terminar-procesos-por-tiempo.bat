@echo off
echo Terminando procesos por tiempo de ejecución...
set /p tiempo="Tiempo máximo en minutos: "
for /f "tokens=2" %%a in ('tasklist /FI "CPUTIME gt %tiempo%:00" /FO CSV') do (
    echo Terminando proceso %%a (tiempo excedido)
    taskkill /PID %%a /F
)
echo Procesos con tiempo excedido terminados
pause 