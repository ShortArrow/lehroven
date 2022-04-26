. bin/glass_factory.ps1

Describe "Powershell" {
    BeforeAll {
        [string]$machine = Get-FormingMachine $PSCommandPath
        . $machine
    }
    It "found Machine" {
        Test-Path "function:Get-PowershellVersion" | Should -BeTrue
    }
    It "Powershell Version" {
        Get-PowershellVersion | Should -BeGreaterThan 6
    }
    It "Powershell Version" {
        [string](Get-PSEditionState) | Should -Be "isCore"
    }
}
