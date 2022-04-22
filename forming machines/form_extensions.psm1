# @echo off

# echo.
# echo =================================================================
# echo 「登録されている拡張子は表示しない」のレジストリをコマンドで設定する
# echo =================================================================
# echo.

# rem -----「登録されている拡張子は表示しない」を無効 -----
# reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f
# pause