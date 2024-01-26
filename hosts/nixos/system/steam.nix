{ pkgs, config, lib, inputs, ... }:

{

  programs.steam = {
    enable = true;
    #package = pkgs.steam.override { 
    #  withJava = true; 
    #withPrimus = true;
    #extraPkgs = pkgs: [ bumblebee glxinfo ];
    #};
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [
      # add the packages that you would like to have in Steam's extra compatibility packages list
      # pkgs.luxtorpeda
      inputs.nix-gaming.packages.${pkgs.system}.proton-ge
      # etc.
    ];
  };

}
