{ config, lib, pkgs, ... }:

{

  home.packages = [
      #pkgs.virt-manager
      #pkgs.libvirt
      #pkgs.libvirt-glib
      pkgs.quickemu
      pkgs.quickgui
  ];

}
