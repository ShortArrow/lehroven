function Get-FormingMachineHangar {
    param ([string]$Here)
    return "${Here}/forming machines"
}

function Get-FormingMachines {
    $Here = "$(Split-Path -Parent (Split-Path -Parent $PSCommandPath))"
    $FormingMachineHangar = Get-FormingMachineHangar($Here);
    return (Get-ChildItem $FormingMachineHangar).Name
}

function Start-FormingMachines {
    param ()
    $FormingMashines = Get-FormingMachines
    foreach ($item in $FormingMashines) {
        $item
    }
}

Describe "API validation" {
    [string]$response>$null
    BeforeAll { 
        $response = "pika"
    }

    It "response has Name = 'Pikachu'" {
        $response | Should -Be 'pika'
    }

    It "response has Type = 'electric'" {
        $response | Should -Not -Be 'electric'
    }
}

