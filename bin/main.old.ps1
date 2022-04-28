
. .\elevate.ps1

$Script:mothernumber = 0
$Script:childnumber = 0
function Show-TestReport {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $testName,
        [Parameter(Mandatory = $true)]
        [bool]
        $testResult
    )
    Write-Host "- [" -NoNewline
    if ($testResult) {
        Write-Host "OK" -ForegroundColor Green  -NoNewline
        $Script:mothernumber++
        $Script:childnumber++
    }
    else {
        Write-Host "NG" -ForegroundColor Red -NoNewline
        $Script:mothernumber++
    }
    Write-Host "] : "$testName

}
function Show-TestInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $testName,
        [Parameter(Mandatory = $true)]
        [string]
        $testResult
    )
    Write-Host "- [" -NoNewline
    Write-Host "!?" -NoNewline -ForegroundColor Blue
    Write-Host "] : " -NoNewline
    Write-Host ""$testResult"" -ForegroundColor Blue -NoNewline
    Write-Host " : "$testName

}
function Show-TestTitle {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $titleName
    )
    $Decoration = "======"
    Write-Host
    Write-Host "## "$Decoration" "$titleName" "$Decoration

}

function Start-Test {
    param (
        
    )
    
    Show-TestTitle "Powershell Configrations"
    Show-TestReport -testName "Powershell isCore" -testResult ("Core" -eq $PSVersionTable.PSEdition)
    Show-TestReport -testName "Powershell MajorVer" -testResult (6 -le $PSVersionTable.PSVersion.Major)
    
    Show-TestTitle "OneDrive Configrations"
    $DisableFileSyncNGSC = Get-ItemPropertyValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC"
    Show-TestReport -testName "OneDrive DisableSync" -testResult (1 -eq $DisableFileSyncNGSC)
    Show-TestReport -testName "OneDrive OneDrive.lnk" -testResult (!(Test-Path $env:USERPROFILE"\Links\OneDrive.lnk"))
    Show-TestReport -testName "OneDrive SkyDrive.lnk" -testResult (!(Test-Path $env:USERPROFILE"\Links\SkyDrive.lnk"))
    
    Show-TestTitle "Explorer Configrations"
    $ShowFrequent = Get-ItemPropertyValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent"
    $ShowRecent = Get-ItemPropertyValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent"
    $HideFileExt = Get-ItemPropertyValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt"
    Show-TestReport -testName "Explorer ShowFrequent" -testResult (0 -eq $ShowFrequent)
    Show-TestReport -testName "Explorer ShowRecent" -testResult (0 -eq $ShowRecent)
    Show-TestReport -testName "Explorer HideFileExt" -testResult (0 -eq $HideFileExt)
    
    Show-TestTitle "NetFramework Configrations"
    $NetFrameeorkV = (Get-ItemProperty "HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full").Release
    Show-TestReport -testName "NetFramework Version" -testResult ($NetFrameeorkV -ge 394802)
    
    Show-TestTitle "IPAddress Configrations"
    $PrimaryIndex = $(Get-NetConnectionProfile).InterfaceIndex
    $myIpv4Address = $(Get-NetIPAddress | Where-Object { ($_.InterfaceIndex -eq $PrimaryIndex) -and ($_.AddressFamily -eq "IPv4") }).IPv4Address
    $myPrefixLength = $(Get-NetIPAddress | Where-Object { ($_.InterfaceIndex -eq $PrimaryIndex) -and ($_.AddressFamily -eq "IPv4") }).PrefixLength
    $DefaultGateway = $(Get-NetRoute | Where-Object -Property DestinationPrefix -Match 0.0.0.0/0).NextHop
    $Dns1 = $(Get-DnsClientServerAddress | Where-Object { ($_.InterfaceIndex -eq $PrimaryIndex) -and ($_.AddressFamily -eq 2) }).ServerAddresses[0]
    $Dns2 = $(Get-DnsClientServerAddress | Where-Object { ($_.InterfaceIndex -eq $PrimaryIndex) -and ($_.AddressFamily -eq 2) }).ServerAddresses[1]
    Show-TestReport -testName "LAN IP v4 Address" -testResult ($myIpv4Address -match "^192\.168\.\d+\.\d+")
    Show-TestReport -testName "LAN IP v4 PrefixLen" -testResult ($myPrefixLength -eq 24)
    Show-TestReport -testName "LAN IP v4 Gateway" -testResult ($DefaultGateway -match "^192\.168\.\d+\.254")
    Show-TestReport -testName "LAN IP v4 Combination" `
        -testResult (
        [regex]::Match($myIpv4Address, "^\d+\.\d+\.(\d+)").Groups[1].Value -eq `
            [regex]::Match($DefaultGateway, "^\d+\.\d+\.(\d+)").Groups[1].Value)
    Show-TestInfo -testName "LAN IP v4 Address" -testResult $myIpv4Address
    Show-TestInfo -testName "LAN IP v4 PrefixLen" -testResult $myPrefixLength
    Show-TestInfo -testName "LAN IP v4 Gateway" -testResult $DefaultGateway
    Show-TestInfo -testName "LAN IP v4 Dns1" -testResult $Dns1
    Show-TestInfo -testName "LAN IP v4 Dns2" -testResult $Dns2

    Show-TestTitle "No Need Apps"
    Import-Module Appx -usewindowspowershell
    $CandyCrushFriends = (Get-AppxPackage king.com.CandyCrushFriends)
    $FarmHeroesSaga = (Get-AppxPackage king.com.FarmHeroesSaga)
    $ZuneMusic = (Get-AppxPackage Microsoft.ZuneMusic)
    $MicrosoftOfficeHub = (Get-AppxPackage Microsoft.MicrosoftOfficeHub)
    $OneNote = (Get-AppxPackage Microsoft.Office.OneNote)
    $People = (Get-AppxPackage Microsoft.People)
    $SkypeApp = (Get-AppxPackage Microsoft.SkypeApp)
    $SpotifyMusic = (Get-AppxPackage SpotifyAB.SpotifyMusic)
    $XboxGamingOverlay = (Get-AppxPackage Microsoft.XboxGamingOverlay)
    $TCUI = (Get-AppxPackage Microsoft.Xbox.TCUI)
    $XboxApp = (Get-AppxPackage Microsoft.XboxApp)
    $ZuneVideo = (Get-AppxPackage Microsoft.ZuneVideo)
    $WindowsCamera = (Get-AppxPackage Microsoft.WindowsCamera)
    $YourPhone = (Get-AppxPackage Microsoft.YourPhone)
    $Messaging = (Get-AppxPackage Microsoft.Messaging)
    $OneConnect = (Get-AppxPackage Microsoft.OneConnect)
    Show-TestReport -testName "CandyCrush" -testResult ($null -eq $CandyCrushFriends)
    Show-TestReport -testName "FarmHeroes" -testResult ($null -eq $FarmHeroesSaga)
    Show-TestReport -testName "ZuneMusic" -testResult ($null -eq $ZuneMusic)
    Show-TestReport -testName "MsOfficeHub" -testResult ($null -eq $MicrosoftOfficeHub)
    Show-TestReport -testName "OneNote" -testResult ($null -eq $OneNote)
    #Show-TestReport -testName "People" -testResult ($null -eq $People)
    Show-TestReport -testName "SkypeApp" -testResult ($null -eq $SkypeApp)
    Show-TestReport -testName "SpotifyMusic" -testResult ($null -eq $SpotifyMusic)
    # Show-TestReport -testName "XboxOverlay" -testResult ($null -eq $XboxGamingOverlay)
    # Show-TestReport -testName "XboxTCUI" -testResult ($null -eq $TCUI)
    Show-TestReport -testName "XboxApp" -testResult ($null -eq $XboxApp)
    Show-TestReport -testName "ZuneVideo" -testResult ($null -eq $ZuneVideo)
    # Show-TestReport -testName "WindowsCamera" -testResult ($null -eq $WindowsCamera)
    # Show-TestReport -testName "YourPhone" -testResult ($null -eq $YourPhone)
    # Show-TestReport -testName "Messaging" -testResult ($null -eq $Messaging)
    Show-TestReport -testName "OneConnect" -testResult ($null -eq $OneConnect)

    Show-TestTitle -titleName "Lan Manager Configrations"
    $lsa = (Get-Item "HKLM:\SYSTEM\CurrentControlSet\Control\lsa").Property
    $hasntLmcl = $false
    $hasntLmcl = !($lsa -contains "LmCompatibilityLevel")
    Show-TestReport -testName "LmCompatibilityLevel" -testResult ($hasntLmcl)
    
    Show-TestTitle -titleName "IE Proxy Configrations"
    $ProxyEnable = Get-ItemPropertyValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "ProxyEnable"
    $s = (Get-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings").Property
    if ($s.Contains("ProxyServer")) {
        $ProxyServer = Get-ItemPropertyValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "ProxyServer"
    }
    else {
        $ProxyServer = $null
    }
    $s = (Get-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings").Property
    if ($s.Contains("ProxyOverride")) {
        $ProxyOverride = Get-ItemPropertyValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "ProxyOverride"
    }
    else {
        $ProxyOverride = $null
    }
    $IpLastValue = [int][regex]::Match($myIpv4Address, "^\d+\.\d+\.\d+\.(\d+)").Groups[1].Value
    $isInternetConnected = $(1 -le $IpLastValue -and $IpLastValue -le 99)
    Show-TestReport -testName "IE ProxyEnable" -testResult ($isInternetConnected -xor ! $ProxyEnable)
    Show-TestReport -testName "IE ProxyServer" -testResult (! $isInternetConnected -or ("192.168.110.110:12080" -eq $ProxyServer))
    Show-TestReport -testName "IE ProxyOverride" -testResult (! $isInternetConnected -or [regex]::IsMatch($ProxyOverride, "<local>"))
    # reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f /v ProxyEnable /t reg_dword /d 1
    # reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f /v ProxyServer /t reg_sz /d 192.168.110.110:12080
    # reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f /v ProxyOverride /t reg_sz /d "192.168.0.*,192.168.1.*,192.168.10.*,192.168.20.*,192.168.30.*,nms132;<local>"


    Show-TestTitle -titleName "UAC Configurations"
    $ConsentPromptBehaviorAdmin = $(Get-ItemProperty "HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system").ConsentPromptBehaviorAdmin
    $PromptOnSecureDesktop = $(Get-ItemProperty "HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system").PromptOnSecureDesktop
    $EnableLUA = $(Get-ItemProperty "HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system").EnableLUA
    Show-TestReport -testName "ConsentBehaviorAdmin" -testResult ($ConsentPromptBehaviorAdmin -eq 5)
    Show-TestReport -testName "OnSecureDesktop" -testResult ($PromptOnSecureDesktop -eq 1)
    Show-TestReport -testName "EnableLUA      " -testResult ($EnableLUA -eq 1)

    Show-TestTitle "Local Intranet Zone Settings"

    $LocalIntranetZoneSetting = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap"
    $AutoDetect = $(Get-ItemProperty -Path $LocalIntranetZoneSetting).AutoDetect
    $IntranetName = $(Get-ItemProperty -Path $LocalIntranetZoneSetting).IntranetName
    $ProxyBypass = $(Get-ItemProperty -Path $LocalIntranetZoneSetting).ProxyBypass
    $UNCAsIntranet = $(Get-ItemProperty -Path $LocalIntranetZoneSetting).UNCAsIntranet
    # 「イントラネットのネットワークを自動的に検出する」のチェックを外す
    # 「ほかのゾーンに指定されていないローカル（イントラネット）のサイトをすべて含める」にチェックを付ける
    # 「プロキシサーバーを使用しないサイトをすべて含める」にチェックを付ける
    # 「すべてのネットワークパス（UNC)を含める」にチェックを付ける
    Show-TestReport -testName "AutoDetect     " -testResult (0 -eq $AutoDetect)
    Show-TestReport -testName "IntranetName     " -testResult (1 -eq $IntranetName)
    Show-TestReport -testName "ProxyBypass     " -testResult (1 -eq $ProxyBypass)
    Show-TestReport -testName "UNCAsIntranet     " -testResult (1 -eq $UNCAsIntranet)

    $LocalIntranetZonePath = "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges"
    $LocalSubnets = @(
        "192.168.0.*",
        "192.168.1.*",
        "192.168.10.*",
        "192.168.20.*",
        "192.168.30.*"
    )
    if (Test-Path $LocalIntranetZonePath) {
        # 使用済みのレジストリキーを確認しておく
        foreach ($LocalSubnet in $LocalSubnets) {
            # 登録済のIP範囲かどうか確認する
            $neverSet = $true
            foreach ($item in $(Get-ChildItem $LocalIntranetZonePath)) {
                if ($($(Get-ItemProperty -Path $("Registry::" + $item)).":Range") -eq $LocalSubnet) {
                    $neverSet = $false
                    Show-TestReport -testName "Allow $LocalSubnet" -testResult (! $neverSet)
                }
            }
        }
        
    }

    Show-TestTitle "Excel Security Center Settings"
    function Set-ToDefaultExcel {
        param (
            # Path of Target Excel Registry
            [string]
            $TargetExcelPath,
            # Diplay Version
            [string]
            $ExcelVersionDisplay
        )
        if (Test-Path $TargetExcelPath) {
            # 「警告を表示してすべてのマクロを無効にする」
            # 「VBA プロジェクト オブジェクト モデルへのアクセスを信頼する」 のチェックを外します
            # 「インターネットから取得したファイルに対して、保護ビューを有効にする」のチェックを付けます
            # 「安全でない可能性のある場所のファイルに対して、保護ビューを有効にする」のチェックを付けます
            # 「Outlook の添付ファイルに対して、保護ビューを有効にする」のチェックを付けます
            if (Test-Path $TargetExcelPath\Security) {
                $VBAWarnings = $(Get-ItemProperty -Path $TargetExcelPath\Security).VBAWarnings #-Value 2
            }
            else {
                $VBAWarnings = 2
            }
            if (Test-Path $TargetExcelPath\Security) {
                $AccessVBOM = $(Get-ItemProperty -Path $TargetExcelPath\Security).AccessVBOM #-Value 0
            }
            else {
                $AccessVBOM = 0
            }
            if (Test-Path $TargetExcelPath\Security\ProtectedView) {
                $DisableInternetFilesInPV = $(Get-ItemProperty -Path $TargetExcelPath\Security\ProtectedView).DisableInternetFilesInPV #-Value 0
            }
            else {
                $DisableInternetFilesInPV = 0
            }
            if (Test-Path $TargetExcelPath\Security\ProtectedView) {
                $DisableUnsafeLocationsInPV = $(Get-ItemProperty -Path $TargetExcelPath\Security\ProtectedView).DisableUnsafeLocationsInPV #-Value 0
            }
            else {
                $DisableUnsafeLocationsInPV = 0
            }
            if (Test-Path  $TargetExcelPath\Security\ProtectedView) {
                $DisableAttachmentsInPV = $(Get-ItemProperty -Path $TargetExcelPath\Security\ProtectedView).DisableAttachmentsInPV #-Value 0
            }
            else {
                $DisableAttachmentsInPV = 0
            }
            Show-TestReport -testName "VBAWarnings     " -testResult (2 -eq $VBAWarnings)
            Show-TestReport -testName "AccessVBOM     " -testResult (0 -eq $AccessVBOM)
            Show-TestReport -testName "InternetFilesInPV" -testResult (0 -eq $DisableInternetFilesInPV)
            Show-TestReport -testName "UnsafeLocationsInPV" -testResult (0 -eq $DisableUnsafeLocationsInPV)
            Show-TestReport -testName "AttachmentsInPV" -testResult (0 -eq $DisableAttachmentsInPV)
        }
        else {
            Show-TestInfo -testName ExcelSearch -testResult $("Excel" + $ExcelVersionDisplay + " is 404")
        }
    }
    
    
    $targetExcels = @(
        @{ver = "2019"; path = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Excel" },
        @{ver = "2016"; path = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Excel" },
        @{ver = "2013"; path = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\15.0\Excel" },
        @{ver = "2010"; path = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\14.0\Excel" },
        @{ver = "2007"; path = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\12.0\Excel" },
        @{ver = "2003"; path = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\11.0\Excel" }
    )
    
    foreach ($targetExcel in $targetExcels) {
        if (Test-Path $targetExcel) {
        }
        Set-ToDefaultExcel -TargetExcelPath $targetExcel.path -ExcelVersionDisplay $targetExcel.ver
    }
    function Set-ToDefaultCommon {
        param (
            # Path of Target Office Registry
            [string]
            $TargetCommonPath
        )
        if (Test-Path $TargetCommonPath) {
            # 「Office のサインイン ボタンを非表示」
            if (Test-Path $TargetCommonPath\SignIn) {
                $SignInOptions = $(Get-ItemProperty -Path $TargetCommonPath\SignIn).SignInOptions #-Value 3
            }
            else {
                $SignInOptions = 3
            }
            Show-TestReport -testName "SignInOptions     " -testResult (3 -eq $SignInOptions)
        }
    }
    
    
    $targetCommons = @()
    # for Excel 2016・2019
    $targetCommons += "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Common"
    # for Excel 2013
    $targetCommons += "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\15.0\Common"
    
    foreach ($targetCommon in $targetCommons) {
        Set-ToDefaultCommon -TargetCommonPath $targetCommon
    }

    $Target = "registry::HKCU\Software\Microsoft\Internet Explorer\Main"
}

function Start-MainProcess {
    param (
        
    )
    
    $Answer = 'y'
    while ($Answer -eq 'y') {
        $Script:mothernumber = 0
        $Script:childnumber = 0
        Write-Host "↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓" -ForegroundColor Yellow
        Start-Test
        Write-Host "======================================================="
        if ($Script:childnumber -eq $Script:mothernumber) {
            Write-Host "All succeed !!" -ForegroundColor Green
        }
        else {
            Write-Host $Script:childnumber"/"$Script:mothernumber" tests are Succeed" -ForegroundColor Blue
        }
        Write-Host "======================================================="
        $Answer = (Read-Host -Prompt "Test Again ? (y/n) [default is y]")
        if ('' -eq $Answer) {
            $Answer = 'y'
        }
    }
    Write-Host
    Write-Host "Finish"
}


# Start-ScriptAsAdmin -ScriptPath $PSCommandPath
if (Test-Admin) {
    Start-MainProcess
}
else {
    Write-Host "Must Need Administrators" -ForegroundColor White -BackgroundColor Red
}
