function Get-FormingMachineHangar {
    param ([string]$Here)
    return "${Here}/forming machines"
}

function Get-FormingMachine {
    param (
        [string]
        $parent
    )
    $Here = "$(Split-Path -Parent (Split-Path -Parent $parent))"
    $FormingMachineHangar = Get-FormingMachineHangar($Here);
    $sut = (Split-Path -Leaf $parent) -replace ".Tests.", "."
    return Resolve-Path $FormingMachineHangar/$sut
}