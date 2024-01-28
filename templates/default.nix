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
    path = ./templates/javascript;
    description = "Javascript / Typescript dev environment";
  };

  python = {
    inherit welcomeText;
    path = ./templates/python;
    description = "Python dev environment";
  };

  rust = {
    inherit welcomeText;
    path = ./templates/rust;
    description = "Rust dev environment";
  };

  haskell = {
    inherit welcomeText;
    path = ./templates/haskell;
    description = "Haskell dev environment";
  };

  texlive = {
    inherit welcomeText;
    path = ./templates/texlive;
    description = "Texlive dev environment";
  };

  js = javascript;
  ts = javascript;
  py = python;
  rs = rust;
  hs = haskell;
  tx = texlive;
}
