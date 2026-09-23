function opacity
    # Pick the terminal from env vars it exports (inherited through tmux/zellij)
    if set -q KITTY_WINDOW_ID
        set -f term kitty
        set -f file ~/.config/kitty/opacity.conf
        set -f pattern 'background_opacity\s+(?<current>\S+)'
    else if set -q ALACRITTY_WINDOW_ID; or set -q ALACRITTY_SOCKET
        set -f term alacritty
        set -f file ~/.config/alacritty/opacity.toml
        set -f pattern 'opacity\s*=\s*(?<current>\S+)'
    else
        echo "opacity: unsupported terminal (expected kitty or alacritty)" >&2
        return 1
    end

    if test (count $argv) -eq 0
        if test -f $file
            string match -rq $pattern <$file
        end
        if set -q current
            printf '%.0f%%\n' (math "$current * 100")
        else
            echo "no opacity set" >&2
            return 1
        end
        return 0
    end

    if test (count $argv) -ne 1
        echo "Usage: opacity [percentage 0-100]" >&2
        return 1
    end

    set -l pct (string trim -c '%' $argv[1])
    if not string match -qr '^\d+$' $pct; or test $pct -gt 100
        echo "opacity: expected a percentage between 0 and 100, got '$argv[1]'" >&2
        return 1
    end

    set -l value (printf '%.2f' (math "$pct / 100"))
    switch $term
        case kitty
            printf 'background_opacity %s\n' $value >$file
            # Apply to running windows; the file covers new kitty instances
            if not set -q KITTY_LISTEN_ON
                echo "opacity: saved, but this kitty has no remote-control socket (restart kitty to apply live)" >&2
                return 1
            end
            kitten @ set-background-opacity --all $value
        case alacritty
            printf '[window]\nopacity = %s\n' $value >$file
    end
end
