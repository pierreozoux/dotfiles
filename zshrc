# Loaded by home-manager after oh-my-zsh (see home.nix).
[ -e ~/.nix-profile/etc/profile.d/nix.sh ] && . ~/.nix-profile/etc/profile.d/nix.sh
export EDITOR=vim
export PATH="$HOME/go/bin:${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

alias nix-shell="nix-shell --command zsh"

# Current Azure subscription (`az account set -s ...`), read from the profile
# file because calling `az` on every prompt is too slow.
azure_prompt() {
  local f="${AZURE_CONFIG_DIR:-$HOME/.azure}/azureProfile.json"
  [[ -r $f ]] || return
  local sub=$(sed '1s/^\xEF\xBB\xBF//' "$f" | jq -r '.subscriptions[] | select(.isDefault) | .name' 2>/dev/null)
  [[ -n $sub ]] && echo "%F{blue}az:$sub%f"
}

# Left: folder, git branch, dirty mark (robbyrussell). Right: kube context:namespace, azure subscription.
RPROMPT='$(kube_ps1) $(azure_prompt)'
source <(switcher init zsh)
source <(switch completion zsh)
