{ config, lib, pkgs, username, name, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    # initialPassword = "1234";
    isNormalUser = true;
    description = name;
    extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" "audio" "video" "tty" "input" "storage" "scanner" "lp" "kvm" ];
    packages = with pkgs; [
      floorp
      conda
    ];
  };
}