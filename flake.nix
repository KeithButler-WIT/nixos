{
  description = "Keith's dotfiles managed via NixOS and home-manager";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland.url = "github:hyprwm/Hyprland";
    hyprland.url = "github://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    # split-monitor-workspaces = {
    #   url = "github:Duckonaut/split-monitor-workspaces";
    #   inputs.hyprland.follows = "hyprland";
    # };

    devenv.url = "github:cachix/devenv";
    hosts.url = "github:StevenBlack/hosts";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-colors.url = "github:misterio77/nix-colors";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nix-doom-emacs.url = "github:vlaci/nix-doom-emacs";
    xremap-flake.url = "github:xremap/nix-flake";

    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    ags.url = "github:Aylur/ags";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";

    yazi.url = "github:sxyazi/yazi";
    nix-alien.url = "github:thiagokokada/nix-alien";

    # impermanence.url = "github:nix-community/impermanence";

    # sops-nix = {
    #   url = "github:Mic92/sops-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # https://www.youtube.com/watch?v=ljHkWgBaQWU
    stylix.url = "github:danth/stylix";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      self,
      hosts,
      hyprland,
      home-manager,
      ...
    }@inputs:
    let
      forAllSystems =
        function:
        nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system: function nixpkgs.legacyPackages.${system});
      commonInherits = {
        inherit (nixpkgs) lib;
        inherit
          self
          inputs
          nixpkgs
          nixpkgs-stable
          ;
        inherit (import ./options.nix) systemSettings userSettings;
        user = "keith";
        system = "x86_64-linux";
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.allowUnfreePredicate = _: true;
          config.permittedInsecurePackages = [ # all for sonarr
            "aspnetcore-runtime-6.0.36"
            "aspnetcore-runtime-wrapped-6.0.36"
            "dotnet-sdk-6.0.428"
            "dotnet-sdk-wrapped-6.0.428"
            "dotnet-runtime-6.0.36"
            "dotnet-runtime-wrapped-6.0.36"
            "dotnet-sdk-6.0.428"
          ];
        };
        pkgs-stable = import inputs.nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        specialArgs = {
          inherit self inputs;
        };
      };
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};

      inherit (import ./options.nix) systemSettings userSettings;
    in
    {

      nixosConfigurations =
        (import ./hosts/nixos.nix commonInherits) // (import ./hosts/iso commonInherits);

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
      templates = import ./templates;

    };
}
