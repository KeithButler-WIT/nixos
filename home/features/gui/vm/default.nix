{ config, lib, pkgs, userSettings, ... }:

{

  home.packages = [
    pkgs.quickemu
    pkgs.quickgui
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };


}
