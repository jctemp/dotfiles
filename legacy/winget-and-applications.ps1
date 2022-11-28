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
