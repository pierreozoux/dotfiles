# dotfiles

zsh, vim, git config and CLI tools, managed with [home-manager](https://github.com/nix-community/home-manager).

Prompt: `➜  folder git:(branch) ✗` on the left, `(⎈|kube-context:namespace) az:subscription` on the right.

## Mac

1. Install Nix (flakes enabled by default, survives macOS updates):

       curl -fsSL https://install.determinate.systems/nix | sh -s -- install

   Optional, for GUI apps (`~/.zprofile` loads `brew shellenv`):

       /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

2. Clone and apply (open a new terminal first). `-b backup` renames existing `~/.zshrc` etc. to `*.backup`:

       git clone https://github.com/pierreozoux/dotfiles.git ~/dotfiles
       cd ~/dotfiles
       nix run home-manager/release-26.05 -- switch --flake .#mac -b backup

3. Open a new terminal, then:

       az login
       az account set -s <subscription>

## Linux

    nix run home-manager/release-26.05 -- switch --flake .#linux -b backup

## Day to day

    home-manager switch --flake ~/dotfiles#mac    # after editing home.nix / zshrc
    nix flake update                              # upgrade all packages, then switch
