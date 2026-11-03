{ config, pkgs, ... }:

{
  home.homeDirectory =
    (if pkgs.stdenv.isDarwin then "/Users/" else "/home/") + config.home.username;
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    azure-cli
    kubelogin
    kubectl
    kubeswitch
    kubernetes-helm
    k9s
    krew
    fzf
    ripgrep
    jq
  ];

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "kubectl" "kube-ps1" ];
    };
    initContent = builtins.readFile ./zshrc;
  };

  home.file.".vimrc".source = ./vimrc;
  home.file.".gitconfig".source = ./gitconfig;
}
