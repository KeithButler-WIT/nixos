{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.discord;
in {

  options.modules.desktop.apps.discord.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
      # discord-screenaudio
      # (discord.override {
      #   # remove any overrides that you don't want
      #   withOpenASAR = true;
      #   withVencord = true;
      # })
      # vesktop
    ];

    xdg.configFile."Vencord/themes/custom.css".text = ''
      /**
      * @name Catppuccin Mocha
      * @author winston#0001
      * @authorId 505490445468696576
      * @version 0.2.0
      * @description 🎮 Soothing pastel theme for Discord
      * @website https://github.com/catppuccin/discord
      * @invite r6Mdz5dpFc
      * **/

      @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css");
    '';
  };

}
