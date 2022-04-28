function Show-Welcome {
    param (
        
    )
    $blockA = "`e[38;5;215m█`e[0m"
    $blockB = "`e[38;5;1m█`e[0m"
    # $blockAB = [string]($blockA*2)+$blockB*2+$blockA*2+$blockB*2*$blockA*1
    # $blockBA = [string]($blockA*1)+$blockB*2+$blockA*2+$blockB*2*$blockA*2
    $blockAB = "$($blockB*2)$(($($blockA*4)+$($blockB*4))*2)"
    $blockBA = "$(($($blockA*4)+$($blockB*4))*2)$($blockA*2)"
    Write-Host `
    "
    $($blockAB) `e[38;5;51m█    █▀▀ █  █ █▀▀█  █▀▀▀█ ▀█ █▀ █▀▀ █▀▀▄`e[0m $($blockBA)
    $($blockBA) `e[38;5;51m█    █▀▀ █▀▀█ █▄▄▀  █   █  █▄█  █▀▀ █  █`e[0m $($blockAB)
    $($blockAB) `e[38;5;51m█▄▄█ █▄▄ █  █ █ ▀█  █▄▄▄█   █   █▄▄ █  █`e[0m $($blockBA)
    "
}

Show-Welcome
