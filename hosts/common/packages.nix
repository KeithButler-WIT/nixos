{ pkgs, lib, systemSettings, userSettings, ... }:

{

  environment.systemPackages = with pkgs; [
    git
  ];

}
