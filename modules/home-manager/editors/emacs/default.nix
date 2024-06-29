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
    home.packages = with pkgs; [
      ## Emacs itself
      binutils # native-comp needs 'as', provided by this
      # HEAD + native-comp
      emacs

      ## Doom dependencies
      git
      ripgrep
      gnutls # for TLS connectivity

      ## Optional dependencies
      fd # faster projectile indexing
      imagemagick # for image-dired
      # (mkIf (config.programs.gnupg.agent.enable)
      #   pinentry-emacs) # in-emacs gnupg prompts
      pinentry-emacs
      zstd # for undo-fu-session/undo-tree compression

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
      sqlite
      # :lang latex & :lang org (latex previews)
      # texlive.combined.scheme-medium
      # :lang nix
      age
    ];

    # home.file.".config/doom" = {
    #   source = ./doom;
    #   recursive = true;
    # };

    # https://nixos.wiki/wiki/Emacs
    # services.emacs = {
    #   enable = true;
    #   client.enable = true;
    #   package = pkgs.emacs;
    # };

    # system.userActivationScripts = {
    #   installDoomEmacs = ''
    #     if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
    #        git clone --depth=1 --single-branch "https://github.com/doomemacs/doomemacs" "$XDG_CONFIG_HOME/emacs"
    #        git clone "https://github.com/doomemacs/doomemacs" "$XDG_CONFIG_HOME/doom"
    #     fi
    #   '';
    # };

  };

}
