# Install VirtualBox Guest Additions
# This script installs VirtualBox Guest Additions for better VM performance

Write-Host "Installing VirtualBox Guest Additions..." -ForegroundColor Green

try {
    # Check if Guest Additions are already installed
    $guestAdditionsPath = "C:\Program Files\Oracle\VirtualBox Guest Additions"
    if (Test-Path $guestAdditionsPath) {
        Write-Host "VirtualBox Guest Additions already installed." -ForegroundColor Yellow
        exit 0
    }
    
    # Look for VirtualBox Guest Additions ISO
    Write-Host "Looking for VirtualBox Guest Additions ISO..." -ForegroundColor Yellow
    
    # Check for mounted CD-ROM with Guest Additions
    $cdDrive = Get-Volume | Where-Object { $_.DriveType -eq "CD-ROM" } | Select-Object -First 1
    
    if ($cdDrive) {
        $isoPath = $cdDrive.DriveLetter + ":\"
        Write-Host "Found Guest Additions at: $isoPath" -ForegroundColor Yellow
        
        # Check if VBoxWindowsAdditions.exe exists
        $installerPath = Join-Path $isoPath "VBoxWindowsAdditions.exe"
        if (Test-Path $installerPath) {
            Write-Host "Installing Guest Additions..." -ForegroundColor Yellow
            
            # Install with silent mode and auto-reboot
            $process = Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait -PassThru
            
            if ($process.ExitCode -eq 0) {
                Write-Host "VirtualBox Guest Additions installed successfully!" -ForegroundColor Green
            } else {
                Write-Host "Installation completed with exit code: $($process.ExitCode)" -ForegroundColor Yellow
            }
        } else {
            Write-Host "VBoxWindowsAdditions.exe not found in CD-ROM drive." -ForegroundColor Red
        }
    } else {
        # Try to mount the ISO from VirtualBox installation
        Write-Host "No CD-ROM drive found, attempting to mount VirtualBox ISO..." -ForegroundColor Yellow
        
        $vboxPath = "C:\Program Files\Oracle\VirtualBox"
        $isoFile = Join-Path $vboxPath "VBoxGuestAdditions.iso"
        
        if (Test-Path $isoFile) {
            Write-Host "Mounting VirtualBox Guest Additions ISO..." -ForegroundColor Yellow
            Mount-DiskImage -ImagePath $isoFile
            
            # Wait a moment for the mount to complete
            Start-Sleep -Seconds 3
            
            # Try to find the newly mounted drive
            $cdDrive = Get-Volume | Where-Object { $_.DriveType -eq "CD-ROM" } | Select-Object -First 1
            
            if ($cdDrive) {
                $installerPath = Join-Path ($cdDrive.DriveLetter + ":\") "VBoxWindowsAdditions.exe"
                if (Test-Path $installerPath) {
                    Write-Host "Installing Guest Additions from mounted ISO..." -ForegroundColor Yellow
                    $process = Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait -PassThru
                    
                    if ($process.ExitCode -eq 0) {
                        Write-Host "VirtualBox Guest Additions installed successfully!" -ForegroundColor Green
                    } else {
                        Write-Host "Installation completed with exit code: $($process.ExitCode)" -ForegroundColor Yellow
                    }
                }
            }
        } else {
            Write-Host "VirtualBox Guest Additions ISO not found at: $isoFile" -ForegroundColor Red
            Write-Host "Guest Additions installation skipped. VM will work but with limited features." -ForegroundColor Yellow
        }
    }
    
} catch {
    Write-Host "Error during Guest Additions installation: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "VM will work without Guest Additions, but with limited features." -ForegroundColor Yellow
} 