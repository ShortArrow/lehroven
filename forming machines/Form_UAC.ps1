function Get-UacState {
    param ()
    $state = (Get-ConsentPromptBehaviorAdminState `
            -eq [ConsentPromptBehaviorAdminState]::isEnable) `
        -and (Get-PromptOnSecureDesktopState `
            -eq [PromptOnSecureDesktopState]::isEnable) `
        -and (Get-EnableLUAState `
            -eq [EnableLUAState]::isEnable)
    return $state -eq $true `
        ? [UacState]::isEnable
    : [UacState]::isDisable
}

enum UacState {
    # Default is true
    isDisable = $false
    isEnable = $true
}

function Get-ConsentPromptBehaviorAdminState {
    param ()
    $regpath = "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system"
    $state = (Get-Item -Path $regpath).GetValue("ConsentPromptBehaviorAdmin")
    return $state -eq 5 `
        ? [UacState]::isEnable
    : [UacState]::isDisable
}

enum ConsentPromptBehaviorAdminState {
    # Default is true
    isDisable = $false
    isEnable = $true
}

function Get-PromptOnSecureDesktopState {
    param ()
    $regpath = "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system"
    $state = (Get-Item -Path $regpath).GetValue("PromptOnSecureDesktop")
    return $state -eq 1 `
        ? [UacState]::isEnable
    : [UacState]::isDisable
}

enum PromptOnSecureDesktopState {
    # Default is true
    isDisable = $false
    isEnable = $true
}

function Get-EnableLUAState {
    param ()
    $regpath = "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system"
    $state = (Get-Item -Path $regpath).GetValue("EnableLUA")
    return $state -eq 1 `
        ? [UacState]::isEnable
    : [UacState]::isDisable
}

enum EnableLUAState {
    # Default is true
    isDisable = $false
    isEnable = $true
}
