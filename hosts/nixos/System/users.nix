{ config, lib, pkgs, userSettings, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    initialPassword = "1234";
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" "audio" "video" "tty" "input" "storage" "scanner" "lp" "kvm" "nixconfig" "dialout" ];
    packages = with pkgs; [
      floorp
      conda
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMNXXNh8eWgPtjc7+iiBFuM6mB+C+8m13wD4tHZFPtYm keithbutler2001@gmail.com"
    ];
  };

}
