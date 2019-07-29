# Stop PowerShell on first error
$ErrorActionPreference = "Stop"

Write-Host "$(date) Starting msbuild script"-ForegroundColor green

$build_target = 'WSAPlayer'
$build_name = 'ExampleProjectName'
cd "./Builds/$build_target/$build_name"

$project_name = "unity3d-encrypted-appveyor-poc"
$visualstudio_solution = "$project_name.sln"

Write-Host "$(date) Restoring nuget packages (this is usually done by visual studio ui automatically)"-ForegroundColor green
msbuild $visualstudio_solution /m /t:restore /p:Configuration=Release /p:Platform=x86 /logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll"

Write-Host "$(date) building msproject"-ForegroundColor green
msbuild $visualstudio_solution /m /t:build /p:Configuration=Release /p:Platform=x86 /logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll"

Write-Host "$(date) Done with msbuild"-ForegroundColor green
