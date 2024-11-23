# Nushell Environment Config File

# always behave as a login shell inside vscode
if (($env | get -i TERM_PROGRAM) == "vscode") {
    source ~/.config/nushell/login.nu
}
