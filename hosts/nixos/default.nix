# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}:
with lib.my; {
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
  ];

  #services.samba.enableWinbindd = true;
  #services.samba.nsswins = true;

  hardware.graphics.enable = true;

  modules = {
    autologin.enable = true;
    autoUpgrade.enable = true;
    # doas.enable = true;
    sudo-rs.enable = true;
    nh.enable = true;
    # gc.enable = true; # conflicts with nh clean
    flatpak.enable = true;
    nix-ld.enable = true;
    stylix.enable = true;
    # vm.enable = true;
    desktop = {
      enable = true;
      hyprland.enable = true;
      # plasma6.enable = true;
      tuigreet.enable = true;
      gaming = {
        steam.enable = true;
      };
    };
    dev = {
      xdg.enable = true;
      cc.enable = true;
      python.enable = true;
      rust.enable = true;
      shell.enable = true;
    };
    editors = {
      emacs.enable = true;
    };
    hardware = {
      audio.enable = true;
      amd.enable = true;
      bluetooth.enable = true;
      # nvidia.enable = true;
      logitech.enable = true;
      fs = {
        enable = true;
        ssd.enable = true;
        zfs.enable = true;
      };
    };
    services = {
      # backup.enable = true;
      # containers = {
      #   enable = true;
      #   distrobox.enable = true;
      #   docker.enable = true;
      #   podman.enable = true;
      # };
      keyd.enable = true;
      # firewall.enable = true;
      # flood.enable = true;
      mullvad-vpn.enable = true;
      # power-management.enable = true;
      printer.enable = true;
      ssh.enable = true;
      streaming = {
        enable = true;
        # plex.enable = true;
        jellyfin.enable = true;
        radarr.enable = true;
        sonarr.enable = true;
        jackett.enable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # inkscape # TODO: make module
    # conda # TODO: make module
    crun
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
    calibre
    samrewritten
    jetbrains.rust-rover
  ];

  services.gvfs.enable = true;

  services.udev.packages = with pkgs; [usb-modeswitch-data];

  hardware.new-lg4ff.enable = true;

  networking.interfaces.enp4s0.wakeOnLan.enable = true;

  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        lsp = {
          enable = true;
          formatOnSave = true;
          trouble.enable = true;
          lightbulb.enable = true;
          # lspkind.enable = true;
          lsplines.enable = true;
          # nvim-docs-view.enable = true;
        };
        languages = {
          enableLSP = true;
          bash.lsp.enable = true;
          css.lsp.enable = true;
          markdown.lsp.enable = true;
          nix.lsp.enable = true;
          python.lsp.enable = true;
          rust.lsp.enable = true;
        };
      };
    };
  };
}
