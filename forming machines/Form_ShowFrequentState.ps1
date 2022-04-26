# @echo off
# reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t "REG_DWORD" /d "0" /f 
# reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t "REG_DWORD" /d "0" /f
# pause
# exit

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
