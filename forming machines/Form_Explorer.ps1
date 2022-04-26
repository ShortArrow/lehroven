function Get-ShowFrequentState {
    param ()
    $regpath = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\"
    $state=(Get-Item -Path $regpath).GetValue("ShowFrequent")
    return [ShowFrequentState]$state
}

enum ShowFrequentState {
    # Default is 1
    isHidden=0
    Shown=1
}

function Get-ShowRecentState {
    param ()
    $regpath = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\"
    $state=(Get-Item -Path $regpath).GetValue("ShowRecent")
    return [ShowRecentState]$state
}

enum ShowRecentState {
    # Default is 1
    isHidden=0
    Shown=1
}

function Get-HideFileExtState {
    param ()
    $regpath = "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"
    $state=(Get-Item -Path $regpath).GetValue("HideFileExt")
    return [HideFileExtState]$state
}

enum HideFileExtState {
    # Default is 1
    Shown=0
    isHidden=1
}
