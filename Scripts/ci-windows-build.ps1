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

$build_target = 'StandaloneWindows64'
#$build_target = 'WSAPlayer' # TODO: UWP
$build_name = 'ExampleProjectName'
$build_path = "./Builds/$build_target/"

New-Item -Path $build_path -ItemType "directory"

Write-Host "$(date) Starting unity editor with method execution"-ForegroundColor green
Start-UnityEditor `
  -Credential $credentials `
  -Serial $secure_serial `
  -BatchMode `
  -Quit `
  -LogFile .\build.log `
  -ExecuteMethod BuildCommand.PerformBuild `
  -buildTarget $build_target `
  -Wait `
  -AdditionalArguments "-customBuildTarget $build_target -customBuildName $build_name -customBuildPath $build_path -customBuildOptions AcceptExternalModificationsToPlayer"

Write-Host "$(date) Reading build logs"-ForegroundColor green
Get-Content -Path .\build.log

# TODO: Try with free version too
#Start-UnityEditor -Credential $credentials -ForceFree -ExecuteMethod Build.Invoke -BatchMode -Quit -LogFile .\build.log -Wait # -AdditionalArguments "-BuildArg1 -BuildArg2"
Write-Host "$(date) Done with build. Output log saved to build.log"-ForegroundColor green
