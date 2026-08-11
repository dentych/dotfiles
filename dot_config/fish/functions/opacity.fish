function opacity
    set -l file ~/.config/alacritty/opacity.toml

    if test (count $argv) -eq 0
        if test -f $file
            string match -rq 'opacity\s*=\s*(?<current>\S+)' <$file
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

    printf '[window]\nopacity = %.2f\n' (math "$pct / 100") >$file
end
