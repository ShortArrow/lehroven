. bin/glass_factory.ps1

Describe "frequents" {
    BeforeAll {
        [string]$machine = Get-FormingMachine($PSCommandPath)
        . $machine
    }

    It "Hide frequent directorys or files" {
        [string](Get-ShowFrequentState) | Should -Be "isHidden"
    }
    It "Hide recent acceess derectory of file are shown" {
        [string](Get-ShowRecentState) | Should -Be "isHidden"
    }
    It "All extensions of file are shown" {
        [string](Get-HideFileExtState) | Should -Be "Shown"
    }
}
