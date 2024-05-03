{ config, lib, pkgs, inputs, userSettings, ... }:

with lib.my;
{

  modules = {
    # torrent.enable = true;
    nh.enable = true;
    hyprland.enable = true;
    desktop = {
      browsers = {
        # firefox.enable = true;
        floorp.enable = true;
        # qutebrowser.enable = true;
      };
      apps = {
        # lf.enable = true;
        # blender.enable = true;
        # bottles.enable = true;
        # godot.enable = true;
        # libreoffice.enable = true;
        # obs.enable = true;
        # pass.enable = true;
        # signal.enable = true;
        # slack.enable = true;
        # thunderbird.enable = true;
        # unity.enable = true;
        # weeb.enable = true;
        # zoom.enable = true;
      };
      gaming = {
        # discord.enable = true;
        # minecraft.enable = true;
        # r2modman.enable = true;
      };
      media = {
        # mpv.enable = true;
        # ncmpcpp.enable = true;
      };
      term = {
        kitty.enable = true;
        # alacritty.enable = true;
      };
      # vm.enable = true;
      gtk.enable = true;
    };
    editors = {
      # emacs.enable = true;
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
      # borgmatic.enable = true;
      dunst.enable = true;
      # mako.enable = true;
      # mpd.enable = true;
      ssh.enable = true;
      # syncthing.enable = true;
      xremap.enable = true;
    };
  };

}
