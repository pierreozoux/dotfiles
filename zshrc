# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
DEFAULT_USER="pierre"


# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

plugins=(aws git kubectl per-directory-history env)

function help() {
  echo "trash - move a specified file to the Trash"
  echo "zshconfig - configure zsh"
  echo "awesomeconfig"
}

source ~/.OC

function desktop() {
  xrandr --output DP-3 --mode 2560x1440
  xrandr --output LVDS-1 --off
}

function laptop() {
  xrandr --output LVDS-1 --mode 1600x900
  xrandr --output VGA-1 --off
  xrandr --output DP-3 --off
}

function beamer() {
  xrandr --output VGA-1 --mode 1024x768
  xrandr --output LVDS-1 --off
}

function share() {
  apiurl="ocs/v1.php/apps/files_sharing/api/v1/shares"
  result=$(curl -s -k $OC_URL/$apiurl -u $OC_USER:$OC_PASS -d path=$1 -d shareType=3)
  echo $result | sed -e 's/.*<url>\(.*\)<\/url>.*/\1/' | grep http
}

function video() {
  oc_webdav="$OC_URL/remote.php/webdav"
  youtube_link=$(xclip -o)
  filename=$(youtube-dl --get-filename -o '%(title)s.%(ext)s' $youtube_link | sed -e 's/ //g' | sed -e 's/,/-/g' | sed -e 's/°/o/g' )
  filepath="/tmp/$filename"
  youtube-dl -o $filepath $youtube_link
  curl -u $OC_USER:$OC_PASS -T $filepath $oc_webdav/videos/$filename
  link=$(share videos/$filename)
  tag='
  <video tabindex="0" controls="" preload="none" style="width:580px;">
    <source src="'$link'/download" type="video/mp4">
  </video>
  source '$youtube_link
  echo $tag | xclip -sel clip
}

function screenshot() {
  oc_webdav="$OC_URL/remote.php/webdav"
  filepath=/tmp/sc-`date +%d-%m-%y-%H:%M`.png
  basename=$(basename "$filepath")

  scrot -s $filepath

  curl -s -k -u $OC_USER:$OC_PASS -T $filepath $oc_webdav/ScreenShots/$basename
  #share ScreenShots/$basename | xclip -sel clip
}
function beep() {
  paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
}
function gif() {
	DELAY=5
  TIME=`date +%d-%m-%y-%H:%M`
  #USERDUR=$(gdialog --title "Duration?" --inputbox "Please enter the screencast duration in seconds" 200 100 2>&1)
  USERDUR=10
  # xrectsel from https://github.com/lolilolicon/xrectsel
  GEOMETRY=$(xrectsel "--x=%x --y=%y --width=%w --height=%h")
  #GEOMETRY="--x=42 --y=152 --width=600 --height=400"
  echo $GEOMETRY
  notify-send -t $((DELAY*1000)) -u normal -i info 'Byzanz' "Recording in ${DELAY}s"
  sleep $DELAY
  beep
  eval byzanz-record --delay=0 --duration=$USERDUR  $GEOMETRY "/tmp/recording_${TIME}.gif"
  beep
  notify-send -u normal -i info 'Byzanz' 'Done recording'
}

function genpasswd() {
  openssl rand -base64 18 | xclip
}

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export EDITOR="vi"
export LC_CTYPE="UTF-8"
export LC_ALL="en_US.UTF-8"

# PATH
export GOPATH="$HOME/go"
export GOROOT="/usr/local/go"
export GOBIN=$GOPATH/bin
export PATH="$PATH:$HOME/npm/bin"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH="$PATH:/usr/share/applications"
export PATH=~/.local/bin:$PATH

#http://stackoverflow.com/questions/564648/zsh-tab-completion-for-cd
zstyle ':completion:*' special-dirs true

alias ll='ls -lah'
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias zshconfig="vi ~/.zshrc && reload"
alias awesomeconfig="vi .config/awesome/rc.lua && echo 'awesome.restart()' | awesome-client"
alias ohmyzsh="vi ~/.oh-my-zsh"
alias xclip="xclip -selection c"
#alias npm="docker run --rm --name node4 -v "$PWD":/usr/src/app -w /usr/src/app node:4 npm"
#alias node="docker run --rm --name node4 -v "$PWD":/usr/src/app -w /usr/src/app node:4 node"
alias reveal="docker run --rm --name node4 -v "$PWD":/usr/src/app -w /usr/src/app -p 1947:1947 node:4 node"
alias nginx="docker run --rm --name nginx -v "$PWD":/usr/share/nginx/html:ro -p 8000:80 nginx"
alias firefox="/home/pierre/.local/share/umake/web/firefox-dev/firefox"
alias wifi=nmtui

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# The next line updates PATH for the Google Cloud SDK.
if [ -f /home/pierre/google-cloud-sdk/path.zsh.inc ]; then
  source '/home/pierre/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /home/pierre/google-cloud-sdk/completion.zsh.inc ]; then
  source '/home/pierre/google-cloud-sdk/completion.zsh.inc'
fi

function aws_profile () {
  if [ -n "$AWS_PROFILE" ];then 
    echo "<${AWS_PROFILE}>"
  fi
}

function current_k8s_context () {
  if [ -n "$AWS_PROFILE" ];then 
    local context=`kubectl config current-context`
    if [ "$context" != "devnull" ]; then
      echo "<${context}>"
    fi
  fi
}

#kubectl config use-context devnull > /dev/null
RPROMPT='$FG[055]$(current_k8s_context)$FG[003]$(aws_profile)%{$reset_color%}'
eval `ssh-agent -s`
ssh-add ~/.ssh/id_rsa

if [[ -r /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
  source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
fi

function aws_profile () {
  echo ${AWS_PROFILE}
}

function gpg_cred () {
  touch /tmp/to_sign
  echo "Pass for pierre"
  gpg --output /tmp/to_sign.sig --sign /tmp/to_sign
  echo "Pass for indie"
  gpg -u C4C975ABCA42CAE13B2B96E128F13D21466A44FD --output /tmp/to_sign2.sig --sign /tmp/to_sign
  rm /tmp/to_sign.sig /tmp/to_sign /tmp/to_sign2.sig
} 
