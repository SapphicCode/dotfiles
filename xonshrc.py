import os
import datetime
import subprocess
import shutil

$PATH.append('/snap/bin')
$PATH.append('/var/lib/snapd/snap/bin')
$PATH.append(os.path.join($HOME, ".local", "bin"))
$GOPATH = os.path.join($HOME, "dev", "go")
$CGO_ENABLED = 0
$SSH_AUTH_SOCK = f'/run/user/{os.getuid()}/keyring/ssh'
if shutil.which('sway'):
    $SWAYSOCK = $(sway --get-socketpath).strip()

aliases['dc'] = ['docker-compose']
aliases['la'] = ['ls', '-hAl']

# add dotfile version to shell
dotfile_path = os.path.join($HOME, ".dotfiles")
if os.path.exists(dotfile_path):
    version = subprocess.check_output(("git", "rev-parse", "--short", "HEAD"), cwd=dotfile_path).decode().strip()
    $PROMPT_FIELDS['dotver'] = f'#{version}'
del dotfile_path

# XONSH WEBCONFIG START
$PROMPT = '{env_name}{BOLD_CYAN}{user}{BOLD_YELLOW}@{hostname}{RED}{dotver}{BOLD_BLUE} {short_cwd}{branch_color}{gitstatus: {}}{NO_COLOR} {BOLD_BLUE}{prompt_end}{NO_COLOR} '
$XONSH_COLOR_STYLE = 'monokai'
# XONSH WEBCONFIG END
