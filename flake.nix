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
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;}; # Might be redundent
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
      templates =
        let
          welcomeText = ''
            # `.devenv` and `direnv` should be added to `.gitignore`
            ```sh
              echo .devenv >> .gitignore
              echo .direnv >> .gitignore
            ```
          '';
        in
        rec {
          javascript = {
            inherit welcomeText;
            path = ./templates/javascript;
            description = "Javascript / Typescript dev environment";
          };

          python = {
            inherit welcomeText;
            path = ./templates/python;
            description = "Python dev environment";
          };

          rust = {
            inherit welcomeText;
            path = ./templates/rust;
            description = "Rust dev environment";
          };

          haskell = {
            inherit welcomeText;
            path = ./templates/haskell;
            description = "Haskell dev environment";
          };

          js = javascript;
          ts = javascript;
          py = python;
          rs = rust;
          hs = haskell;
        };
    };
}
