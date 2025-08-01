# Script para crear partición con PowerShell
Write-Host "=== CREANDO PARTICION CON POWERSHELL ===" -ForegroundColor Green
# Obtener el primer disco disponible
$disk = Get-Disk | Where-Object {$_.PartitionStyle -eq "RAW" -or $_.NumberOfPartitions -eq 0} | Select-Object -First 1
if ($disk) {
    # Inicializar disco si es necesario
    if ($disk.PartitionStyle -eq "RAW") {
        Initialize-Disk -Number $disk.DiskNumber -PartitionStyle GPT
        Write-Host "Disco inicializado con GPT" -ForegroundColor Yellow
    }
    # Crear partición
    $partition = New-Partition -DiskNumber $disk.DiskNumber -Size 50GB -AssignDriveLetter
    # Formatear con NTFS
    Format-Volume -DriveLetter $partition.DriveLetter -FileSystem NTFS -NewFileSystemLabel "POWERSHELL_PART" -Confirm:$false
    Write-Host "Particion creada en unidad $($partition.DriveLetter):" -ForegroundColor Green
} else {
    Write-Host "No se encontraron discos disponibles para particionar" -ForegroundColor Red
}
