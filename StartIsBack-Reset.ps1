Clear-Host
Write-Host ''
Write-Host 'STARTISBACK FULL RESET BY L1himNaUtak'
Write-Host 'This script will remove ALL remaining StartIsBack files and registry entries from your system.'
Write-Host '!! At the end, the script will restart Explorer, closing all opened Explorer windows.'
Write-Host ''

$response = Read-Host 'Do you want to begin? (Y/N)'
if ($response -notin @("Y", "y")) {
    Write-Host 'Cancelled by user!'
    exit
}

Write-Host "`nScanning registry..."

# Define list of known StartIsBack registry paths
$registryPaths = @(
    "HKCU:\Software\StartIsBack",
    "HKLM:\Software\StartIsBack",
    "HKLM:\Software\Wow6432Node\StartIsBack",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\StartIsBack",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\StartIsBack",
    "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\StartIsBack"
)

foreach ($path in $registryPaths) {
    if (Test-Path $path) {
        try {
            Remove-Item -Path $path -Recurse -Force -ErrorAction Stop
            Write-Host "Deleted: $path"
        } catch {
            Write-Host "Failed to delete: $path — $_"
        }
    }
}

# Also clean up suspicious leftover CLSID keys with no subkeys and no default value
$clsidRoot = "Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\CLSID"
Get-ChildItem -Path $clsidRoot | ForEach-Object {
    try {
        $subkey = $_
        $hasSubkeys = @(Get-ChildItem -Path $subkey.PSPath -ErrorAction SilentlyContinue).Count -gt 0
        $defaultValue = (Get-ItemProperty -Path $subkey.PSPath -ErrorAction SilentlyContinue).'(default)'

        if (-not $hasSubkeys -and [string]::IsNullOrEmpty($defaultValue)) {
            Remove-Item -Path $subkey.PSPath -Force -ErrorAction Stop
            Write-Host "Deleted empty CLSID key: $($subkey.Name)"
        }
    } catch {
        # Ignore permission errors
    }
}

Write-Host "`nRestarting Explorer..."
Stop-Process -Name explorer -Force

Write-Host "`nSuccess!"
Write-Host 'If you do not see the taskbar or desktop icons, please restart your computer.'
