{ config, pkgs, lib, userSettings, ... }:

{

  networking.hostName = userSettings.hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Set your time zone.

  # Enable networking
  networking.networkmanager.enable = true;

  # https://github.com/StevenBlack/hosts
  networking.stevenBlackHosts = {
    enable = true;
    blockFakenews = true;
    blockGambling = true;
    blockPorn = false;
    blockSocial = false;
  };

}
