function Get-Here {
    return "$(Split-Path -Parent (Split-Path -Parent $PSCommandPath))"
}
function Get-FormingMachineHangar {
    return "$(Get-Here)/forming machines"
}

function Get-FormingMachineNames {
    return (Get-ChildItem (Get-FormingMachineHangar)).Name
}

function Get-TestingMachineHangar {
    return "$(Get-Here)/test"
}

function Get-TestingMachineNames {
    return (Get-ChildItem (Get-TestingMachineHangar)).Name
}

Describe "Test coverage" {
    It "Same TestsCount and FormingsCount" {
        [array]$tests = Get-TestingMachineNames
        [array]$formings = Get-FormingMachineNames
        # ($tests.Length -1) | Should -Be $formings.Length 
    }
    It "Test Names has Forming Names" {
        [array]$tests = Get-TestingMachineNames
        [array]$formings = Get-FormingMachineNames
        # ($tests.Length -1) | Should -Be $formings.Length 
        # Todo: Unnecesary?
    }
    It "Can extension split" {
        Split-Path -Extension "asdfg.hjkl" | Should -Be ".hjkl"
    }
}

