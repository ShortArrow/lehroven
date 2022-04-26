function Get-Here {
    return "$(Split-Path -Parent (Split-Path -Parent $PSCommandPath))"
}
function Get-FormingMachineHangar {
    return "$(Get-Here)/forming machines"
}
function Get-TestingMachineHangar {
    return "$(Get-Here)/test"
}
function Get-FormingMachine {
    param ([string]$parent)
    $sut = (Split-Path -Leaf $parent) -replace ".Tests.", "."
    return (Resolve-Path "$(Get-FormingMachineHangar)/$sut")
}
