# Script para extender volumen con PowerShell
Write-Host "=== EXTENDER VOLUMEN CON POWERSHELL ===" -ForegroundColor Green
# Parámetros
$DriveLetter = "D"
$SizeToAdd = 50GB
# Obtener la partición
$partition = Get-Partition -DriveLetter $DriveLetter
if ($partition) {
    # Verificar espacio disponible
    $disk = Get-Disk -Number $partition.DiskNumber
    $freeSpace = $disk.Size - $disk.AllocatedSize
    if ($freeSpace -ge $SizeToAdd) {
        # Extender la partición
        $newSize = $partition.Size + $SizeToAdd
        Resize-Partition -DriveLetter $DriveLetter -Size $newSize
        Write-Host "Volumen $DriveLetter`: extendido en $($SizeToAdd/1GB) GB" -ForegroundColor Green
        # Verificar resultado
        $updatedPartition = Get-Partition -DriveLetter $DriveLetter
        Write-Host "Nuevo tamaño: $($updatedPartition.Size/1GB) GB" -ForegroundColor Yellow
    } else {
        Write-Host "ERROR: Espacio insuficiente. Disponible: $($freeSpace/1GB) GB" -ForegroundColor Red
    }
} else {
    Write-Host "ERROR: Volumen $DriveLetter`: no encontrado" -ForegroundColor Red
}
