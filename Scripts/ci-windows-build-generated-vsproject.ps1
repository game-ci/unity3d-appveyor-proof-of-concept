# Stop PowerShell on first error
$ErrorActionPreference = "Stop"

Write-Host "$(date) Starting msbuild script"-ForegroundColor green

$build_target = 'WSAPlayer'
$build_name = 'ExampleProjectName'
pushd "./Builds/$build_target/$build_name"

$project_name = "unity3d-encrypted-appveyor-poc"
$visualstudio_solution = "$project_name.sln"

$buildPlatform = 'x64'
$buildConfiguration = 'Release'
$appxPackageDir = "./AppxPackages/"
$buildLogger = "C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll"

Write-Host "$(date) Restoring nuget packages (this is usually done by visual studio ui automatically)"-ForegroundColor green
msbuild $visualstudio_solution /m /t:restore /p:Configuration="$buildConfiguration" /p:Platform="$buildPlatform" /logger:"$buildLogger"

Write-Host "$(date) Building msproject"-ForegroundColor green
msbuild $visualstudio_solution /m /t:build /p:Configuration="$buildConfiguration" /p:Platform="$buildPlatform" /logger:"$buildLogger"

Write-Host "$(date) Generating appxPackage to '$appxPackageDir' based on following instructions: https://docs.microsoft.com/en-us/windows/uwp/packaging/auto-build-package-uwp-apps"-ForegroundColor green
msbuild $visualstudio_solution /m /p:AppxBundlePlatforms="$buildPlatform" /p:AppxPackageDir="$appxPackageDir" /p:AppxBundle=Always /p:UapAppxPackageBuildMode=StoreUpload /logger:"$buildLogger"

popd
Write-Host "$(date) Done with msbuild"-ForegroundColor green
