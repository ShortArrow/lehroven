. bin/glass_factory.ps1

Describe "Explorer" {
    BeforeAll {
        [string]$machine = Get-FormingMachine($PSCommandPath)
        . $machine
    }

    It "Hide frequent directorys or files" {
        [string](Get-ShowFrequentState) | Should -Be "isHidden"
    }
    It "Hide recent acceess derectory of file are isShown" {
        [string](Get-ShowRecentState) | Should -Be "isHidden"
    }
    It "All extensions of file are isShown" {
        [string](Get-HideFileExtState) | Should -Be "isShown"
    }
    It "Not Exists Onedrive Link" {
        [string](Get-OneDriveLinkState) | Should -Be "NotFound"
    }
    It "Disable Onedrive" {
        [string](Get-OneDriveState) | Should -Be "Enable"
    }
}
