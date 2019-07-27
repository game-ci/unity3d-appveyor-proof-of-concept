# Stop PowerShell on first error
$ErrorActionPreference = "Stop"

Write-Host "$(date) Start build script"-ForegroundColor green

Install-Module -Name UnitySetup -RequiredVersion 5.0.105

$unity_version = $env:UNITY_VERSION
$unity_components = 'Windows','Linux','UWP'

$username = $env:UNITY_USERNAME
$password = $env:UNITY_PASSWORD

# Create non-interactive credential object as explained here: https://blogs.msdn.microsoft.com/koteshb/2010/02/12/powershell-how-to-create-a-pscredential-object/
$secure_password = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $secure_password)

$serial = $env:UNITY_SERIAL
$secure_serial = ConvertTo-SecureString $serial -AsPlainText -Force
$serial_credentials = New-Object System.Management.Automation.PSCredential ($username, $secure_serial)

Write-Host "$(date) Installing Unity version $unity_version with components $unity_components"-ForegroundColor green
Find-UnitySetupInstaller -Version $unity_version -Components $unity_components| Install-UnitySetupInstance

$cd = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowDomainUser = $true
            PSDscAllowPlainTextPassword = $true
        }
    )
}

. .\Scripts\Install_Unity.ps1

Write-Host "$(date) Running DSC configuration"-ForegroundColor green
Install_Unity -ConfigurationData $cd -UnityCredential $credentials -UnitySerial $serial_credentials -UnityVersion $unity_version
Write-Host "$(date) Installed Unity version $unity_version"-ForegroundColor green
