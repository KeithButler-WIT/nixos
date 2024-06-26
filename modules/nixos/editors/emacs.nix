{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.editors.emacs;
  emacs = with pkgs; (emacsPackagesFor
    # (if config.modules.desktop.type == "wayland"
    # then emacs-pgtk
    # else emacs-git)).emacsWithPackages
    (emacs-pgtk)).emacsWithPackages
    (epkgs: [ ]);
in
{

  options.modules.editors.emacs = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      inputs.emacs-overlay.overlays.default
    ];

    # TODO: move to home-manager
    environment.variables.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];

    fonts.packages = [
      (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
  };

}
