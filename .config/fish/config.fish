if status is-interactive
    zellij attach -c main
    fzf --fish | source
end

