# rust cli tools that are cross platfrom
# - bat     replacement for cat
# - bottom  replacement for top
# - dust    replacement for du
# - fd      replacement for find
# - ripgrep replacement for grep

# - felix   is a tui-file manager
# - xh      is a http request

$cli = @("du-dust", "fd-find", "felix", "ripgrep", "xh")
$lcli = @("bat", "bottom")

foreach ($c in $cli) {
    cargo install $c
}

foreach ($c in $lcli) {
    cargo install $c --locked
}
