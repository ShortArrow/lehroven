function Get-FormingMachines {
    $Here = "$(Split-Path -Parent (Split-Path -Parent $PSCommandPath))"
    $FormingMachineHangar = "${Here}/forming machines";
    return (Get-ChildItem $FormingMachineHangar).Name
}

$FormingMashines = Get-FormingMachines

for ($i = 0; $i -lt $FormingMashines.Count; $i++) {
    Import-Module $FormingMashines -Scope Local
    
}
