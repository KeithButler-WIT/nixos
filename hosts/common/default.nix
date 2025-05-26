{
  pkgs,
  systemSettings,
  ...
}: {
  imports = [
    ./boot.nix
    ./cleanup.nix
    ./network.nix
    ./packages.nix
    ./polkit.nix
    ./users.nix
  ];

  home-manager.backupFileExtension = "bkp";

  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  time.hardwareClockInLocalTime = true;

  services = {
    xserver.enable = true;
    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    envfs.enable = true;
  };

  programs = {
    fuse.userAllowOther = true;
    dconf.enable = true;
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    mtr.enable = true;
  };

  time.timeZone = systemSettings.timezone;

  i18n.defaultLocale = systemSettings.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
