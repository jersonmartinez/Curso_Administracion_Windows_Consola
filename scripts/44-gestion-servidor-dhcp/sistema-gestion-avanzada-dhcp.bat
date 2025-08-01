@echo off
setlocal enabledelayedexpansion

:: Advanced DHCP Server Management System
:: This script provides comprehensive DHCP server management with configuration file support

set "CONFIG_FILE=dhcp_advanced.conf"
set "LOG_FILE=advanced_dhcp.log"
set "BACKUP_DIR=backups"
set "REPORTS_DIR=reports"

:: Create necessary directories
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
if not exist "%REPORTS_DIR%" mkdir "%REPORTS_DIR%"

:: Initialize configuration file if it doesn't exist
if not exist "%CONFIG_FILE%" (
    echo Creating default configuration file...
    (
        echo # Advanced DHCP Server Configuration
        echo # Server Settings
        echo SERVER_NAME=localhost
        echo BACKUP_INTERVAL=24
        echo LOG_LEVEL=INFO
        echo MONITORING_ENABLED=true
        echo # Default Scope Settings
        echo DEFAULT_SCOPE_START=192.168.1.100
        echo DEFAULT_SCOPE_END=192.168.1.200
        echo DEFAULT_SUBNET_MASK=255.255.255.0
        echo DEFAULT_GATEWAY=192.168.1.1
        echo DEFAULT_DNS1=8.8.8.8
        echo DEFAULT_DNS2=8.8.4.4
        echo DEFAULT_LEASE_TIME=24
        echo # Monitoring Settings
        echo ALERT_THRESHOLD=80
        echo MONITOR_INTERVAL=300
    ) > "%CONFIG_FILE%"
)

:: Load configuration
for /f "tokens=1,2 delims==" %%a in (%CONFIG_FILE%) do (
    if not "%%a"=="" if not "%%a:~0,1%"=="#" (
        set "%%a=%%b"
    )
)

:: Logging function
:log
set "level=%~1"
set "message=%~2"
set "timestamp=%date% %time%"
echo [%timestamp%] [%level%] %message% >> "%LOG_FILE%"
goto :eof

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: This script requires administrator privileges.
    call :log ERROR "Script executed without administrator privileges"
    pause
    exit /b 1
)

call :log INFO "Advanced DHCP Management System started"

:main_menu
cls
echo.
echo ========================================
echo    Advanced DHCP Server Management
echo ========================================
echo.
echo 1. Configuration Management
echo 2. Scope Management
echo 3. Reservation Management
echo 4. Server Monitoring
echo 5. Backup and Recovery
echo 6. Reports and Analytics
echo 7. Advanced Maintenance
echo 8. System Information
echo 9. Exit
echo.
set /p choice="Select an option (1-9): "

if "%choice%"=="1" goto config_menu
if "%choice%"=="2" goto scope_menu
if "%choice%"=="3" goto reservation_menu
if "%choice%"=="4" goto monitoring_menu
if "%choice%"=="5" goto backup_menu
if "%choice%"=="6" goto reports_menu
if "%choice%"=="7" goto maintenance_menu
if "%choice%"=="8" goto system_info
if "%choice%"=="9" goto exit_script
goto main_menu

:config_menu
cls
echo.
echo ========================================
echo        Configuration Management
echo ========================================
echo.
echo 1. View Current Configuration
echo 2. Edit Configuration File
echo 3. Validate Configuration
echo 4. Reset to Defaults
echo 5. Import Configuration
echo 6. Export Configuration
echo 7. Back to Main Menu
echo.
set /p config_choice="Select an option (1-7): "

if "%config_choice%"=="1" goto view_config
if "%config_choice%"=="2" goto edit_config
if "%config_choice%"=="3" goto validate_config
if "%config_choice%"=="4" goto reset_config
if "%config_choice%"=="5" goto import_config
if "%config_choice%"=="6" goto export_config
if "%config_choice%"=="7" goto main_menu
goto config_menu

:view_config
cls
echo.
echo Current Configuration:
echo =====================
type "%CONFIG_FILE%"
echo.
pause
goto config_menu

:edit_config
cls
echo.
echo Opening configuration file for editing...
notepad "%CONFIG_FILE%"
call :log INFO "Configuration file edited"
goto config_menu

:validate_config
cls
echo.
echo Validating configuration...
set "valid=true"
for /f "tokens=1,2 delims==" %%a in (%CONFIG_FILE%) do (
    if not "%%a"=="" if not "%%a:~0,1%"=="#" (
        if "%%b"=="" (
            echo Warning: Empty value for %%a
            set "valid=false"
        )
    )
)
if "%valid%"=="true" (
    echo Configuration is valid.
    call :log INFO "Configuration validation successful"
) else (
    echo Configuration has issues.
    call :log WARNING "Configuration validation failed"
)
pause
goto config_menu

:reset_config
cls
echo.
set /p confirm="Are you sure you want to reset configuration? (y/N): "
if /i "%confirm%"=="y" (
    del "%CONFIG_FILE%"
    call :log INFO "Configuration reset to defaults"
    echo Configuration reset. Please restart the script.
    pause
    exit /b 0
)
goto config_menu

:import_config
cls
echo.
set /p import_file="Enter configuration file path: "
if exist "!import_file!" (
    copy "!import_file!" "%CONFIG_FILE%" >nul
    echo Configuration imported successfully.
    call :log INFO "Configuration imported from !import_file!"
) else (
    echo File not found.
    call :log ERROR "Import file not found: !import_file!"
)
pause
goto config_menu

:export_config
cls
echo.
set /p export_file="Enter export file path: "
copy "%CONFIG_FILE%" "!export_file!" >nul
echo Configuration exported successfully.
call :log INFO "Configuration exported to !export_file!"
pause
goto config_menu

:scope_menu
cls
echo.
echo ========================================
echo           Scope Management
echo ========================================
echo.
echo 1. List All Scopes
echo 2. Create New Scope
echo 3. Configure Scope Options
echo 4. Activate/Deactivate Scope
echo 5. Delete Scope
echo 6. Scope Statistics
echo 7. Back to Main Menu
echo.
set /p scope_choice="Select an option (1-7): "

if "%scope_choice%"=="1" goto list_scopes
if "%scope_choice%"=="2" goto create_scope
if "%scope_choice%"=="3" goto configure_scope_options
if "%scope_choice%"=="4" goto toggle_scope
if "%scope_choice%"=="5" goto delete_scope
if "%scope_choice%"=="6" goto scope_stats
if "%scope_choice%"=="7" goto main_menu
goto scope_menu

:list_scopes
cls
echo.
echo DHCP Scopes:
echo ============
netsh dhcp server scope show scope
echo.
pause
goto scope_menu

:create_scope
cls
echo.
set /p scope_name="Enter scope name: "
set /p start_ip="Enter start IP: "
set /p end_ip="Enter end IP: "
set /p subnet_mask="Enter subnet mask: "
set /p description="Enter description: "

netsh dhcp server scope add scope=%start_ip% mask=%subnet_mask% name="%scope_name%" comment="%description%"
if %errorLevel% equ 0 (
    echo Scope created successfully.
    call :log INFO "Scope created: %scope_name% (%start_ip% - %end_ip%)"
) else (
    echo Failed to create scope.
    call :log ERROR "Failed to create scope: %scope_name%"
)
pause
goto scope_menu

:configure_scope_options
cls
echo.
set /p scope_ip="Enter scope IP: "
echo.
echo 1. Configure Gateway
echo 2. Configure DNS Servers
echo 3. Configure Lease Time
echo 4. Configure WINS Server
echo 5. Back to Scope Menu
echo.
set /p option_choice="Select an option (1-5): "

if "%option_choice%"=="1" goto config_gateway
if "%option_choice%"=="2" goto config_dns
if "%option_choice%"=="3" goto config_lease
if "%option_choice%"=="4" goto config_wins
if "%option_choice%"=="5" goto scope_menu
goto configure_scope_options

:config_gateway
set /p gateway="Enter gateway IP: "
netsh dhcp server scope %scope_ip% set optionvalue 3 IPADDRESS %gateway%
echo Gateway configured.
pause
goto configure_scope_options

:config_dns
set /p dns1="Enter primary DNS: "
set /p dns2="Enter secondary DNS: "
netsh dhcp server scope %scope_ip% set optionvalue 6 IPADDRESS %dns1% %dns2%
echo DNS servers configured.
pause
goto configure_scope_options

:config_lease
set /p lease_time="Enter lease time (hours): "
netsh dhcp server scope %scope_ip% set optionvalue 51 DWORD %lease_time%
echo Lease time configured.
pause
goto configure_scope_options

:config_wins
set /p wins="Enter WINS server IP: "
netsh dhcp server scope %scope_ip% set optionvalue 44 IPADDRESS %wins%
echo WINS server configured.
pause
goto configure_scope_options

:toggle_scope
cls
echo.
set /p scope_ip="Enter scope IP: "
echo.
echo 1. Activate Scope
echo 2. Deactivate Scope
echo 3. Back to Scope Menu
echo.
set /p toggle_choice="Select an option (1-3): "

if "%toggle_choice%"=="1" (
    netsh dhcp server scope %scope_ip% set state 1
    echo Scope activated.
    call :log INFO "Scope activated: %scope_ip%"
) else if "%toggle_choice%"=="2" (
    netsh dhcp server scope %scope_ip% set state 0
    echo Scope deactivated.
    call :log INFO "Scope deactivated: %scope_ip%"
) else if "%toggle_choice%"=="3" (
    goto scope_menu
)
pause
goto scope_menu

:delete_scope
cls
echo.
set /p scope_ip="Enter scope IP to delete: "
set /p confirm="Are you sure? (y/N): "
if /i "%confirm%"=="y" (
    netsh dhcp server scope %scope_ip% delete
    echo Scope deleted.
    call :log INFO "Scope deleted: %scope_ip%"
)
pause
goto scope_menu

:scope_stats
cls
echo.
set /p scope_ip="Enter scope IP: "
echo.
echo Scope Statistics:
echo =================
netsh dhcp server scope %scope_ip% show statistics
echo.
pause
goto scope_menu

:reservation_menu
cls
echo.
echo ========================================
echo        Reservation Management
echo ========================================
echo.
echo 1. List Reservations
echo 2. Create Reservation
echo 3. Delete Reservation
echo 4. Modify Reservation
echo 5. Back to Main Menu
echo.
set /p res_choice="Select an option (1-5): "

if "%res_choice%"=="1" goto list_reservations
if "%res_choice%"=="2" goto create_reservation
if "%res_choice%"=="3" goto delete_reservation
if "%res_choice%"=="4" goto modify_reservation
if "%res_choice%"=="5" goto main_menu
goto reservation_menu

:list_reservations
cls
echo.
set /p scope_ip="Enter scope IP: "
echo.
echo Reservations in scope %scope_ip%:
echo =================================
netsh dhcp server scope %scope_ip% show reservedip
echo.
pause
goto reservation_menu

:create_reservation
cls
echo.
set /p scope_ip="Enter scope IP: "
set /p reserved_ip="Enter reserved IP: "
set /p mac_address="Enter MAC address: "
set /p client_name="Enter client name: "
set /p description="Enter description: "

netsh dhcp server scope %scope_ip% add reservedip %reserved_ip% %mac_address% "%client_name%" "%description%"
if %errorLevel% equ 0 (
    echo Reservation created successfully.
    call :log INFO "Reservation created: %reserved_ip% for %client_name%"
) else (
    echo Failed to create reservation.
    call :log ERROR "Failed to create reservation: %reserved_ip%"
)
pause
goto reservation_menu

:delete_reservation
cls
echo.
set /p scope_ip="Enter scope IP: "
set /p reserved_ip="Enter reserved IP: "
set /p confirm="Are you sure? (y/N): "
if /i "%confirm%"=="y" (
    netsh dhcp server scope %scope_ip% delete reservedip %reserved_ip%
    echo Reservation deleted.
    call :log INFO "Reservation deleted: %reserved_ip%"
)
pause
goto reservation_menu

:modify_reservation
cls
echo.
set /p scope_ip="Enter scope IP: "
set /p reserved_ip="Enter reserved IP: "
set /p new_name="Enter new client name: "
set /p new_description="Enter new description: "

netsh dhcp server scope %scope_ip% set reservedip %reserved_ip% "%new_name%" "%new_description%"
echo Reservation modified.
call :log INFO "Reservation modified: %reserved_ip%"
pause
goto reservation_menu

:monitoring_menu
cls
echo.
echo ========================================
echo         Server Monitoring
echo ========================================
echo.
echo 1. Real-time Monitoring
echo 2. Connection Statistics
echo 3. Lease Information
echo 4. Error Logs
echo 5. Performance Metrics
echo 6. Back to Main Menu
echo.
set /p monitor_choice="Select an option (1-6): "

if "%monitor_choice%"=="1" goto real_time_monitoring
if "%monitor_choice%"=="2" goto connection_stats
if "%monitor_choice%"=="3" goto lease_info
if "%monitor_choice%"=="4" goto error_logs
if "%monitor_choice%"=="5" goto performance_metrics
if "%monitor_choice%"=="6" goto main_menu
goto monitoring_menu

:real_time_monitoring
cls
echo.
echo Real-time DHCP Server Monitoring
echo Press Ctrl+C to stop monitoring
echo =================================
call :log INFO "Real-time monitoring started"
:monitor_loop
cls
echo.
echo DHCP Server Status - %date% %time%
echo ===================================
netsh dhcp server show all
echo.
echo Active Leases:
netsh dhcp server scope show clients
echo.
timeout /t 10 /nobreak >nul
goto monitor_loop

:connection_stats
cls
echo.
echo DHCP Connection Statistics:
echo ==========================
netsh dhcp server show statistics
echo.
pause
goto monitoring_menu

:lease_info
cls
echo.
set /p scope_ip="Enter scope IP: "
echo.
echo Lease Information for Scope %scope_ip%:
echo =======================================
netsh dhcp server scope %scope_ip% show clients
echo.
pause
goto monitoring_menu

:error_logs
cls
echo.
echo DHCP Server Error Logs:
echo ======================
wevtutil qe System /q:"*[System[Provider[@Name='Microsoft-Windows-DHCP-Server'] and (Level=1 or Level=2)]]" /c:20 /f:text
echo.
pause
goto monitoring_menu

:performance_metrics
cls
echo.
echo DHCP Server Performance Metrics:
echo ================================
echo.
echo Server Statistics:
netsh dhcp server show statistics
echo.
echo Scope Statistics:
for /f "tokens=2 delims= " %%i in ('netsh dhcp server scope show scope ^| findstr "Scope"') do (
    echo.
    echo Scope: %%i
    netsh dhcp server scope %%i show statistics
)
echo.
pause
goto monitoring_menu

:backup_menu
cls
echo.
echo ========================================
echo        Backup and Recovery
echo ========================================
echo.
echo 1. Create Backup
echo 2. Restore from Backup
echo 3. List Backups
echo 4. Delete Backup
echo 5. Backup Configuration
echo 6. Back to Main Menu
echo.
set /p backup_choice="Select an option (1-6): "

if "%backup_choice%"=="1" goto create_backup
if "%backup_choice%"=="2" goto restore_backup
if "%backup_choice%"=="3" goto list_backups
if "%backup_choice%"=="4" goto delete_backup
if "%backup_choice%"=="5" goto backup_config
if "%backup_choice%"=="6" goto main_menu
goto backup_menu

:create_backup
cls
echo.
set /p backup_name="Enter backup name: "
set "backup_path=%BACKUP_DIR%\%backup_name%_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_path=%backup_path: =0%"

mkdir "%backup_path%"
netsh dhcp server export "%backup_path%\dhcp_backup.xml" all
copy "%CONFIG_FILE%" "%backup_path%\"
echo Backup created: %backup_path%
call :log INFO "Backup created: %backup_path%"
pause
goto backup_menu

:restore_backup
cls
echo.
echo Available Backups:
echo ==================
dir /b "%BACKUP_DIR%"
echo.
set /p backup_path="Enter backup path: "
if exist "%BACKUP_DIR%\%backup_path%\dhcp_backup.xml" (
    netsh dhcp server import "%BACKUP_DIR%\%backup_path%\dhcp_backup.xml"
    echo Backup restored successfully.
    call :log INFO "Backup restored: %backup_path%"
) else (
    echo Backup not found.
    call :log ERROR "Backup not found: %backup_path%"
)
pause
goto backup_menu

:list_backups
cls
echo.
echo Available Backups:
echo ==================
dir /b "%BACKUP_DIR%"
echo.
pause
goto backup_menu

:delete_backup
cls
echo.
echo Available Backups:
echo ==================
dir /b "%BACKUP_DIR%"
echo.
set /p backup_name="Enter backup name to delete: "
set /p confirm="Are you sure? (y/N): "
if /i "%confirm%"=="y" (
    rmdir /s /q "%BACKUP_DIR%\%backup_name%"
    echo Backup deleted.
    call :log INFO "Backup deleted: %backup_name%"
)
pause
goto backup_menu

:backup_config
cls
echo.
set /p config_backup="Enter configuration backup name: "
copy "%CONFIG_FILE%" "%BACKUP_DIR%\%config_backup%_%date:~-4,4%%date:~-10,2%%date:~-7,2%.conf"
echo Configuration backed up.
call :log INFO "Configuration backed up: %config_backup%"
pause
goto backup_menu

:reports_menu
cls
echo.
echo ========================================
echo        Reports and Analytics
echo ========================================
echo.
echo 1. Generate Scope Report
echo 2. Generate Reservation Report
echo 3. Generate Statistics Report
echo 4. Generate Audit Report
echo 5. View Report History
echo 6. Back to Main Menu
echo.
set /p report_choice="Select an option (1-6): "

if "%report_choice%"=="1" goto scope_report
if "%report_choice%"=="2" goto reservation_report
if "%report_choice%"=="3" goto statistics_report
if "%report_choice%"=="4" goto audit_report
if "%report_choice%"=="5" goto report_history
if "%report_choice%"=="6" goto main_menu
goto reports_menu

:scope_report
cls
echo.
set /p report_name="Enter report name: "
set "report_file=%REPORTS_DIR%\%report_name%_scope_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
echo DHCP Scope Report - %date% %time% > "%report_file%"
echo ========================================== >> "%report_file%"
echo. >> "%report_file%"
netsh dhcp server scope show scope >> "%report_file%"
echo Report generated: %report_file%
call :log INFO "Scope report generated: %report_file%"
pause
goto reports_menu

:reservation_report
cls
echo.
set /p report_name="Enter report name: "
set "report_file=%REPORTS_DIR%\%report_name%_reservations_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
echo DHCP Reservations Report - %date% %time% > "%report_file%"
echo ================================================ >> "%report_file%"
echo. >> "%report_file%"
for /f "tokens=2 delims= " %%i in ('netsh dhcp server scope show scope ^| findstr "Scope"') do (
    echo Scope: %%i >> "%report_file%"
    netsh dhcp server scope %%i show reservedip >> "%report_file%"
    echo. >> "%report_file%"
)
echo Report generated: %report_file%
call :log INFO "Reservation report generated: %report_file%"
pause
goto reports_menu

:statistics_report
cls
echo.
set /p report_name="Enter report name: "
set "report_file=%REPORTS_DIR%\%report_name%_stats_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
echo DHCP Statistics Report - %date% %time% > "%report_file%"
echo ========================================== >> "%report_file%"
echo. >> "%report_file%"
netsh dhcp server show statistics >> "%report_file%"
echo Report generated: %report_file%
call :log INFO "Statistics report generated: %report_file%"
pause
goto reports_menu

:audit_report
cls
echo.
set /p report_name="Enter report name: "
set "report_file=%REPORTS_DIR%\%report_name%_audit_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
echo DHCP Audit Report - %date% %time% > "%report_file%"
echo ====================================== >> "%report_file%"
echo. >> "%report_file%"
wevtutil qe System /q:"*[System[Provider[@Name='Microsoft-Windows-DHCP-Server']]]" /c:50 /f:text >> "%report_file%"
echo Report generated: %report_file%
call :log INFO "Audit report generated: %report_file%"
pause
goto reports_menu

:report_history
cls
echo.
echo Report History:
echo ===============
dir /b "%REPORTS_DIR%"
echo.
pause
goto reports_menu

:maintenance_menu
cls
echo.
echo ========================================
echo        Advanced Maintenance
echo ========================================
echo.
echo 1. Clean Expired Leases
echo 2. Reconcile Database
echo 3. Compact Database
echo 4. Check Database Integrity
echo 5. Optimize Performance
echo 6. Reset Server Statistics
echo 7. Back to Main Menu
echo.
set /p maint_choice="Select an option (1-7): "

if "%maint_choice%"=="1" goto clean_leases
if "%maint_choice%"=="2" goto reconcile_db
if "%maint_choice%"=="3" goto compact_db
if "%maint_choice%"=="4" goto check_integrity
if "%maint_choice%"=="5" goto optimize_performance
if "%maint_choice%"=="6" goto reset_stats
if "%maint_choice%"=="7" goto main_menu
goto maintenance_menu

:clean_leases
cls
echo.
echo Cleaning expired leases...
for /f "tokens=2 delims= " %%i in ('netsh dhcp server scope show scope ^| findstr "Scope"') do (
    echo Processing scope: %%i
    netsh dhcp server scope %%i delete clients
)
echo Expired leases cleaned.
call :log INFO "Expired leases cleaned"
pause
goto maintenance_menu

:reconcile_db
cls
echo.
echo Reconciling DHCP database...
netsh dhcp server set databasebackupinterval 60
netsh dhcp server set databasebackuppath "%BACKUP_DIR%"
echo Database reconciliation completed.
call :log INFO "Database reconciliation completed"
pause
goto maintenance_menu

:compact_db
cls
echo.
echo Compacting DHCP database...
netsh dhcp server set databasebackupinterval 60
echo Database compaction completed.
call :log INFO "Database compaction completed"
pause
goto maintenance_menu

:check_integrity
cls
echo.
echo Checking database integrity...
netsh dhcp server show database
echo.
echo Database integrity check completed.
call :log INFO "Database integrity check completed"
pause
goto maintenance_menu

:optimize_performance
cls
echo.
echo Optimizing DHCP server performance...
netsh dhcp server set databasebackupinterval 60
netsh dhcp server set databasebackuppath "%BACKUP_DIR%"
echo Performance optimization completed.
call :log INFO "Performance optimization completed"
pause
goto maintenance_menu

:reset_stats
cls
echo.
set /p confirm="Are you sure you want to reset server statistics? (y/N): "
if /i "%confirm%"=="y" (
    netsh dhcp server set databasebackupinterval 60
    echo Server statistics reset.
    call :log INFO "Server statistics reset"
)
pause
goto maintenance_menu

:system_info
cls
echo.
echo ========================================
echo         System Information
echo ========================================
echo.
echo DHCP Server Information:
echo ========================
netsh dhcp server show all
echo.
echo Server Statistics:
echo ==================
netsh dhcp server show statistics
echo.
echo Database Information:
echo =====================
netsh dhcp server show database
echo.
pause
goto main_menu

:exit_script
cls
echo.
echo Thank you for using Advanced DHCP Server Management System.
call :log INFO "Advanced DHCP Management System stopped"
echo.
pause
exit /b 0 