{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    fzf
    zsh-fzf-history-search
    zsh-fzf-tab
  ];
  # programs.neovim.enable = true;
  # programs.neovim.plugins = [
  # (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [ p.c p.java ]))
  # ];
  programs.starship.enable = true;
  programs.starship.settings = { };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    initExtraBeforeCompInit = "unsetopt beep";
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
    shellAliases = {
      ll = "ls -l";
      upnix = "sudo nixos-rebuild switch";
      uphm = "home-manager switch";
      tma = "tmux attach";
      tmd = "tmux detach";

    };
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "c2b4aa5ad2532cca91f23908ac7f00efb7ff09c9";
          sha256 = "1b4pksrc573aklk71dn2zikiymsvq19bgvamrdffpf7azpq6kxl2";
        };
      }
    ];
  };
  xdg.configFile."starship.toml".source = ./starship.toml;
}