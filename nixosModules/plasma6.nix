{ pkgs, config, lib, ... }:

{

  options = {
    plasma6.enable =
      lib.mkEnableOption "enables plasma6";
  };

  config = lib.mkIf config.plasma6.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    # Enable the KDE Plasma Desktop Environment.
    services.xserver.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      kate
      kwrited
      konsole
      kwalletmanager
      kwallet
      kmail
    ]
    ++
    [
      # pkgs.libsForQt5.plasma-browser-integration
      pkgs.libsForQt5.konsole
      pkgs.libsForQt5.oxygen
    ];
  };

}
