# Nushell Environment Config File

# always behave as a login shell inside vscode
if ($env.TERM_PROGRAM == "vscode") {
    source ~/.config/nushell/login.nu
}
