{
  description = "pierreozoux dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      mkHome = system: username: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home.nix { home.username = username; } ];
      };
    in {
      homeConfigurations = {
        linux = mkHome "x86_64-linux" "pierreo";
        mac = mkHome "aarch64-darwin" "pierreok";
      };
    };
}
