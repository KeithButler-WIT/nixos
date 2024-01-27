{ pkgs, config, ... }:

{

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl = {
    driSupport = true; # This is already enabled by default
    driSupport32Bit = true; # For 32 bit applications
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      amdvlk
    ];
    # For 32 bit applications 
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;


  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Use the flake
    # package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;
  };

  # Enable automatic login for the user.
  # ervices.xserver.displayManager.startx.enable = true;
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "keith";
  };

  services.getty.autologinUser = "keith";
  # services.kmscon = {
  #   enable = true;
  #   autologinUser = "keith";
  #   hwRender = true;
  # };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

}