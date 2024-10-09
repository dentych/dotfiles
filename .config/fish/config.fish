if status is-interactive
    if not set -q TMUX
        tmux new-session -A -s main
    end
    if command -q zoxide init fish 2>/dev/null
        zoxide init fish | source
    end
    if command -q fzf --fish 2>/dev/null
        fzf --fish | source
    end
end

