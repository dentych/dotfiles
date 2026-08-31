if status is-interactive
    # Add ~/.local/bin to PATH
    fish_add_path -g "$HOME/.local/bin"

    # Go toolchain and `go install` binaries
    fish_add_path -g /opt/go/bin
    fish_add_path -g "$HOME/go/bin"

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
