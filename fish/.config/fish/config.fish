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

# pnpm
set -gx PNPM_HOME "/home/dennis/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
