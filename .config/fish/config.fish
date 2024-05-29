if status is-interactive
    if not set -q ZELLIJ
        zellij attach -c main
    end
    #fzf --fish | source
end

