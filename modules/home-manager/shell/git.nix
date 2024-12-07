{ config, lib, pkgs, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.git;
in {

  options.modules.shell.git.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # github-desktop
      delta
      lazygit
      git-credential-manager
    ];

    programs.gh = {
      enable = true;
      extensions = [ pkgs.gh-eco ];
      gitCredentialHelper.hosts = [ "https://github.com" ];
      settings = {
        version = 1; # https://github.com/cli/cli/issues/8462
        git_protocol = "ssh";
        prompt = "enabled";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
    };

    programs.git = {
      enable = true;
      package = pkgs.git;
      extraConfig = {
        user = {
          useConfigOnly = true;
          name = userSettings.fullName;
          email = userSettings.gitEmail;
          signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMNXXNh8eWgPtjc7+iiBFuM6mB+C+8m13wD4tHZFPtYm keithbutler2001@gmail.com";
        };

        # host."github.com" = {
        #   User = "git";
        #   IdentityFile = "~/.ssh/id_ed25519";
        # };

        init.defaultBranch = "main";

        credential.helper = "bw";
        # credential.credentialStore = "gpg";

        safe.directory = "/opt/flutter";

        gpg.format = "ssh";

        push.autoSetupRemote = true;

        # Fixed a fatal error of url hanging
        http.postBuffer = 2147483648;
        http.lowSpeedLimit = 0;
        http.lowSpeedTime = 999999;

        # https://github.com/dandavison/delta
        core.pager = "${pkgs.delta}/bin/delta";
        interactive.diffFilter = "${pkgs.delta}/bin/delta - -color-only";
        delta.navigate = true; # use n and N to move between diff sections
        delta.side-by-side = true;
        # delta detects terminal colors automatically; set one of these to disable auto-detection
        # dark = true
        # light = true
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";

        core.compression = 0; # Quick fix for Fatal: early EOF’ Error
        core.packedGitLimit = "512m"; 
        core.packedGitWindowSize = "512m"; 
        pack.deltaCacheSize = "2047m";
        pack.packSizeLimit = "2047m";
        pack.windowMemory = "2047m";
      };
      lfs.enable = true;
      aliases = {
        # identify = "! git-identify";
        # id = "! git-identify";
        co = "checkout";
      };
    };
  };

}
