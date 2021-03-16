#!/usr/bin/env bash

# alpaca
export ACCTS=$HOME/Dev/alpaca/accts

# gcloud
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
export CLOUDSDK_PYTHON="/Users/gnvk/.pyenv/versions/2.7.13/bin/python"

# GO
export GOOS=darwin

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color
