alias g='git'
alias gr='git reset'
alias grs='git restore'
alias gst='git status'
alias gsw='git switch'

function gswm
    set -l default_branch (git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
    if test -z "$default_branch"
        set default_branch (git rev-parse --abbrev-ref HEAD)
    end
    git switch $default_branch
end

alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch'
alias gl='git pull'
alias glr='git pull --rebase'
alias gp='git push'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcmsg='git commit -m'
alias gclean "git clean -d -i"

function gcm
    set -l default_branch (git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
    if test -z "$default_branch"
        set default_branch (git rev-parse --abbrev-ref HEAD)
    end
    git switch $default_branch
end
alias ga='git add'
alias gdca='git diff --cached'
alias gdab='git branch | grep -v \'*\' | xargs git branch -D'

function cdr
    set -l git_root (git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$git_root"
        cd $git_root
    else
        echo "Not in a git repository"
        return 1
    end
end
