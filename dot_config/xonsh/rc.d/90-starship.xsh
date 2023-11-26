import shutil


# better xonsh prompt, as of xonsh>=0.14.2
def starship_prompt():
    n_jobs = len(__xonsh__.all_jobs)
    if len(__xonsh__.history) > 0:
        ts = __xonsh__.history.tss[-1]
        duration = int((ts[1] - ts[0]) * 1000)
    else:
        duration = 0
    return $(starship prompt --status=$LAST_RETURN_CODE --jobs=@(n_jobs) --cmd-duration=@(duration))


if shutil.which('starship'):
    $PROMPT = starship_prompt


# clean up after ourselves
del shutil

