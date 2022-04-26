. bin/glass_factory.ps1

Describe "SMB" {
    BeforeAll {
        [string]$machine = Get-FormingMachine $PSCommandPath
        . $machine
    }
    It "LmCompatibilityLevelState" {
        [string](Get-LmCompatibilityLevelState) | Should -Be "notHaveLmCompatibilityLevel"
    }
}
