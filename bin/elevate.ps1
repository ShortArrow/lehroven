function Test-Admin {
    (
        [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::
        GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}
function Start-ScriptAsAdmin {
    param(
        [string]
        $ScriptPath,
        [object[]]
        $ArgumentList
    )
    if (!(Test-Admin)) {
        $list = @($ScriptPath)
        if ($null -ne $ArgumentList) {
            $list += @($ArgumentList)
        }
        Start-Process pwsh -ArgumentList $list -Verb RunAs -Wait
    }
}

function Register-ScriptAsAdmin {
    param(
        [string]
        $ScriptPath,
        [object[]]
        $ArgumentList
    )

    $jobArgs = @{
        FilePath           = $ScriptPath
        ScheduledJobOption = New-ScheduledJobOption -RunElevated
        Name               = "RunAsAdmin $(Split-Path -Leaf $ScriptPath)"
    }
    if ($null -ne $ArgumentList) { $jobArgs += @{ArgumentList = $ArgumentList } }

    Register-ScheduledJob @jobArgs 
}

function Invoke-ScriptAsAdmin {
    param(
        [string]
        $ScriptPath
    )
    $job = Get-ScheduledJob -Name "RunAsAdmin $(Split-Path -Leaf $ScriptPath)"
    $job.RunAsTask()
}

function Unregister-ScriptAsAdmin {
    param(
        [string]
        $ScriptPath
    )
    Unregister-ScheduledJob -Name "RunAsAdmin $(Split-Path -Leaf $ScriptPath)"  
}

function Show-WarningMessageOfAdmin {
    param (
        [string]
        $Message
    )
    $MessageArea = ("`e[48;5;231;38;5;232m" + " " * 10 + $Message + " " * 10 + "`e[0m") 
    $Tape = (("`e[48;5;226m " + "`e[48;5;232m ") * ($Message.length / 2 + 10) + "`e[0m")
    Write-Output ($Tape + "`n" + $MessageArea + "`n" + $Tape)
}