# ---------------------------------------------------------------------------------------
# UTILS
function Confirm-Command($name) {
    return $null -ne (Get-Command $name 2> $null)
}

function export($name, $value) {
    Set-Item -path "env:$name" -value $value;
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
# PRETTY CLI

if (Confirm-Command starship) {
    Invoke-Expression (&starship init powershell)
}
