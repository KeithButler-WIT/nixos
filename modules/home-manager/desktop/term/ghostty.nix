{
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.term.ghostty;
in {
  options.modules.desktop.term.ghostty.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      # enableZshIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
    };
  };
}
