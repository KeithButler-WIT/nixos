{ config, lib, pkgs, userSettings, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    # initialPassword = "1234";
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" "audio" "video" "tty" "input" "storage" "scanner" "lp" "kvm" ];
    packages = with pkgs; [
      floorp
      conda
    ];
  };
}