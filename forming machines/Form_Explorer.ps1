function Get-ShowFrequentState {
    param ()
    $regpath = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\"
    $state = (Get-Item -Path $regpath).GetValue("ShowFrequent")
    return $state ? $ShowFrequentState.isShown : $ShowFrequentState.isHidden
}

$ShowFrequentState = @{
    # Default is 1
    isHidden = 0
    isShown  = 1
}

function Get-ShowRecentState {
    param ()
    $regpath = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\"
    $state = (Get-Item -Path $regpath).GetValue("ShowRecent")
    return $state ? $ShowRecentState.isShown : $ShowRecentState.isHidden
}

$ShowRecentState = @{
    # Default is 1
    isHidden = 0
    isShown  = 1
}

function Get-HideFileExtState {
    param ()
    $regpath = "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"
    $state = (Get-Item -Path $regpath).GetValue("HideFileExt")
    return $state ? $HideFileExtState.isHidden : $HideFileExtState.isShown 
}

$HideFileExtState = @{
    # Default is 1
    isShown  = 0
    isHidden = 1
}

function Get-OneDriveState {
    param ()
    $regpath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive\"
    $state = (Get-Item -Path $regpath).GetValue("DisableFileSyncNGSC")
    return $state ? $OneDriveState.Enable : $OneDriveState.Disable 
}

$OneDriveState = @{
    # Default is 1
    Disable = 0
    Enable  = 1
}

function Get-OneDriveLinkState {
    param ()
    $state = (Test-Path "$env:USERPROFILE\Links\OneDrive.lnk")
    return ($state ? $OneDriveLinkState.Found : $OneDriveLinkState.NotFound)
}
$OneDriveLinkState = @{
    # Default is Found
    Found=$true
    NotFound=$false
}
