if type -q forest
    forest shell fish | source
end

if type -q awslogin
    # `shell` embeds the full `awslogin completion fish` output plus the awsl helpers
    awslogin shell fish | source
end
