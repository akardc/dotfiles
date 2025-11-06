if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x PHAAS_PIPELINE_CLONE_PATH ~/onecause/phaas-pipeline

# set -x AWS_PROFILE bidpal-dev
set -x AWS_PROFILE prod-engineer
set -x DEV_AWS_PROFILE bidpal-dev

set -x ONECAUSEDEV 1
set -x GOPATH /Users/cakard/go
set -x GOPRIVATE "github.com/BidPal/*"
set -x PHAAS_GO_LIB_DEVTOOLS "/Users/cakard/go/src/github.com/BidPal/phaas-go-lib/devtools"
set -x PHAASDEVCLI_SEQUEL_ACE_PASS "Sequel Ace : phaas-prod-dev-v3-rw (-2081059084050211711)"
set -x PHAAS_SNS_TOPIC_ARN "arn:aws:sns:us-east-2:411971060769:cpa-service-topic"
set -x PHAAS_SQS_QUEUE_NAME cpa-test

set -ax PATH /opt/homebrew/bin
set -ax PATH /Users/cakard/go/bin
set -ax PATH /Users/cakard/.docker/bin
set -ax PATH /Users/cakard/Library/Python/3.9/bin
set -ax PATH /Users/cakard/.config/herd-lite/bin


set -x DEV_AURORA_USER cakard@onecause.com
# set -x DEV_AURORA_PASS $(phaas-dev-cli db token)

set -x EDITOR nvim


# Setting PATH for Python 3.12
# The original version is saved in /Users/cakard/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"

# nvm/node version
set -ax NVM_DIR "$HOME/.nvm"
# set -ax PATH /Users/cakard/.nvm/versions/node/v18.20.4/bin
# set -ax NODE_VERSION v18.20.4

# requires https://starship.rs/
starship init fish | source

# requires https://github.com/ajeetdsouza/zoxide
zoxide init fish | source

# requires https://github.com/junegunn/fzf
fzf --fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
