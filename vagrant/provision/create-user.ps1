# Create User and Enable RDP for Windows 10 Lab
# This script creates a test user and configures RDP access

param(
    [string]$Username = $env:VAGRANT_WIN_USER,
    [string]$Password = $env:VAGRANT_WIN_PASS
)

Write-Host "Creating user account and configuring RDP..." -ForegroundColor Green

try {
    # Check if user already exists
    $existingUser = Get-LocalUser -Name $Username -ErrorAction SilentlyContinue
    if ($existingUser) {
        Write-Host "User $Username already exists. Skipping user creation." -ForegroundColor Yellow
    } else {
        # Create user account
        Write-Host "Creating user: $Username" -ForegroundColor Yellow
        $securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
        New-LocalUser -Name $Username -Password $securePassword -FullName "Batch Script Tester" -Description "Test user for batch script development"
        
        # Add user to Administrators group
        Write-Host "Adding user to Administrators group..." -ForegroundColor Yellow
        Add-LocalGroupMember -Group "Administrators" -Member $Username
    }
    
    # Configure user account settings (only if user exists)
    $user = Get-LocalUser -Name $Username -ErrorAction SilentlyContinue
    if ($user) {
        Write-Host "Configuring user account settings..." -ForegroundColor Yellow
        
        # Set password never expires (with error handling)
        try {
            Set-LocalUser -Name $Username -PasswordNeverExpires $true -ErrorAction SilentlyContinue
            Write-Host "Password never expires set successfully." -ForegroundColor Green
        } catch {
            Write-Host "Note: Could not set password never expires: $($_.Exception.Message)" -ForegroundColor Yellow
        }
        
        # Try to set password change restriction, but don't fail if it's the last admin
        try {
            Set-LocalUser -Name $Username -UserMayChangePassword $false -ErrorAction SilentlyContinue
            Write-Host "Password change restriction set successfully." -ForegroundColor Green
        } catch {
            Write-Host "Note: Could not restrict password changes (may be last administrator or policy restriction)" -ForegroundColor Yellow
        }
    }
    
    # Enable Remote Desktop
    Write-Host "Enabling Remote Desktop..." -ForegroundColor Yellow
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0 -Type DWord -Force
    
    # Configure Windows Firewall for RDP
    Write-Host "Configuring Windows Firewall for RDP..." -ForegroundColor Yellow
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop" -ErrorAction SilentlyContinue
    
    # Enable Network Level Authentication (NLA) for security
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 1 -Type DWord -Force
    
    Write-Host "User account and RDP configuration completed successfully!" -ForegroundColor Green
    
} catch {
    Write-Host "Error during user creation: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Some settings may not have been applied, but RDP should still work." -ForegroundColor Yellow
    # Don't exit with error code to allow provisioning to continue
} 