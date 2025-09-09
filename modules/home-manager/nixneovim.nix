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

  home.packages = with pkgs; [
    typescript-language-server
  ];

  programs.nixneovim = {
    enable = true;
    globals.mapleader = " ";
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      termColors = true;
      transparentBackground = true;
    };

    options = {
      number = true; # Show line numbers
      wrap = false;

      shiftwidth = 2; # Tab width should be 2
      smarttab = true;
      expandtab = true;
      tabstop = 8;
      softtabstop = 4;
      clipboard = "unnamedplus";
      termguicolors = true;
    };
    extraConfigVim = ''
      :set nofixeol
    '';

    plugins = {
      lightline.enable = true;
      telescope.enable = true;
      tagbar.enable = true;
      treesitter = {
        enable = true;
        indent = true;
      };

      gitsigns = {
        enable = true;
      };

      diffview = {
        enable = true;
      };

      nvim-tree = {
        enable = true;
        disableNetrw = true;
      };

      nvim-cmp = {
        enable = true;
        snippet.luasnip.enable = true;
        completion = {
          completeopt = "menu,menuone,preview,noselect";
        };
        mapping = {
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<Up>" = "cmp.mapping.select_prev_item()";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<Down>" = "cmp.mapping.select_next_item()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<PageUp>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<PageDown>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<LeftMouse>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<Esc>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = false })";
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
          jsonls.enable = true;
          nil.enable = true;
          pyright.enable = true;
          rust-analyzer.enable = true;
        };
        extraLua.post = ''
          do -- lsp server config ts_ls

          local setup =  {
            on_attach = function(client, bufnr)


            end,

          }

            require('lspconfig')["ts_ls"].setup(setup)
          end -- lsp server config ts_ls
        '';
      };
      lsp-progress.enable = true;
    };
    mappings = let
      general = {
        # refactoring
        "<leader>re" = {action = "\":Refactor extract \"";}; # into func
        "<leader>rv" = {action = "\":Refactor extract_var \"";};
        "<leader>ri" = {action = "\":Refactor inline_var\"";};
        "<leader>rI" = {action = "\":Refactor inline_func\"";};
        "<F2>" = {action = "\":TagbarToggle<CR>\"";};
        "<F1>" = {action = "\":NvimTreeToggle<CR>\"";};
        "<F3>" = {action = "'<cmd>:lua require\"nvim-tree.api\".tree.find_file({open=true, focus=false})<CR>'";};
      };
    in {
      normal =
        general
        // {
          "<leader>e" = {action = "'<cmd>:Explore<CR>'";};
          "<leader>q" = {action = "'<cmd>:q<CR>'";};
          "<leader>h" = {action = "'<cmd>:split<CR>'";};
          "<leader>v" = {action = "'<cmd>:vsplit<CR>'";};

          "<leader>i" = {action = "'<cmd>:lua vim.diagnostic.open_float(nil, {focus=true, scope=\"cursor\"})<CR>'";};

          "<leader>ff" = {action = "'<cmd>:Telescope find_files<CR>'";};
          "<leader>fg" = {action = "'<cmd>:Telescope live_grep<CR>'";};
          "<leader>fb" = {action = "'<cmd>:Telescope buffers<CR>'";};
          "<leader>fh" = {action = "'<cmd>:Telescope help_tags<CR>'";};
          "<leader>fs" = {action = "'<cmd>:Telescope lsp_document_symbols<CR>'";};
          "<leader>fw" = {action = "'<cmd>:Telescope lsp_workspace_symbols<CR>'";};

          "<leader><Right>" = {action = "'<cmd>:vertical resize +5<CR>'";};
          "<leader><Left>" = {action = "'<cmd>:vertical resize -5<CR>'";};
          "<leader><Up>" = {action = "'<cmd>:resize +5<CR>'";};
          "<leader><Down>" = {action = "'<cmd>:resize -5<CR>'";};
          "gd" = {action = "vim.lsp.buf.definition";};
          "<leader>gd" = {action = "'<cmd>tab split | lua vim.lsp.buf.definition()<CR>'";};
          "gD" = {action = "vim.lsp.buf.declaration";};
          "gI" = {action = "vim.lsp.buf.implementation";};
          "gr" = {action = "vim.lsp.buf.rename";};
          "gR" = {action = "vim.lsp.buf.references";};
          "gA" = {action = "vim.lsp.buf.code_action";};

          "<leader><TAB>" = {action = "\":tabn<CR>\"";};
          "<S-TAB>" = {action = "\":tabp<CR>\"";};
          "<leader>t" = {action = "\":tabnew<CR>\"";};

          #debugging
          "<F8>" = {action = "'<cmd>:call vimspector#ToggleBreakpoint()<CR>'";};
          "<Leader><F5>" = {action = "'<cmd>:call vimspector#Continue()<CR>'";};
          "<F5>" = {action = "'<cmd>:call vimspector#Launch()<CR>'";};
          "<F10>" = {action = "'<cmd>:call vimspector#Stop()<CR>'";};
          "<F6>" = {action = "'<cmd>:call vimspector#StepOver()<CR>'";};
          "<F7>" = {action = "'<cmd>:call vimspector#StepInto()<CR>'";};
          "<Leader><F7>" = {action = "'<cmd>:call vimspector#StepOut()<CR>'";};
        };
      visual =
        general
        // {
          "K" = {action = "\":m '>+1<CR>gv=gv\"";};
          "J" = {action = "\":m '<-2<CR>gv=gv\"";};
          "H" = {action = "\"<gv\"";};
          "L" = {action = "\">gv\"";};
        };
    };
    extraPlugins = with pkgs; [
      vimPlugins.vimspector
      vimPlugins.refactoring-nvim
    ];
    extraConfigLua = ''
      vim.g.vimspector_base_dir = vim.env.HOME .. "/.config/nvim/vimspector-config"
      vim.g.vimspector_install_gadgets = { "CodeLLDB" }
    '';
  };
}
