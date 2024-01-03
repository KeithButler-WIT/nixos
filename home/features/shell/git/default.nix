{ config, lib, pkgs, ... }:

{

  home.packages = [
      pkgs.github-desktop
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
        pv = "pr view";  };
      };
  };

  programs.git = {
    enable = true;
    package = pkgs.git;
    extraConfig = {
      user = {
        useConfigOnly = true;
        name = "Keith Butler";
        email= "keithbutler2001@gmail.com";
        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMNXXNh8eWgPtjc7+iiBFuM6mB+C+8m13wD4tHZFPtYm keithbutler2001@gmail.com";
      };

      # host."github.com" = {
      #   User = "git";
      #   IdentityFile = "~/.ssh/id_ed25519";
      # };

      init.defaultBranch = "main";

      credential.helper= "/usr/bin/git-credential-manager";
      credential.credentialStore = "gpg";

      safe.directory = "/opt/flutter";

      gpg.format = "ssh";

      # Fixed a fatal error of url hanging
      http.postBuffer = 2147483648;
      http.lowSpeedLimit = 0;
      http.lowSpeedTime = 999999;
    };
    lfs.enable = true;
    aliases = {
      # identify = "! git-identify";
      # id = "! git-identify";
      co = "checkout";
    };
  };

}
