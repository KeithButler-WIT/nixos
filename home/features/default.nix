{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    ./file
    ./gui
    ./tui
  ];

}
