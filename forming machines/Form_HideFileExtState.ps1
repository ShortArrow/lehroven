# @echo off

# echo.
# echo =================================================================
# echo 「登録されている拡張子は表示しない」のレジストリをコマンドで設定する
# echo =================================================================
# echo.

# rem -----「登録されている拡張子は表示しない」を無効 -----
# reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f
# pause
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
