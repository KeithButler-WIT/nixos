{

  systemSettings = rec {
    system = "x86_64-linux";
    timezone = "Europe/Dublin";
    locale = "en_IE.UTF-8";
  };
  # User Variables
  userSettings = rec {
    hostname = "nixos";
    username = "keith";
    name = "Keith";
    fullName = "Keith Butler";
    gitUsername = "KeithButler-WIT";
    gitEmail = "keithbutler2001@gmail.com";
    flakeDir = "/home/${username}/nixos";
    #font = "jetbrains mono nerd font";
    #fontpkg = "jetbrains-mono";
  };

}
