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

    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    ags.url = "github:Aylur/ags";

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
      forAllSystems = function:
        nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system: function nixpkgs.legacyPackages.${system});
      commonInherits = {
        inherit (nixpkgs) lib;
        inherit self inputs nixpkgs;
        inherit (import ./options.nix) systemSettings userSettings;
        user = "keith";
        system = "x86_64-linux";
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        specialArgs = {
          inherit self inputs;
        };
      };
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # unstable = nixpkgs-unstable.legacyPackages.${system};
      inherit (import ./options.nix) systemSettings userSettings;
    in
    {

      nixosConfigurations = (import ./hosts/nixos.nix commonInherits) // (import ./hosts/iso commonInherits);

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

