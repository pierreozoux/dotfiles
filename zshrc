# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
DEFAULT_USER="pierre"

# Example aliases
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="vi ~/.oh-my-zsh"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

plugins=(git per-directory-history wd)

function help() {
  echo "tab - open the current directory in a new tab"
  echo "pfd - return the path of the frontmost Finder window"
  echo "pfs - return the current Finder selection"
  echo "cdf - cd to the current Finder directory"
  echo "pushdf - pushd to the current Finder directory"
  echo "quick-look - Quick Look a specified file"
  echo "man-preview - open a specified man page in Preview"
  echo "trash - move a specified file to the Trash"
  echo "zshconfig - configure zsh"
}

function genpasswd() {
  openssl rand -base64 32
}

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export EDITOR="vi"
export LC_CTYPE="UTF-8"

#http://stackoverflow.com/questions/564648/zsh-tab-completion-for-cd
zstyle ':completion:*' special-dirs true

alias ll='ls -lah'
