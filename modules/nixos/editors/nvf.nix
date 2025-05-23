{
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.editors.nvf;
in {
  options.modules.editors.nvf = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      enableManpages = true;
      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;
          debugMode = {
            enable = false;
            level = 16;
            logFile = "/tmp/nvim.log";
          };

          spellcheck = {
            enable = true;
            programmingWordlist.enable = true;
          };

          lsp = {
            enable = true;
            formatOnSave = true;
            lspkind.enable = false;
            lightbulb.enable = true;
            lspsaga.enable = false;
            trouble.enable = true;
            lspSignature.enable = true;
            otter-nvim.enable = true;
            nvim-docs-view.enable = true;
          };

          debugger = {
            nvim-dap = {
              enable = true;
              ui.enable = true;
            };
          };

          # This section does not include a comprehensive list of available language modules.
          # To list all available language module options, please visit the nvf manual.
          languages = {
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;

            # Languages that are always used
            nix.enable = true;
            markdown.enable = true;

            # Languages that I use
            bash.enable = true;
            css.enable = true;
            html.enable = true;
            lua.enable = true;
            python.enable = true;
            rust = {
              enable = true;
              crates.enable = true;
            };

            # Language modules that are not as common.
            typst.enable = false;
            zig.enable = false;
            clang.enable = false;
            sql.enable = false;
            java.enable = false;
            kotlin.enable = false;
            ts.enable = false;
            go.enable = false;
            assembly.enable = false;
            astro.enable = false;
            nu.enable = false;
            csharp.enable = false;
            julia.enable = false;
            vala.enable = false;
            scala.enable = false;
            r.enable = false;
            gleam.enable = false;
            dart.enable = false;
            ocaml.enable = false;
            elixir.enable = false;
            haskell.enable = false;

            tailwind.enable = false;
            svelte.enable = false;

            # Nim LSP is broken on Darwin and therefore
            # should be disabled by default. Users may still enable
            # `vim.languages.vim` to enable it, this does not restrict
            # that.
            # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
            nim.enable = false;
          };

          visuals = {
            nvim-scrollbar.enable = true;
            nvim-web-devicons.enable = true;
            nvim-cursorline.enable = true;
            cinnamon-nvim.enable = true;
            fidget-nvim.enable = true;

            highlight-undo.enable = true;
            indent-blankline.enable = true;
            rainbow-delimiters.enable = true;

            # Fun
            # cellular-automaton.enable = true;
          };

          statusline = {
            lualine = {
              enable = true;
              # theme = "auto";
            };
          };

          theme = {
            enable = true;
            #name = "catppuccin"; # Now done with stylix
            #style = "mocha";
            transparent = false;
          };

          autopairs.nvim-autopairs.enable = true;

          autocomplete.nvim-cmp.enable = true;
          snippets.luasnip.enable = true;

          filetree = {
            neo-tree = {
              enable = true;
              setupOpts = {
                enable_cursor_hijack = true;
                git_status_async = true;
              };
            };
          };

          tabline = {
            nvimBufferline.enable = true;
          };

          treesitter = {
            enable = true;
            autotagHtml = true;
            context.enable = true;
            fold = true;
          };

          binds = {
            whichKey.enable = true;
            cheatsheet.enable = true;
          };

          telescope.enable = true;

          git = {
            enable = true;
            gitsigns.enable = true;
            gitsigns.codeActions.enable = false; # throws an annoying debug message
          };

          minimap = {
            minimap-vim.enable = false;
            codewindow.enable = true; # lighter, faster, and uses lua for configuration
          };

          dashboard = {
            dashboard-nvim.enable = false;
            alpha.enable = true;
          };

          notify = {
            nvim-notify.enable = true;
          };

          projects = {
            project-nvim.enable = true;
          };

          utility = {
            ccc.enable = false;
            vim-wakatime.enable = false;
            icon-picker.enable = true;
            surround.enable = true;
            diffview-nvim.enable = true;
            motion = {
              hop.enable = true;
              leap.enable = true;
              precognition.enable = true;
            };

            images = {
              image-nvim.enable = false;
            };
          };

          notes = {
            obsidian.enable = false; # FIXME: neovim fails to build if obsidian is enabled
            # neorg.enable = false; # TODO: Uncomment
            # orgmode.enable = true;
            mind-nvim.enable = true;
            todo-comments.enable = true;
          };

          terminal = {
            toggleterm = {
              enable = true;
              lazygit.enable = true;
            };
          };

          ui = {
            borders.enable = true;
            noice.enable = true;
            colorizer.enable = true;
            modes-nvim.enable = false; # the theme looks terrible with catppuccin
            illuminate.enable = true;
            breadcrumbs = {
              enable = true;
              navbuddy.enable = true;
            };
            smartcolumn = {
              enable = true;
              setupOpts.custom_colorcolumn = {
                # this is a freeform module, it's `buftype = int;` for configuring column position
                nix = "110";
                ruby = "120";
                java = "130";
                go = [
                  "90"
                  "130"
                ];
              };
            };
            fastaction.enable = true;
          };

          assistant = {
            chatgpt.enable = false;
            copilot = {
              enable = false;
              cmp.enable = true;
            };
          };

          session = {
            nvim-session-manager.enable = false;
          };

          gestures = {
            gesture-nvim.enable = false;
          };

          comments = {
            comment-nvim.enable = true;
          };

          presence = {
            neocord.enable = false;
          };
        };
      };
    };
  };
}
