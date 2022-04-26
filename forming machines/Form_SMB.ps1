function Get-LmCompatibilityLevelState {
    param ()
    $regpath = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\lsa\"
    $regprop = "LmCompatibilityLevel"
    
    $state = ((Get-Item $regpath).Property -contains $regprop)
    return $state `
        ? [LmCompatibilityLevelState]::hasLmCompatibilityLevel
        : [LmCompatibilityLevelState]::notHaveLmCompatibilityLevel
}

enum LmCompatibilityLevelState {
    # Default is 1
    hasLmCompatibilityLevel = 0
    notHaveLmCompatibilityLevel = 1
}
