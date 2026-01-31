{
  config,
  lib,
  pkgs,
  system,
  nixvim,
  ...
}: {
  imports = [
    nixvim.homeModules.nixvim
  ];

  home.packages = with pkgs; [
  ];

  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      termColors = true;
      transparentBackground = true;
    };

    opts = {
      number = true;
      wrap = false;

      shiftwidth = 2;
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
        highlight.enable = true;
        indent = {
          enable = true;
        };
      };
      treesitter-context = {
        enable = true;
      };

      gitsigns = {
        enable = true;
      };

      diffview = {
        enable = true;
      };

      nvim-tree = {
        enable = true;
        settings = {
          disable_netrw = true;
        };
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

      lsp = {
        enable = true;
        servers = {
          "*" = {
            config = {
              capabilities = {
                textDocument = {
                  semanticTokens = {
                    multilineTokenSupport = true;
                  };
                };
              };
              root_markers = [
                ".git"
              ];
            };
          };
          bashls.enable = true;
          clangd.enable = true;
          cssls.enable = true;
          eslint.enable = true;
          jsonls.enable = true;
          nil.enable = true;
          pyright.enable = true;
          rust_analyzer = {
            installCargo = false;
            installRustc = false;
            enable = true;
          };
          ts_ls.enable = true;
          intelephense = {
            enable = true;
            package = pkgs.intelephense;
          };
        };
      };
      lsp-progress.enable = true;
      web-devicons.enable = true;
    };

    keymaps = [
      # general (normal + visual)
      {
        key = "<leader>re";
        action = ":Refactor extract ";
        mode = [ "n" "v" ];
      }
      {
        key = "<leader>rv";
        action = ":Refactor extract_var ";
        mode = [ "n" "v" ];
      }
      {
        key = "<leader>ri";
        action = ":Refactor inline_var";
        mode = [ "n" "v" ];
      }
      {
        key = "<leader>rI";
        action = ":Refactor inline_func";
        mode = [ "n" "v" ];
      }
      {
        key = "<F2>";
        action = ":TagbarToggle<CR>";
        mode = [ "n" "v" ];
      }
      {
        key = "<F1>";
        action = ":NvimTreeToggle<CR>";
        mode = [ "n" "v" ];
      }
      {
        key = "<F3>";
        action = "<cmd>:lua require('nvim-tree.api').tree.find_file({open=true, focus=false})<CR>";
        mode = [ "n" "v" ];
      }

      # normal only
      {
        key = "<leader>e";
        action = "<cmd>Explore<CR>";
        mode = "n";
      }
      {
        key = "<leader>q";
        action = "<cmd>q<CR>";
        mode = "n";
      }
      {
        key = "<leader>h";
        action = "<cmd>split<CR>";
        mode = "n";
      }
      {
        key = "<leader>v";
        action = "<cmd>vsplit<CR>";
        mode = "n";
      }
      {
        key = "<leader>i";
        action = "<cmd>lua vim.diagnostic.open_float(nil, {focus=true, scope=\"cursor\"})<CR>";
        mode = "n";
      }
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        mode = "n";
      }
      {
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        mode = "n";
      }
      {
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        mode = "n";
      }
      {
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
        mode = "n";
      }
      {
        key = "<leader>fs";
        action = "<cmd>Telescope lsp_document_symbols<CR>";
        mode = "n";
      }
      {
        key = "<leader>fw";
        action = "<cmd>Telescope lsp_workspace_symbols<CR>";
        mode = "n";
      }

      {
        key = "<leader><Right>";
        action = "<cmd>vertical resize +5<CR>";
        mode = "n";
      }
      {
        key = "<leader><Left>";
        action = "<cmd>vertical resize -5<CR>";
        mode = "n";
      }
      {
        key = "<leader><Up>";
        action = "<cmd>resize +5<CR>";
        mode = "n";
      }
      {
        key = "<leader><Down>";
        action = "<cmd>resize -5<CR>";
        mode = "n";
      }

      {
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        mode = "n";
      }
      {
        key = "<leader>gd";
        action = "<cmd>tab split | lua vim.lsp.buf.definition()<CR>";
        mode = "n";
      }
      {
        key = "gD";
        action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
        mode = "n";
      }
      {
        key = "gI";
        action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
        mode = "n";
      }
      {
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        mode = "n";
      }
      {
        key = "gR";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        mode = "n";
      }
      {
        key = "gA";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        mode = "n";
      }

      {
        key = "<leader><TAB>";
        action = ":tabn<CR>";
        mode = "n";
      }
      {
        key = "<S-TAB>";
        action = ":tabp<CR>";
        mode = "n";
      }
      {
        key = "<leader>t";
        action = ":tabnew<CR>";
        mode = "n";
      }

      {
        key = "<F8>";
        action = "<cmd>call vimspector#ToggleBreakpoint()<CR>";
        mode = "n";
      }
      {
        key = "<Leader><F5>";
        action = "<cmd>call vimspector#Continue()<CR>";
        mode = "n";
      }
      {
        key = "<F5>";
        action = "<cmd>call vimspector#Launch()<CR>";
        mode = "n";
      }
      {
        key = "<F10>";
        action = "<cmd>call vimspector#Stop()<CR>";
        mode = "n";
      }
      {
        key = "<F6>";
        action = "<cmd>call vimspector#StepOver()<CR>";
        mode = "n";
      }
      {
        key = "<F7>";
        action = "<cmd>call vimspector#StepInto()<CR>";
        mode = "n";
      }
      {
        key = "<Leader><F7>";
        action = "<cmd>call vimspector#StepOut()<CR>";
        mode = "n";
      }

      # visual only
      {
        key = "K";
        action = ":m '>+1<CR>gv=gv";
        mode = "v";
      }
      {
        key = "J";
        action = ":m '<-2<CR>gv=gv";
        mode = "v";
      }
      {
        key = "H";
        action = "<gv";
        mode = "v";
      }
      {
        key = "L";
        action = ">gv";
        mode = "v";
      }
    ];

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
