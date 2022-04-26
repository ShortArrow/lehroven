. bin/glass_factory.ps1


$NewName = (Read-Host -Prompt "New Name of Forming Machine")
$TestFileName = "Form_$NewName.Tests.ps1"
$TestFilePath = "$(Get-TestingMachineHangar)/$($TestFileName)"
$FormFileName = "Form_$NewName.ps1"
$FormFilePath = "$(Get-FormingMachineHangar)/$($FormFileName)"

$StateName = (Read-Host -Prompt "Name of State")

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

$StateName = "$($StateName)State"

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