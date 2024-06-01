{ inputs, lib, pkgs, specialArgs, user ? "keith", userSettings, systemSettings, ... }:
let
  inherit (lib.my) mapModules mapModulesRec mapHosts;
  lib = inputs.nixpkgs.lib.extend
    (self: super: { my = import ../lib { inherit pkgs inputs; lib = self; }; });

  mkNixosConfiguration =
    host:
    lib.nixosSystem {
      inherit pkgs;

      specialArgs = specialArgs // {
        inherit lib;
        inherit inputs;
        inherit userSettings systemSettings;
        inherit host user;
      };
      modules = [
        ./${host}/default.nix
        ./common/default.nix
        # ./.
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user}.imports = [
            # inputs.stylix.homeManagerModules.stylix
            # ./home/home.nix
            # ./home/${userSettings.username}.nix
            ./common/home.nix
            ./${host}/home.nix
          ] ++ (lib.my.mapModulesRec' (toString ../modules/home-manager) import);

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
          home-manager.extraSpecialArgs = specialArgs // {
            inherit inputs;
            inherit host user;
            inherit userSettings systemSettings;
          };
        }
        inputs.hosts.nixosModule
        inputs.stylix.nixosModules.stylix
        # inputs.impermanence.nixosModules.impermanence
        # inputs.sops-nix.nixosModules.sops
      ] ++ (lib.my.mapModulesRec' (toString ../modules/nixos) import);
    };
in
{
  lib = lib.my;
  nixos = mkNixosConfiguration "nixos";
  vm = mkNixosConfiguration "vm";
}
