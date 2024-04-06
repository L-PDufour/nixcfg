{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./autocmds.nix
    ./lsp.nix
    ./completion.nix
    ./keymapping.nix
    ./telescope.nix
    ./options.nix
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    colorschemes.tokyonight.enable = true;
    luaLoader.enable = true;

    plugins = {
    better-escape.enable = true;
    treesitter.enable = true;
    treesitter.ensureInstalled = "all";
    treesitter.nixGrammars = true;
    };
  };
}
