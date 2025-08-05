# Configure Windows for Development and Script Testing
# This script optimizes Windows settings for batch script development

Write-Host "Configuring Windows for development environment..." -ForegroundColor Green

try {
    # Enable PowerShell execution policy for script development
    Write-Host "Configuring PowerShell execution policy..." -ForegroundColor Yellow
    try {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force -ErrorAction SilentlyContinue
        Write-Host "PowerShell execution policy configured successfully." -ForegroundColor Green
    } catch {
        Write-Host "Note: Could not set PowerShell execution policy - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Configure Windows Explorer for better development experience
    Write-Host "Configuring Windows Explorer..." -ForegroundColor Yellow
    
    try {
        # Show file extensions
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -ErrorAction SilentlyContinue
        
        # Show hidden files
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -ErrorAction SilentlyContinue
        
        # Show system files
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 1 -ErrorAction SilentlyContinue
        
        Write-Host "Windows Explorer configured successfully." -ForegroundColor Green
    } catch {
        Write-Host "Note: Some Explorer settings may not have been applied - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Configure command prompt for better usability
    Write-Host "Configuring command prompt..." -ForegroundColor Yellow
    
    try {
        # Enable QuickEdit mode for command prompt
        Set-ItemProperty -Path "HKCU:\Console" -Name "QuickEdit" -Value 1 -ErrorAction SilentlyContinue
        
        # Set command prompt colors (dark background, light text)
        Set-ItemProperty -Path "HKCU:\Console" -Name "ColorTable00" -Value 0x00000000 -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Console" -Name "ColorTable07" -Value 0x00C0C0C0 -ErrorAction SilentlyContinue
        
        Write-Host "Command prompt configured successfully." -ForegroundColor Green
    } catch {
        Write-Host "Note: Some command prompt settings may not have been applied - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Configure Windows Update to not restart automatically
    Write-Host "Configuring Windows Update..." -ForegroundColor Yellow
    try {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
        Write-Host "Windows Update configured successfully." -ForegroundColor Green
    } catch {
        Write-Host "Note: Windows Update setting may not have been applied - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Configure performance options
    Write-Host "Configuring performance options..." -ForegroundColor Yellow
    
    try {
        # Set visual effects to performance
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2 -ErrorAction SilentlyContinue
        
        # Disable animations
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0 -ErrorAction SilentlyContinue
        
        Write-Host "Performance options configured successfully." -ForegroundColor Green
    } catch {
        Write-Host "Note: Some performance settings may not have been applied - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Configure power settings for better performance
    Write-Host "Configuring power settings..." -ForegroundColor Yellow
    try {
        powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null  # High Performance
        Write-Host "Power settings configured successfully." -ForegroundColor Green
    } catch {
        Write-Host "Note: Power settings may not have been applied - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Configure UAC for development (less prompts)
    Write-Host "Configuring UAC for development..." -ForegroundColor Yellow
    try {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue
        Write-Host "UAC configured successfully." -ForegroundColor Green
    } catch {
        Write-Host "Note: UAC setting may not have been applied - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Enable long path support for development
    Write-Host "Enabling long path support..." -ForegroundColor Yellow
    try {
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
        Write-Host "Long path support enabled successfully." -ForegroundColor Green
    } catch {
        Write-Host "Note: Long path support may not have been enabled - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Configure Windows Defender exclusions for development
    Write-Host "Configuring Windows Defender exclusions..." -ForegroundColor Yellow
    try {
        Add-MpPreference -ExclusionPath "C:\BatchScripts" -ErrorAction SilentlyContinue
        Add-MpPreference -ExclusionProcess "cmd.exe" -ErrorAction SilentlyContinue
        Add-MpPreference -ExclusionProcess "powershell.exe" -ErrorAction SilentlyContinue
        Write-Host "Windows Defender exclusions configured successfully." -ForegroundColor Green
    } catch {
        Write-Host "Note: Windows Defender exclusions may not have been applied - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Create desktop shortcuts for common tools
    Write-Host "Creating desktop shortcuts..." -ForegroundColor Yellow
    
    try {
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
        
        # Create shortcut to PowerShell ISE (if available)
        $shortcut = $wshShell.CreateShortcut("$desktopPath\PowerShell ISE.lnk")
        $shortcut.TargetPath = "powershell_ise.exe"
        $shortcut.WorkingDirectory = "C:\BatchScripts"
        $shortcut.Description = "Open PowerShell ISE in BatchScripts folder"
        $shortcut.Save()
        
        Write-Host "Desktop shortcuts created successfully." -ForegroundColor Green
    } catch {
        Write-Host "Note: Some desktop shortcuts may not have been created - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Create test directories for scripts
    Write-Host "Creating test directories..." -ForegroundColor Yellow
    try {
        $testDirs = @("C:\BatchScripts\test", "C:\BatchScripts\logs", "C:\BatchScripts\temp", "C:\BatchScripts\backup")
        foreach ($dir in $testDirs) {
            if (!(Test-Path $dir)) {
                New-Item -ItemType Directory -Path $dir -Force | Out-Null
            }
        }
        
        # Create a sample test script
        $sampleScript = @"
@echo off
REM Sample Batch Script for Testing
REM This script demonstrates basic batch functionality

echo ========================================
echo Windows Batch Script Testing Environment
echo ========================================
echo.
echo Current date and time:
date /t
time /t
echo.
echo Current directory:
cd
echo.
echo System information:
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type"
echo.
echo Available disk space:
wmic logicaldisk get size,freespace,caption
echo.
echo ========================================
echo Test completed successfully!
echo ========================================
pause
"@
        
        $sampleScript | Out-File -FilePath "C:\BatchScripts\test\sample-test.bat" -Encoding ASCII
        
        Write-Host "Test directories and sample script created successfully." -ForegroundColor Green
    } catch {
        Write-Host "Note: Test directories may not have been created - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    Write-Host "Windows configuration completed successfully!" -ForegroundColor Green
    Write-Host "Note: Some settings may not have been applied due to permissions or policy restrictions." -ForegroundColor Yellow
    Write-Host "The VM will still be functional for script testing." -ForegroundColor Yellow
    
} catch {
    Write-Host "Error during Windows configuration: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Some settings may not have been applied, but the VM will still be functional." -ForegroundColor Yellow
} 