# INSTALL RUST
if (-Not (Get-Command rustup -ErrorAction SilentlyContinue)) {
    $Uri = "https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc"
    $Filename = "rustup-init.exe"

    Write-Host "[Rust]: Downloading installer..."
    Invoke-WebRequest -Uri "$Uri/$Filename" -OutFile "$PWD/$Filename"
    
    Write-Host "[Rust]: Start installer..."
    Start-Process -FilePath "$PWD/$Filename" -ArgumentList "-y" -WindowStyle Hidden -Wait

    Write-Host "[Rust] Installed." -ForegroundColor Green
    Remove-Item -Force -Path "$PWD/$Filename"
}
else {
    Write-Host "[Rust] Already installed." -ForegroundColor Green
}

# INSTALL SCOOP
if (-Not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    $Uri = "https://get.scoop.sh"
    $Filename = "scoop.ps1"

    Write-Host "[Scoop]: Downloading installer..."
    Invoke-WebRequest -Uri $Uri -OutFile "$PWD/$Filename"

    Write-Host "[Scoop]: Start installer..."
    Invoke-Expression "$PWD/$Filename" | Out-File "$PWD/scoop-install.log"

    Write-Host "[Scoop]: Installed." -ForegroundColor Green
    Remove-Item -Force -Path "$PWD/$Filename"
}
else {
    Write-Host "[Scoop]: Already installed." -ForegroundColor Green
}

# INSTALL NUGET PACKAGE
if ((Get-PackageProvider -Name NuGet).version -lt 2.8.5.201) {
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Confirm:$False -Force -Scope CurrentUser
}

# INSTALL TERMINAL ICONS MODULE
if (-Not (Get-Module -ListAvailable -Name Terminal-Icons -ErrorAction SilentlyContinue)) {
    Install-Module -Name Terminal-Icons -Repository "PSGallery" -Verbose -Scope CurrentUser
}

# OTHER
Write-Host ""
Write-Host "Final touches..."

if (-Not (Get-Command winget -ErrorAction SilentlyContinue)) {
    scoop install starship
}
else {
    winget install --accept-package-agreements --accept-source-agreements -e --id "Starship.Starship"
}

$Folder = "$HOME\.config"
if (!(Test-Path -Path $Folder)) {
    mkdir $Folder
}

Copy-Item ".\templates\starship.toml" $Folder
Copy-Item ".\templates\powershell-profile.ps1" $PROFILE

. $PROFILE