{
  description = "Keith's dotfiles managed via NixOS and home-manager";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland.url = "github:hyprwm/Hyprland";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };

    devenv.url = "github:cachix/devenv";
    hosts.url = "github:StevenBlack/hosts";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-colors.url = "github:misterio77/nix-colors";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nix-doom-emacs.url = "github:vlaci/nix-doom-emacs";
    xremap-flake.url = "github:xremap/nix-flake";

    impermanence.url = "github:nix-community/impermanence";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Haskell thing
    ormolu.url = "github:tweag/ormolu";
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # https://www.youtube.com/watch?v=ljHkWgBaQWU
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, self, hosts, hyprland, home-manager, ormolu, ... } @ inputs:
    let
      inherit (lib.my) mapModules mapModulesRec mapHosts;

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

      lib = nixpkgs.lib.extend
        (self: super: { my = import ./lib { inherit pkgs inputs; lib = self; }; });

      # unstable = nixpkgs-unstable.legacyPackages.${system};
      inherit (import ./options.nix) systemSettings userSettings;
    in
    {
      lib = lib.my;

      # nixosModules =
      #   { } // mapModulesRec ./modules/nixos import;

      # homeModules =
      #   { } // mapModulesRec ./modules/home-manager import;

      # nixosConfigurations =
      #   mapHosts ./hosts { };

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit lib;
            inherit inputs;
            inherit userSettings systemSettings;
          }; # Might be redundent
          modules = [
            hosts.nixosModule
            ./hosts/nixos/default.nix
            ./hosts/common/default.nix
            # ./.
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userSettings.username}.imports = [
                # inputs.stylix.homeManagerModules.stylix
                # ./home/home.nix
                # ./home/${userSettings.username}.nix
                ./hosts/common/home.nix
                ./hosts/nixos/home.nix
              ] ++ (lib.my.mapModulesRec' (toString ./modules/home-manager) import);

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit userSettings systemSettings;
              };
            }
          ] ++ (lib.my.mapModulesRec' (toString ./modules/nixos) import);
        };
        vm = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit lib;
            inherit inputs;
            inherit userSettings systemSettings;
          }; # Might be redundent
          modules = [
            hosts.nixosModule
            ./hosts/nixos/default.nix
            ./hosts/common/default.nix
            # ./.
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userSettings.username}.imports = [
                # inputs.stylix.homeManagerModules.stylix
                # ./home/home.nix
                # ./home/${userSettings.username}.nix
                ./hosts/common/home.nix
                ./hosts/vm/home.nix
              ] ++ (lib.my.mapModulesRec' (toString ./modules/home-manager) import);

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit userSettings systemSettings;
              };
            }
          ] ++ (lib.my.mapModulesRec' (toString ./modules/nixos) import);
        };
      };

      # homeConfigurations = {
      #   keith = inputs.home-manager.lib.homeManagerConfiguration {
      #     inherit pkgs;
      #     # inherit userSettings systemSettings;
      #     modules = [
      #       # ./home/home.nix
      #       ./hosts/common/home.nix
      #       ./hosts/nixos/home.nix
      #     ] ++ (lib.my.mapModulesRec' (toString ./modules/home-manager) import);
      #   };
      # };

      inherit self;

      # templates for devenv
      templates = import
        ./templates;

    };
}

