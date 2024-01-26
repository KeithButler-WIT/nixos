{ config, lib, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.keith = {
    # initialPassword = "1234";
    isNormalUser = true;
    description = "Keith Butler";
    extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" "audio" "video" "tty" "input" "storage" "scanner" "kvm" ];
    packages = with pkgs; [
      floorp
      conda
    ];
  };
}