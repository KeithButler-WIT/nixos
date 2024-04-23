{ config, lib, pkgs, userSettings, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    initialPassword = "1234";
    isNormalUser = true;
    description = userSettings.name;
    extraGroups =
      [ "networkmanager" "wheel" "disk" "plugdev" "video" "tty" "input" "storage" "lp" "nixconfig" "dialout" ]
      ++ [ "docker" ]
      ++ [ "kvm" ] # TODO: add if check
      ++ [ "scanner" ];
    packages = with pkgs; [
      # Home Backup
      pika-backup
      haskell-language-server
      stack
      rclone
      inkscape
      ghc
      floorp
      conda
    ];
    openssh.authorizedKeys.keys = lib.mkIf config.modules.services.ssh.enable [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMNXXNh8eWgPtjc7+iiBFuM6mB+C+8m13wD4tHZFPtYm keithbutler2001@gmail.com"
    ];
  };

}
