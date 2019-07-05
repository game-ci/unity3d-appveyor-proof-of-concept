Write-Host "$(date) Start build script"-ForegroundColor green

#Invoke-WebRequest "http://beta.unity3d.com/download/a122f5dc316d/Windows64EditorInstaller/UnitySetup64-2018.2.21f1.exe" -OutFile .\UnitySetup64.exe
#Start-Process -FilePath ".\UnitySetup64.exe" -Wait -ArgumentList ('/S', '/Q')

Install-Module -Name UnitySetup -RequiredVersion 5.0.105

$username = $env:UNITY_USERNAME
$password = $env:UNITY_PASSWORD

# Create non-interactive credential object as explained here: https://blogs.msdn.microsoft.com/koteshb/2010/02/12/powershell-how-to-create-a-pscredential-object/
$secure_password = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $secure_password)

$serial = $env:UNITY_SERIAL
$secure_serial = ConvertTo-SecureString $serial -AsPlainText -Force
$serial_credentials = New-Object System.Management.Automation.PSCredential $secure_serial

$cd = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowDomainUser = $true
            PSDscAllowPlainTextPassword = $true
        }
    )
}

. .\Scripts\Install_Unity.ps1

Unity_Install -ConfigurationData $cd -UnityCredential $credentials -UnitySerial $serial_credentials -UnityVersion $env:UNITY_VERSION

Write-Host "$(date) Unity Installed"-ForegroundColor green
