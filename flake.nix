{
  description = "Keith's dotfiles managed via NixOS and home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    devenv.url = "github:cachix/devenv/v0.6.3";
    hosts.url = github:StevenBlack/hosts;
    nix-gaming.url = "github:fufexan/nix-gaming";

    impermanence.url = "github:nix-community/impermanence";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, self, hosts, ... } @ inputs:
    let
      forAllSystems = function:
        nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system: function nixpkgs.legacyPackages.${system});
      commonInherits = {
        inherit (nixpkgs) lib;
        inherit self inputs nixpkgs;
        user = "keith";
        system = "x86_64-linux";
      };
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # User Variables 
      hostname = "nixos";
      username = "keith";
      gitUsername = "KeithButler-WIT";
      gitEmail = "keithbutler2001@gmail.com";
      browser = "floorp";
      flakeDir = "/home/${username}/nixos";
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; }; # Might be redundent
          modules = [
            hosts.nixosModule
            {
              networking.stevenBlackHosts.enable = true;
            }
            ./hosts/nixos/configuration.nix
          ];
        };
      };
      # homeConfigurations = {
      #   keith = inputs.home-manager.lib.homeManagerConfiguration {
      #     inherit pkgs;
      #     modules = [
      #       ./home/home.nix
      #     ];
      #   };
      # };

      # templates for devenv
      templates = ./templates;

    };
}
