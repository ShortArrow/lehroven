. bin/glass_factory.ps1

Describe "Powershell" {
    BeforeAll {
        [string]$machine = Get-FormingMachine $PSCommandPath
        . $machine
    }
    It "found Machine" {
        Test-Path "function:Get-PowershellVersion" | Should -BeTrue
    }
    It "Powershell Version is Core" {
        Get-PowershellVersion | Should -BeGreaterThan 6
    }
}
