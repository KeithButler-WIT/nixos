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
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
    users.users.${userSettings.username}.extraGroups = [ "gamemode" ];

    programs.steam = {
      enable = true;
      extraPackages = with pkgs; [
        gamescope
      ];
        # extraPkgs = pkgs: [ pkgs.ncurses6 pkgs.bumblebee pkgs.glxinfo ];
      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      platformOptimizations.enable = true;
      extest.enable = true; # to translate X11 input events to uinput events
      protontricks.enable = true;
    };

    hardware.steam-hardware.enable = true;

    environment.systemPackages = with pkgs; [
      heroic
      lutris
      protonup-qt
      protonup-ng
      wine
      winetricks
      openmw
      openmw-tes3mp
      steam-run
      steamcmd
      # steam-tui
      mangohud
    ];

    # Better for steam proton games
    systemd.extraConfig = "DefaultLimitNOFILE=1048576";
  };

}
