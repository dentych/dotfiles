#!/bin/bash
if [[ "$(uname)" == "Darwin" ]]; then
    osascript -e 'display notification "BIP tmux" with title "tmux"'
else
    notify-send "tmux" "BIP tmux"
fi
