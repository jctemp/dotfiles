# ---------------------------------------------------------------------------------------
# EXECUTE SCRIPTS

function execute_admin($name) {
    $script = (Get-Item $name).FullName
    Start-Process "$psHome\powershell.exe"  `
        -Argumentlist "-File $script"       `
        -NoNewWindow                        `
        -Wait
}

function execute($name) {
    $script = (Get-Item $name).FullName
    Start-Process "$psHome\powershell.exe"  `
        -Argumentlist "-File $script"       `
        -NoNewWindow                        `
        -Wait
}

execute_admin ".\scripts\winget-and-applications.ps1"

$installing = Read-Host "Install Rust Cli? [y/n]: "
if ($installing -eq "y") {
    execute ".\scripts\rust-cli.ps1"
}

$installing = Read-Host "Download fonts? [y/n]: "
if ($installing -eq "y") {
    execute ".\scripts\download-fonts.ps1"
}

$installing = Read-Host "Download fonts? [y/n]: "
if ($installing -eq "y") {
}


# ---------------------------------------------------------------------------------------
# COPY PROFILE

$folder = "$HOME\.config"
if (!(Test-Path -Path $folder)) {
    mkdir $folder
}

Copy-Item ".\templates\starship.toml" $folder
Copy-Item ".\templates\powershell-profile.ps1" $PROFILE

. $PROFILE