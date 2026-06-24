#!/usr/bin/env zsh

# <xbar.title>Timewarrior</xbar.title>
# <xbar.dependencies>timew</xbar.dependencies>

source "$HOME/.zprofile"

timew=$(whence timew)
running=$(timew get dom.active)

if [ $running = "0" ]; then
    echo ":hourglass:"
else
    echo ":hourglass_flowing_sand: $(timew get dom.active.duration)"
fi

echo "---"

if [ $running = "1" ]; then
    echo "Stop | shell=\"$timew\" param1=stop refresh=true"
fi
