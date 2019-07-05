Write-Host "$(date) Start build script"-ForegroundColor green

Get-UnitySetupInstance

Write-Host "$(date) Setting the right unity instance"-ForegroundColor green
Get-UnitySetupInstance | Select-UnitySetupInstance -Latest

Write-Host "$(date) Starting unity editor with method execution"-ForegroundColor green
Start-UnityEditor -ExecuteMethod Build.Invoke -BatchMode -Quit -LogFile .\build.log -Wait # -AdditionalArguments "-BuildArg1 -BuildArg2"

Write-Host "$(date) Done with build. Output log saved to build.log"-ForegroundColor green
