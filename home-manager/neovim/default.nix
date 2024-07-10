{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = inputs.myneovim.lib.mkHomeManager {
    system = pkgs.system;
  };
}
