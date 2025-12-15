{
  pkgs,
  lib,
  ...
}:
with lib.my;
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
  ];

  # TODO: Needed for openmw multiplayer
  #services.samba.enableWinbindd = true;
  #services.samba.nsswins = true;

  programs.niri.enable = true;
  services.bpftune.enable = true; # Network tuning
  services.psd.enable = true;

  modules = {
    # autologin.enable = true;
    # autoUpgrade.enable = true;
    # doas.enable = true;
    sudo-rs.enable = true;
    nh.enable = true;
    # gc.enable = true; # conflicts with nh clean
    # flatpak.enable = true;
    nix-ld.enable = true;
    stylix.enable = true;
    # vm.enable = true;
    # vr.enable = true;
    desktop = {
      enable = true;
      hyprland.enable = true;
      # cosmic.enable = true;
      # plasma6.enable = true;
      # niri.enable = true;
      tuigreet.enable = true;
      steam = {
        enable = true;
        flatpak = true;
      };
      xdg.enable = true;
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
      nvf.enable = true;
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
        # jackett.enable = true;
        lidarr.enable = true;
        prowlarr.enable = true;
        audiobookshelf.enable = true;
        readarr.enable = true;
        navidrome.enable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    crun # TODO: DO i need this
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland # TODO: Do i still need these
    calibre
    samrewritten
    #jetbrains.rust-rover

    # Unreal Engine Libs
    # libandroid
    # libopensles
    # libglesv3
    # liblog

    fuzzel # niri default app launcher
  ];

  services.gvfs.enable = true;

  services.udev.packages = with pkgs; [ usb-modeswitch-data ];

  # hardware.new-lg4ff.enable = true;

  networking.interfaces.enp4s0.wakeOnLan.enable = true;

  services.udev.extraRules = ''
    # HTC Vive HID Sensor naming and permissioning
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="2c87", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2101", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2000", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="1043", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2050", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2011", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2012", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="2c87", TAG+="uaccess"
    # HTC Camera USB Node
    SUBSYSTEM=="usb", ATTRS{idVendor}=="114d", ATTRS{idProduct}=="8328", TAG+="uaccess"
    # HTC Mass Storage Node
    SUBSYSTEM=="usb", ATTRS{idVendor}=="114d", ATTRS{idProduct}=="8200", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="114d", ATTRS{idProduct}=="8a12", TAG+="uaccess"
  '';

  services.lsfg-vk = {
    enable = true;
    ui.enable = true; # installs gui for configuring lsfg-vk
  };
}
