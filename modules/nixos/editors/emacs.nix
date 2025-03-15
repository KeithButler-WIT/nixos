{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.editors.emacs;
  emacs = with pkgs;
    (
      emacsPackagesFor
      # (if config.modules.desktop.type == "wayland"
      # then emacs-pgtk
      # else emacs-git)).emacsWithPackages
      emacs-git-pgtk
    )
    .emacsWithPackages
    (epkgs: []);
in {
  options.modules.editors.emacs = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      inputs.emacs-overlay.overlays.default
    ];

    environment.systemPackages = [
      pkgs.sqlite
      (mkLauncherEntry "Doom Emacs" {
        description = "Start Doom Emacs";
        icon = "emacs";
        exec = "/home/keith/.config/emacs/bin/doom run /home/keith"; # TODO: Change to user
      })
      (mkLauncherEntry "Emacs (Debug Mode)" {
        description = "Start Emacs in debug mode";
        icon = "emacs";
        exec = "${emacs}/bin/emacs --debug-init";
      })
    ];

    # users.users.${userSettings.username}.packages = with pkgs; [
    # ];

    # TODO: move to home-manager
    environment.variables.PATH = ["$XDG_CONFIG_HOME/emacs/bin"];

    fonts.packages = [
      #pkgs.nerd-fonts.symbols-only
      pkgs.jetbrains-mono
    ];

    systemd.user.services.clone-doom-config = {
      enable = true;
      after = ["network.target"];
      wantedBy = ["default.target"];
      description = "Doom Emacs Clone Service";
      serviceConfig = {
        Type = "simple";
        WorkingDirectory = "~/.config";
        ExecStart = ''${pkgs.git}/bin/git clone git@github.com:KeithButler-WIT/doom.git'';
      };
    };

    systemd.user.services.clone-org-files = {
      enable = true;
      after = ["network.target"];
      wantedBy = ["default.target"];
      description = "Org Files Clone Service";
      serviceConfig = {
        Type = "simple";
        WorkingDirectory = "~/workspace";
        ExecStart = ''${pkgs.git}/bin/git clone git@github.com:KeithButler-WIT/org.git'';
      };
    };
  };
}
