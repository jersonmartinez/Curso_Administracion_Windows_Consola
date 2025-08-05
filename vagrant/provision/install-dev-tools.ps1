# Install Development Tools for Script Testing
# This script installs useful tools for batch and PowerShell development

Write-Host "Installing development tools..." -ForegroundColor Green

try {
    # Install Chocolatey if not already installed
    Write-Host "Checking for Chocolatey package manager..." -ForegroundColor Yellow
    if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Chocolatey..." -ForegroundColor Yellow
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        
        # Refresh environment variables
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        
        # Wait a moment for Chocolatey to be ready
        Start-Sleep -Seconds 5
    } else {
        Write-Host "Chocolatey already installed." -ForegroundColor Yellow
    }
    
    # Install useful development tools with better error handling
    Write-Host "Installing development tools..." -ForegroundColor Yellow
    
    # Function to install package safely
    function Install-PackageSafely {
        param([string]$PackageName, [string]$DisplayName)
        
        Write-Host "Installing $DisplayName..." -ForegroundColor Yellow
        try {
            # Try with ignore checksums first for problematic packages
            choco install $PackageName -y --ignore-checksums --no-progress -ErrorAction SilentlyContinue
            if ($LASTEXITCODE -eq 0) {
                Write-Host "$DisplayName installed successfully." -ForegroundColor Green
            } else {
                # Try without ignore checksums
                choco install $PackageName -y --no-progress -ErrorAction SilentlyContinue
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "$DisplayName installed successfully." -ForegroundColor Green
                } else {
                    Write-Host "Failed to install $DisplayName. Skipping..." -ForegroundColor Yellow
                }
            }
        } catch {
            Write-Host "Error installing $DisplayName - $($_.Exception.Message). Skipping..." -ForegroundColor Yellow
        }
    }
    
    # Install packages with safe installation
    Install-PackageSafely "notepadplusplus" "Notepad++"
    Install-PackageSafely "7zip" "7-Zip"
    Install-PackageSafely "git" "Git"
    Install-PackageSafely "vscode" "Visual Studio Code"
    Install-PackageSafely "microsoft-windows-terminal" "Windows Terminal"
    
    # Skip problematic packages that cause checksum errors
    Write-Host "Skipping Sysinternals Suite due to checksum issues..." -ForegroundColor Yellow
    Write-Host "You can install Sysinternals tools manually from: https://docs.microsoft.com/en-us/sysinternals/" -ForegroundColor Yellow
    
    # Create desktop shortcuts for installed tools
    Write-Host "Creating desktop shortcuts for tools..." -ForegroundColor Yellow
    $desktopPath = [Environment]::GetFolderPath("Desktop")
    $wshShell = New-Object -ComObject WScript.Shell
    
    # Create shortcut to Notepad++
    $notepadPlusPath = "C:\Program Files\Notepad++\notepad++.exe"
    if (Test-Path $notepadPlusPath) {
        $shortcut = $wshShell.CreateShortcut("$desktopPath\Notepad++.lnk")
        $shortcut.TargetPath = $notepadPlusPath
        $shortcut.WorkingDirectory = "C:\BatchScripts"
        $shortcut.Description = "Open Notepad++ in BatchScripts folder"
        $shortcut.Save()
        Write-Host "Notepad++ shortcut created." -ForegroundColor Green
    }
    
    # Create shortcut to Windows Terminal
    $terminalPath = "C:\Program Files\WindowsTerminal\wt.exe"
    if (Test-Path $terminalPath) {
        $shortcut = $wshShell.CreateShortcut("$desktopPath\Windows Terminal.lnk")
        $shortcut.TargetPath = $terminalPath
        $shortcut.WorkingDirectory = "C:\BatchScripts"
        $shortcut.Description = "Open Windows Terminal in BatchScripts folder"
        $shortcut.Save()
        Write-Host "Windows Terminal shortcut created." -ForegroundColor Green
    }
    
    # Create shortcut to Visual Studio Code
    $vscodePath = "C:\Program Files\Microsoft VS Code\Code.exe"
    if (Test-Path $vscodePath) {
        $shortcut = $wshShell.CreateShortcut("$desktopPath\Visual Studio Code.lnk")
        $shortcut.TargetPath = $vscodePath
        $shortcut.WorkingDirectory = "C:\BatchScripts"
        $shortcut.Description = "Open Visual Studio Code in BatchScripts folder"
        $shortcut.Save()
        Write-Host "Visual Studio Code shortcut created." -ForegroundColor Green
    }
    
    # Create shortcut to Git Bash
    $gitBashPath = "C:\Program Files\Git\bin\bash.exe"
    if (Test-Path $gitBashPath) {
        $shortcut = $wshShell.CreateShortcut("$desktopPath\Git Bash.lnk")
        $shortcut.TargetPath = $gitBashPath
        $shortcut.WorkingDirectory = "C:\BatchScripts"
        $shortcut.Description = "Open Git Bash in BatchScripts folder"
        $shortcut.Save()
        Write-Host "Git Bash shortcut created." -ForegroundColor Green
    }
    
    Write-Host "Development tools installation completed!" -ForegroundColor Green
    Write-Host "Note: Some tools may have been skipped due to network or checksum issues." -ForegroundColor Yellow
    Write-Host "You can install additional tools manually as needed." -ForegroundColor Yellow
    
} catch {
    Write-Host "Error during tools installation: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Some tools may not have been installed, but the VM will still be functional." -ForegroundColor Yellow
} 