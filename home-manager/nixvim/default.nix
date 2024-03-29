{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./autocmds.nix
    ./completion.nix
    ./keymapping.nix
    ./telescope.nix
    ./options.nix
    ./plugins
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    luaLoader.enable = true;
  };
}
