Configuration Unity_Install {

    param(
        [PSCredential]$UnityCredential,
        [PSCredential]$UnitySerial,
        [String]$UnityVersion,
        [string[]]$ComputerName = $ENV:ComputerName
    )

    Import-DscResource -ModuleName UnitySetup

    Node $ComputerName {
        xUnitySetupInstance Unity {
            Versions   = $UnityVersion
            Components = 'Windows', 'Mac', 'Linux', 'UWP', 'iOS', 'Android'
            Ensure     = 'Present'
        }

        xUnityLicense UnityLicense {
            Name = 'UL01'
            Credential = $UnityCredential
            Serial = $UnitySerial
            Ensure = 'Present'
            UnityVersion = $UnityVersion
            DependsOn = '[xUnitySetupInstance]Unity'   
        }
    }
}
