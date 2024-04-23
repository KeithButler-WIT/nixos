{ pkgs, config, lib, inputs, ... }:

{

  imports = [
    # inputs.nix-gaming.nixosModules.steamCompat
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  options = {
    steam.enable =
      lib.mkEnableOption "enables steam";
  };

  config = lib.mkIf config.steam.enable {

    # nix.settings = {
    #   substituters = [ "https://nix-gaming.cachix.org" ];
    #   trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    # };

    programs.gamemode = {
      enable = true;
      settings.general.inhibit_screensaver = 0; # If you don't have a screensaver installed
    };

    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        # withJava = true;
        # withPrimus = true;
        extraPkgs = pkgs: [ pkgs.ncurses6 ];
        # extraPkgs = pkgs: [ pkgs.ncurses6 pkgs.bumblebee pkgs.glxinfo ];
      };
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [
        # add the packages that you would like to have in Steam's extra compatibility packages list
        pkgs.proton-ge-bin
        # etc.
      ];
      platformOptimizations.enable = true;
    };
    environment.systemPackages = with pkgs; [
      # pkgs.gamemode # GameMode depends on root-level capabilities that aren't available in a user-level Nix package installation.
      heroic
      lutris
      protonup-qt
      protonup-ng
      protontricks
      winetricks
      protontricks
      #wine-staging
      #wine-osu
      #wine-tkg
      # (openmw.overrideAttrs (_: rec { dontWrapQtApps = false; }))
      openmw
      steam-run
      steamcmd
    ];
  };

}
