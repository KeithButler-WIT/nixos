{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    ./system.nix
    ./users.nix
    ./polkit.nix
    ./packages.nix
    ./users.nix
    ./boot.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true; # TODO: check if needed

  hyprland.enable = true;
  # plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.envfs.enable = true;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  programs.fuse.userAllowOther = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

}
