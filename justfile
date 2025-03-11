_default:
    just -l

import? '~/.local.just'

# Update dotfiles
apply:
    chezmoi update -a

export RCLONE_EXCLUDE_FROM := env('HOME') / ".local/share/rclone/macOS.rclone-filter"
export RCLONE_EXCLUDE := "cache/,DistantHorizons.sqlite"

# Pull remote directory to given local path (will overwrite local files)
pull DIR PREFIX="":
    rclone sync -P "@personal:Sync/{{PREFIX}}$(basename '{{DIR}}')" '{{DIR}}'
    RCLONE_RESYNC=true just sync '{{DIR}}' '{{PREFIX}}'

# Push local path to remote directory (will overwrite remote files)
push DIR PREFIX="":
    rclone sync -P '{{DIR}}' "@personal:Sync/{{PREFIX}}$(basename '{{DIR}}')"
    RCLONE_RESYNC=true just sync '{{DIR}}' '{{PREFIX}}'

# Sync local path with remote, assuming it has been set up using `pull` or `push`
sync DIR PREFIX="":
    rclone bisync \
        -v --conflict-resolve=newer \
        '{{DIR}}' "@personal:Sync/{{PREFIX}}$(basename '{{DIR}}')"
