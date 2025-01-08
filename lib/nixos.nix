{
  inputs,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.my;
let
  sys = "x86_64-linux";
  inherit (import ../options.nix) systemSettings userSettings;
in
{
  # mkHost = path: attrs @ { system ? sys, ... }:
  #   nixosSystem {
  #     inherit system;
  #     specialArgs = {
  #       inherit lib inputs system systemSettings userSettings;
  #     };
  #     modules = [
  #       {
  #         # nixpkgs.pkgs = pkgs;
  #         networking.hostName = mkDefault (removeSuffix ".nix" (baseNameOf path));
  #       }
  #       inputs.hosts.nixosModule
  #       ../hosts/common
  #       # inputs.home-manager.nixosModules.home-manager
  #       inputs.home-manager.nixosModules.home-manager
  #       {
  #         home-manager.useGlobalPkgs = true;
  #         home-manager.useUserPackages = true;
  #         home-manager.users.keith.imports = [
  #           # ./home/home.nix
  #           ../hosts/common/home.nix
  #           # ./hosts/${systemSettings.hostname}/home.nix
  #           ../home/home.nix
  #         ] ++ (mapModulesRec' (toString ../modules/home-manager) import);
  #         # Optionally, use home-manager.extraSpecialArgs to pass
  #         # arguments to home.nix
  #         home-manager.extraSpecialArgs = {
  #           inherit inputs;
  #           inherit userSettings systemSettings;
  #         };
  #       }

  #       (filterAttrs (n: v: !elem n [ "system" ]) attrs)
  #       (import path)
  #       ../. # /default.nix
  #     ] ++ (mapModulesRec' (toString ../modules/nixos) import);
  #   };
  # homeConfigurations = {
  #   keith = inputs.home-manager.lib.homeManagerConfiguration {
  #     inherit pkgs;
  #     modules = [
  #       ../hosts/common/home.nix
  #       ../home/home.nix
  #     ] ++ (lib.my.mapModulesRec' (toString ../modules/home-manager) import);
  #   };
  # };

  # mapHosts = dir: attrs @ { system ? system, ... }:
  #   mapModules dir
  #     (hostPath: mkHost hostPath attrs);
}
