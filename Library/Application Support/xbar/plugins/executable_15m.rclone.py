#!/opt/homebrew/bin/python3

import os
import shutil
import subprocess

os.environ["PATH"] = ":".join(
    [
        os.path.expanduser("~/.local/bin"),
        os.path.expanduser("~/.nix-profile/bin"),
        "/opt/homebrew/bin",
        *os.environ["PATH"].split(":"),
    ],
)
SHELL = shutil.which("fish")


if __name__ == "__main__":
    print("􀤂")  # externaldrive
    print("---")
    version = subprocess.check_output(("rclone", "version"), text=True).splitlines()[0]
    print(version)
    print("---")
    mounts = (
        subprocess.check_output(("rclone", "listremotes"), text=True)
        .strip()
        .splitlines()
    )
    for mount in mounts:
        mount = mount[: len(mount) - 1]
        target_path = os.path.expanduser(f"~/mnt/{mount}")
        os.makedirs(target_path, exist_ok=True)

        if os.path.ismount(target_path):
            status = "🟢"
            command = (
                f' | shell={SHELL} param1=-c param2="umount {target_path}" refresh=true'
            )
        else:
            status = "🔴"
            command = f' | shell={SHELL} param1=-c param2="rclone mount --daemon --vfs-cache-mode=full --noappledouble --noapplexattr {mount}: {target_path}" refresh=true'
        print(f"{status} {mount}{command}")
