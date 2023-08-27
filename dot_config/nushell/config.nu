# Nushell Config File

# Add aliases
source ~/.config/nushell/aliases.nu

# Source starship
if (_external_exists starship) {
  source ~/.cache/starship/init.nu
}
