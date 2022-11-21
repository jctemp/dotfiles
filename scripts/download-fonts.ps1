# ---------------------------------------------------------------------------------------
# DOWNLOAD FONTS

$font = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/InconsolataGo.zip"
Invoke-RestMethod $font -OutFile "InconsolataGo.zip"
$loc = (Get-Item ".\InconsolataGo.zip").FullName

Write-Console "Downloaded fonts and were saved at $loc"