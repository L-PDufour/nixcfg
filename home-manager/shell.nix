{
  pkgs,
  config,
  inputs,
  ...
}:
let
  system = pkgs.system;
  mkHomeManager = inputs.user-nvim.lib.mkHomeManager;
in
{
  home.packages = with pkgs; [
    fzf
    zsh-fzf-history-search
    zsh-fzf-tab
  ];
  programs.lazygit.enable = true;
  programs.neovim = mkHomeManager { inherit system; };
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };
  programs.zsh = {
    enable = true;
    initExtraBeforeCompInit = "
export FUNCNEST=200
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.config/emacs/bin
bindkey '^l' forward-word
bindkey '^y' autosuggest-execute
bindkey -s 'jk' '^['
autoload -Uz compinit && compinit
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
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
      vim = "nvim";
      c = "clear";
      ls = "ls --color";
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
}
