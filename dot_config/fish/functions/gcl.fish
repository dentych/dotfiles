function gcl --description "Fuzzy find and clone a GitHub repo"
    set -l cache_dir (test -n "$XDG_CACHE_HOME" && echo "$XDG_CACHE_HOME" || echo "$HOME/.cache")
    set -l cache_file "$cache_dir/tv/git-clone-repos.txt"
    set -l lock_file "$cache_file.lock"

    mkdir -p (dirname "$cache_file")

    if not test -f "$cache_file"
        echo "Fetching repos for the first time..."
        begin
            gh repo list --limit 1000
            gh org list | awk '{print $1}' | xargs -L 1 gh repo list -L 1000
        end | awk '{print $1}' | sort -u >"$cache_file"
    end

    set -l repo (cat "$cache_file" | gum filter --placeholder "Clone a repo...")

    if test -n "$repo"
        gh repo clone "$repo"
        and cd (basename "$repo")
    end

    # Refresh cache in background for next time
    if not test -f "$lock_file"
        fish -c "
            touch $lock_file
            begin
                gh repo list --limit 1000
                gh org list | awk '{print \$1}' | xargs -L 1 gh repo list -L 1000
            end | awk '{print \$1}' | sort -u > $cache_file.tmp
            and mv $cache_file.tmp $cache_file
            rm -f $lock_file
        " &
        disown
    end
end
