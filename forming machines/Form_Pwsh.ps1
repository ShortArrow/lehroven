function Get-PowershellVersion {
    param()
    return $PSVersionTable.PSVersion.Major
}

function Get-PSEditionState {
    param ()
    return $PSVersionTable.PSEdition -eq "Core" `
        ? [PSEditionState]::isCore 
        : [PSEditionState]::notCore
}

enum PSEditionState {
    isCore
    notCore
}