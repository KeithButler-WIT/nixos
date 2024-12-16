{ config, lib, pkgs, inputs, userSettings, ... }:

{

  home.packages = with pkgs; [
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  modules = {
    torrent.enable = true;
    nh.enable = true;
    # hyprland.enable = true;
    waybar.enable = true;
    desktop = {
      browsers = {
        # firefox.enable = true;
        floorp.enable = true;
        qutebrowser.enable = true;
      };
      apps = {
        lf.enable = true;
        blender.enable = true;
        # bottles.enable = true;
        godot.enable = true;
        libreoffice.enable = true;
        obs.enable = true;
        pass.enable = true;
        signal.enable = true;
        slack.enable = true;
        thunderbird.enable = true;
        unity.enable = true;
        weeb.enable = true;
        # zoom.enable = true;
      };
      gaming = {
        discord.enable = true;
        minecraft.enable = true;
        r2modman.enable = true;
      };
      media = {
        mpv.enable = true;
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
      emacs.enable = true;
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
      syncthing.enable = true;
      # xremap.enable = true;
    };
  };

  programs.java.enable = true;

  services.home-manager.autoUpgrade.frequency = "monthly";

}
