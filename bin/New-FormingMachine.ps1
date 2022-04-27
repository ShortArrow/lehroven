. bin/glass_factory.ps1

while ($true) {
    $NewName = (Read-Host -Prompt "New Name of Forming Machine")
    $TestFileName = "Form_$NewName.Tests.ps1"
    $TestFilePath = "$(Get-TestingMachineHangar)/$($TestFileName)"
    $FormFileName = "Form_$NewName.ps1"
    $FormFilePath = "$(Get-FormingMachineHangar)/$($FormFileName)"
    
    $StateName = (Read-Host -Prompt "Name of State")
    $StateName = "$($StateName)State"
    Write-Host "TestingFileName : (`e[38;5;10m$TestFilePath`e[0m)"
    Write-Host "FormingFileName : (`e[38;5;10m$FormFilePath`e[0m)"
    $res = (Read-Host "Ok/No/Cancel[y/n/c]")
    if ($res -eq "y") {
        Write-Host "`e[38;5;11mWriting out files`e[0m"
        break
    }
    elseif ($res -eq "c") {
        Write-Host "`e[38;5;11mCanceled`e[0m"
        exit
    }
    else {
        Write-Host "`e[38;5;11mAgain`e[0m"
    }
}

Write-Output ". bin/glass_factory.ps1

Describe `"template`" {
    BeforeAll {
        [string]`$machine = Get-FormingMachine `$PSCommandPath
        . `$machine
    }
    
    It `"template`" {
        `$true | Should -Be `$true
    }
    It `"$($StateName)`" {
        [string](Get-$($StateName)) | Should -Be `"isHidden`"
    }
}
">$TestFilePath


Write-Output "function Get-$($StateName) {
    param ()
    `$regpath = `"Registry::HKEY_CURRENT_USER\xxx\xxx`"
    `$state = (Get-Item -Path `$regpath).GetValue(`"template`")
    return `$state -eq 0 ``
        ? [$($StateName)]::isHidden
        : [$($StateName)]::isShown
}

enum $($StateName) {
    # Default is 1
    isHidden = 0
    isShown = 1
}
">$FormFilePath