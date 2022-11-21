# ---------------------------------------------------------------------------------------
# INSTALL STYLES
# Requires administrator rights

if ((Get-PackageProvider -Name NuGet).version -lt 2.8.5.201 ) {
    try {
        Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Confirm:$False -Force 
    }
    catch [Exception] {
        $_.message 
        exit
    }
}
else {
    Write-Host "Version of NuGet installed = " (Get-PackageProvider -Name NuGet).version
}

if (Get-Module -ListAvailable -Name Terminal-Icons) {
    Write-Host "Terminal-Icons Already Installed"
} 
else {
    try {
        Install-Module -Name Terminal-Icons -Repository "PSGallery" -Verbose
    }
    catch [Exception] {
        $_.message 
        exit
    }
}   

# ---------------------------------------------------------------------------------------
# INSTALL WINGET
# Failing installation might require updating MS in the MS store
# Requires administrator rights

if (Get-Command winget -CommandType Application) {
    Write-Host "Winget Already Installed"
}
else {
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
    Install-Script -Name winget-install -Force
    winget-install.ps1
}

$confirmation = Read-Host "Install winget applications? [y/n]: "
if ($confirmation -eq 'y') {
    $general = @(
        "OpenWhisperSystems.Signal", "KeePassXCTeam.KeePassXC", "Microsoft.PowerToys",
        "Discord.Discord", "Spotify.Spotify", "DigitalScholar.Zotero",
        "Google.Chrome", "Google.Drive", "Valve.Steam", "7zip.7zip",
        "Starship.Starship", "GnuPG.Gpg4win"
    )

    $dev = @(
        "Microsoft.VisualStudio.2022.Community", "Microsoft.VisualStudioCode", 
        "Microsoft.OpenJDK.17", "Python.Python.3.11", "Neovim.Neovim", "OpenJS.NodeJS",
        "GitHub.GitHubDesktop", "GitHub.cli", "Git.Git", "Rustlang.Rust.MSVC"
    )

    foreach ($application in $general) {
        Write-Host "Installing $application"
        winget install --accept-package-agreements --accept-source-agreements -e --id $application
    }

    foreach ($application in $dev) {
        Write-Host "Installing $application"
        winget install --accept-package-agreements --accept-source-agreements -e --id $application
    }

    Write-Console "Installed default applications."
}

. $PROFILE
