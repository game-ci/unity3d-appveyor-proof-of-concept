# Stop PowerShell on first error
$ErrorActionPreference = "Stop"

$build_target = 'WSAPlayer'
$build_name = 'ExampleProjectName'
cd "./Builds/$build_target/$build_name"

$project_name = "unity3d-encrypted-appveyor-poc"
$visualstudio_solution = "$project_name.sln"

# restore nuget packages (this is usually done by visual studio ui automatically)
msbuild $visualstudio_solution /m /t:restore /p:Configuration=Release /p:Platform=x86 /logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll"
# actually build the project
msbuild $visualstudio_solution /m /t:build /p:Configuration=Release /p:Platform=x86 /logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll"
