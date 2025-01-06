{
  config,
  lib,
  pkgs,
  inputs,
  userSettings,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.editors.emacs;
  emacs =
    with pkgs;
    (emacsPackagesFor
      # (if config.modules.desktop.type == "wayland"
      # then emacs-pgtk
      # else emacs-git)).emacsWithPackages
      (emacs-pgtk)
    ).emacsWithPackages
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

    users.users.${userSettings.username}.packages = with pkgs; [
      (mkLauncherEntry "Doom Emacs" {
        description = "Start Doom Emacs";
        icon = "emacs";
        exec = "doom run";
      })
      (mkLauncherEntry "Emacs (Debug Mode)" {
        description = "Start Emacs in debug mode";
        icon = "emacs";
        exec = "${emacs}/bin/emacs --debug-init";
      })
    ];

    # TODO: move to home-manager
    environment.variables.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];

    fonts.packages = [
      #pkgs.nerd-fonts.symbols-only
      pkgs.jetbrains-mono
    ];

    systemd.user.services.clone-doom-config = {
      enable = true;
      after = [ "network.target" ];
      wantedBy = [ "default.target" ];
      description = "Doom Emacs Clone Service";
      serviceConfig = {
        Type = "simple";
        WorkingDirectory = "~/.config";
        ExecStart = ''${pkgs.git}/bin/git clone git@github.com:KeithButler-WIT/doom.git'';
      };
    };

  };

}
