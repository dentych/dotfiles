if status is-interactive
    if set -q ZELLIJ
        zellij attach -c main
    end
    #fzf --fish | source
end

