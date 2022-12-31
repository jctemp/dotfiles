param(
    [Parameter(Mandatory)]$File
)

$PackageManager = Get-Content -Path $File -TotalCount 1
$Apps = Get-Content -Path $File -Exclude $PackageManager

if ($PackageManager.ToLower() -eq "winget") {
    if (-Not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "Winget is not installed." -ForegroundColor Red
        return
    }

    foreach ($item in $Apps) {
        if ($item -notmatch $PackageManager -and $item -ne "") {
            winget install `
                --accept-package-agreements `
                --accept-source-agreements `
                -e --id $item
        }
    }
}

if ($PackageManager.ToLower() -eq "scoop") {
    if (-Not (Get-Command scoop -ErrorAction SilentlyContinue)) {
        Write-Host "Scoop is not installed." -ForegroundColor Red
        return    
    }

    scoop bucket add extras

    foreach ($item in $Apps) {
        if ($item -notmatch $PackageManager -and $item -ne "") {
            scoop install $item
        }
    }
}
