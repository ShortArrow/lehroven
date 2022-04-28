. bin/glass_factory.ps1
[string]$machine = Get-FormingMachine $PSCommandPath
. $machine

Describe "UnnecesaryApps" {
    BeforeAll {
        [string]$machine = Get-FormingMachine $PSCommandPath
        . $machine
    }
    It "'<AppName>' '<URI>'" -TestCases $Names {
        param ($AppName, $URI)
            (Get-AppState($URI))  | Should -Be $AppState.Disable
    }
}
