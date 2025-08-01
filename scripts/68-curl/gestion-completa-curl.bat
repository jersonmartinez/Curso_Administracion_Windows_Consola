@echo off
setlocal enabledelayedexpansion
title GESTION COMPLETA CON CURL

echo ========================================
echo    GESTION COMPLETA CON CURL
echo ========================================
echo.

:menu_principal
cls
echo ========================================
echo    GESTION COMPLETA CON CURL
echo ========================================
echo.
echo 1. Descarga simple
echo 2. Descarga con verificacion
echo 3. Peticiones HTTP
echo 4. Transferencias FTP
echo 5. Descargas multiples
echo 6. Monitoreo de descargas
echo 7. Generar reportes
echo 8. Salir
echo.
set /p opcion="Seleccione una opcion: "

if "%opcion%"=="1" goto descarga_simple
if "%opcion%"=="2" goto descarga_verificacion
if "%opcion%"=="3" goto peticiones_http
if "%opcion%"=="4" goto transferencias_ftp
if "%opcion%"=="5" goto descargas_multiples
if "%opcion%"=="6" goto monitoreo_descargas
if "%opcion%"=="7" goto generar_reportes
if "%opcion%"=="8" goto salir
goto menu_principal

:descarga_simple
cls
echo ========================================
echo    DESCARGA SIMPLE
echo ========================================
echo.
echo 1. Descarga con nombre original
echo 2. Descarga con nombre personalizado
echo 3. Descarga con seguimiento de redirecciones
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto descarga_nombre_original
if "%subopcion%"=="2" goto descarga_nombre_personalizado
if "%subopcion%"=="3" goto descarga_redirecciones
if "%subopcion%"=="4" goto menu_principal
goto descarga_simple

:descarga_nombre_original
cls
echo === DESCARGA CON NOMBRE ORIGINAL ===
echo.
set /p url="Ingrese la URL del archivo: "
if not "%url%"=="" (
    echo Descargando: %url%
    curl -O "%url%"
    if !errorlevel! equ 0 (
        echo Descarga completada exitosamente.
    ) else (
        echo Error en la descarga.
    )
) else (
    echo URL no valida.
)
pause
goto descarga_simple

:descarga_nombre_personalizado
cls
echo === DESCARGA CON NOMBRE PERSONALIZADO ===
echo.
set /p url="Ingrese la URL del archivo: "
set /p nombre="Ingrese el nombre del archivo: "
if not "%url%"=="" (
    echo Descargando: %url% como %nombre%
    curl -o "%nombre%" "%url%"
    if !errorlevel! equ 0 (
        echo Descarga completada exitosamente.
    ) else (
        echo Error en la descarga.
    )
) else (
    echo URL no valida.
)
pause
goto descarga_simple

:descarga_redirecciones
cls
echo === DESCARGA CON SEGUIMIENTO DE REDIRECCIONES ===
echo.
set /p url="Ingrese la URL del archivo: "
if not "%url%"=="" (
    echo Descargando con seguimiento de redirecciones: %url%
    curl -L -O "%url%"
    if !errorlevel! equ 0 (
        echo Descarga completada exitosamente.
    ) else (
        echo Error en la descarga.
    )
) else (
    echo URL no valida.
)
pause
goto descarga_simple

:descarga_verificacion
cls
echo ========================================
echo    DESCARGA CON VERIFICACION
echo ========================================
echo.
echo 1. Descarga con verificacion de errores
echo 2. Descarga con verificacion SSL
echo 3. Descarga con timeout
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto descarga_verificacion_errores
if "%subopcion%"=="2" goto descarga_verificacion_ssl
if "%subopcion%"=="3" goto descarga_timeout
if "%subopcion%"=="4" goto menu_principal
goto descarga_verificacion

:descarga_verificacion_errores
cls
echo === DESCARGA CON VERIFICACION DE ERRORES ===
echo.
set /p url="Ingrese la URL del archivo: "
set /p nombre="Ingrese el nombre del archivo: "
if not "%url%"=="" (
    echo Descargando con verificacion: %url%
    curl -f -o "%nombre%" "%url%"
    if !errorlevel! equ 0 (
        echo Descarga completada exitosamente.
    ) else (
        echo Error en la descarga (HTTP error).
    )
) else (
    echo URL no valida.
)
pause
goto descarga_verificacion

:descarga_verificacion_ssl
cls
echo === DESCARGA CON VERIFICACION SSL ===
echo.
set /p url="Ingrese la URL del archivo: "
set /p nombre="Ingrese el nombre del archivo: "
if not "%url%"=="" (
    echo Descargando con verificacion SSL: %url%
    curl -k -o "%nombre%" "%url%"
    if !errorlevel! equ 0 (
        echo Descarga completada exitosamente.
    ) else (
        echo Error en la descarga SSL.
    )
) else (
    echo URL no valida.
)
pause
goto descarga_verificacion

:descarga_timeout
cls
echo === DESCARGA CON TIMEOUT ===
echo.
set /p url="Ingrese la URL del archivo: "
set /p nombre="Ingrese el nombre del archivo: "
set /p timeout="Ingrese el timeout en segundos: "
if not "%url%"=="" (
    echo Descargando con timeout %timeout%s: %url%
    curl --connect-timeout %timeout% -o "%nombre%" "%url%"
    if !errorlevel! equ 0 (
        echo Descarga completada exitosamente.
    ) else (
        echo Error en la descarga (timeout).
    )
) else (
    echo URL no valida.
)
pause
goto descarga_verificacion

:peticiones_http
cls
echo ========================================
echo    PETICIONES HTTP
echo ========================================
echo.
echo 1. Peticion GET
echo 2. Peticion POST
echo 3. Peticion con headers
echo 4. Peticion con cookies
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto peticion_get
if "%subopcion%"=="2" goto peticion_post
if "%subopcion%"=="3" goto peticion_headers
if "%subopcion%"=="4" goto peticion_cookies
if "%subopcion%"=="5" goto menu_principal
goto peticiones_http

:peticion_get
cls
echo === PETICION GET ===
echo.
set /p url="Ingrese la URL: "
if not "%url%"=="" (
    echo Realizando peticion GET a: %url%
    curl -X GET "%url%"
    if !errorlevel! equ 0 (
        echo Peticion completada exitosamente.
    ) else (
        echo Error en la peticion.
    )
) else (
    echo URL no valida.
)
pause
goto peticiones_http

:peticion_post
cls
echo === PETICION POST ===
echo.
set /p url="Ingrese la URL: "
set /p datos="Ingrese los datos (JSON): "
if not "%url%"=="" (
    echo Realizando peticion POST a: %url%
    curl -X POST -H "Content-Type: application/json" -d "%datos%" "%url%"
    if !errorlevel! equ 0 (
        echo Peticion completada exitosamente.
    ) else (
        echo Error en la peticion.
    )
) else (
    echo URL no valida.
)
pause
goto peticiones_http

:peticion_headers
cls
echo === PETICION CON HEADERS ===
echo.
set /p url="Ingrese la URL: "
set /p user_agent="Ingrese User-Agent (opcional): "
if not "%url%"=="" (
    echo Realizando peticion con headers a: %url%
    if not "%user_agent%"=="" (
        curl -H "User-Agent: %user_agent%" -H "Accept: application/json" "%url%"
    ) else (
        curl -H "Accept: application/json" "%url%"
    )
    if !errorlevel! equ 0 (
        echo Peticion completada exitosamente.
    ) else (
        echo Error en la peticion.
    )
) else (
    echo URL no valida.
)
pause
goto peticiones_http

:peticion_cookies
cls
echo === PETICION CON COOKIES ===
echo.
set /p url="Ingrese la URL: "
set /p cookie="Ingrese la cookie (nombre=valor): "
if not "%url%"=="" (
    echo Realizando peticion con cookies a: %url%
    curl -b "%cookie%" "%url%"
    if !errorlevel! equ 0 (
        echo Peticion completada exitosamente.
    ) else (
        echo Error en la peticion.
    )
) else (
    echo URL no valida.
)
pause
goto peticiones_http

:transferencias_ftp
cls
echo ========================================
echo    TRANSFERENCIAS FTP
echo ========================================
echo.
echo 1. Descarga desde FTP
echo 2. Subida a FTP
echo 3. Listar directorio FTP
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto descarga_ftp
if "%subopcion%"=="2" goto subida_ftp
if "%subopcion%"=="3" goto listar_ftp
if "%subopcion%"=="4" goto menu_principal
goto transferencias_ftp

:descarga_ftp
cls
echo === DESCARGA DESDE FTP ===
echo.
set /p servidor="Ingrese el servidor FTP: "
set /p usuario="Ingrese el usuario: "
set /p contraseña="Ingrese la contraseña: "
set /p archivo="Ingrese el archivo a descargar: "
if not "%servidor%"=="" (
    echo Descargando desde FTP: %servidor%
    curl -u "%usuario%:%contraseña%" -O "ftp://%servidor%/%archivo%"
    if !errorlevel! equ 0 (
        echo Descarga FTP completada exitosamente.
    ) else (
        echo Error en la descarga FTP.
    )
) else (
    echo Servidor no valido.
)
pause
goto transferencias_ftp

:subida_ftp
cls
echo === SUBIDA A FTP ===
echo.
set /p servidor="Ingrese el servidor FTP: "
set /p usuario="Ingrese el usuario: "
set /p contraseña="Ingrese la contraseña: "
set /p archivo="Ingrese el archivo local a subir: "
if not "%servidor%"=="" (
    if exist "%archivo%" (
        echo Subiendo a FTP: %servidor%
        curl -u "%usuario%:%contraseña%" -T "%archivo%" "ftp://%servidor%/"
        if !errorlevel! equ 0 (
            echo Subida FTP completada exitosamente.
        ) else (
            echo Error en la subida FTP.
        )
    ) else (
        echo Archivo local no encontrado.
    )
) else (
    echo Servidor no valido.
)
pause
goto transferencias_ftp

:listar_ftp
cls
echo === LISTAR DIRECTORIO FTP ===
echo.
set /p servidor="Ingrese el servidor FTP: "
set /p usuario="Ingrese el usuario: "
set /p contraseña="Ingrese la contraseña: "
if not "%servidor%"=="" (
    echo Listando directorio FTP: %servidor%
    curl -u "%usuario%:%contraseña%" "ftp://%servidor%/"
    if !errorlevel! equ 0 (
        echo Listado completado exitosamente.
    ) else (
        echo Error en el listado FTP.
    )
) else (
    echo Servidor no valido.
)
pause
goto transferencias_ftp

:descargas_multiples
cls
echo ========================================
echo    DESCARGAS MULTIPLES
echo ========================================
echo.
echo 1. Descarga desde lista de archivos
echo 2. Descarga con patron de URL
echo 3. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto descarga_lista_archivos
if "%subopcion%"=="2" goto descarga_patron_url
if "%subopcion%"=="3" goto menu_principal
goto descargas_multiples

:descarga_lista_archivos
cls
echo === DESCARGA DESDE LISTA DE ARCHIVOS ===
echo.
set /p archivo_lista="Ingrese el archivo con la lista de URLs: "
if exist "%archivo_lista%" (
    echo Descargando desde lista: %archivo_lista%
    for /f "usebackq delims=" %%u in ("%archivo_lista%") do (
        echo Descargando: %%u
        curl -O "%%u"
        if !errorlevel! equ 0 (
            echo Descarga exitosa: %%u
        ) else (
            echo Error en descarga: %%u
        )
    )
    echo Proceso de descargas multiples completado.
) else (
    echo Archivo de lista no encontrado.
)
pause
goto descargas_multiples

:descarga_patron_url
cls
echo === DESCARGA CON PATRON DE URL ===
echo.
set /p url_base="Ingrese la URL base: "
set /p inicio="Ingrese el numero inicial: "
set /p fin="Ingrese el numero final: "
set /p extension="Ingrese la extension (ej: .txt): "
if not "%url_base%"=="" (
    echo Descargando con patron: %url_base%
    for /l %%i in (%inicio%,1,%fin%) do (
        echo Descargando: %url_base%%%i%extension%
        curl -O "%url_base%%%i%extension%"
        if !errorlevel! equ 0 (
            echo Descarga exitosa: %%i
        ) else (
            echo Error en descarga: %%i
        )
    )
    echo Proceso de descargas con patron completado.
) else (
    echo URL base no valida.
)
pause
goto descargas_multiples

:monitoreo_descargas
cls
echo ========================================
echo    MONITOREO DE DESCARGAS
echo ========================================
echo.
echo 1. Verificar estado de URL
echo 2. Monitorear descarga en tiempo real
echo 3. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto verificar_estado_url
if "%subopcion%"=="2" goto monitorear_descarga_tiempo_real
if "%subopcion%"=="3" goto menu_principal
goto monitoreo_descargas

:verificar_estado_url
cls
echo === VERIFICAR ESTADO DE URL ===
echo.
set /p url="Ingrese la URL a verificar: "
if not "%url%"=="" (
    echo Verificando estado de: %url%
    curl -I "%url%"
    if !errorlevel! equ 0 (
        echo Verificacion completada exitosamente.
    ) else (
        echo Error en la verificacion.
    )
) else (
    echo URL no valida.
)
pause
goto monitoreo_descargas

:monitorear_descarga_tiempo_real
cls
echo === MONITOREO DE DESCARGA EN TIEMPO REAL ===
echo.
set /p url="Ingrese la URL a monitorear: "
set /p nombre="Ingrese el nombre del archivo: "
if not "%url%"=="" (
    echo Monitoreando descarga de: %url%
    curl -# -o "%nombre%" "%url%"
    if !errorlevel! equ 0 (
        echo Descarga completada exitosamente.
    ) else (
        echo Error en la descarga.
    )
) else (
    echo URL no valida.
)
pause
goto monitoreo_descargas

:generar_reportes
cls
echo ========================================
echo    GENERAR REPORTES
echo ========================================
echo.
echo 1. Reporte de descargas
echo 2. Reporte de errores
echo 3. Reporte completo
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto reporte_descargas
if "%subopcion%"=="2" goto reporte_errores
if "%subopcion%"=="3" goto reporte_completo
if "%subopcion%"=="4" goto menu_principal
goto generar_reportes

:reporte_descargas
cls
echo === REPORTE DE DESCARGAS ===
echo.
set "report_file=reporte_descargas_curl_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Descargas CURL - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === ARCHIVOS DESCARGADOS === >> "%report_file%"
dir *.txt *.zip *.pdf *.exe /b >> "%report_file%" 2>nul
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto generar_reportes

:reporte_errores
cls
echo === REPORTE DE ERRORES ===
echo.
set "report_file=reporte_errores_curl_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Errores CURL - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === LOG DE ERRORES === >> "%report_file%"
echo Este reporte puede incluir errores de descargas recientes. >> "%report_file%"
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto generar_reportes

:reporte_completo
cls
echo === REPORTE COMPLETO ===
echo.
set "report_file=reporte_completo_curl_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte Completo CURL - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === INFORMACION DEL SISTEMA === >> "%report_file%"
curl --version >> "%report_file%"
echo. >> "%report_file%"

echo === ARCHIVOS DESCARGADOS === >> "%report_file%"
dir *.txt *.zip *.pdf *.exe /b >> "%report_file%" 2>nul
echo. >> "%report_file%"

echo === ESTADO DE RED === >> "%report_file%"
ping -n 1 8.8.8.8 >> "%report_file%"
echo. >> "%report_file%"

echo Reporte completo generado: %report_file%
pause
goto generar_reportes

:salir
echo Gracias por usar la Gestion Completa con CURL
exit /b 0 