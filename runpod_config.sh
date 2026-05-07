#!/bin/bash

: << EOF
Runpod configuration file
This file should be run everytime I set up a runpod instance, to properly arrange everything according to my expectations

Includes downloading certain utilities, setting up very common shell aliases, and pointing frequent large downloads to shared memory.
EOF

# install brew if not already installed
if ! command -v brew 2>/dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install basic devtools through brew (if not already installed)
command -v uv   &>/dev/null || brew install uv
command -v nvim &>/dev/null || brew install neovim

# set the download destinations of frequent large files to shared memory
# note that if a network volume is used, this will not direct downloads to it and these vars should be changed manually
export UV_CACHE_DIR='/dev/shm/uv/'
export HF_HOME='/dev/shm/hf/'

# set this script to be part of the bashrc
SCRIPT_PATH="$(realpath "$0")"
grep -qxF "source \"$SCRIPT_PATH\"" ~/.bashrc || echo "source \"$SCRIPT_PATH\"" >> ~/.bashrc

# set up some really common aliases I don't want to do without
alias memuse='du -h -d1 2>/dev/null | sort -hr' # see the memory usage of subdirectories
alias reload='source $HOME/.bashrc' # relaunch the current shell
alias gst="git status"
alias gaa="git add --all"
alias gcam="git commit --all --message "

