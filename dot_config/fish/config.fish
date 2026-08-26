if status is-interactive
    # Add ~/.local/bin to PATH
    fish_add_path -g "$HOME/.local/bin"

    # pnpm
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
    if not string match -q -- $PNPM_HOME $PATH
        set -gx PATH "$PNPM_HOME" $PATH
    end
    # pnpm end

    # Initialize starship if available
    if command -q starship
        starship init fish | source
    end

    # Start zellij or tmux if not already in a session
    if not set -q ZELLIJ; and not set -q TMUX
        if command -q tmux
            tmux new-session -A -s main
        else if command -q zellij
            zellij attach main -c
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

    set -x EDITOR hx
end

function handler_emit_bell --on-event fish_postexec
    printf '\a'
end
