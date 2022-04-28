. bin/glass_factory.ps1

Describe "UAC" {
    BeforeAll {
        [string]$machine = Get-FormingMachine $PSCommandPath
        . $machine
    }
    It "UacState" {
        [string](Get-UacState) | Should -Be "isEnable"
    }
    It "ConsentPromptBehaviorAdminState" {
        [string](Get-ConsentPromptBehaviorAdminState) | Should -Be "isEnable"
    }
    It "PromptOnSecureDesktopState" {
        [string](Get-PromptOnSecureDesktopState) | Should -Be "isEnable"
    }
    It "EnableLUAState" {
        [string](Get-EnableLUAState) | Should -Be "isEnable"
    }
}
