import os

$PATH.append(os.path.join($HOME, ".local", "bin"))
$GOPATH = os.path.join($HOME, "dev", "go")
$CGO_ENABLED = 0

aliases['dc'] = ['docker-compose']
aliases['la'] = ['ls', '-hAl']

# XONSH WEBCONFIG START
$PROMPT = '{env_name}{BOLD_CYAN}{user}{NO_COLOR}@{BOLD_YELLOW}{hostname}{BOLD_BLUE} {short_cwd}{branch_color}{gitstatus: {}}{NO_COLOR} {BOLD_BLUE}{prompt_end}{NO_COLOR} '
$XONSH_COLOR_STYLE = 'monokai'
# XONSH WEBCONFIG END
