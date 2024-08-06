{ pkgs, config, lib, inputs, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.gaming.steam;
in {

  imports = [
    # inputs.nix-gaming.nixosModules.steamCompat
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  options.modules.desktop.gaming.steam.enable =
    mkBoolOpt false;


  config = lib.mkIf cfg.enable {

    # nix.settings = {
    #   substituters = [ "https://nix-gaming.cachix.org" ];
    #   trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    # };

    # TODO: move to own module
    # For openmw-tes3mp
    # services.logmein-hamachi.enable = true;
    # programs.haguichi.enable = true;

    programs.gamescope.enable = true;
    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          inhibit_screensaver = 0;
          renice = 10;
        };
      };
    };
    users.users.${userSettings.username}.extraGroups = [ "gamemode" ];

    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        # withJava = true;
        # withPrimus = true;
        extraPkgs = pkgs: [
          pkgs.ncurses6
          pkgs.libGLU
          pkgs.harfbuzz
          pkgs.bubblewrap
        ];
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
      heroic
      lutris
      protonup-qt
      protonup-ng
      protontricks
      winetricks
      protontricks
      openmw
      openmw-tes3mp
      steam-run
      steamcmd
      steam-tui
      mangohud
    ];

    # Better for steam proton games
    systemd.extraConfig = "DefaultLimitNOFILE=1048576";
  };

}
