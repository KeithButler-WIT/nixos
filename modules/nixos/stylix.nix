{ pkgs, config, lib, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.stylix;
in {

  options.modules.stylix.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      # package = inputs.stylix.nixosModules.stylix;
      # package = inputs.stylix.packages."${pkgs.system}".stylix;
      # FIXME: TEMP comment
      # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      image = ../../wallpaper.jpg;
      fonts = {
        monospace = {
          name = "JetBrainsMono Nerd Font Mono";
          package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };
        emoji = {
          name = "Nerd Fonts Symbols Only";
          package = pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; };
        };
        # sizes = {
        #   applications = 12;
        #   terminal = 15;
        #   desktop = 10;
        #   popups = 10;
        # };
      };
      cursor = {
        name = "Nordzy-cursors";
        package = pkgs.nordzy-cursor-theme;
        size = 24;
      };
      opacity = {
        applications = 0.95;
        desktop = 0.95;
        popups = 0.95;
        terminal = 0.95;
      };
      targets = {
        grub.useImage = true;
      };
      polarity = "dark";
    };
  };

}
