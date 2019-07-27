# Stop PowerShell on first error
$ErrorActionPreference = "Stop"

Write-Host "$(date) Start build script"-ForegroundColor green
Get-UnitySetupInstance

Write-Host "$(date) Setting the right unity instance"-ForegroundColor green

$username = $env:UNITY_USERNAME
$password = $env:UNITY_PASSWORD
$serial = $env:UNITY_SERIAL

# Create non-interactive credential object as explained here: https://blogs.msdn.microsoft.com/koteshb/2010/02/12/powershell-how-to-create-a-pscredential-object/
$secure_password = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $secure_password)

$secure_serial = ConvertTo-SecureString $serial -AsPlainText -Force
$serial_credentials = New-Object System.Management.Automation.PSCredential ('ignored', $secure_serial)

Write-Host "$(date) Starting unity editor with method execution"-ForegroundColor green
Start-UnityEditor -Credential $credentials -Serial $serial_credentials -ExecuteMethod Build.Invoke -BatchMode -Quit -LogFile .\build.log -Wait # -AdditionalArguments "-BuildArg1 -BuildArg2"

Write-Host "$(date) Reading build logs"-ForegroundColor green
Get-Content -Path .\build.log

# TODO: Try with free version too
#Start-UnityEditor -Credential $credentials -ForceFree -ExecuteMethod Build.Invoke -BatchMode -Quit -LogFile .\build.log -Wait # -AdditionalArguments "-BuildArg1 -BuildArg2"
Write-Host "$(date) Done with build. Output log saved to build.log"-ForegroundColor green
