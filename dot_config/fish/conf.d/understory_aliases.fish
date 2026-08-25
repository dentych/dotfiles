function aws-dev
    aws login --profile udev
    set -Ux AWS_PROFILE udev
end

function aws-prod
    aws login --profile uprod
    set -Ux AWS_PROFILE uprod
end
