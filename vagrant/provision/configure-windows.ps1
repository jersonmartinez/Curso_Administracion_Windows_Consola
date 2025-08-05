# Configure Windows for Development and Script Testing
# This script optimizes Windows settings for batch script development

Write-Host "Configuring Windows for development environment..." -ForegroundColor Green

try {
    # Enable PowerShell execution policy for script development
    Write-Host "Configuring PowerShell execution policy..." -ForegroundColor Yellow
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
    
    # Configure Windows Explorer for better development experience
    Write-Host "Configuring Windows Explorer..." -ForegroundColor Yellow
    
    # Show file extensions
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
    
    # Show hidden files
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1
    
    # Show system files
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 1
    
    # Configure command prompt for better usability
    Write-Host "Configuring command prompt..." -ForegroundColor Yellow
    
    # Enable QuickEdit mode for command prompt
    Set-ItemProperty -Path "HKCU:\Console" -Name "QuickEdit" -Value 1
    
    # Set command prompt colors (dark background, light text)
    Set-ItemProperty -Path "HKCU:\Console" -Name "ColorTable00" -Value 0x00000000
    Set-ItemProperty -Path "HKCU:\Console" -Name "ColorTable07" -Value 0x00C0C0C0
    
    # Configure Windows Update to not restart automatically
    Write-Host "Configuring Windows Update..." -ForegroundColor Yellow
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Value 1 -Type DWord -Force
    
    # Disable Windows Defender real-time protection for development (optional)
    # Uncomment the following lines if you want to disable Windows Defender for testing
    # Write-Host "Disabling Windows Defender real-time protection..." -ForegroundColor Yellow
    # Set-MpPreference -DisableRealtimeMonitoring $true
    
    # Configure performance options
    Write-Host "Configuring performance options..." -ForegroundColor Yellow
    
    # Set visual effects to performance
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2
    
    # Disable animations
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0
    
    # Configure power settings for better performance
    Write-Host "Configuring power settings..." -ForegroundColor Yellow
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c  # High Performance
    
    # Create desktop shortcuts for common tools
    Write-Host "Creating desktop shortcuts..." -ForegroundColor Yellow
    
    $desktopPath = [Environment]::GetFolderPath("Desktop")
    
    # Create shortcut to BatchScripts folder
    $wshShell = New-Object -ComObject WScript.Shell
    $shortcut = $wshShell.CreateShortcut("$desktopPath\BatchScripts.lnk")
    $shortcut.TargetPath = "C:\BatchScripts"
    $shortcut.Description = "Open Batch Scripts folder"
    $shortcut.Save()
    
    # Create shortcut to Command Prompt
    $shortcut = $wshShell.CreateShortcut("$desktopPath\Command Prompt.lnk")
    $shortcut.TargetPath = "cmd.exe"
    $shortcut.WorkingDirectory = "C:\BatchScripts"
    $shortcut.Description = "Open Command Prompt in BatchScripts folder"
    $shortcut.Save()
    
    # Create shortcut to PowerShell
    $shortcut = $wshShell.CreateShortcut("$desktopPath\PowerShell.lnk")
    $shortcut.TargetPath = "powershell.exe"
    $shortcut.WorkingDirectory = "C:\BatchScripts"
    $shortcut.Description = "Open PowerShell in BatchScripts folder"
    $shortcut.Save()
    
    Write-Host "Windows configuration completed successfully!" -ForegroundColor Green
    
} catch {
    Write-Host "Error during Windows configuration: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Some settings may not have been applied." -ForegroundColor Yellow
} 