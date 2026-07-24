function opacity
    if test (count $argv) -ne 1
        echo "Usage: opacity <float>" >&2
        return 1
    end

    printf '[window]\nopacity = %s\n' $argv[1] >~/.config/alacritty/opacity.toml
end
