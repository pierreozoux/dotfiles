# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
DEFAULT_USER="PierreOzoux"

# Example aliases
alias zshconfig="sb ~/.zshrc"
alias ohmyzsh="sb ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx per-directory-history)
# plugins=(git brew bundler gem knife osx per-directory-history rails3 ruby vagrant)

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

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/Users/PierreOzoux/.rbenv/shims:/Users/PierreOzoux/.rbenv/bin:$PATH:/usr/local/sbin:/opt/X11/bin:/usr/X11/bin:/Users/PierreOzoux/bin

export EDITOR='sb'
export LC_CTYPE="UTF-8"

eval "$(rbenv init - --no-rehash)"

#http://stackoverflow.com/questions/564648/zsh-tab-completion-for-cd
zstyle ':completion:*' special-dirs true

alias ll='ls -lah'

# Add the ability to have Runmefile in your folder : 
# Runmefile example here : https://gist.github.com/pierreozoux/5798032

_within-runme-project() {
  local check_dir=$PWD
  if [ $check_dir != "/" ]; then
    [ -f "$check_dir/Runmefile" ] && return
  fi
  false
}

function chpwd() {
  if _within-runme-project; then
    source ./Runmefile
  fi
}

# Octopress not working with zsh
# http://travisjeffery.com/b/2012/01/zshs-extended-glob-and-octopresss-new-post-script/
alias rake="noglob bundle exec rake"

export HOST=local.seedrs.com
export DIRECT_HOST=local.seedrs.com

