# Stop PowerShell on first error
$ErrorActionPreference = "Stop"
# TODO: proceed with license return only if $env:UNITY_SERIAL is set

Write-Host "$(date) Starting return license script"-ForegroundColor green
Write-Host "$(date) Getting unity instance"-ForegroundColor green
Get-UnitySetupInstance

# TODO: extract $credentials to own ps1 file to make it more DRY
$username = $env:UNITY_USERNAME
$password = $env:UNITY_PASSWORD

Write-Host "$(date) Creating non-interactive credential object for password"-ForegroundColor green
$secure_password = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $secure_password)

Write-Host "$(date) Returning license"-ForegroundColor green
Start-UnityEditor -Credential $credentials -ReturnLicense -Wait

Write-Host "$(date) Done with license return"-ForegroundColor green
