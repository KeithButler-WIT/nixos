{
  pkgs,
  pkgs-stable,
  config,
  lib,
  inputs,
  userSettings,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.steam;
in {
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  options.modules.desktop.steam = {
    enable = mkBoolOpt false;
    flatpak = mkBoolOpt false;
  };

  config = lib.mkIf cfg.enable {
    # TODO: move to own module
    # For openmw-tes3mp
    # services.logmein-hamachi.enable = true;
    # programs.haguichi.enable = true;

    programs = {
      gamescope = {
        enable = true;
        capSysNice = true;
      };
      gamemode = {
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
    };

    users.users.${userSettings.username}.extraGroups = ["gamemode"];

    programs.steam = {
      enable = true;
      extraPackages = with pkgs; [
        gamescope
        gamemode
        mangohud
        (python3.withPackages (ps: with ps; [renpy]))
        glib
        glibc
      ];
      extraCompatPackages = with pkgs; [
        #proton-ge-bin
        proton-ge-custom
      ];
      # extraPkgs = pkgs: [ pkgs.ncurses6 pkgs.bumblebee pkgs.glxinfo ];
      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      platformOptimizations.enable = true;
      # extest.enable = true; # to translate X11 input events to uinput events
      protontricks.enable = true;
    };

    hardware.steam-hardware.enable = true;
    hardware.xone.enable = true;

    environment.systemPackages = with pkgs;
      [
        protonup-qt
        protonup-ng
        wine
        winetricks
        # steam-run
        steamcmd
        # steam-tui
        mangohud
        steamtinkerlaunch
        yad

        glib
        glibc

        lldb #for openmw
      ]
      ++ [
        # pkgs-stable.openmw
        # pkgs-stable.openmw-tes3mp
        pkgs-stable.heroic
        pkgs-stable.lutris
        inputs.openmw-nix.packages.${system}.delta-plugin
        inputs.openmw-nix.packages.${system}.openmw-dev
        inputs.openmw-nix.packages.${system}.openmw-validator
        inputs.openmw-nix.packages.${system}.plox
      ];
  };
}
