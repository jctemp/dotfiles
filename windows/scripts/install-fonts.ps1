if (-Not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "[Font]: Scoop not found." -ForegroundColor Red
    $answer = Read-Host -Prompt "[Font]: Use alternative download? (y/_)"

    if ($answer.ToLower() -eq "y") {
        $Uri = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2"
        $Filename = "CodeNewRoman.zip"

        Write-Host "[Font]: Downloading compressed file..."
        Invoke-WebRequest "$Uri/$Filename" -OutFile "$PWD/$Filename"

        Write-Host "[Font]: Unpacking compressed file..."
        Expand-Archive "$PWD/$Filename" -DestinationPath "$PWD/font"

        Write-Host "[Font]: Font available at $PWD/font." -ForegroundColor Green
        Move-Item "$PWD/$Filename" "$PWD/font"
    }
}
else {

    $Filename = "$PWD\font-install.log"

    Write-Host "[Font]: Adding nerd-fonts bucket to scoop..."
    Start-Process powershell                        `
        -ArgumentList "scoop bucket add nerd-fonts" `
        -WindowStyle Hidden -Wait
        

    Write-Host "[Font]: Installing fonts..."
    $FontArgs = "scoop install -g CodeNewRoman-NF; scoop install -g CascadiaCode-NF"

    Start-Process powershell                `
        -ArgumentList $FontArgs             `
        -Verb RunAs -WindowStyle Hidden -Wait

    Write-Host "[Font]: Installed." -ForegroundColor Green
}
