{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./autocmds.nix
    ./lsp.nix
    ./mini.nix
    ./completion.nix
    ./keymapping.nix
    ./telescope.nix
    ./treesitter.nix
    ./lualine.nix
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    # package = pkgs.neovim-nightly;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    # colorschemes.tokyonight.enable = true;
    colorschemes.catppuccin.enable = true;
    colorschemes.catppuccin.settings = {flavour = "mocha";};
    luaLoader.enable = true;
    globals = {
      # Disable useless providers
      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2
    };

    clipboard.register = "";
    clipboard.providers.wl-copy.enable = true;
    opts = {
      updatetime = 100; # Faster completion

      # Line numbers
      relativenumber = true; # Relative line numbers
      number = true; # Display the absolute line number of the current line
      hidden = true; # Keep closed buffer open in the background
      mouse = "a"; # Enable mouse control
      mousemodel = "extend"; # Mouse right-click extends the current selection
      splitbelow = true; # A new window is put below the current one
      splitright = true; # A new window is put right of the current one

      swapfile = false; # Disable the swap file
      modeline = true; # Tags such as 'vim:ft=sh'
      modelines = 100; # Sets the type of modelines
      undofile = true; # Automatically save and restore undo history
      incsearch = true; # Incremental search: show match for partly typed search command
      inccommand = "split"; # Search and replace: preview changes in quickfix list
      ignorecase = true; # When the search query is lower-case, match both lower and upper-case
      #   patterns
      smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper
      #   case characters
      scrolloff = 8; # Number of screen lines to show around the cursor
      cursorline = true; # Highlight the screen line of the cursor
      cursorcolumn = false; # Highlight the screen column of the cursor
      signcolumn = "yes"; # Whether to show the signcolumn
      laststatus = 0; # When to use a status line for the last window
      fileencoding = "utf-8"; # File-content encoding for the current buffer
      termguicolors = true; # Enables 24-bit RGB color in the |TUI|
      spell = false; # Highlight spelling mistakes (local to window)
      wrap = false; # Prevent text from wrapping

      # Tab options
      tabstop = 4; # Number of spaces a <Tab> in the text stands for (local to buffer)
      shiftwidth = 4; # Number of spaces used for each step of (auto)indent (local to buffer)
      expandtab = true; # Expand <Tab> to spaces in Insert mode (local to buffer)
      autoindent = true; # Do clever autoindenting

      textwidth = 0; # Maximum width of text that is being inserted.  A longer line will be
      #   broken after white space to get this width.

      # Folding
      foldlevel = 99; # Folds with a level higher than this number will be closed
      # Kickstart setting
      showmode = false;
      breakindent = true;
      timeoutlen = 300;
      list = true;
      hlsearch = true;
    };
    extraPlugins = [pkgs.vimPlugins.vim-dadbod pkgs.vimPlugins.vim-dadbod-ui pkgs.vimPlugins.vim-dadbod-completion pkgs.vimPlugins.vimwiki];
    plugins = {
      zen-mode.enable = true;
      which-key.enable = true;
      nvim-osc52.enable = true;
      nvim-osc52.keymaps.enable = true;
      better-escape.enable = true;
      sleuth.enable = true;
      comment.enable = true;
      treesitter-textobjects.enable = true;
      floaterm.enable = true;
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
          delete.text = "_";
          topdelete.text = "‾";
          changedelete.text = "~";
        };
      };
    };
  };
}
