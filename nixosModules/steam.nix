{ pkgs, config, lib, inputs, ... }:

{

  options = {
    steam.enable =
      lib.mkEnableOption "enables steam";
  };

  config = lib.mkIf config.steam.enable {
    # imports = [
    #   inputs.nix-gaming.nixosModules.steamCompat
    # ];

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
        pkgs.proton-ge-bin
        # etc.
      ];
    };
  };

}
