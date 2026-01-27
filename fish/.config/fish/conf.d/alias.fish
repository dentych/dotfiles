if status is-interactive
    alias c "xclip -selection clipboard"
    alias k kubectl
    alias gtc "cd ~/code"

    # understory
    alias aws-ship-dev "node ../node-aws-env/bin/deploy.js -e development --profile understory-dev -g ../glue/development/glue.json"
    alias aws-ship-prod "node ../node-aws-env/bin/deploy.js -e production --profile understory-prod -g ../glue/production/glue.json"
end
