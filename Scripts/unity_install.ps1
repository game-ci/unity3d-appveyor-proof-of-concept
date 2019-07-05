Configuration Unity_Install {

    param(
        [PSCredential]$UnityCredential,
        [PSCredential]$UnitySerial
    )

    Import-DscResource -ModuleName UnitySetup

    Node 'localhost' {

        xUnitySetupInstance Unity {
            Versions   = '2018.2.21f1'
            Components = 'Windows', 'Mac', 'Linux', 'UWP', 'iOS', 'Android'
            Ensure     = 'Present'
        }

        xUnityLicense UnityLicense {
            Name = 'UL01'
            Credential = $UnityCredential
            Serial = $UnitySerial
            Ensure = 'Present'
            UnityVersion = '2018.2.21f1'
            DependsOn = '[xUnitySetupInstance]Unity'   
        }
    }
}