# Nushell Config File

# Suppress welcome message
$env.config = {
    show_banner: false,
}

# Set up prompt
const _starship = "~/.cache/starship.nu"
source $_starship

# Add aliases
source ~/.config/nushell/aliases.nu
