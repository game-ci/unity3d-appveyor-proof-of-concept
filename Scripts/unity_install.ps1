Configuration Unity_Install {

    param(
        [PSCredential]$UnityCredential,
        [PSCredential]$UnitySerial,
        [String]$UnityVersion
    )

    Import-DscResource -ModuleName UnitySetup

    Node 'localhost' {

        PSDscAllowDomainUser = $true
        PSDscAllowPlainTextPassword = $true

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
