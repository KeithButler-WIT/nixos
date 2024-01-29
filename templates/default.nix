let
  welcomeText = ''
    # `.devenv` and `direnv` should be added to `.gitignore`
    ```sh
      echo .devenv >> .gitignore
      echo .direnv >> .gitignore
    ```
  '';
in
rec {
  javascript = {
    inherit welcomeText;
    path = ./javascript;
    description = "Javascript / Typescript dev environment";
  };

  python = {
    inherit welcomeText;
    path = ./python;
    description = "Python dev environment";
  };

  rust = {
    inherit welcomeText;
    path = ./rust;
    description = "Rust dev environment";
  };

  haskell = {
    inherit welcomeText;
    path = ./haskell;
    description = "Haskell dev environment";
  };

  texlive = {
    inherit welcomeText;
    path = ./texlive;
    description = "Texlive dev environment";
  };

  js = javascript;
  ts = javascript;
  py = python;
  rs = rust;
  hs = haskell;
  tx = texlive;
}
