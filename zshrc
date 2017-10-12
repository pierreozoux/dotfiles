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
}

source ~/.OC

function desktop() {
  xrandr --output VGA-1 --mode 1920x1080 --left-of LVDS-1
  xrandr --output LVDS-1 --off
  xrandr --output HDMI-1 --mode 1920x1080 --right-of VGA-1
}

function laptop() {
  xrandr --output VGA-1 --off
  xrandr --output HDMI-1 --off
  xrandr --output LVDS-1 --mode 1366x768
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

  gnome-screenshot -a -f $filepath

  curl -s -k -u $OC_USER:$OC_PASS -T $filepath $oc_webdav/ScreenShots/$basename
  share ScreenShots/$basename | xclip -sel clip
}
function beep() {
  paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
}
function gif() {
	DELAY=5
  TIME=`date +%d-%m-%y-%H:%M`
  USERDUR=$(gdialog --title "Duration?" --inputbox "Please enter the screencast duration in seconds" 200 100 2>&1)
  # xrectsel from https://github.com/lolilolicon/xrectsel
  GEOMETRY=$(xrectsel "--x=%x --y=%y --width=%w --height=%h")
  notify-send -t $((DELAY*1000)) -u normal -i info 'Byzanz' "Recording in ${DELAY}s"
  sleep $DELAY
  sleep 0.5
  beep
  eval byzanz-record --delay=0 --duration=$USERDUR  $GEOMETRY "/tmp/recording_${TIME}.gif"
  beep
  notify-send -u normal -i info 'Byzanz' 'Done recording'
}

function genpasswd() {
  openssl rand -base64 32 | xclip
}

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export EDITOR="vi"
export LC_CTYPE="UTF-8"
export LC_ALL="en_US.UTF-8"

export NAMECHEAP_URL="sandbox.namecheap.com"
export NAMECHEAP_API_USER="pierreozoux"
export NAMECHEAP_API_KEY=`cat ~/.NAMECHEAP_API_KEY`
export VULTR_API_KEY=`cat ~/.VULTR_API_KEY`
export DIGITALOCEAN_API_KEY=`cat ~/.DIGITALOCEAN_API_KEY`
export IP=`curl -s http://icanhazip.com/`
export FirstName="Pierre"
export LastName="Ozoux"
export Address="streetblah"
export PostalCode="1100-000"
export Country="Portugal"
export Phone="+351.123456789"
export EmailAddress="pierre@ozoux.net"
export City="Lisbon"
export CountryCode="PT"

# PATH
export PATH="$PATH:$HOME/npm/bin"
export PATH="$PATH:$HOME/gopath/bin"
export GOPATH="$HOME/gopath"

#http://stackoverflow.com/questions/564648/zsh-tab-completion-for-cd
zstyle ':completion:*' special-dirs true

alias ll='ls -lah'
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias zshconfig="vi ~/.zshrc && reload"
alias ohmyzsh="vi ~/.oh-my-zsh"
alias xclip="xclip -selection c"
#alias npm="docker run --rm --name node4 -v "$PWD":/usr/src/app -w /usr/src/app node:4 npm"
#alias node="docker run --rm --name node4 -v "$PWD":/usr/src/app -w /usr/src/app node:4 node"
alias reveal="docker run --rm --name node4 -v "$PWD":/usr/src/app -w /usr/src/app -p 1947:1947 node:4 node"
alias nginx="docker run --rm --name nginx -v "$PWD":/usr/share/nginx/html:ro -p 8000:80 nginx"
alias firefox="/home/pierre/.local/share/umake/web/firefox-dev/firefox"

export NVM_DIR="/home/pierre/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
