Configuration Unity_Install {

    param(
        [PSCredential]$UnityCredential,
        [PSCredential]$UnitySerial,
        [System.String]$UnityVersion
    )

    Import-DscResource -ModuleName UnitySetup

    Node 'localhost' {

        xUnitySetupInstance Unity {
            Versions   = $UnityVersion
            Components = 'Windows', 'Linux', 'UWP'
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