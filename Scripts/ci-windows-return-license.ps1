# Stop PowerShell on first error
$ErrorActionPreference = "Stop"

# todo: extract $credentials to own ps1 file to make it more DRY
$username = $env:UNITY_USERNAME
$password = $env:UNITY_PASSWORD

# Create non-interactive credential object as explained here: https://blogs.msdn.microsoft.com/koteshb/2010/02/12/powershell-how-to-create-a-pscredential-object/
$secure_password = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $secure_password)

Write-Host "$(date) Returning license"-ForegroundColor green
Start-UnityEditor -Credential $credentials -ReturnLicense -Wait
