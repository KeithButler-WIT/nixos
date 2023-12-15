{ config, lib, pkgs, ... }:

{
  # Was used to get emacs-git
  # nixpkgs.overlays = [
    # (import (builtins.fetchTarball {
    #   url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    # }))
  # ];
  #
  # home = {
  #   sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
  #   sessionVariables = {
  #     DOOMDIR = "${config.xdg.configHome}/doom-config";
  #     DOOMLOCALDIR = "${config.xdg.configHome}/doom-local";
  #     # DOOMLOCALDIR = ./doom;
  #     # DOOMLOCALDIR = "/home/keith/nixos/home/features/emacs/doom";
  #   };
  # };
  #
  # xdg = {
  #   enable = true;
  #   configFile = {
  #     "doom-config/config.el".source = ./doom/config.el;
  #     "doom-config/init.el".source = ./doom/init.el;
  #     "doom-config/packages.el".source = ./doom/packages.el;
  #     "doom-config/ding.mp3".source = ./doom/ding.mp3;
  #     "emacs" = {
  #       source = builtins.fetchGit "https://github.com/hlissner/doom-emacs";
  #       onChange = "${pkgs.writeShellScript "doom-change" ''
  #         export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
  #         export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
  #         if [ ! -d "$DOOMLOCALDIR" ]; then
  #           ${config.xdg.configHome}/emacs/bin/doom -y install
  #         else
  #           ${config.xdg.configHome}/emacs/bin/doom -y sync -u
  #         fi
  #       ''}";
  #     };
  #   };
  # };

  # home.packages = with pkgs; [
  #   # DOOM Emacs dependencies
  #   binutils
  #   (ripgrep.override { withPCRE2 = true; })
  #   gnutls
  #   fd
  #   imagemagick
  #   zstd
  #   nodePackages.javascript-typescript-langserver
  #   sqlite
  #   editorconfig-core-c
  #   emacs-all-the-icons-fonts
  # ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    extraPackages =
      (epkgs: [
        epkgs.vterm epkgs.lsp-pyright epkgs.pdf-tools

        # Doom Emacs Deps
        pkgs.libpng
        pkgs.zlib
        pkgs.poppler_gi
        pkgs.fd
        pkgs.aspell
        pkgs.aspellDicts.en
        pkgs.imagemagick
        pkgs.librsvg
        pkgs.binutils
        (pkgs.ripgrep.override { withPCRE2 = true; })
        pkgs.gnutls
        pkgs.imagemagick
        pkgs.zstd
        pkgs.nodePackages.javascript-typescript-langserver
        pkgs.sqlite
        pkgs.editorconfig-core-c
        pkgs.emacs-all-the-icons-fonts
      ] );
  };

  home.file.".config/doom" = {
    source = ./doom;
    recursive = true;
  };

  # https://nixos.wiki/wiki/Emacs
  # services.emacs.enable = true;
  # services.emacs.client.enable = true;
}
