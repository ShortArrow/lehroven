$Names = @(
    @{ AppName = 'OneNote' ; URI = 'Microsoft.Office.OneNote' }
    @{ AppName = 'CandyCrushFriends' ; URI = 'king.com.CandyCrushFriends' }
    @{ AppName = 'FarmHeroesSaga' ; URI = 'king.com.FarmHeroesSaga' }
    @{ AppName = 'ZuneMusic' ; URI = 'Microsoft.ZuneMusic' }
    @{ AppName = 'MicrosoftOfficeHub' ; URI = 'Microsoft.MicrosoftOfficeHub' }
    @{ AppName = 'SkypeApp' ; URI = 'Microsoft.SkypeApp' }
    @{ AppName = 'XboxApp' ; URI = 'Microsoft.XboxApp' }
    @{ AppName = 'OneConnect' ; URI = 'Microsoft.OneConnect' }
)

$AppState = @{
    Enable  = $true
    Disable = $false
}
function Get-AppState {
    param (
        [string]
        $URI
    )
    Import-Module Appx -usewindowspowershell -Scope Local
    $state = Get-AppxPackage($URI)
    return (($null -eq $state) ? $AppState.Disable : $AppState.Enable)
}
function Get-TargetAppNames {
    return $Names
}