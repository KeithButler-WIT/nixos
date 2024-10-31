{ pkgs, lib, inputs, systemSettings, userSettings, ... }:

{

  environment.systemPackages = with pkgs; [
    git
    nixd
    nixfmt-rfc-style
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

}
