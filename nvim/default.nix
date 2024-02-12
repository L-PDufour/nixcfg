{ config, pkgs, ... }:
{
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

    plugins = with pkgs.vimPlugins; [

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./lua/lsp-setup.lua;
      }
		trouble-nvim
                no-neck-pain-nvim
		undotree
      {
        plugin = alpha-nvim;
        #config = toLuaFile ./lua/dashboard.lua;
     }
      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      {
        plugin = tokyonight-nvim;
        config = "colorscheme tokyonight";
      }
{
plugin = which-key-nvim;
config = toLua "require(\"which-key\").setup()";
}

      neodev-nvim

      cmp-nvim-lsp
      nvim-cmp 
      cmp_luasnip
      cmp-buffer
      cmp-path
      luasnip
      friendly-snippets

      {
        plugin = nvim-cmp;
        config = toLuaFile ./lua/cmp-setup.lua;
      }

      telescope-fzf-native-nvim
telescope-file-browser-nvim
telescope-ui-select-nvim

      {
        plugin = telescope-nvim;
         config = toLuaFile ./lua/telescope-setup.lua;
      }
     

      lualine-nvim
      nvim-web-devicons

      vim-rhubarb
      vim-sleuth
{
        plugin = fidget-nvim;
        config = toLua "require(\"fidget\").setup()";
      }

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        type = "lua";
        config = builtins.readFile(./lua/treesitter-setup.lua);
      }

      vim-nix

      # {
      #   plugin = vimPlugins.own-onedark-nvim;
      #   config = "colorscheme onedark";
      # }
    ];
      extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp
      xclip
      wl-clipboard
    ];


    extraLuaConfig = ''
      ${builtins.readFile ./lua/options.lua}
      ${builtins.readFile ./lua/lualine.lua}
      ${builtins.readFile ./lua/keymaps.lua}
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

  programs.home-manager.enable = true;
}
