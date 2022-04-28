. bin/glass_factory.ps1
[string]$machine = Get-FormingMachine $PSCommandPath
. $machine

Describe "Explorer" {
    BeforeAll {
        [string]$machine = Get-FormingMachine $PSCommandPath
        . $machine
    }

    It "Hide frequent directorys or files" {
        Get-ShowFrequentState | Should -Be $ShowFrequentState.isHidden
    }
    It "Hide recent acceess derectory of file are isShown" {
        Get-ShowRecentState | Should -Be $ShowRecentState.isHidden
    }
    It "All extensions of file are isShown" {
        Get-HideFileExtState | Should -Be $HideFileExtState.isShown
    }
    It "Not Exists Onedrive Link" {
        Get-OneDriveLinkState | Should -Be $OneDriveLinkState.NotFound
    }
    It "Disable Onedrive" {
        Get-OneDriveState | Should -Be $OneDriveState.Enable
    }
}
