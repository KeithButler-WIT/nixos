{ inputs, pkgs, config, userSettings, ... }:

{

  # Enable the X11 windowing system.
  services.xserver.enable = true; # TODO: check if needed

  hyprland.enable = true;
  # plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

}
