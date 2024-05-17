{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.emacs;
in {

  options.modules.editors.emacs.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs28;
      # package = doom-emacs;
      # extraPackages = with pkgs; [
        ## Emacs itself
        # binutils # native-comp needs 'as', provided by this
        #   # 28.2 + native-comp
        #   # ((emacsPackagesFor emacs-unstable).emacsWithPackages
        #   #   (epkgs: [
        #   #     epkgs.vterm
        #   #     epkgs.f
        #   #     epkgs.s
        #   #     epkgs.emacsql
        #   #     epkgs.emacsql-sqlite
        #   #     epkgs.magit-section
        #   #     epkgs.magit-filenotify
        #   #   ]))

        #   ## Doom dependencies
        # git
        #   (ripgrep.override { withPCRE2 = true; })
        #   gnutls # for TLS connectivity

        ## Optional dependencies
        # fd # faster projectile indexing
        # imagemagick # for image-dired
        #   # (mkIf (config.programs.gnupg.agent.enable)
        #   #   pinentry_emacs) # in-emacs gnupg prompts
        # zstd # for undo-fu-session/undo-tree compression

        ## Module dependencies
        # :checkers spell
        # (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
        # :tools editorconfig
        # editorconfig-core-c # per-project style config
        # :tools lookup & :lang org +roam
        # sqlite
        #   # :lang latex & :lang org (latex previews)
        #   texlive.combined.scheme-medium
        #   fava

        # org-roam deps
        # dash
      # ];
    };

    home.file.".config/doom" = {
      source = ./doom;
      recursive = true;
    };

    # https://nixos.wiki/wiki/Emacs
    services.emacs.enable = true;
    services.emacs.client.enable = true;

    # fonts.packages = [ pkgs.emacs-all-the-icons-fonts ];

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
