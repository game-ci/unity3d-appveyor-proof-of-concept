# Stop PowerShell on first error
$ErrorActionPreference = "Stop"

Write-Host "$(date) Start build script"-ForegroundColor green

Install-Module -Name UnitySetup -RequiredVersion 5.1.126

$unity_version = $env:UNITY_VERSION
$unity_components = 'Windows','Linux','UWP'

$username = $env:UNITY_USERNAME
$password = $env:UNITY_PASSWORD

# Create non-interactive credential object as explained here: https://blogs.msdn.microsoft.com/koteshb/2010/02/12/powershell-how-to-create-a-pscredential-object/
$secure_password = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $secure_password)

Write-Host "$(date) Installing Unity version $unity_version with components $unity_components"-ForegroundColor green
Find-UnitySetupInstaller -Version $unity_version -Components $unity_components| Install-UnitySetupInstance

Write-Host "$(date) Installed Unity version $unity_version"-ForegroundColor green
