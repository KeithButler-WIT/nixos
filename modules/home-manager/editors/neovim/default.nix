{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.neovim;
in {

  options.modules.editors.neovim.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.neovim =
      let
        toLua = str: "lua << EOF\n${str}\nEOF\n";
        toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
      in
      {
        enable = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        extraPackages = with pkgs; [
          nixd
          luajitPackages.lua-lsp
          # rnix-lsp
          # haskell-language-server
          cmake-language-server
          markdown-oxide
          vim-language-server
          csharp-ls

          xclip
          wl-clipboard
        ];

        plugins = with pkgs.vimPlugins; [

          {
            plugin = nvim-lspconfig;
            config = toLuaFile ./plugin/lsp.lua;
          }

          {
            plugin = comment-nvim;
            config = toLua "require(\"Comment\").setup()";
          }

          {
            plugin = onedark-nvim;
            config = "colorscheme onedark";
          }

          neodev-nvim

          nvim-cmp

          {
            plugin = nvim-cmp;
            config = toLuaFile ./plugin/cmp.lua;
          }

          {
            plugin = telescope-nvim;
            config = toLuaFile ./plugin/telescope.lua;
          }

          telescope-fzf-native-nvim

          cmp_luasnip
          cmp-nvim-lsp

          luasnip
          friendly-snippets


          lualine-nvim
          nvim-web-devicons

          {
            plugin = (nvim-treesitter.withPlugins (p: [
              p.tree-sitter-c
              p.tree-sitter-cpp
              p.tree-sitter-tsx
              p.tree-sitter-nix
              p.tree-sitter-vim
              p.tree-sitter-vimdoc
              p.tree-sitter-bash
              p.tree-sitter-lua
              p.tree-sitter-python
              p.tree-sitter-json
              p.tree-sitter-rust
              p.tree-sitter-fish
              p.tree-sitter-java
              p.tree-sitter-haskell
            ]));
            config = toLuaFile ./plugin/treesitter.lua;
          }

          vim-nix

          # {
          #   plugin = vimPlugins.own-onedark-nvim;
          #   config = "colorscheme onedark";
          # }
        ];

        extraLuaConfig = ''
          ${builtins.readFile ./options.lua}
        '';

        # extraLuaConfig = ''
        #   ${builtins.readFile ./nvim/options.lua}
        #   ${builtins.readFile ./nvim/plugin/lsp.lua}
        #   ${builtins.readFile ./nvim/plugin/cmp.lua}
        #   ${builtins.readFile ./nvim/plugin/telescope.lua}
        #   ${builtins.readFile ./nvim/plugin/treesitter.lua}
        #   ${builtins.readFile ./nvim/plugin/other.lua}
        # '';
      };
  };

}
