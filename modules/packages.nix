{ pkgs, ... }:
{
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    alejandra
    gnumake
    lazygit
    ripgrep
    fd
    git
    wget
    curl
    syncthing
    keepassxc
    unzip
    vscode
    vscode.fhs
    go
    postgresql
    via
    qmk
    rofi-screenshot
    xclip
    flameshot
  ];
}
