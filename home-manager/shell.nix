{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    fzf
    zsh-fzf-history-search
    zsh-fzf-tab
  ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
  programs.starship.enable = true;
  programs.starship.settings = {};
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    initExtraBeforeCompInit = "
export FUNCNEST=100
bindkey '^l' forward-word
bindkey '^y' autosuggest-execute
bindkey -s 'jk' '^['
unsetopt beep
    ";
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
    shellAliases = {
      ll = "ls -l";
      lg = "lazygit";
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
