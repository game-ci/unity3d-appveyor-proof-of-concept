# Stop PowerShell on first error
$ErrorActionPreference = "Stop"

Write-Host "$(date) Starting build script"-ForegroundColor green
Write-Host "$(date) Getting unity instance"-ForegroundColor green
Get-UnitySetupInstance
s
$username = $env:UNITY_USERNAME
$password = $env:UNITY_PASSWORD
$serial = $env:UNITY_SERIAL

Write-Host "$(date) Creating non-interactive credential object for password"-ForegroundColor green
$secure_password = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $secure_password)

$secure_serial = ConvertTo-SecureString $serial -AsPlainText -Force

#$build_target = 'StandaloneWindows64'
$build_target = 'WSAPlayer'
$build_name = 'ExampleProjectName'
$build_path = "./Builds/$build_target/"
$build_log = ".\build.log"

New-Item -Path $build_path -ItemType "directory"

Write-Host "$(date) Starting unity editor with method execution"-ForegroundColor green
Start-UnityEditor `
  -Credential $credentials `
  -Serial $secure_serial `
  -BatchMode `
  -Quit `
  -LogFile $build_log `
  -ExecuteMethod BuildCommand.PerformBuild `
  -buildTarget $build_target `
  -Wait `
  -AdditionalArguments "-customBuildTarget $build_target -customBuildName $build_name -customBuildPath $build_path -customBuildOptions AcceptExternalModificationsToPlayer"
# TODO: Try with free version too '-ForceFree `'

Write-Host "$(date) Reading build logs"-ForegroundColor green
Get-Content -Path $build_log

Write-Host "$(date) Done with unity build. Output log saved to $build_log"-ForegroundColor green
