{
  config,
  lib,
  pkgs,
  system,
  nixneovim,
  ...
}: {
  imports = [
    nixneovim.nixosModules.default
  ];

  programs.nixneovim = {
    enable = true;
    globals.mapleader = " ";

    options = {
      number = true; # Show line numbers
      wrap = false;

      shiftwidth = 2; # Tab width should be 2
      smarttab = true;
      expandtab = true;
      tabstop = 8;
      softtabstop = 4;
    };

    plugins = {
      lightline.enable = true;
      telescope.enable = true;
      treesitter = {
        enable = true;
        indent = true;
      };

      nvim-cmp = {
        enable = true;
        snippet.luasnip.enable = true;
        completion = {
          keyword_length = 1;
          keyword_pattern = ".*";
        };
        mapping = {
          "<Tab>" = ''
            cmp.mapping(function(fallback)
              local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
              end

              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- they way you will only jump inside the snippet region
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
              local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
              end

              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-c>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })";
        };
        sources = {
          "nvim_lsp" = {
            enable = true;
          };
          "buffer" = {
            enable = true;
            option = {
              keyword_length = 5;
            };
          };
          "luasnip" = {
            enable = true;
            option = {
              "use_show_condition" = false;
              show_autosnippets = true;
            };
          };
          "path" = {
            enable = true;
          };
        };
      };

      lspconfig = {
        enable = true;
        servers = {
          bashls.enable = true;
          clangd.enable = true;
          cssls.enable = true;
          eslint.enable = true;
        };
      };
    };
    mappings = {
      normal = {
        "<leader>e" = {action = "'<cmd>:Explore<CR>'";};
        "<leader>q" = {action = "'<cmd>:q<CR>'";};
        "<leader>h" = {action = "'<cmd>:split<CR>'";};
        "<leader>v" = {action = "'<cmd>:vsplit<CR>'";};

        "<leader>i" = {action = "'<cmd>:lua vim.diagnostic.open_float(nil, {focus=true, scope=\"cursor\"})<CR>'";};

        "<leader>ff" = {action = "'<cmd>:Telescope find_files<CR>'";};
        "<leader>fg" = {action = "'<cmd>:Telescope live_grep<CR>'";};
        "<leader>fb" = {action = "'<cmd>:Telescope buffers<CR>'";};
        "<leader>fh" = {action = "'<cmd>:Telescope help_tags<CR>'";};

        "<leader><Right>" = {action = "'<cmd>:vertical resize +5<CR>'";};
        "<leader><Left>" = {action = "'<cmd>:vertical resize -5<CR>'";};
        "<leader><Up>" = {action = "'<cmd>:resize +5<CR>'";};
        "<leader><Down>" = {action = "'<cmd>:resize -5<CR>'";};
      };
    };

    extraPlugins = [
      {
        plugin = pkgs.vimPlugins.ale;
        config = ''
               let g:ale_linters_ignore = {
                 \  'haskell': ['ghc'],
          \}
        '';
      }
    ];
  };
}
