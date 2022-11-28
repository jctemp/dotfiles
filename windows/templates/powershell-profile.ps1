# ---------------------------------------------------------------------------------------
# UTILS
function Confirm-Command($name) {
    return $null -ne (Get-Command $name 2> $null)
}

# ---------------------------------------------------------------------------------------
# IMPORT MODULES
Import-Module -Name Terminal-Icons

# ---------------------------------------------------------------------------------------
# ADMINISTRATOR ELEVATION
# Simple function to start a new elevated process. If arguments are supplied then 
# a single command is started with admin rights; if not then a new admin instance
# of PowerShell is started. 

function admin {
    if ($args.Count -gt 0) {   
        $argList = "& '" + $args + "'"
        Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $argList
    }
    else {
        Start-Process "$psHome\powershell.exe" -Verb runAs
    }
}

# ---------------------------------------------------------------------------------------
# ENV. VARIABLE

$pathContent = [Environment]::GetEnvironmentVariable("path")
if ((Confirm-Command cargo) -and !($pathContent -split ';' -contains "$HOME\.cargo\bin")) {
    $env:Path += ";$HOME\.cargo\bin"
}

# ---------------------------------------------------------------------------------------
# ALIAS

function export($name, $value) {
    set-item -path "env:$name" -value $value;
}

if (Confirm-Command bat)  { Set-Alias cat bat -Force -Option AllScope }
if (Confirm-Command btm)  { Set-Alias top btm -Force -Option AllScope }
if (Confirm-Command dust) { Set-Alias du dust -Force -Option AllScope }
if (Confirm-Command fd)   { Set-Alias find fd -Force -Option AllScope }
if (Confirm-Command rg)   { Set-Alias grep rg -Force -Option AllScope }

# ---------------------------------------------------------------------------------------
# PRETTY CLI

if (Confirm-Command starship) {
    Invoke-Expression (&starship init powershell)
}
