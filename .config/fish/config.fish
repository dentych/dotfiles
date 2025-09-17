if status is-interactive
    # Start zellij or tmux if not already in a session
    if not set -q ZELLIJ; and not set -q TMUX
        if command -q zellij
            zellij attach main -c
        else if command -q tmux
            tmux new-session -A -s main
        end
    end

    # Initialize zoxide if available
    if command -q zoxide
        zoxide init fish | source
    end

    # Initialize fzf if available
    if command -q fzf
        fzf --fish | source
    end
end

# Source local configuration if it exists
if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
