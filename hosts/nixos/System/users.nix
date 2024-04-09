{ config, lib, pkgs, userSettings, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    initialPassword = "1234";
    isNormalUser = true;
    description = userSettings.name;
    extraGroups =
      [ "networkmanager" "wheel" "disk" "docker" "plugdev" "audio" "video" "tty" "input" "storage" "lp" "nixconfig" "dialout" ]
      ++ [ "kvm" ] # TODO: add if check
      ++ [ "scanner" ];
    packages = with pkgs; [
    ];
    openssh.authorizedKeys.keys = lib.mkIf config.ssh.enable [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMNXXNh8eWgPtjc7+iiBFuM6mB+C+8m13wD4tHZFPtYm keithbutler2001@gmail.com"
    ];
  };

}
