{
  description = "Home Manager configuration of keith";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap-flake.url = "github:xremap/nix-flake";
    nix-colors.url = "github:misterio77/nix-colors";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    emacs-doom.url = "github:librephoenix/nix-doom-emacs?ref=pgtk-patch";
  };

  outputs = { nixpkgs, nur, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."keith" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit inputs; };

        modules = [
          nur.nixosModules.nur
          ./home.nix
        ];
      };
    };
}
