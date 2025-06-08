{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    initialPassword = "1234";
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [
      "networkmanager"
      "wheel"
      "disk"
      "plugdev"
      "video"
      "tty"
      "input"
      "storage"
      "lp"
      "nixconfig"
      "dialout"
    ];
    # shell = pkgs.fish; # Enabled in home manager
    # ignoreShellProgramCheck = true;
    packages = with pkgs; [
    ];
    openssh.authorizedKeys.keys = lib.mkIf config.modules.services.ssh.enable [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMNXXNh8eWgPtjc7+iiBFuM6mB+C+8m13wD4tHZFPtYm keithbutler2001@gmail.com"
    ];
  };
}
