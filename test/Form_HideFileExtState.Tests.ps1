. bin/glass_factory.ps1

Describe "extensions" {
    [string]$response>$null
    BeforeAll { 
        [string]$machine = Get-FormingMachine($PSCommandPath)
        . $machine
    }

    It "All extensions of file are shown" {
        [string](Get-HideFileExtState) | Should -Be "Shown"
    }
}

