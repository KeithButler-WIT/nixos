{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.gaming.discord;
in {

  options.modules.gaming.discord.enable =
    mkEnableOption "enables discord";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      discord-screenaudio
      # (pkgs.discord.override {
      #   # remove any overrides that you don't want
      #   withOpenASAR = true;
      #   withVencord = true;
      # })
      vesktop
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
