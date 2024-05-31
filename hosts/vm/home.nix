{ config, lib, pkgs, inputs, userSettings, ... }:

with lib.my;
{

  modules = {
    just.enable = true;
    nh.enable = true;
    desktop = {
      hyprland.enable = true;
      # waybar.enable = true;
      browsers = {
        qutebrowser.enable = true;
      };
      apps = {
        lf.enable = true;
      };
      term = {
        kitty.enable = true;
      };
      gtk.enable = true;
    };
    editors = {
      neovim.enable = true;
    };
    shell = {
      bash.enable = true;
      fish.enable = true;
      fzf.enable = true;
      git.enable = true;
      starship.enable = true;
      tealdeer.enable = true;
      direnv.enable = true;
    };
    services = {
      dunst.enable = true;
      ssh.enable = true;
      xremap.enable = true;
    };
  };

}
