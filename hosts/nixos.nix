{
  inputs,
  lib,
  pkgs,
  pkgs-stable,
  specialArgs,
  user ? "keith",
  userSettings,
  systemSettings,
  ...
}: let
  inherit (lib.my) mapModules mapModulesRec mapHosts;
  lib = inputs.nixpkgs.lib.extend (
    self: super: {
      my = import ../lib {
        inherit pkgs inputs;
        lib = self;
      };
    }
  );

  mkNixosConfiguration = host:
    lib.nixosSystem {
      inherit pkgs;

      specialArgs =
        specialArgs
        // {
          inherit lib;
          inherit inputs;
          inherit pkgs-stable;
          inherit userSettings systemSettings;
          inherit host user;
          isVm = host == "vm";
        };
      modules =
        [
          ./${host}/default.nix
          ./common/default.nix # ./.
          inputs.chaotic.nixosModules.default
          inputs.nur.modules.nixos.default
          inputs.home-manager.nixosModules.home-manager
	  inputs.lsfg-vk-flake.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user}.imports =
                [
                  # inputs.stylix.homeManagerModules.stylix
                  # ./home/home.nix
                  # ./home/${userSettings.username}.nix
                  ./common/home.nix
                  ./${host}/home.nix
                ]
                ++ (lib.my.mapModulesRec' (toString ../modules/home-manager) import);
              extraSpecialArgs =
                specialArgs
                // {
                  inherit pkgs-stable;
                  inherit inputs;
                  inherit host user;
                  inherit userSettings systemSettings;
                };
            };
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
          inputs.hosts.nixosModule
          inputs.stylix.nixosModules.stylix
          inputs.nvf.nixosModules.default
          # inputs.impermanence.nixosModules.impermanence
          # inputs.sops-nix.nixosModules.sops
        ]
        ++ (lib.my.mapModulesRec' (toString ../modules/nixos) import);
    };
in {
  lib = lib.my;
  nixos = mkNixosConfiguration "nixos";
  vm = mkNixosConfiguration "vm";
}
