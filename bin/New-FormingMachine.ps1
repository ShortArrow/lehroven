. bin/glass_factory.ps1


$NewName = (Read-Host -Prompt "New Name of Forming Machine")
$FileName = "Form_$NewName.ps1"
$FilePath = "$(Get-FormingMachineHangar)/$($FileName)"

Write-Output ". bin/glass_factory.ps1

Describe `"template`" {
    BeforeAll {
        [string]`$machine = Get-FormingMachine `$PSCommandPath
        . `$machine
    }

    It `"template`" {
        `$true | Should -Be `$true
    }
}
">$FilePath