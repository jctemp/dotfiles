if (-Not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "Not implemented."
}
elseif (-Not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    throw "Not implemented."
}
else {
    Write-Host "Cannot install apps." -ForegroundColor Red
}