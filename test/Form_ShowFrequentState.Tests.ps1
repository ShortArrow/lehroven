. bin/glass_factory.ps1

Describe "frequents" {
    BeforeAll {
        [string]$machine = Get-FormingMachine($PSCommandPath)
        . $machine
    }

    It "Hide frequent directorys or files" {
        [string](Get-ShowFrequentState) | Should -Be "isHidden"
    }
}
