# Script para recuperar archivos eliminados
Write-Host "=== RECUPERACION DE ARCHIVOS ELIMINADOS ===" -ForegroundColor Green

# Parámetros
$DriveLetter = "C"
$SearchPattern = "*.docx"
$RecoveryPath = "C:\Recuperados"

# Crear directorio de recuperación
if (!(Test-Path $RecoveryPath)) {
    New-Item -ItemType Directory -Path $RecoveryPath -Force
}

# Función para recuperar archivos
function Recover-DeletedFiles {
    param($Path, $Pattern, $Destination)
    
    Write-Host "Buscando archivos $Pattern en $Path..." -ForegroundColor Yellow
    
    # Usar Get-ChildItem para buscar archivos eliminados
    $deletedFiles = Get-ChildItem -Path $Path -Recurse -Force | 
                   Where-Object { $_.Name -like $Pattern -and $_.Attributes -match "Hidden" }
    
    foreach ($file in $deletedFiles) {
        $destinationFile = Join-Path $Destination $file.Name
        try {
            Copy-Item $file.FullName -Destination $destinationFile -Force
            Write-Host "Recuperado: $($file.Name)" -ForegroundColor Green
        } catch {
            Write-Host "Error recuperando $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

# Ejecutar recuperación
Recover-DeletedFiles -Path "$DriveLetter`:\" -Pattern $SearchPattern -Destination $RecoveryPath

Write-Host "Recuperación completada. Archivos guardados en: $RecoveryPath" -ForegroundColor Green
